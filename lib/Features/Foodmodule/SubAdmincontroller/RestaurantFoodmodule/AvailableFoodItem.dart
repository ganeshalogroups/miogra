// ignore_for_file: avoid_print, use_build_context_synchronously, file_names, unnecessary_null_comparison, must_be_immutabimport 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/Foodgetcontroller.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodlistdesign.dart';
import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Redirectcontroller.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:get/get.dart';

class AvailableItem extends StatelessWidget {
   final dynamic rescommission;
  final dynamic foodIndexvalue;
  final dynamic resid;
  final dynamic totalDis;
  final dynamic index;
  final dynamic model;
  final dynamic restaurantname;
  final dynamic offerPercentage;
  final ValueNotifier<int> itemCountNotifier;
  const AvailableItem({ 
    required this.foodIndexvalue,
    required this.resid,
    required this.totalDis,
    required this.index,
    required this.model,
    required this.restaurantname,
    required this.offerPercentage,
  super.key, required this.itemCountNotifier, 
 required this.rescommission});

  @override
  Widget build(BuildContext context) {
  final RedirectController redirect = Get.find<RedirectController>();
 // var rescom = Provider.of<FoodProductviewPaginations>(context).foodcom;
 return Container(
    margin: const EdgeInsets.only(top: 10, bottom: 10),
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: Customcolors.DECORATION_CONTAINERGREY,
      borderRadius: BorderRadius.circular(15),
      border: const Border(
        bottom: BorderSide(color: Color.fromARGB(255, 202, 199, 199)),
      ),
      boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 182, 182, 182).withOpacity(0.2),
          offset: const Offset(0, 4),
          blurRadius: 6,
          spreadRadius: 0,
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 90,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          memCacheHeight: 200,
                          memCacheWidth: 200,
                          placeholder: (context, url) => Image.asset(fastxdummyImg),
                          errorWidget: (context, url, error) => Image.asset(fastxdummyImg),
                          width: 90,
                          imageUrl: "$globalImageUrlLink${foodIndexvalue.foodImgUrl!}",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    if (foodIndexvalue.iscustomizable == true)
                      const Text("Customisable", style: CustomTextStyle.addressfetch),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(right: 35),
                      child: Row(
                      //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              foodIndexvalue.foodName.toString().capitalizeFirst.toString(),
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                            fontSize: 12.h,
                            fontWeight: FontWeight.w500,
                            color: Customcolors.addressColor,
                            fontFamily: 'Poppins-Medium'),
                            ),
                          ),
                      
                           (offerPercentage != null &&offerPercentage.toString().isNotEmpty &&offerPercentage != 0)?
                       Text(
                                  " ₹ ${foodIndexvalue.iscustomizable == true
                                       ?
                                       (foodIndexvalue.customizedFood!.addVariants!.isNotEmpty
                                          ? foodIndexvalue.customizedFood!.addVariants![0].variantType![0].customerPrice 
                                         :   foodIndexvalue.customizedFood!.addOns![0].addOnsType![0].customerPrice ).toString()
                           :  foodIndexvalue.food!.customerPrice
                                    
                                  }",
                              
                                style: TextStyle(
                            fontSize: 12.h,
                            fontWeight: FontWeight.w600,
                            color: Customcolors.DECORATION_BLACK,
                            fontFamily: 'Poppins-Medium'),
                                ):
                      
                                
                                 Obx(() {
                              if (redirect.isredirectLoading.isTrue) {
                                return const Center(child: CupertinoActivityIndicator());
                              } else if (redirect.redirectLoadingDetails == null ||
                                  redirect.redirectLoadingDetails["data"] == null) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      " ₹${foodIndexvalue.iscustomizable == true
                                          ? (foodIndexvalue.customizedFood!.addVariants!.isNotEmpty
                                              ? foodIndexvalue.customizedFood!.addVariants![0].variantType![0].customerPrice.toString()
                                              : foodIndexvalue.customizedFood!.addOns![0].addOnsType![0].customerPrice.toString())
                                          : foodIndexvalue.food!.customerPrice.toString()
                                      }",
                                      style: CustomTextStyle.foodpricetext,
                                    ),
                                    
                                   
                                  ],
                                );
                              }
                               else {
                                double offerValue = 0;
                                for (var item in redirect.redirectLoadingDetails["data"]) {
                                  if (item["key"] == "offerValue") {
                                     offerValue = item["value"] != null ? double.tryParse(item["value"].toString()) ?? 0 : 0;
                                    break;
                                  }
                                }
                      
                                return Text(
                                  " ₹${foodIndexvalue.iscustomizable == true
                                      ? (foodIndexvalue.customizedFood!.addVariants!.isNotEmpty
                                          ? foodIndexvalue.customizedFood!.addVariants![0].variantType![0].customerPrice
                                          : foodIndexvalue.customizedFood!.addOns![0].addOnsType![0].customerPrice).toString()
                                      : foodIndexvalue.food!.customerPrice.toString()
                                  }",
                                  style: TextStyle(
                                      fontSize: 12.h,
                                      fontWeight: FontWeight.w600,
                                      color: Customcolors.DECORATION_BLACK,
                                      fontFamily: 'Poppins-Medium'),
                                );
                              }
                            }),
                      
                      
                          //  VEG NON VEG IMAGE
                          // Padding(
                          //   padding: const EdgeInsets.only(right: 8, top: 8),
                          //   child: Builder(
                          //     builder: (context) {
                          //       String foodType = foodIndexvalue.foodType ?? '';
                          //       String assetPath;
                      
                          //       switch (foodType) {
                          //         case 'nonveg':
                          //           assetPath = "assets/images/Non veg.png";
                          //           break;
                          //         case 'veg':
                          //           assetPath = "assets/images/veg.png";
                          //           break;
                          //         case 'egg':
                          //           assetPath = "assets/images/egg.jpg";
                          //           break;
                          //         default:
                          //           assetPath = '';
                          //       }
                      
                          //       return assetPath.isNotEmpty
                          //           ? iconFunction(iconname: assetPath)
                          //           : const SizedBox.shrink();
                          //     },
                          //   ),
                          // )
                        ],
                      ),
                    ),

                    
                    // const CustomSizedBox(height: 5),
                    // if (foodIndexvalue.foodDiscription!.toString().isNotEmpty &&
                    //     foodIndexvalue.foodDiscription!.toString() != "null")
                    //   ReadMoreText(
                    //     foodIndexvalue.foodDiscription!.toString(),
                    //     trimLines: 3,
                    //     trimMode: TrimMode.Line,
                    //     trimCollapsedText: ' See more',
                    //     trimExpandedText: ' See less',
                    //     moreStyle: CustomTextStyle.boldblack12,
                    //     lessStyle: const TextStyle(
                    //       fontSize: 12,
                    //       fontWeight: FontWeight.bold,
                    //       color: Customcolors.darkpurple,
                    //     ),
                    //     style: CustomTextStyle.foodDescription,
                    //     textAlign: TextAlign.justify,
                    //     colorClickableText: Customcolors.DECORATION_BLACK,
                    //   ),
                    const SizedBox(height: 10),

