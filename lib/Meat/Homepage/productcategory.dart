// ignore_for_file: unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:testing/Meat/MeatController.dart/Meatcategory.dart';
import 'package:testing/Meat/MeatSearch/Meatlist.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Shimmers/CategoriesShimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MeatProductcategory extends StatefulWidget {
  const MeatProductcategory({super.key});

  @override
  State<MeatProductcategory> createState() => _MeatProductcategoryState();
}
class _MeatProductcategoryState extends State<MeatProductcategory> {
  final Categorymeatlistcontroller getcat = Get.put(Categorymeatlistcontroller());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (getcat.iscategorymeatloading.isTrue) {
        return const Center(child:  CategoriesShimmer());
      } else if (getcat.categorymeat == null || getcat.categorymeat["data"].isEmpty) {
        return const Center(
          child: Text("No Meat Categories Found",style: CustomTextStyle.chipgrey,),
        );
      } else {
        return SizedBox(
          height: 75.h,
          child: ListView.builder(
            itemCount: getcat.categorymeat["data"].length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
              onTap: () {
                Get.to(Meatlistscreen(searchvalue:getcat.categorymeat["data"][index]["foodCusineName"].toString() ,meatproductcategoryid: meatproductCateId,), transition: Transition.leftToRight);
              },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: Customcolors.DECORATIONVERYLIGHTGREY,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: CachedNetworkImage(
                          imageUrl: getcat.categorymeat["data"][index]["foodCusineImage"].toString(),
                          imageBuilder: (context, imageProvider) => Container(
                            width: 65.w,
                            height: 55.h,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(meatdummy),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.transparent,
                            ),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            "${fastxdummyImg}",
                            width: 65.w,
                            height: 55.h,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(
                        child: AutoSizeText(
                          getcat.categorymeat["data"][index]["foodCusineName"]
                              .toString()
                              .capitalizeFirst
                              .toString(),
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          wrapWords: true,
                          style: CustomTextStyle.addressfetch,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }
    });
  }
}
