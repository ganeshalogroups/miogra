
// ignore_for_file: must_be_immutable, file_names, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'package:cached_network_image/cached_network_image.dart';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Addfoodcontroller.dart';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Foodsearchlistgetcontroller.dart';
import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Redirectcontroller.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Disabledishes extends StatelessWidget {
  dynamic foods;
   Disabledishes({ 
      this.foods,
      super.key});
  Foodsearchcontroller createrecentsearch = Get.find<Foodsearchcontroller>();
   RedirectController redirect =  Get.find<RedirectController>();
   Foodcartcontroller foodcart = Get.find<Foodcartcontroller>();
  @override
  Widget build(BuildContext context) {
      final isCustomizable = foods["iscustomizable"] == true;

    final dynamic actualPrice = isCustomizable
        ? foods["customizedFood"]["addVariants"][0]["variantType"][0]["customerPrice"]
        : foods["food"]["customerPrice"];
      return Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Color.fromARGB(255, 240, 240, 240),
            ),
            child: Row(
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child:
                    // createrecentsearch.foodsearchlist!["data"]["AdminUserList"][widget.index]
                    // ["categoryDetails"][0]["foods"][widget.index2]["additionalImage"].isEmpty ?
                        Column(
                            children: [
                              ClipRRect(
                                borderRadius:
                                    const BorderRadius.all( Radius.circular(10)),
                                child: ColorFiltered(
                                  colorFilter: const ColorFilter.mode(
                                    Colors.grey,
                                    BlendMode.saturation,
                                  ),
                                  child: CachedNetworkImage(
                                    placeholder: (context, url) => Image.asset(
                                      "${fastxdummyImg}",
                                      fit: BoxFit.fill,
                                      height: 10,
                                      width: 10,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                      "${fastxdummyImg}",
                                      fit: BoxFit.fill,
                                      height: 10,
                                      width: 10,
                                    ),
                                     height: 100,
                                     width: 90,
                                    imageUrl:"${globalImageUrlLink}${foods["foodImgUrl"].toString()}",
                                    fit: BoxFit.fill,
                                    // You can specify height and width if needed, or omit them.
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              foods["iscustomizable"]? const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 12),
                                      child: Text("Customisable",style: CustomTextStyle.addressfetch),
                                    )
                                  : const SizedBox.shrink()
                            ],
                          )
                         
                        ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(height: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  foods["foodName"].toString().capitalizeFirst.toString(),
                                  style: CustomTextStyle.googlebuttontext,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Image(
                               image:foods["foodType"] =="nonveg"
                                        ? const AssetImage( "assets/images/Non veg.png")
                                        : const AssetImage("assets/images/veg.png"),
                                height: 15,
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                          const SizedBox(height: 5),
                           foods["foodDiscription"] == null ||foods["foodDiscription"]  == "" || foods["foodDiscription"]  .isEmpty
                                  ? const SizedBox.shrink()
                                  : Text("${foods["foodDiscription"].toString().trim().capitalizeFirst!}",
                                      style: CustomTextStyle.boldgrey,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Text(
          "₹ ${actualPrice.toStringAsFixed(1)}",
          style: CustomTextStyle.foodpricetext,
        ),
                      const CustomSizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  
  }
}