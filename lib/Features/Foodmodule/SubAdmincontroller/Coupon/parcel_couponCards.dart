// ignore_for_file: file_names, unnecessary_const

import 'dart:async';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/Coupon/Coupondialog.dart';
import 'package:testing/Features/coupon/couponController.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/CustomDottedline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ParcelCouponCards extends StatefulWidget {
  bool isFromSingle;
  dynamic couponId;
  dynamic couponcode;
  dynamic hashUser;
  bool isused;
  dynamic cupontitle;
  dynamic discountvalue;
  dynamic coupontype;
  dynamic availableStatus;
  bool status;
  bool pricestatus;
  dynamic originalprice;
  List coupondetails;
  dynamic abovevalue;
  final VoidCallback apply;
  final VoidCallback remove;
  bool isCouponApplied;
  dynamic couponstartDate;
  dynamic couponendDate;

  ParcelCouponCards(
      {super.key,
      required this.isCouponApplied,
      required this.couponId,
      required this.cupontitle,
      required this.isFromSingle,
      required this.discountvalue,
      required this.coupontype,
      required this.isused,
      required this.hashUser,
      required this.availableStatus,
      required this.pricestatus,
      required this.status,
      required this.couponcode,
      required this.originalprice,
      required this.coupondetails,
      required this.abovevalue,
      required this.apply,
      required this.remove,
      required this.couponendDate,
      required this.couponstartDate});

  @override
  State<ParcelCouponCards> createState() => _ParcelCouponCardsState();
}

class _ParcelCouponCardsState extends State<ParcelCouponCards> {
  bool _showDetails1 = false;

