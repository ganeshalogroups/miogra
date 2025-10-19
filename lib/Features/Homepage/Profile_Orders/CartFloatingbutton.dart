// ignore_for_file: unnecessary_brace_in_string_interps, file_names

import 'dart:async';
import 'package:testing/Features/Bottomsheets/Adduserbottomsheet.dart';
import 'package:testing/Features/Foodmodule/Domain/favouritemodel.dart';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Addfoodcontroller.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodviewfirstscreen.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/foodcartscreen.dart';
import 'package:testing/Features/Foodmodule/getFoodCartProvider.dart';
import 'package:testing/Features/OrderScreen/OrdersTab.dart';
import 'package:testing/utils/Buttons/CustomAlertDialoug.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Custom_Widgets/customCartBox.dart';
import 'package:testing/utils/Toast/customtoastmessage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:testing/Features/OrderScreen/OrderScreenController/OrdersControllerPagination.dart';
import 'package:provider/provider.dart';

class Floatingcartbutton extends StatefulWidget {
  const Floatingcartbutton({super.key});

  @override
  State<Floatingcartbutton> createState() => _FloatingcartbuttonState();
}

class _FloatingcartbuttonState extends State<Floatingcartbutton> {
Foodcartcontroller foodcart = Get.put(Foodcartcontroller());
  @override
  Widget build(BuildContext context) {
   final  foodcartprovider  =  Provider.of<FoodCartProvider>(context); 
     var      orderForOthers  =  Provider.of<InstantUpdateProvider>(context);  
    return   foodcartprovider.isHaveFood
                
                    ? Positioned(
                        // bottom : 15,
                        // left   : 15,
                        // right  : 15,
                         left: 0,
                         right: 0,
                         bottom: MediaQuery.of(context).size.height * 0.46, // Adjust as needed
                        child  : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomCartBox(
                          
                                  itemCount : foodcartprovider.foodCartDetails['totalQuantity'].toString(),
                                  price     : foodcartprovider.foodCartDetails['totalFoodAmount'].toString(),
                                  restName  : foodcartprovider.foodCartDetails['restaurantDetails']['name'],
                                  resImage  : "${globalImageUrlLink}${foodcartprovider.foodCartDetails['restaurantDetails']['logoUrl']}",
                                
                            checkOut: () {
                          
                              List<dynamic> cartRes = [];
                              cartRes = foodcartprovider.searchResModel;
                              if (cartRes.isNotEmpty) {
                                      if (cartRes[0]['status'] == true && cartRes[0]['activeStatus'] == "online") {
                                      final restaurant = FavoriteRestaurant(
                                        id       : cartRes[0]["_id"],
                                        name     : cartRes[0]["name"].toString(),
                                        city     : cartRes[0]["address"]["city"].toString(),
                                        region   : cartRes[0]["address"]["region"].toString(),
                                        imageUrl : "${globalImageUrlLink}${cartRes[0]["imgUrl"].toString()}",
                                        rating   : cartRes[0]["ratingAverage"].toString(),
                                      );
                          
                                       double totalDistance = double.tryParse(foodcartprovider.totalDis.split(' ').first.toString()) ?? 0.0;
                                       Get.to(
                                       AddToCartScreen(
                                       totalDis: totalDistance,
                                       favourListDetails: cartRes[0]["favourListDetails"] ?? [],
                                       menu: cartRes[0]['categoryDetails']?.length ?? 0,
                                      //  additionalImages: additionalImages,
                                       restaurant: restaurant,
                                       restaurantId: restaurant.id,
                                       restaurantcity: restaurant.city,
                                       restaurantfoodtitle: cartRes[0]['cusineList'],
                                       restaurantimg: restaurant.imageUrl,
                                       restaurantname: restaurant.name,
                                       restaurantregion: restaurant.region,
                                       restaurantreview: cartRes[0]['ratingAverage']?.toString() ?? '0',
                                       reviews: cartRes[0]['ratings']?.length ?? 0,
                                       fulladdress: cartRes[0]["address"]?['fullAddress']?.toString() ?? '',
                                       ), transition: Transition.rightToLeft,
                                      );
                                    } else if (cartRes[0]['status'] == false && cartRes[0]['activeStatus'] == "offline") {
                                     AppUtils.showToast('The restaurant is currently closed. Please select another restaurant.');
                                    } else {
                                     AppUtils.showToast('The restaurant is currently closed. Please select another restaurant.');
                                    }
                                    } else {
                                    AppUtils.showToast('The address you selected is outside the restaurant\'s \ndelivery area.');
                                    }
                                    },
                          
                          
                            clearCart: () {
                          
                              List<dynamic> cartRes = [];
                              cartRes = foodcartprovider.searchResModel;
                          
                          
                              if (foodcartprovider.searchResModel.isNotEmpty || cartRes.isNotEmpty) {
                                      
                                CustomLogoutDialog.show(
                                  context: context,
                                  title: 'Clear cart?',
                                  content:"Are you sure you want to clear your cart from ${cartRes[0]["name"].toString()} Restaurant?",
                                  onConfirm: () async {
                          
                          
                                      foodcart.clearCartItem(context: context).then((value) {
                                      foodcartprovider.getfoodcartProvider(km: resGlobalKM);
                          
                                      setState(() {
                                        orderForSomeOneName = '';
                                        orderForSomeOnePhone ='';
                                      });
                                      orderForOthers.upDateInstruction(instruction: '');
                                      orderForOthers.updateSomeOneDetaile(someOneName:'', someOneNumber: '');
                                              
                                      }
                                    );
                          
                                    Get.back();
                                  },
                          
                                  buttonname: 'Yes',
                                   oncancel: () {  Navigator.pop(context); },
                                );
                                      
                                      
                                      
                                      
                              } else {
                          
                                CustomLogoutDialog.show(
                                  context: context,
                                  title: 'Clear cart?',
                                  content: "Are you sure you want to clear your cart from this Restaurant?",
                                  onConfirm: () async {
                          
                                  
                                    foodcart.clearCartItem(context: context).then((value) {
                                    foodcartprovider.getfoodcartProvider(km: resGlobalKM);
                                    
                                      setState(() {
                                        orderForSomeOneName = '';
                                        orderForSomeOnePhone ='';
                                      });
                          
                                      orderForOthers.upDateInstruction(instruction: '');
                                      orderForOthers.updateSomeOneDetaile(someOneName:'', someOneNumber: '');
                                    });
                          
                                    Get.back();
                          
                                  },
                                  buttonname: 'Yes', oncancel: () {  Navigator.pop(context); },
                                );
                              }
                            },
                          
                          
                            viewResturant: () {
                                      
                              List<dynamic> cartRes = [];
                                                
                              cartRes = foodcartprovider.searchResModel;
                          
                              double  totalDistance = double.parse(foodcartprovider.totalDis.split(' ').first.toString());
                                      
                          
                          
                              if (cartRes.isNotEmpty) {
                          
                                  final restaurant = FavoriteRestaurant(
                                    id       : cartRes[0]["_id"],
                                    name     : cartRes[0]["name"].toString(),
                                    city     : cartRes[0]["address"]["city"].toString(),
                                    region   : cartRes[0]["address"]["region"].toString(),
                                    imageUrl :  "${globalImageUrlLink}${cartRes[0]["imgUrl"].toString()}",
                                    rating   : cartRes[0]["ratingAverage"].toString(),
                                  );
                          
                          
                                      Get.to(
                                        Foodviewscreen(
                                          totalDis         : totalDistance,
                                          restaurantId     : restaurant.id,
                                          ),
                          
                                          transition: Transition.rightToLeft,
                                          curve: Curves.easeIn
                                        );
                          
                                        } else {
                                      
                          
                                              AppUtils.showToast('The address you selected is outside the restaurant\'s \ndelivery area.');
                          
                                            }
                                    },
                                  ),
                        ),
                              )
                        
                        
                      : const SizedBox();       
  }
}


