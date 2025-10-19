// ignore_for_file: file_names, must_be_immutable

import 'package:testing/Features/coupon/couponController.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatOrderController/MeatCouponcontroller.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';



class CouponDialogContent extends StatelessWidget {

  bool isSingle;
  final VoidCallback onClose;

   CouponDialogContent({super.key, required this.onClose,required this.isSingle});

  @override
  Widget build(BuildContext context) {
   var coupon  =  Provider.of<CouponController>(context);
     return isSingle ?  Stack(
      children: [
        SizedBox(
          height: 210.0.h,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/CoupenAnimation.gif",
                  height: 120.0,
                  filterQuality: FilterQuality.high,
                ),
                Text("“${coupon.pcouponTitle}” applied", style: CustomTextStyle.coupountext),
                const SizedBox(height: 5),
               coupon.pcoupontype == 'percentage' ?
               Text(
                  "${coupon.pcouponAmt}% Savings with this Coupon",
                  style: CustomTextStyle.bigORANGEtext,
                  textAlign: TextAlign.center,
                ):
               Text(
                  "₹${coupon.pcouponAmt} Savings with this Coupon",
                  style: CustomTextStyle.bigORANGEtext,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                const Text(
                  "Enjoy the great offers with every order on Fastx!",
                  textAlign: TextAlign.center,
                  style: CustomTextStyle.smallblacktext,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: IconButton(
            icon: const Icon(Icons.close, color: Customcolors.DECORATION_GREY),
            onPressed: onClose,
          ),
        ),
      ],
    )   
       : 
    
     Stack(
      children: [
        SizedBox(
          height: 210.0.h,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/CoupenAnimation.gif",
                  height: 120.0,
                  filterQuality: FilterQuality.high,
                ),
                Text("“${coupon.rTrippcouponTitle}” applied", style: CustomTextStyle.coupountext),
                const SizedBox(height: 5),
               coupon.rTrippcouponTypee == 'percentage' ?
               Text(
                  "${coupon.rTrippcouponAmt}% Savings with this Coupon",
                  style: CustomTextStyle.bigORANGEtext,
                  textAlign: TextAlign.center,
                ):
               Text(
                  "₹${coupon.rTrippcouponAmt} Savings with this Coupon",
                  style: CustomTextStyle.bigORANGEtext,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                const Text(
                  "Enjoy the great offers with every order on Fastx!",
                  textAlign: TextAlign.center,
                  style: CustomTextStyle.smallblacktext,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: IconButton(
            icon: const Icon(Icons.close, color: Customcolors.DECORATION_GREY),
            onPressed: onClose,
          ),
        ),
      ],
    )
    
    ;
  }
}






/////////////////////////////////////////////////////////////////////////////////////////////////////
///
///
///
///






class ParcelCouponCart extends StatelessWidget {

  final VoidCallback onClose;

   const ParcelCouponCart({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
     var coupon  =  Provider.of<CouponController>(context);
    return   Stack(
      children: [
        SizedBox(
          height: 210.0.h,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/CoupenAnimation.gif",
                  height: 120.0,
                  filterQuality: FilterQuality.high,
                ),
                Text("“${coupon.couponTitle}” applied", style: CustomTextStyle.coupountext),
                const SizedBox(height: 5),
               coupon.coupontype == 'percentage' ?
               Text(
                  "${coupon.couponAmt}% Savings with this Coupon",
                  style: CustomTextStyle.bigORANGEtext,
                  textAlign: TextAlign.center,
                ):
               Text(
                  "₹${coupon.couponAmt} Savings with this Coupon",
                  style: CustomTextStyle.bigORANGEtext,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                const Text(
                  "Enjoy the great offers with every order on Fastx!",
                  textAlign: TextAlign.center,
                  style: CustomTextStyle.smallblacktext,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: IconButton(
            icon: const Icon(Icons.close, color: Customcolors.DECORATION_GREY),
            onPressed: onClose,
          ),
        ),
      ],
    );
     
  }
}



// For meat

class MeatCouponDialogContent extends StatelessWidget {
  final VoidCallback onClose;

   const MeatCouponDialogContent({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
   var coupon  =  Provider.of<MeatCouponController>(context);
     return  Stack(
      children: [
        SizedBox(
          height: 210.0.h,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/CoupenAnimation.gif",
                  height: 120.0,
                  filterQuality: FilterQuality.high,
                ),
                Text("“${coupon.couponTitle}” applied", style: CustomTextStyle.coupountext),
                const SizedBox(height: 5),
               coupon.coupontype == 'percentage' ?
               Text(
                  "${coupon.couponAmt}% Savings with this Coupon",
                  style: CustomTextStyle.bigORANGEtext,
                  textAlign: TextAlign.center,
                ):
               Text(
                  "₹${coupon.couponAmt} Savings with this Coupon",
                  style: CustomTextStyle.bigORANGEtext,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                const Text(
                  "Enjoy the great offers with every order on Fastx!",
                  textAlign: TextAlign.center,
                  style: CustomTextStyle.smallblacktext,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: IconButton(
            icon: const Icon(Icons.close, color: Customcolors.DECORATION_GREY),
            onPressed: onClose,
          ),
        ),
      ],
    )  ;
  }
}