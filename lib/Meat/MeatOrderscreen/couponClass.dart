// ignore_for_file: must_be_immutable, file_names

import 'package:testing/Meat/MeatOrderscreen/MeatCouponscreen.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatOrderController/MeatCouponcontroller.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/CustomDottedline.dart';
import 'package:testing/utils/Decorations/boxDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CouponWidget extends StatefulWidget {
  dynamic shopid;
  dynamic totalDis;
  CouponWidget({super.key, required this.shopid,required this.totalDis});

  @override
  State<CouponWidget> createState() => CouponWidgetState();
}

class CouponWidgetState extends State<CouponWidget> {
  @override
  Widget build(BuildContext context) {
    var coupon = Provider.of<MeatCouponController>(context);
    String getFormattedText() {
      if (coupon.coupontype == "percentage") {
        return "Save ${coupon.couponamount}% more with Miogra";
      } else if (coupon.coupontype == "subtraction") {
        return "Save ₹${coupon.couponamount} more with Miogra";
      } else {
        return "Get Your Coupon";
      }
    }

    bool isCouponApplied = false;

    void applyCoupon() {
      setState(() {
        isCouponApplied = true;
      });
    }

    void removeCoupon() {
      setState(() {
        isCouponApplied = false;
      });
    }

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
                Row(
                  children: [
                    Text(
                      getFormattedText(),
                      style: CustomTextStyle.boldblack12,
                    ),
                  ],
                ),

                const Spacer(flex: 1),

                coupon.isCouponApplied
                    ? InkWell(
                        onTap: () {
                          coupon.removeCoupon();
                        },
                        child: const Text(
                          "Remove",
                          style: CustomTextStyle.DECORATION_regulartext,
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          Get.to(
                              Meatcouponscreen(
                                shopid: widget.shopid,
                                totalDis: widget.totalDis,
                                isCouponApplied: isCouponApplied,
                                apply: applyCoupon,
                                remove: removeCoupon,
                              ),
                              transition: Transition.zoom);
                        },
                        child: const Text("Apply",
                            style: CustomTextStyle.DECORATION_regulartext)), //
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
                 Get.to(
                   Meatcouponscreen(
                     shopid: widget.shopid,
                     totalDis: widget.totalDis,
                     isCouponApplied: isCouponApplied,
                     apply: applyCoupon,
                     remove: removeCoupon,), transition: Transition.zoom);
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