class TrackorderFloatingButton extends StatefulWidget {
  const TrackorderFloatingButton({super.key});

  @override
  State<TrackorderFloatingButton> createState() => _TrackorderFloatingButtonState();
}

class _TrackorderFloatingButtonState extends State<TrackorderFloatingButton> {
  String currentImage = "assets/images/viewfood.png";
  String currentText = "Dine"; // Only "Dine" or "Track"
  late Timer _imageSwitchTimer;

  @override
  void initState() {
    super.initState();

    _imageSwitchTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted) return;
      setState(() {
        if (currentImage == "assets/images/viewfood.png") {
          currentImage = "assets/images/home-delivery.png";
          currentText = "Track";
        } else {
          currentImage = "assets/images/viewfood.png";
          currentText = "Dine";
        }
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<GetOrdersProvider>(context, listen: false).getOders();
    });
  }

  @override
  void dispose() {
    _imageSwitchTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetOrdersProvider>(
      builder: (context, value, child) {
        if (value.isLoading || value.orderModel == null || value.orderModel.isEmpty) {
          return const SizedBox();
        }

        final bool isFoodImage = currentImage == "assets/images/viewfood.png";

        return GestureDetector(
          onTap: () {
            Get.to(const OrdersHistory());
          },
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // Removed CircularProgressIndicator and the half circular progress container

              // Floating circular button with image & color change
              Container(
                width: 50.w,
                height: 55.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Customcolors.DECORATION_WHITE,width: 1.5),
                  // color: containerColor,
                  gradient: isFoodImage
                      ? const LinearGradient(
           begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
           colors: [ Colors.grey, Colors.white],
        )
                      : const  LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [0.2, 1.4],
                    colors: [Customcolors.lightpurple,
                  Customcolors.darkpurple],
                  ),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: const Color.fromARGB(255, 221, 206, 185).withOpacity(0.2),
                  //     blurRadius: 12,
                  //     offset: const Offset(0, 6),
                  //   ),
                  // ],
                  boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
                ),
                child: Center(
                  child: Image.asset(
                    currentImage,
                    height: 30,
                  ),
                ),
              ),

              // Track order label with dynamic text and background color
              Positioned(
                bottom: -10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                  decoration: BoxDecoration(
                    // color: labelBgColor,
                       gradient: isFoodImage
                      ? const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
           Customcolors.lightpurple,
          Customcolors.darkpurple
          ],
        )  : const  LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
 colors: [Color.fromARGB(75, 0, 0, 0), Colors.grey,  Color.fromARGB(75, 0, 0, 0),],
),

                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    currentText,
                    style:CustomTextStyle.font10blackreg,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
