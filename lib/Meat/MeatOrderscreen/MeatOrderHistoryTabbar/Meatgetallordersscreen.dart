// ignore_for_file: must_be_immutable, file_names

import 'dart:async';
import 'package:testing/Meat/MeatOrderscreen/MeatOrderController/Meatgetallorders.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatOrderHistoryTabbar/MeatOrderstatus.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatTrackOrder.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/CustomDottedline.dart';
import 'package:testing/utils/Shimmers/FavouriteResgetshimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
//import 'package:marquee/marquee.dart';
import '../../../Features/OrderScreen/Orderslist.dart';

class MeatgetallorderlistTab extends StatefulWidget {
  bool isFromHome;
  MeatgetallorderlistTab({super.key, this.isFromHome = false});

  @override
  State<MeatgetallorderlistTab> createState() => _MeatgetallorderlistTabState();
}

class _MeatgetallorderlistTabState extends State<MeatgetallorderlistTab> {
  MeatOrderGetallPaginController meatordercontroller =
      Get.put(MeatOrderGetallPaginController());
  Timer? timer; // Timer for countdown
  final Map<int, int> _countdownValues = {};

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      meatordercontroller.getmeatOrderHistoryController.refresh();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  refresh() async {
    await Future.delayed(const Duration(seconds: 2), () {
      meatordercontroller.getmeatOrderHistoryController.refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Customcolors.darkpurple,
      onRefresh: () async {
        await refresh();
      },
      child: PagedListView<int, dynamic>(
        shrinkWrap: true,
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: false,
        addSemanticIndexes: false,
        pagingController: meatordercontroller.getmeatOrderHistoryController,
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(16.0),
        builderDelegate: PagedChildBuilderDelegate<dynamic>(
          animateTransitions: true,
          transitionDuration: const Duration(milliseconds: 500),
          itemBuilder: (context, orders, index) {
            dynamic createdAtforcancellation =
                orders.containsKey('paymentDetails')
                    ? orders['paymentDetails']["createdAt"]
                    : "";

            if (_countdownValues.isEmpty) {
              for (int index = 0; index < orders.length; index++) {
                DateTime createdAt = DateTime.parse(createdAtforcancellation);

                _countdownValues[index] = getCountdownValue(createdAt);
              }
              _startCountdown();
            }

            var createdAt = DateTime.parse(createdAtforcancellation);
            int countdownValue = getCountdownValue(createdAt);

            return InkWell(
              onTap: () {
                var formatedDate = formatDate(dateStr: orders['createdAt']);
                dynamic deliverymanimg = orders.containsKey('assigneeDetails')
                    ? orders['assigneeDetails']["imgUrl"]
                    : "";
                dynamic deliverymanname = orders.containsKey('assigneeDetails')
                    ? orders['assigneeDetails']["name"]
                    : "";
                dynamic razorpaymentId = orders.containsKey('paymentDetails')
                    ? orders['paymentDetails']["razorPayPaymentId"]
                    : "";
                dynamic razorpaymentstatus =
                    orders.containsKey('paymentDetails')
                        ? orders['paymentDetails']["paymentStatus"]
                        : "";
                dynamic razorPayRefundId = orders.containsKey('paymentDetails')
                    ? orders['paymentDetails']["razorPayRefundId"]
                    : "";
                dynamic paymentmode = orders.containsKey('paymentDetails')
                    ? orders['paymentDetails']["paymentMode"]
                    : "";

                Get.to(
                    MeatOrderstatus(
                      packagingCharge: orders['amountDetails']
                          ['packingCharges'],
                      km: orders['totalKms'],
                      invoicePath: orders["invoicePath"],
                      razorPayRefundId: razorPayRefundId,
                      paymentStatus: razorpaymentstatus,
                      razorpaymentId: razorpaymentId,
                      vendorAdminid: orders["vendorAdminId"],
                      productCategoryId: orders["productCategoryId"],
                      ratings: orders['ratings'],
                      couponDiscount: orders['amountDetails']['couponsAmount'],
                      delivaryAddress: orders['dropAddress'][0]['fullAddress']
                          .toString()
                          .capitalizeFirst
                          .toString(),
                      delivaryAddresstype: orders['dropAddress'][0]
                              ['addressType']
                          .toString()
                          .capitalizeFirst
                          .toString(),
                      delivaryFee: orders['amountDetails']['deliveryCharges'],
                      grandtotal: orders['amountDetails']['finalAmount'],
                      gst: orders['amountDetails']['tax'],
                      itemTotal: orders['amountDetails']
                          ['cartFoodAmountWithoutCoupon'],
                      orderDate: formatedDate,
                      orderId: orders['orderCode'],
                      paymentMethod: paymentmode,
                      shopAddres: orders['pickupAddress'][0]['fullAddress']
                          .toString()
                          .capitalizeFirst
                          .toString(),
                      shopName: orders['pickupAddress'][0]['name']
                          .toString()
                          .capitalizeFirst
                          .toString(),
                      status: orders['orderStatus'],
                      orderdetails: orders['ordersDetails'],
                      subAdminid: orders['subAdminId'],
                      delivermanid: orders['assignedToId'] ?? "",
                      ordergetid: orders['_id'],
                      couponType: orders['amountDetails']['couponType'] ?? "",
                      deliverymanimg: deliverymanimg,
                      deliverymanname: deliverymanname,
                    ),
                    transition: Transition.leftToRight);
              },
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Customcolors
                              .DECORATION_LIGHTGREY, //color of shadow
                          spreadRadius: 5, //spread radius
                          blurRadius: 7, // blur radius
                          offset: Offset(0, 2),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Text(
                              orders['orderStatus']
                                  .toString()
                                  .capitalizeFirst
                                  .toString(), // Capitalizing the first letter of the status
                              style: orders['orderStatus'] == "delivered"
                                  ? CustomTextStyle
                                      .greenordertext // Green text for "delivered"
                                  : ([
                                      "new",
                                      "orderAssigned",
                                      "orderPickedUped",
                                      "deliverymanReachedDoor",
                                      "initiated"
                                    ].contains(orders['orderStatus']))
                                      ? CustomTextStyle.yellowtext
                                      : CustomTextStyle.redmarktext,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width / 2.2.w,
                                child: Text(
                                  orders['pickupAddress'][0]['name']
                                      .toString()
                                      .capitalizeFirst
                                      .toString(),
                                  style: CustomTextStyle.boldblack2,
                                ),
                              ),
                              Text(formatDate(dateStr: orders['createdAt']),
                                  style: CustomTextStyle.smallgrey)
                            ],
                          ),
                          const SizedBox(height: 20),
                          CustomPaint(
                            size: Size(MediaQuery.of(context).size.width / 1,
                                20), // Adjust size here
                            painter: DottedLinePainter(),
                          ),
                          ListView.builder(
                            itemCount: orders['ordersDetails'].length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 6),
                                    child: SizedBox(
                                      width: 260,
                                      child: Text(
                                        "${orders['ordersDetails'][index]['quantity']} X ${orders['ordersDetails'][index]['foodName'].toString().capitalizeFirst.toString()}",
                                        style: CustomTextStyle.noboldblack,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomPaint(
                            size: Size(MediaQuery.of(context).size.width / 1,
                                20), // Adjust size here
                            painter: DottedLinePainter(),
                          ),
                          if (countdownValue > 0 &&
                              orders['orderStatus'] == "initiated")

                            //  SizedBox(
                            //  height: 30,
                            //    child: Marquee(
                            //    text: "You can cancel within ${countdownValue}s of placing your order. After that, cancellation isn’t available.",
                            //         style:CustomTextStyle.rederrortext,
                            //         scrollAxis: Axis.horizontal,
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         blankSpace: 20.0,
                            //         velocity: 50.0,
                            //         startPadding: 10.0,
                            //         accelerationDuration: const Duration(seconds: 1),
                            //         accelerationCurve: Curves.linear,
                            //         decelerationDuration: const Duration(milliseconds: 500),
                            //         decelerationCurve: Curves.easeOut,

                            //      ),
                            //  ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "₹ ${double.parse(orders['amountDetails']['finalAmount'].toString()).toStringAsFixed(2)}",
                                      style: CustomTextStyle.black14bold,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Icon(Icons.arrow_forward_ios,
                                        color: Customcolors.DECORATION_BLACK,
                                        size: 15)
                                  ],
                                ),
                                orders['orderStatus'] == "new" ||
                                        orders['orderStatus'] ==
                                            "orderAssigned" ||
                                        orders['orderStatus'] ==
                                            "orderPickedUped" ||
                                        orders['orderStatus'] ==
                                            "deliverymanReachedDoor" ||
                                        orders['orderStatus'] == "initiated"
                                    ? InkWell(
                                        onTap: () {
                                          var formattedDate = formatDate(
                                              dateStr: orders['createdAt']);

                                          String createdAt =
                                              orders["paymentDetails"]
                                                  ['createdAt'];

                                          Get.to(
                                            MeatTrackorder(
                                              isfromhome: widget.isFromHome,
                                              createdAt: createdAt,
                                              ordeID: orders['_id'],
                                              resname: orders['pickupAddress']
                                                  [0]['name'],
                                              status: orders['orderStatus'],
                                              ordercode: orders['orderCode'],
                                              datetime: formattedDate,
                                              shoplatlng: LatLng(
                                                orders['pickupAddress'][0]
                                                    ['latitude'],
                                                orders['pickupAddress'][0]
                                                    ['longitude'],
                                              ),
                                              userlat: LatLng(
                                                orders['dropAddress'][0]
                                                    ['latitude'],
                                                orders['dropAddress'][0]
                                                    ['longitude'],
                                              ),
                                            ),
                                            transition: Transition.leftToRight,
                                          );
                                        },
                                        child: CustomContainer(
                                          decoration: CustomContainerDecoration
                                              .gradientbuttondecoration(),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 20),
                                            child: Center(
                                              child: Text(
                                                "Track Order",
                                                style: CustomTextStyle
                                                    .smallwhitetext,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox() // Fallback widget when the condition is not met.
                              ],
                            )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            );
          },
          firstPageProgressIndicatorBuilder: (context) =>
              const Favouriteresgetshimmer(),
          firstPageErrorIndicatorBuilder: (context) =>
              const Favouriteresgetshimmer(),
          noMoreItemsIndicatorBuilder: (_) => const SizedBox(),
          newPageErrorIndicatorBuilder: (context) =>
              const Center(child: Text("No Orders available")),
          newPageProgressIndicatorBuilder: (context) => const SizedBox(),
          noItemsFoundIndicatorBuilder: (context) =>
              _buildNoDataScreen(context),
        ),
      ),
    );
  }

  void _startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _countdownValues.forEach((index, countdownValue) {
          if (countdownValue > 0) {
            _countdownValues[index] = countdownValue - 1;
          }
        });
      });
    });
  }
}

Widget _buildNoDataScreen(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/meat_images/Nomeatorders.gif",
          height: 200,
        ),
        const CustomSizedBox(
          height: 35,
        ),
        const Text("No Orders", style: CustomTextStyle.googlebuttontext),
        const Text("You haven’t made any orders yet.",
            style: CustomTextStyle.blacktext)
      ],
    ),
  );
}
