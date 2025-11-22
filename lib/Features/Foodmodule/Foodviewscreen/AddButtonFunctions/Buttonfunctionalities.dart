
// ignore_for_file: must_be_immutable, file_names, avoid_print

import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Addfoodcontroller.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/foodcartscreen.dart';
import 'package:testing/Features/Foodmodule/getFoodCartProvider.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';





class AddProductButton extends StatefulWidget {
  dynamic totalDis;
  dynamic restaurantId;
  dynamic vendorId;
  dynamic commissionFilter;
  String? restaurantname;
  String? restaurantcity;
  String? restaurantregion;
  final List<dynamic>? restaurantfoodtitle;
  dynamic restaurantreview;
  dynamic reviews;
  String? restaurantimg;
  dynamic restaurant;
  dynamic menu;
  // final List favourListDetails;
  bool isfromTabscreen;
    String? fulladdress;
  // final List<dynamic>? additionalImages;


  AddProductButton({ 
    super.key,
    this.totalDis,
    this.restaurantId,
    this.vendorId,
    this.commissionFilter,
    this.restaurantcity,
    this.restaurantfoodtitle,
    this.restaurantname,
    required this.fulladdress,
    this.restaurantregion,
    this.restaurantreview,
    this.reviews,
    this.restaurantimg,
    this.isfromTabscreen = false,
    this.restaurant,
    this.menu,
    // this.favourListDetails = const [],
    // required this.additionalImages,
  });

  @override
  State<AddProductButton> createState() => _AddProductButtonState();
}



class _AddProductButtonState extends State<AddProductButton> {

  Foodcartcontroller foodcart = Get.put(Foodcartcontroller());

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    var cartProvider = Provider.of<FoodCartProvider>(context, listen: false);
    var btncontroll = Provider.of<ButtonController>(context);