Text(restaurantname,style:  TextStyle(
      fontSize: 12.h,
      fontWeight: FontWeight.w600,
      color: Color(0xFF424242),
      fontFamily: 'Poppins-SemiBold'),

),
                    // Price and Button Row
                    (offerPercentage != null &&offerPercentage.toString().isNotEmpty &&offerPercentage != 0)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                             
                             
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: ButtonNew(
                                  totalDis: totalDis,
                                  restaurantname: restaurantname.toString(),
                                  itemcountNotifier: itemCountNotifier,
                                  restaurantId: resid,
                                  index: index,
                                  model: model,
                                ),
                              ),
                            ],
                          )
                        : Obx(() {
                            if (redirect.isredirectLoading.isTrue) {
                              return const Center(child: CupertinoActivityIndicator());
                            } else if (redirect.redirectLoadingDetails == null ||
                                redirect.redirectLoadingDetails["data"] == null) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    " ₹${foodIndexvalue.iscustomizable == true
                                        ? (foodIndexvalue.customizedFood!.addVariants!.isNotEmpty
                                            ? foodIndexvalue.customizedFood!.addVariants![0].variantType![0].customerPrice.toString()
                                            : foodIndexvalue.customizedFood!.addOns![0].addOnsType![0].customerPrice.toString())
                                        : foodIndexvalue.food!.customerPrice.toString()
                                    }",
                                    style: CustomTextStyle.foodpricetext,
                                  ),
                                  const SizedBox(width: 1),
                                  // Text(
                                  //   " ₹${foodIndexvalue.iscustomizable == true
                                  //       ? (foodIndexvalue.customizedFood!.addVariants!.isNotEmpty
                                  //           ? (foodIndexvalue.customizedFood!.addVariants![0].variantType![0].customerPrice +(foodIndexvalue.customizedFood!.addVariants![0].variantType![0].customerPrice*20/100))
                                  //           : (foodIndexvalue.customizedFood!.addOns![0].addOnsType![0].customerPrice+(foodIndexvalue.customizedFood!.addOns![0].addOnsType![0].customerPrice*20/100))).roundToDouble().toStringAsFixed(2)
                                  //       : (foodIndexvalue.food!.customerPrice+(foodIndexvalue.food!.customerPrice*20/100)).roundToDouble().toStringAsFixed(2)}",
                                  //   style: CustomTextStyle.strikered,
                                  // ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: ButtonNew(
                                      totalDis: totalDis,
                                      restaurantname: restaurantname.toString(),
                                      itemcountNotifier: itemCountNotifier,
                                      restaurantId: resid,
                                      index: index,
                                      model: model,
                                    ),
                                  ),
                                ],
                              );
                            }
                             else {
                              double offerValue = 0;
                              for (var item in redirect.redirectLoadingDetails["data"]) {
                                if (item["key"] == "offerValue") {
                                   offerValue = item["value"] != null ? double.tryParse(item["value"].toString()) ?? 0 : 0;
                                  break;
                                }
                              }

                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    " ₹${foodIndexvalue.iscustomizable == true
                                        ? (foodIndexvalue.customizedFood!.addVariants!.isNotEmpty
                                            ? foodIndexvalue.customizedFood!.addVariants![0].variantType![0].customerPrice
                                            : foodIndexvalue.customizedFood!.addOns![0].addOnsType![0].customerPrice).toString()
                                        : foodIndexvalue.food!.customerPrice.toString()
                                    }",
                                    style: TextStyle(
      fontSize: 12.h,
      fontWeight: FontWeight.w600,
      color: Customcolors.DECORATION_BLACK,
      fontFamily: 'Poppins-Medium'),
                                  ),
                                  const SizedBox(width: 1),
                                  if (offerValue != null)
                                    // Text(
                                    //   " ₹${foodIndexvalue.iscustomizable == true
                                    //       ? (foodIndexvalue.customizedFood!.addVariants!.isNotEmpty
                                    //           ? (foodIndexvalue.customizedFood!.addVariants![0].variantType![0].customerPrice+(foodIndexvalue.customizedFood!.addVariants![0].variantType![0].customerPrice*offerValue/100))
                                    //           : (foodIndexvalue.customizedFood!.addOns![0].addOnsType![0].customerPrice +(foodIndexvalue.customizedFood!.addOns![0].addOnsType![0].customerPrice*offerValue/100))).roundToDouble().toStringAsFixed(2)
                                    //       : (foodIndexvalue.food!.customerPrice +(foodIndexvalue.food!.customerPrice *offerValue/100)).roundToDouble().toStringAsFixed(2)
                                    //   }",
                                    //   style: CustomTextStyle.strikered,
                                    // ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: ButtonNew(
                                      totalDis: totalDis,
                                      restaurantname: restaurantname.toString(),
                                      itemcountNotifier: itemCountNotifier,
                                      restaurantId: resid,
                                      index: index,
                                      model: model,
                                    ),
                                  ),
                                ],
                              );
                            }
                          }),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
  }
}
