// ignore_for_file: must_be_immutable, file_names

import 'package:testing/Meat/Meatview/Gridclass.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MeatItemWidget extends StatelessWidget {
 dynamic data;
 dynamic shopId;
 dynamic shopname;
 dynamic totalDis;
  // Constructor
   MeatItemWidget({
    super.key,
    required this.data,
    required this.totalDis,
    required this.shopId,
    required this.shopname,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(148, 255, 255, 255),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            height: 70.h,
            width: MediaQuery.of(context).size.width / 1.05,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      useOldImageOnUrlChange: true,
                      imageUrl: data["meatCateImage"].toString(),
                      placeholder: (context, url) =>
                          Image.asset(meatdummy),
                      errorWidget: (context, url, error) =>
                          Image.asset(meatdummy),
                      height: 60,
                      width: 70,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${data["meatCateName"].toString().capitalizeFirst}",
                          style: CustomTextStyle.splashpermissionTitle,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        data["meatCateDescription"]==null||data["meatCateDescription"].isEmpty?const SizedBox():
                        Text(
                          "${data["meatCateDescription"].toString().capitalizeFirst}",
                          style: CustomTextStyle.boldgrey,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const CustomSizedBox(height: 10),
          MeatGrid(
            shopname: shopname,
            meats: data["meats"],
            shopId: shopId, shopstatus: data["status"], totalDis: totalDis,
          ),
          CustomSizedBox(height: 10.h),
        ],
      ),
    );
  }
}
