
// ignore_for_file: avoid_print, use_build_context_synchronously, file_names, unnecessary_null_comparison, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodlistdesign.dart';
import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Redirectcontroller.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:get/get.dart';

class UnavailableItem extends StatelessWidget {
  final dynamic foodIndexvalue;
  final dynamic resid;
  final dynamic totalDis;
  final dynamic index;
  final dynamic model;
  final dynamic offerPercentage;
  final dynamic restaurantname;
  final dynamic restaurantAvailable;
  final ValueNotifier<int> itemCountNotifier;

  const UnavailableItem({
    super.key,
    required this.offerPercentage,
    this.foodIndexvalue,
    required this.resid,
    required this.totalDis,
    required this.index,
    required this.restaurantAvailable,
    this.model,
    required this.restaurantname,
    required this.itemCountNotifier,
  });

  @override
  Widget build(BuildContext context) {
    final RedirectController redirect = Get.find<RedirectController>();
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: const Border(
          bottom: BorderSide(color: Color.fromARGB(255, 202, 199, 199)),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: Customcolors.DECORATION_CONTAINERGREY,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 182, 182, 182).withOpacity(0.2),
            offset: const Offset(0, 4),
            blurRadius: 6,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                        width: 90,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          child: ColorFiltered(
                            colorFilter: const ColorFilter.mode(
                              Colors.grey,
                              BlendMode.saturation,
                            ),
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
                      ),
                      if (foodIndexvalue.iscustomizable == true)
                        const Text("Customisable", style: CustomTextStyle.addressfetch),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              foodIndexvalue.foodName.toString().capitalizeFirst.toString(),
                              overflow: TextOverflow.clip,
                            //  style: CustomTextStyle.googlebuttontext,
                            style: TextStyle(
      fontSize: 12.h,
      fontWeight: FontWeight.w600,
      color: Customcolors.DECORATION_BLACK,
      fontFamily: 'Poppins-Medium'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8, top: 8),
                            child: Builder(
                              builder: (context) {
                                String foodType = foodIndexvalue.foodType ?? '';
                                String assetPath;

                                switch (foodType) {
                                  case 'nonveg':
                                    assetPath = "assets/images/Non veg.png";
                                    break;
                                  case 'veg':
                                    assetPath = "assets/images/veg.png";
                                    break;
                                  case 'egg':
                                    assetPath = "assets/images/egg.jpg";
                                    break;
                                  default:
                                    assetPath = '';
                                }

                                return assetPath.isNotEmpty
                                    ? iconFunction(iconname: assetPath)
                                    : const SizedBox.shrink();
                              },
                            ),
                          )
                        ],
                      ),
                      // const CustomSizedBox(height: 5),
                      // if (foodIndexvalue.foodDiscription?.toString().isNotEmpty == true &&
                      //     foodIndexvalue.foodDiscription!.toString() != "null")
                      //   ReadMoreText(
                      //     (foodIndexvalue.foodDiscription!.toString()),
                      //     style: CustomTextStyle.foodDescription,
                      //     textAlign: TextAlign.justify,
                      //     trimLines: 3,
                      //     colorClickableText: Colors.blue,
                      //     trimMode: TrimMode.Line,
                      //     trimCollapsedText: 'See more',
                      //     trimExpandedText: 'See less',
                      //     moreStyle: CustomTextStyle.boldblack12,
                      //     lessStyle: const TextStyle(
                      //       fontSize: 12,
                      //       fontWeight: FontWeight.bold,
                      //       color: Customcolors.darkpurple,
                      //     ),
                      //   ),
                      const SizedBox(height: 10),

                      /// Offer price block
                      (offerPercentage != null &&
                              offerPercentage.toString().isNotEmpty &&
                              offerPercentage != 0)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  " ₹${foodIndexvalue.iscustomizable == true
                                      ? (foodIndexvalue.customizedFood!.addVariants!.isNotEmpty
                                          ? foodIndexvalue.customizedFood!.addVariants![0].variantType![0].customerPrice
                                          : foodIndexvalue.customizedFood!.addOns![0].addOnsType![0].customerPrice)
                                          .toStringAsFixed(0)
                                      : foodIndexvalue.food!.customerPrice.toStringAsFixed(0)}",
                                 // style: CustomTextStyle.foodpricetext,
                                  style: TextStyle(
      fontSize: 12.h,
      fontWeight: FontWeight.w600,
      color: Customcolors.DECORATION_BLACK,
      fontFamily: 'Poppins-Medium'),
                                ),
                                // const SizedBox(width: 1),
                                // Text(
                                //   " ₹${foodIndexvalue.iscustomizable == true
                                //       ? (foodIndexvalue.customizedFood!.addVariants!.isNotEmpty
                                //           ? foodIndexvalue.customizedFood!.addVariants![0].variantType![0].customerPrice+(foodIndexvalue.customizedFood!.addVariants![0].variantType![0].customerPrice*offerPercentage/100)
                                //           : foodIndexvalue.customizedFood!.addOns![0].addOnsType![0].customerPrice+(foodIndexvalue.customizedFood!.addOns![0].addOnsType![0].customerPrice*offerPercentage/100))
                                //          .roundToDouble() .toStringAsFixed(2)
                                //       : (foodIndexvalue.food!.customerPrice +(foodIndexvalue.food!.customerPrice*offerPercentage/100)).roundToDouble().toStringAsFixed(2)}",
                                //   style: CustomTextStyle.strikered,
                                // ),
                                const Spacer(),
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
                                              ? foodIndexvalue.customizedFood!.addVariants![0].variantType![0].customerPrice
                                              : foodIndexvalue.customizedFood!.addOns![0].addOnsType![0].customerPrice)
                                              .toStringAsFixed(0)
                                          : foodIndexvalue.food!.customerPrice.toStringAsFixed(0)}",
                                      style: CustomTextStyle.foodpricetext,
                                    ),
                                    const SizedBox(width: 1),
                                    Text(
                                      " ₹${foodIndexvalue.iscustomizable == true
                                          ? (foodIndexvalue.customizedFood!.addVariants!.isNotEmpty
                                              ? foodIndexvalue.customizedFood!.addVariants![0].variantType![0].customerPrice+(foodIndexvalue.customizedFood!.addVariants![0].variantType![0].customerPrice*20/100)
                                              : foodIndexvalue.customizedFood!.addOns![0].addOnsType![0].customerPrice+( foodIndexvalue.customizedFood!.addOns![0].addOnsType![0].customerPrice*20/100))
                                              .roundToDouble().toStringAsFixed(2)
                                          : (foodIndexvalue.food!.customerPrice+(foodIndexvalue.food!.customerPrice*20/100)).roundToDouble().toStringAsFixed(2)}",
                                      style: CustomTextStyle.strikered,
                                    ),
                                    const Spacer(),
                                  ],
                                );
                              } else {
                                double offerValue = 0;
                                for (var item in redirect.redirectLoadingDetails["data"]) {
                                  if (item["key"] == "offerValue") {
                                    offerValue = double.tryParse(item["value"].toString()) ?? 0;
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
                                              : foodIndexvalue.customizedFood!.addOns![0].addOnsType![0].customerPrice)
                                              .toStringAsFixed(0)
                                          : foodIndexvalue.food!.customerPrice.toStringAsFixed(0)}",
                                      style: CustomTextStyle.foodpricetext,
                                    ),
                                    const SizedBox(width: 1),
                                    if (offerValue != null)
                                      Text(
                                        " ₹${foodIndexvalue.iscustomizable == true
                                            ? (foodIndexvalue.customizedFood!.addVariants!.isNotEmpty
                                                ? foodIndexvalue.customizedFood!.addVariants![0].variantType![0].customerPrice+(foodIndexvalue.customizedFood!.addVariants![0].variantType![0].customerPrice*offerValue/100)
                                                : foodIndexvalue.customizedFood!.addOns![0].addOnsType![0].customerPrice+(foodIndexvalue.customizedFood!.addOns![0].addOnsType![0].customerPrice*offerValue/100))
                                                .roundToDouble().toStringAsFixed(2)
                                            : (foodIndexvalue.food!.customerPrice+(foodIndexvalue.food!.customerPrice*offerValue/100)).roundToDouble().toStringAsFixed(2)}",
                                        style: CustomTextStyle.strikered,
                                      ),
                                    const Spacer(),
                                  ],
                                );
                              }
                            }),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


