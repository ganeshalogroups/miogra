// ignore_for_file: file_names, must_be_immutable

import 'dart:async';
import 'package:testing/Features/coupon/couponController.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Validator/dateFormatters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'CouponCards.dart';
class Couponscreen extends StatefulWidget {
  dynamic totalDis;
  dynamic restaurantid;
  bool isCouponApplied;
  final VoidCallback apply;
  final VoidCallback remove;
  dynamic vendorAdminId;
  Couponscreen(
      {super.key,
      required this.totalDis,
      required this.restaurantid,
      required this.isCouponApplied,
      required this.apply,
      required this.vendorAdminId,
      required this.remove});

  @override
  State<Couponscreen> createState() => _CouponscreenState();
}


class _CouponscreenState extends State<Couponscreen> {
  final TextEditingController couponController = TextEditingController();
  bool showCancelIcon = false;
  String? errorMessage;
  // bool showLoadingGif = true;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _applyCoupon('');
      fetchOriginalAmount();
    });

    // Future.delayed(Duration(seconds: 3), () {
    //   if (mounted) {
    //     setState(() {
    //       showLoadingGif = false;
    //     });
    //   }
    // });
  }

  void fetchOriginalAmount() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CouponController>(context, listen: false)
          .getfoodcartforToken(km: widget.totalDis);
    });
  }

  void _applyCoupon(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      final controller = Provider.of<CouponController>(context, listen: false);
      final success = await controller.getrestaurantCouponFunction(
        value: value,
        restaurantid: widget.restaurantid,
        venorAdminid: widget.vendorAdminId,
      );

      if (mounted) {
        // setState(() {
        //   errorMessage = (!success && value.isNotEmpty)
        //       ? "Invalid coupon or Failed to fetch coupon details."
        //       : null;
        // });
        setState(() {
  final controller = Provider.of<CouponController>(context, listen: false);
  errorMessage = (!success && value.isNotEmpty) ? controller.errorMessage : null;
});

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var amttotal = Provider.of<CouponController>(context, listen: false);

    return Scaffold(
      backgroundColor: Customcolors.DECORATION_CONTAINERGREY,
      appBar: AppBar(
        title: const Text('Apply Coupon', style: CustomTextStyle.darkgrey),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            // Coupon Input
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
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 4),
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: couponController,
                    onChanged: (value) {
                      setState(() {
                        showCancelIcon = value.isNotEmpty;
                        if (value.isEmpty) {
                          errorMessage = null;
                          // _applyCoupon('');
                          _applyCoupon(value.trim());
                        }
                      });
                    },
                    onFieldSubmitted: (value) {
                      _applyCoupon(value.trim());
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Coupon Code',
                      hintStyle: const TextStyle(
                        fontFamily: 'Poppins-Regular',
                        color: Customcolors.DECORATION_GREY,
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (showCancelIcon)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  couponController.clear();
                                  showCancelIcon = false;
                                  errorMessage = null;
                                });
                                _applyCoupon('');
                              },
                              child: const Icon(Icons.close, color: Colors.grey),
                            ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              _applyCoupon(couponController.text.trim());
                            },
                            child: const Text(
                              "Apply",
                              style: CustomTextStyle.coupontext,
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Error message
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.only( top: 6.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    errorMessage!.capitalizeFirst.toString(),
                    style: CustomTextStyle.rederrortext,
                  ),
                ),
              ),

            // Coupon list or loader or empty view
            Consumer<CouponController>(
              builder: (context, value, child) {
                final hasCoupons = value.coupons != null &&
                    value.coupons.isNotEmpty &&
                    value.coupons["data"] != null &&
                    value.coupons["data"].isNotEmpty &&
                    value.coupons["data"]["searchList"] != null;

                if ( value.isLoading) {
                return const CupertinoActivityIndicator();
                  // return Column(
                  //   children: [
                  //     SizedBox(height: 100),
                  //     Image.asset(
                  //       "assets/meat_images/searching_tickets.gif",
                  //       errorBuilder: (context, error, stackTrace) {
                  //         return CupertinoActivityIndicator(
                  //           color: Customcolors.darkpurple,
                  //         );
                  //       },
                  //     ),
                  //   ],
                  // );
                }

                if (!hasCoupons) {
                  return Column(mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 150),
                      Image.asset("assets/images/coupon.png", height: 180.h,color: Customcolors.DECORATION_GREY,),
                      const SizedBox(
                      width: 300,
                        child: Text(
                          "Snagged a coupon? Search it here. Your deals will pop up below!",
                          style: CustomTextStyle.chipgrey,
                           textAlign: TextAlign.center, // ⬅️ Centers text within the SizedBox
                        ),
                      ),
                    ],
                  );
                }

                return ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                  itemCount: value.coupons["data"]["searchList"].length,
                  itemBuilder: (context, index) {
                    final coupon = value.coupons["data"]["searchList"][index];
                    return CouponCards(
                      couponendDate: DateTimeFormaterC()
                          .formatDateTime(coupon["endDate"]),
                      couponstartDate: DateTimeFormaterC()
                          .formatDateTime(coupon["startDate"]),
                      isCouponApplied: widget.isCouponApplied,
                      apply: () => widget.apply,
                      remove: () => widget.remove,
                      couponId: coupon["_id"],
                      discountvalue: coupon["couponAmount"],
                      cupontitle: coupon["couponTitle"],
                      coupontype: coupon["couponType"],
                      availableStatus: coupon["availableStatus"],
                      hashUser: coupon["hashUser"],
                      isused: coupon["isUsed"],
                      pricestatus: false,
                      status: coupon["status"],
                      originalprice: amttotal.getcarttoken,
                      coupondetails: coupon["couponDetails"],
                      abovevalue: coupon["aboveValue"],
                      couponcode: coupon["couponCode"],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// class _CouponscreenState extends State<Couponscreen> {
//   Foodcartcontroller foodcart = Foodcartcontroller();
//   TextEditingController couponController = TextEditingController();
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       Provider.of<CouponController>(context, listen: false)
//           .getrestaurantCouponFunction(
//               value: couponController.text, restaurantid: widget.restaurantid,venorAdminid: widget.vendorAdminId, );
//       fetchOriginalAmount();
//     });
//   Future.delayed(Duration(seconds: 3), () {
//       setState(() {
//         showLoadingGif = false;
//       });
//     });
//     super.initState();
//   }

//   bool pricestatus = false;
//   double originalamt = 0;
//  bool showLoadingGif = true;
//   void fetchOriginalAmount() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<CouponController>(context, listen: false)
//           .getfoodcartforToken(km: widget.totalDis);
//     });
//   }
// @override
// Widget build(BuildContext context) {
//   var amttotal = Provider.of<CouponController>(context, listen: false);

//   return Scaffold(
//     backgroundColor: Customcolors.DECORATION_CONTAINERGREY,
//     appBar: AppBar(
//       title: Text('Apply Coupon', style: CustomTextStyle.darkgrey),
//       centerTitle: true,
//     ),
//     body: SingleChildScrollView(
//       physics: AlwaysScrollableScrollPhysics(),
//       child: Column(
//         children: [
//           /// 🟡 Moved OUTSIDE the Consumer
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Center(
//               child: Container(
//                 width: MediaQuery.of(context).size.width * 0.9,
//                 decoration: BoxDecoration(
//                   color: Customcolors.DECORATION_WHITE,
//                   borderRadius: BorderRadius.circular(8),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.2),
//                       offset: const Offset(0, 4),
//                       blurRadius: 1,
//                     ),
//                   ],
//                 ),
//                 child: TextFormField(
//                   cursorColor: Customcolors.DECORATION_GREY,
//                   cursorWidth: 2.0,
//                   cursorRadius: Radius.circular(5.0),
//                   controller: couponController,
//                    onFieldSubmitted: (value) {
//                       //  Timer(Duration(milliseconds: 500), () {
//                       //     Provider.of<CouponController>(context, listen: false).getCouponFunction(value: value);
//                       //             });
//                       if (value.isNotEmpty) {
//                         Timer(Duration(milliseconds: 500), () {
//                           Provider.of<CouponController>(context, listen: false)
//                               .getrestaurantCouponFunction(
//                                   value: couponController.text, restaurantid: widget.restaurantid,venorAdminid: widget.vendorAdminId,);
//                         });
//                       } else if (value.isEmpty) {
//                         Timer(Duration(milliseconds: 500), () {
//                           Provider.of<CouponController>(context, listen: false)
//                               .getrestaurantCouponFunction(
//                                   value: "", restaurantid: widget.restaurantid,venorAdminid: widget.vendorAdminId,);
//                         });
//                       }
//                     },
//                   decoration: InputDecoration(
//                     hintText: 'Enter Coupon Code',
//                     hintStyle: TextStyle(
//                       fontFamily: 'Poppins-Regular',
//                       color: Customcolors.DECORATION_GREY,
//                     ),
//                     border: InputBorder.none,
//                     suffixIcon: Padding(
//                       padding: EdgeInsets.only(top: 15),
//                       child: InkWell(
//                         onTap: () {
//                             final value =
//                                 couponController.text; // Access the value here

//                             if (value.isNotEmpty) {
//                               Timer(Duration(milliseconds: 500), () {
//                                 Provider.of<CouponController>(context,
//                                         listen: false)
//                                     .getrestaurantCouponFunction(
//                                         value: value,
//                                        restaurantid: widget.restaurantid,venorAdminid: widget.vendorAdminId,);
//                               });
//                             } else if (value.isEmpty) {
//                               Timer(Duration(milliseconds: 500), () {
//                                 Provider.of<CouponController>(context,
//                                         listen: false)
//                                     .getrestaurantCouponFunction(
//                                         value: "",
//                                        restaurantid: widget.restaurantid,venorAdminid: widget.vendorAdminId,);
//                               });
//                             }
//                           },
//                         child: Text(
//                           "Apply",
//                           style: CustomTextStyle.coupontext,
//                         ),
//                       ),
//                     ),
//                     contentPadding: EdgeInsets.symmetric(
//                         vertical: 15.0, horizontal: 8),
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           /// 🟢 Inside Consumer (for coupon list rendering)
//           Consumer<CouponController>(
//             builder: (context, value, child) {
//               final hasCoupons = value.coupons != null &&
//                   value.coupons.isNotEmpty &&
//                   value.coupons["data"] != null &&
//                   value.coupons["data"].isNotEmpty &&
//                   value.coupons["data"]["searchList"] != null;

//               if (showLoadingGif || value.isLoading) {
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(height: 100),
//                     Image.asset(
//                       "assets/meat_images/searching_tickets.gif",
//                       errorBuilder: (context, error, stackTrace) {
//                         return CupertinoActivityIndicator(
//                           color: Customcolors.darkpurple,
//                         );
//                       },
//                     ),
//                   ],
//                 );
//               }

//               if (!hasCoupons) {
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(height: 150),
//                     Image.asset("assets/images/coupon_img.png", height: 200),
//                     Center(
//                       child: Text(
//                         'No Coupons Available Right Now!',
//                         style: CustomTextStyle.chipgrey,
//                       ),
//                     ),
//                   ],
//                 );
//               }

//               return ListView.separated(
//                 separatorBuilder: (context, index) => SizedBox(height: 10),
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemCount: value.coupons["data"]["searchList"].length,
//                 padding: EdgeInsets.all(8),
//                 itemBuilder: (context, index) {
//                   final coupon = value.coupons["data"]["searchList"][index];
//                   return CouponCards(
//                     couponendDate:
//                         DateTimeFormaterC().formatDateTime(coupon["endDate"]),
//                     couponstartDate:
//                         DateTimeFormaterC().formatDateTime(coupon["startDate"]),
//                     isCouponApplied: widget.isCouponApplied,
//                     apply: () => widget.apply,
//                     remove: () => widget.remove,
//                     couponId: coupon["_id"],
//                     discountvalue: coupon["couponAmount"],
//                     cupontitle: coupon["couponTitle"],
//                     coupontype: coupon["couponType"],
//                     availableStatus: coupon["availableStatus"],
//                     hashUser: coupon["hashUser"],
//                     isused: coupon["isUsed"],
//                     pricestatus: pricestatus,
//                     status: coupon["status"],
//                     originalprice: amttotal.getcarttoken,
//                     coupondetails: coupon["couponDetails"],
//                     abovevalue: coupon["aboveValue"],
//                     couponcode: coupon["couponCode"],
//                   );
//                 },
//               );
//             },
//           )
//         ],
//       ),
//     ),
//   );
// }

// }
