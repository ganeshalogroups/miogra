import 'dart:async';

import 'package:testing/Features/Foodmodule/SubAdmincontroller/Coupon/parcel_couponCards.dart';
import 'package:testing/Features/coupon/couponController.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Validator/dateFormatters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ParcelCouponScreen extends StatefulWidget {
  bool isfromSingleTrip;
  bool isCouponApplied;
  final VoidCallback apply;
  final VoidCallback remove;
  dynamic baseprice;

  ParcelCouponScreen({
    super.key,
    required this.apply,
    required this.baseprice,
    required this.isCouponApplied,
    required this.isfromSingleTrip,
    required this.remove,
  });

  @override
  State<ParcelCouponScreen> createState() => _ParcelCouponScreenState();
}

class _ParcelCouponScreenState extends State<ParcelCouponScreen> {
  TextEditingController couponController = TextEditingController();
  


  @override
  void initState() {
     WidgetsBinding.instance.addPostFrameCallback((_) {
       Provider.of<CouponController>(context, listen: false)
           .getCouponFunction(value: "", serviceType: parcelservice);
   
     });

    super.initState();
  }

  bool pricestatus = false;

  @override
  Widget build(BuildContext context) {
    var amttotal = Provider.of<CouponController>(context, listen: false);

    return Scaffold(
      backgroundColor: Customcolors.DECORATION_CONTAINERGREY,
      appBar: AppBar(
          title: const Text('Apply Coupon', style: CustomTextStyle.darkgrey),
          centerTitle: true),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Customcolors.DECORATION_WHITE,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2), // Shadow color
                        offset: const Offset(
                            0, 4), // Horizontal offset: 0, Vertical offset: 4
                        blurRadius: 1, // Blur radius
                        spreadRadius: 0, // Spread radius
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: couponController,
                    onFieldSubmitted: (value) {
                      if (value.isNotEmpty) {
                        Timer(const Duration(milliseconds: 500), () {
                          Provider.of<CouponController>(context, listen: false)
                              .getCouponFunction(
                                  value: value, serviceType: parcelservice);
                        });
                      } else if (value.isEmpty) {
                        Timer(const Duration(milliseconds: 500), () {
                          Provider.of<CouponController>(context, listen: false)
                              .getCouponFunction(
                                  value: "", serviceType: parcelservice);
                        });
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Coupon Code',
                      hintStyle: const TextStyle(
                        fontFamily: 'Poppins-Regular',
                        color: Customcolors.DECORATION_GREY,
                      ),
                      border: InputBorder.none,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: InkWell(
                          onTap: () {
                            final value =
                                couponController.text; // Access the value here

                            if (value.isNotEmpty) {
                              Timer(const Duration(milliseconds: 500), () {
                                Provider.of<CouponController>(context,
                                        listen: false)
                                    .getCouponFunction(
                                        value: value,
                                        serviceType: parcelservice);
                              });
                            } else if (value.isEmpty) {
                              Timer(const Duration(milliseconds: 500), () {
                                Provider.of<CouponController>(context,
                                        listen: false)
                                    .getCouponFunction(
                                        value: "", serviceType: parcelservice);
                              });
                            }
                          },
                          child: const Text(
                            "Apply",
                            style: CustomTextStyle.coupontext,
                          ),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 8),
                    ),
                  ),
                ),
              ),
            ),
            Consumer<CouponController>(
              builder: (context, value, child) {
                if (value.isLoading) {
                  return const Center(
                      child: CupertinoActivityIndicator(
                    color: Colors.deepOrange,
                  ));
                } else if (value.parcelCoupons.isEmpty ||
                    value.parcelCoupons == null ||
                    value.parcelCoupons["data"]["searchList"] == "" ||
                    value.parcelCoupons["data"]["searchList"] == null) {
                  return const Center(
                    child: Text(
                      'No parcel Coupons Right Now',
                      style: CustomTextStyle.chipgrey,
                    ),
                  );
                } else {
                  return ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: value.parcelCoupons["data"]["searchList"].length,
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      // return IconButton(onPressed: (){
                      //   print(" AAAAAAAAAAAAAAAAAAA ${value.parcelCoupons} AAAAAAAAAAAAAAAAAA");
                      // }, icon: Icon(Icons.remove_red_eye));

                      return ParcelCouponCards(
                        couponendDate: value.parcelCoupons["data"]["searchList"]
                                    [index]["endDate"] ==
                                null
                            ? ""
                            : DateTimeFormaterC().formatDateTime(value
                                .parcelCoupons["data"]["searchList"][index]
                                    ["endDate"]
                                .toString()),
                        couponstartDate: value.parcelCoupons["data"]
                                    ["searchList"][index]["startDate"] ==
                                null
                            ? ""
                            : DateTimeFormaterC().formatDateTime(value
                                .parcelCoupons["data"]["searchList"][index]
                                    ["startDate"]
                                .toString()),
                        isFromSingle: widget.isfromSingleTrip,
                        isCouponApplied: widget.isCouponApplied,
                        apply: () => widget.apply,
                        remove: () => widget.remove,
                        couponId: value.parcelCoupons["data"]["searchList"]
                            [index]["_id"],
                        discountvalue: value.parcelCoupons["data"]["searchList"]
                            [index]["couponAmount"],
                        cupontitle: value.parcelCoupons["data"]["searchList"]
                            [index]["couponTitle"],
                        coupontype: value.parcelCoupons["data"]["searchList"]
                            [index]["couponType"],
                        availableStatus: value.parcelCoupons["data"]
                                ["searchList"][index]["availableStatus"] ??
                            "",
                        hashUser: value.parcelCoupons["data"]["searchList"]
                            [index]["hashUser"],
                        isused: value.parcelCoupons["data"]["searchList"][index]
                            ["isUsed"],
                        pricestatus: pricestatus,
                        status: value.parcelCoupons["data"]["searchList"][index]
                            ["status"],
                        originalprice: value.parcelCoupons["data"]["searchList"][index]
                            ["isUsed"] ? value.parcelCoupons["data"]["searchList"]
                            [index]["couponAmount"]+widget.baseprice : widget.baseprice,

                        coupondetails: value.parcelCoupons["data"]["searchList"]
                            [index]["couponDetails"],
                        abovevalue: value.parcelCoupons["data"]["searchList"]
                            [index]["aboveValue"],
                        couponcode: value.parcelCoupons["data"]["searchList"]
                            [index]["couponCode"],
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
