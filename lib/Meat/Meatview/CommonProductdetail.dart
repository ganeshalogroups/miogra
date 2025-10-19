// ignore_for_file: must_be_immutable, unnecessary_string_interpolations, file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Commonproductdetailclass extends StatefulWidget {
  dynamic meatItem;
  dynamic shopstatus;
  dynamic availableStatus;
  dynamic meatstatus;
  Commonproductdetailclass({super.key, required this.meatItem ,required this.availableStatus,required this.shopstatus,required this.meatstatus,});

  @override
  State<Commonproductdetailclass> createState() =>CommonproductdetailclassState();
}

class CommonproductdetailclassState extends State<Commonproductdetailclass> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Product Details',
              style: CustomTextStyle
                  .lightorangetext, // Use your preferred text style
            ),
          ),
          const SizedBox(height: 16),
      
          // Image
          widget.availableStatus==true &&widget.meatstatus==true&&widget.shopstatus==true?
           Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                useOldImageOnUrlChange: true,
                imageUrl: widget.meatItem["meatImgUrl"],
                placeholder: (context, url) =>Image.asset(meatdummy),
                errorWidget: (context, url, error) =>Image.asset(meatdummy),
                height: 220.h,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
          ):Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ColorFiltered(
              colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.saturation,),
                child: CachedNetworkImage(
                  useOldImageOnUrlChange: true,
                  imageUrl: widget.meatItem["meatImgUrl"],
                  placeholder: (context, url) =>Image.asset(meatdummy),
                  errorWidget: (context, url, error) =>Image.asset(meatdummy),
                  height: 220.h,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '${widget.meatItem["meatName"].toString().capitalizeFirst.toString()}',
            style: CustomTextStyle.boldblack, // Use your preferred text style
          ),
          const SizedBox(height: 8),
          // Product Description
          Text(
            '${widget.meatItem["meatDiscription"].toString().capitalizeFirst.toString()}',
            style:CustomTextStyle.foodDescription, // Use your preferred text style
            maxLines: 3,
            overflow: TextOverflow.clip,
            // textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
