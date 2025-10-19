// ignore_for_file: file_names

import 'package:testing/Mart/Cartscreen/Commoncartwidgets/MartCouponscreen.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/CustomDottedline.dart';
import 'package:testing/utils/Decorations/boxDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MartCouponWidget extends StatefulWidget {
  const MartCouponWidget({super.key});

  @override
  State<MartCouponWidget> createState() => _MartCouponWidgetState();
}

class _MartCouponWidgetState extends State<MartCouponWidget> {
  @override
  Widget build(BuildContext context) {
      return Container(
      decoration: BoxDecorationsFun.whiteCircelRadiusDecoration(radious: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 23,
                  height: 35,
                  child: Image.asset("assets/images/discount.png"),
                ),
                SizedBox(width: 11.w),
                const Row(
                  children: [
                    Text(
                      "Save ₹125 more with GET125",
                      style: CustomTextStyle.boldblack12,
                    ),
                  ],
                ),

                const Spacer(flex: 1),
                 InkWell(
                 onTap: () { },
                 child: const Text(
                "Remove",
                 style: CustomTextStyle.DECORATION_regulartext,
                 ),
                ) //
              ],
            ),
            8.toHeight,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: DotLine(height: 0),
            ),
            8.toHeight,
            InkWell(
              onTap: () {
             Get.to( const MartCouponscreen());
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("View more coupon", style: CustomTextStyle.boldgrey),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Customcolors.DECORATION_GREY,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}