  @override
  Widget build(BuildContext context) {
    if (checkStatus() == true) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CustomContainer(
                  height: 80.h, // Set the desired height
                  child: Image.asset(
                    "assets/images/Colorcoupon.png",
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Expanded(
                  child: Container(
                    // height: 80.h,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: const BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        color: Customcolors.DECORATION_WHITE),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _showDetails1 = !_showDetails1;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.cupontitle.toString().toUpperCase(),
                                  overflow: TextOverflow.ellipsis,
                                  style: CustomTextStyle.foodpricetext,
                                ),
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Details",
                                    style: CustomTextStyle.mapgrey12,
                                  ),
                                  Icon(
                                    _showDetails1
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    color: Customcolors.DECORATION_GREY,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        // const SizedBox(height: 5),

                        howMuchDiscount(),

                        Text(widget.couponcode,
                            style: CustomTextStyle.mapgrey12),
                        5.toHeight,
                        CustomPaint(
                          size: Size(MediaQuery.of(context).size.width / 1,
                              5), // Adjust size here
                          painter: DottedLinePainter(),
                        ),

                        InkWell(
                            onTap: () async {
                              if (widget.isCouponApplied) {
                                // If coupon is already applied, trigger remove action
                                widget.remove();
                                Provider.of<CouponController>(context,
                                        listen: false)
                                    .parcelsetCouponApplied(false);
                              } else {
                                // Otherwise, trigger apply action
                                widget.apply();
                                Provider.of<CouponController>(context,
                                        listen: false)
                                    .parcelsetCouponApplied(true);
                              }
                              // Close the screen

                              logger.i(
                                  'coupon Id for ${widget.cupontitle}   ${widget.couponId}');

                              Provider.of<CouponController>(context,
                                      listen: false)
                                  .parcelcouponlocalData(
                                      couponAmount:
                                          widget.discountvalue.toString(),
                                      couponid: widget.couponId.toString(),
                                      coupontitl: widget.cupontitle.toString(),
                                      isPrecntage:
                                          widget.coupontype == 'percentage'
                                              ? true
                                              : false,
                                      couponType: widget.coupontype,
                                      aboveAmount:
                                          widget.abovevalue.toDouble());
                              Navigator.pop(context);

                              // Show the dialog
                            //  shoDialog();
                              Future.delayed(const Duration(seconds: 1), () {
                                // Navigator.of(context).pop();
                              });
                            },
                            child: const Center(
                                child: Text(
                              "TAP TO APPLY",
                              style: CustomTextStyle.oRANGEtext,
                            ))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: _showDetails1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                  width: MediaQuery.of(context).size.width / 1,
                  color: Customcolors.DECORATION_WHITE,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ListView.separated(
                          itemCount: widget.coupondetails.length,
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => 8.toHeight,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                const Icon(Icons.circle,
                                    size: 6,
                                    color: Customcolors.DECORATION_DARKGREY),
                                4.toWidth,
                                Text(widget.coupondetails[index],
                                    style: CustomTextStyle.boldgrey),
                              ],
                            );
                          },
                        ),
                        8.toHeight,
                        Row(
                          children: [
                            const Icon(Icons.circle,
                                size: 6,
                                color: Customcolors.DECORATION_DARKGREY),
                            const SizedBox(width: 4),
                            Text('Valid from ${widget.couponstartDate}',
                                style: CustomTextStyle.cartminigrey),
                          ],
                        ),
                        8.toHeight,
                        Row(
                          children: [
                            const Icon(Icons.circle,
                                size: 6,
                                color: Customcolors.DECORATION_DARKGREY),
                            const SizedBox(width: 4),
                            Text('Expired on ${widget.couponendDate}',
                                style: CustomTextStyle.cartminigrey),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
          )
        ],
      );
    } else {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  height: 80.h, // Set the desired height
                  child: Image.asset(
                    "assets/images/Greycoupon.png",
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Expanded(
                  child: Container(
                    // height: 80.h,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        color: Customcolors.DECORATION_WHITE),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _showDetails1 = !_showDetails1;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.cupontitle.toString().toUpperCase(),
                                  overflow: TextOverflow.ellipsis,
                                  style: CustomTextStyle.foodpricetext,
                                ),
                              ),
                              Row(
                                children: [
                                  const Text("Details",
                                      style: CustomTextStyle.mapgrey12),
                                  Icon(
                                      _showDetails1
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down,
                                      color: Customcolors.DECORATION_GREY)
                                ],
                              ),
                            ],
                          ),
                        ),
                        howMuchDiscount(),
                        Text(widget.couponcode,
                            style: CustomTextStyle.mapgrey12),
                        5.toHeight,
                        CustomPaint(
                            size:
                                Size(MediaQuery.of(context).size.width / 1, 5),
                            painter: DottedLinePainter()),
                        const Center(
                            child: Text(
                          "TAP TO APPLY",
                          style: CustomTextStyle.mapgrey,
                        )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: _showDetails1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                  width: MediaQuery.of(context).size.width / 1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Customcolors.DECORATION_WHITE),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ListView.builder(
                          itemCount: widget.coupondetails.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                const Icon(Icons.circle,
                                    size: 6,
                                    color: Customcolors.DECORATION_DARKGREY),
                                4.toWidth,
                                Text(widget.coupondetails[index],
                                    style: CustomTextStyle.boldgrey),
                              ],
                            );
                          },
                        ),
                        8.toHeight,
                        Row(
                          children: [
                            const Icon(Icons.circle,
                                size: 6,
                                color: Customcolors.DECORATION_DARKGREY),
                            const SizedBox(width: 4),
                            Text('Valid from ${widget.couponstartDate}',
                                style: CustomTextStyle.cartminigrey),
                          ],
                        ),
                        8.toHeight,
                        Row(
                          children: [
                            const Icon(Icons.circle,
                                size: 6,
                                color: Customcolors.DECORATION_DARKGREY),
                            const SizedBox(width: 4),
                            Text('Expired on ${widget.couponendDate}',
                                style: CustomTextStyle.cartminigrey),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ],
      );
    }
  }

  Widget howMuchDiscount() {
    if (widget.coupontype == 'percentage') {
      return Text("Save ${widget.discountvalue}% on this order!",
          style: CustomTextStyle.greenordertext);
    } else {
      return Text("Save ₹${widget.discountvalue} on this order!",
          style: CustomTextStyle.greenordertext);
    }
  }

  // void shoDialog({isFromSingGle}) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       // Create a callback to close the dialog after a delay
  //       Future.delayed(const Duration(seconds: 5), () {
  //         Navigator.of(context).pop();
  //       });

  //       return Theme(
  //         data: ThemeData(
  //             dialogTheme: const DialogTheme(backgroundColor: Colors.white)),
  //         child: AlertDialog(
  //           surfaceTintColor: Colors.white,
  //           shape: const RoundedRectangleBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(20.0)),
  //           ),
  //           content: CouponDialogContent(
  //             isSingle: widget.isFromSingle,
  //             onClose: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  final logger = Logger();

  bool checkStatus() {
    //widget.availableStatus == 'active' &&  widget.status &&  widget.isused == false &&

    if (widget.originalprice < widget.abovevalue &&
        widget.status &&
        widget.availableStatus == 'active' &&
        widget.isused == false) {
      //  if (widget.originalprice >= widget.abovevalue &&
      //     widget.availableStatus == 'active' &&
      //     widget.status &&
      //     widget.isused == false) {
      logger.d('🐛🐛(-----------------vv----------------)🐛🐛');
      logger.i('Available status : ${widget.availableStatus}');
      logger.i('Status           : ${widget.status}');
      logger.i('IsUsed           : ${widget.isused}');
      logger
          .i('Above value      : ${widget.originalprice >= widget.abovevalue}');
      logger.i(
          'Original Price   : ${widget.originalprice}   above price : ${widget.abovevalue}');

      return true;
    } else {
      logger.w('(---------else part ---------------)');
      // logger.w('Available status : ${widget.availableStatus}');
      logger.w('Status           : ${widget.status}');
      logger.w('IsUsed           : ${widget.isused}');
      logger
          .w('Above value      : ${widget.originalprice >= widget.abovevalue}');
      logger.w(
          'Original Price   : ${widget.originalprice}   above price : ${widget.abovevalue}');

      return false;
    }
  }
}
