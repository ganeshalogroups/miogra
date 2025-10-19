
// ignore_for_file: must_be_immutable

import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';

class MartCouponscreen extends StatefulWidget {
  // dynamic totalDis;
  // dynamic shopid;
  // bool isCouponApplied; 
  // final VoidCallback apply;
  // final VoidCallback remove;
   const MartCouponscreen({super.key,
  //  required this.totalDis,
  //  required this.shopid,
  //  required this.isCouponApplied,
  //  required this.apply,
  //  required this.remove
   });

  @override
  State<MartCouponscreen> createState() => MartCouponscreenState();
}

class MartCouponscreenState extends State<MartCouponscreen> {
  TextEditingController couponController = TextEditingController();
  bool showLoadingGif = true;
   @override
  void initState() {
 

    super.initState();
  }

  bool pricestatus = false;
  double originalamt = 0;

  @override
  Widget build(BuildContext context) {
        // var amttotal = Provider.of<MeatCouponController>(context, listen: false);
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
                    cursorColor: Customcolors.DECORATION_GREY,
                    cursorWidth: 2.0, // Set the cursor width
                    cursorRadius: const Radius.circular(5.0),
                    controller: couponController,
                    onFieldSubmitted: (value) {
                      if (value.isNotEmpty) {
                        // Timer(Duration(milliseconds: 500), () {
                        //   Provider.of<MeatCouponController>(context, listen: false)
                        //       .getmeatCouponFunction(
                        //           value: value,
                        //           shopid: widget.shopid);
                        // });
                      } else if (value.isEmpty) {
                        // Timer(Duration(milliseconds: 500), () {
                        //   Provider.of<MeatCouponController>(context, listen: false)
                        //       .getmeatCouponFunction(
                        //           value: "", shopid: widget.shopid);
                        // });
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
                              // Timer(Duration(milliseconds: 500), () {
                              //   Provider.of<MeatCouponController>(context,listen: false)
                              //       .getmeatCouponFunction(
                              //           value: value,
                              //           shopid: widget.shopid);
                              // });
                            } else if (value.isEmpty) {
                              // Timer(Duration(milliseconds: 500), () {
                              //   Provider.of<MeatCouponController>(context,listen: false)
                              //       .getmeatCouponFunction(
                              //           value: "",
                              //           shopid: widget.shopid);
                              // });
                            }
                          },
                          child: const Text(
                            "Apply",
                            style: CustomTextStyle.coupontext,
                          ),
                        ),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8),
                    ),
                  ),
                ),
              ),
            ),
        //     Consumer<MeatCouponController>(
        //       builder: (context, value, child) {
        //         if (showLoadingGif || value.isLoading) {
        //   return Column(mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //     SizedBox(height: 100,),
        //       Image.asset(
        //         "assets/meat_images/searching_tickets.gif",
        //         errorBuilder: (context, error, stackTrace) {
        //           return CupertinoActivityIndicator(color: Customcolors.darkpurple,);
        //         },
        //       ),
        //     ],
        //   );
        // } else if (value.meatCoupons.isEmpty || value.meatCoupons == null||value.meatCoupons["data"].isEmpty ||
        //             value.meatCoupons["data"]["data"] == null) {
        //           return Center(
        //             child: Text(
        //               'No Coupons Right Now',
        //               style: CustomTextStyle.chipgrey,
        //             ),
        //           );
        //         } else {
        //           return ListView.separated(
        //             separatorBuilder: (context, index) => SizedBox(height: 10),
        //             shrinkWrap: true,
        //             physics: NeverScrollableScrollPhysics(),
        //             itemCount: value.meatCoupons["data"]["data"].length,
        //             padding: EdgeInsets.all(8),
        //             itemBuilder: (context, index) {
        //               return Meatcouponcards(
        //                 couponendDate: DateTimeFormaterC().formatDateTime(
        //                     value.meatCoupons["data"]["data"][index]["endDate"].toString()),
        //                 couponstartDate: DateTimeFormaterC().formatDateTime(
        //                     value.meatCoupons["data"]["data"][index]["startDate"].toString()),
        //                 isCouponApplied: widget.isCouponApplied,
        //                 apply: () => widget.apply,
        //                 remove: () => widget.remove,
        //                 couponId: value.meatCoupons["data"]["data"][index]["_id"],
        //                 discountvalue: value.meatCoupons["data"]["data"][index]["couponAmount"],
        //                 cupontitle: value.meatCoupons["data"]["data"][index]["couponTitle"],
        //                 coupontype: value.meatCoupons["data"]["data"][index]["couponType"],
        //                 availableStatus: value.meatCoupons["data"]["data"][index]["availableStatus"],
        //                 hashUser: value.meatCoupons["data"]["data"][index]["hashUser"],
        //                 isused: value.meatCoupons["data"]["data"][index]["isUsed"],
        //                 pricestatus: pricestatus,
        //                 status: value.meatCoupons["data"]["data"][index]["status"],
        //                 originalprice: amttotal.getcarttoken,
        //                 coupondetails: value.meatCoupons["data"]["data"][index]["couponDetails"],
        //                 abovevalue: value.meatCoupons["data"]["data"][index]["aboveValue"],
        //                 couponcode: value.meatCoupons["data"]["data"][index]["couponCode"],
        //               );
        //             },
        //           );
        //         }
        //       },
        //     ),
         
          ],
        ),
      ),
    );
 
  }
}