    return Consumer<ButtonController>(
      builder: (context, buttonController, child) {
        return ValueListenableBuilder<int>(
          valueListenable: buttonController.totalItemCountNotifier,
          builder: (context, totalCount, child) {



            return Positioned(
              right  : 10,
              bottom : 0,
              left   : 10,
              child  : totalCount == 0
                  ? const SizedBox() // If totalCount is 0, hide the button 
                  : isLoading? 
                  
                  Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: CustomContainerDecoration.gradientbuttondecoration(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            '${btncontroll.totalItemCountNotifier.value} item added',
                            style: CustomTextStyle.whitemediumtext,
                          ),
                          const Material(
                            color: Colors.transparent,
                            child: Row(
                              children:  [
                                CupertinoActivityIndicator(color: Colors.white),
                                Icon(Icons.arrow_forward_ios, color: Customcolors.DECORATION_WHITE),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  
                  
                  : Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.9,
                   //   decoration: CustomContainerDecoration.gradientbuttondecoration(),
                    decoration: BoxDecoration(
                      color: Customcolors.darkpinkColor,
                      borderRadius: BorderRadius.circular(5)
                    ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            '${btncontroll.totalItemCountNotifier.value} item added',
                             style: CustomTextStyle.whitemediumtext,
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              onTap: () {

                                      setState(() {
                                        isLoading = true;
                                      });

print("Hiiiiiiii  ${cartProvider.totalDis} iii");
                                      cartProvider.searchRes(restaurantId: widget.restaurantId).then((value) {

print("Beeeeeeeeeee  ${cartProvider.totalDis}");

                                              double  totalDistance = double.parse(cartProvider.totalDis.split(' ').first.toString());
                                          //  double totalDistance = double.tryParse(cartProvider.totalDis.split(' ').first.trim()) ?? 0.0;

// String distanceString = cartProvider.totalDis.split(' ').first.trim();
// double totalDistance = double.tryParse(distanceString) ?? 0.0;

                                              foodcart.getbillfoodcartfood(km: totalDistance);



                                               print('$totalDistance  =====> hello world1');
foodcart.restaurantCommission();

                                       Future.delayed(Duration.zero,() {
                                        
                                                 Get.off(AddToCartScreen(
                                                  vendorId: widget.vendorId,
                                                  commissionFilter: widget.commissionFilter,
                                                        isFromtab        : widget.isfromTabscreen,
                                                        // additionalImages : widget.additionalImages,
                                                        // totalDis: widget.totalDis,
                                                        totalDis         :  totalDistance,
                                                        // favourListDetails:  widget.favourListDetails,
                                                        menu             :  widget.menu,
                                                        restaurant       :  widget.restaurant,
                                                        restaurantId     :  widget.restaurantId,
                                                        restaurantcity   :  widget.restaurantcity,
                                                        restaurantfoodtitle: widget.restaurantfoodtitle,
                                                        restaurantimg    :   widget.restaurantimg,
                                                        restaurantname   :   widget.restaurantname,
                                                        restaurantregion :  widget.restaurantregion,
                                                        restaurantreview :  widget.restaurantreview,
                                                        reviews          :  widget.reviews, fulladdress:widget.fulladdress ,),
                                                        transition       : Transition.rightToLeft,
                                                        );
                                       },);


print("Going to next page");

                                                      }
                                                    ).whenComplete(() {

                                                       setState(() {
                                                        isLoading = false;
                                                        });

                                                    }
                                                  );



                              },

                              
                              child: Row(
                                children:  [
                                  isLoading ? const CupertinoActivityIndicator() : const Text("View Cart", style: CustomTextStyle.whitemediumtext),
                                  const Icon(Icons.arrow_forward_ios, color: Customcolors.DECORATION_WHITE),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                );
              },
            );
          },
        );
      }
    }






class ButtonController with ChangeNotifier {
  bool _isButtonVisible = false;
  ValueNotifier<int> totalItemCountNotifier = ValueNotifier<int>(0);

  bool get isButtonVisible => _isButtonVisible;

  void showButton() {
    _isButtonVisible = true;
    notifyListeners();
  }

  void hideButton() {
    _isButtonVisible = false;
     totalItemCountNotifier.value = 0;
    notifyListeners();
  }

void incrementItemCount(int count) {
    totalItemCountNotifier.value += count;
    notifyListeners();
  }

  void decrementItemCount(int count) {
    totalItemCountNotifier.value = (totalItemCountNotifier.value - count).clamp(0, double.infinity).toInt();
    loge.i(count);
    notifyListeners();
  }



Future<void> updateTotalItemCount(Foodcartcontroller foodcart, dynamic km) async {

    try {

        var cartItems = await foodcart.getfoodcartfood(km: km);
        int totalQuantity = cartItems.fold(0, (sum, item) => sum + (item['quantity'] ?? 0),
      );

        loge.i('==Total Quantity --==> $totalQuantity');
        totalItemCountNotifier.value = totalQuantity;

      
      notifyListeners();
    } catch (e) {
      print("Error updating total item count: $e");
    }
  }

}
 




class FoodCustomizationController extends GetxController {

  var selectedVariantId  =  "".obs;
  var selectedAddons     =  <String>[].obs;
  var foodCustomerPrice  =  0.0.obs;  // This will hold the final price including the variant and add-ons

  // Store variant and add-on prices separately
  var baseVariantPrice = 0.0.obs;
  var addonPrices = <String, double>{}; // Store add-on prices with IDs

  // // Updates the variant selection and recalculates the total price
  // void updateVariant(String? newVariantId, dynamic variantPrice) {
  //   selectedVariantId.value = newVariantId!;
  //   baseVariantPrice.value = variantPrice.toDouble();
  //   calculateTotalPrice(); // Recalculate the total price when the variant changes
  // }

  // // Toggles add-on selection and recalculates the total price
  // void toggleAddon(String addonId, dynamic addonPrice) {
  //   if (selectedAddons.contains(addonId)) {
  //     // Remove add-on and price
  //     selectedAddons.remove(addonId);
  //     addonPrices.remove(addonId); // Remove from the prices map
  //   } else {
  //     // Add add-on and price
  //     selectedAddons.add(addonId);
  //     addonPrices[addonId] = addonPrice.toDouble(); // Store the add-on price
  //   }
  //   calculateTotalPrice(); // Recalculate the total price when add-ons change
  // }
void updateVariant(String? newVariantId, dynamic variantPrice) {
  selectedVariantId.value = newVariantId ?? '';
  baseVariantPrice.value = double.tryParse(variantPrice.toString()) ?? 0.0;
  calculateTotalPrice();
}

void toggleAddon(String addonId, dynamic addonPrice) {
  if (selectedAddons.contains(addonId)) {
    selectedAddons.remove(addonId);
    addonPrices.remove(addonId);
  } else {
    selectedAddons.add(addonId);
    addonPrices[addonId] = double.tryParse(addonPrice.toString()) ?? 0.0;
  }
  calculateTotalPrice();
}

  // Calculates the total price based on the selected variant and add-ons
  void calculateTotalPrice() {
    // Start with the base variant price
    double totalPrice = baseVariantPrice.value;

    // Add the price of all selected add-ons
    for (String addonId in selectedAddons) {
      totalPrice += addonPrices[addonId] ?? 0.0;
    }

    // Update the foodCustomerPrice with the new total price
    foodCustomerPrice.value = totalPrice;
    update();
  }
}


class AddProductController extends GetxController {
  var isButtonVisible = false.obs;
  

 var isFabVisible = true.obs;
  void showButton() {
    isButtonVisible.value = true;
  }

  void hideButton() {
    isButtonVisible.value = false;
  }
}