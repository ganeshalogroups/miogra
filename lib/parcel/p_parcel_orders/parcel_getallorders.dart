// ignore_for_file: must_be_immutable, file_names

import 'dart:async';
import 'package:testing/parcel/p_parcel_orders/p_history_details.dart';
import 'package:testing/parcel/p_parcel_orders/parcelTrackOrderScreen.dart';
import 'package:testing/parcel/p_services_provider/p_getalloreders_controller.dart';
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

class ParcelgetallorderlistTab extends StatefulWidget {
  bool isFromHome;
  ParcelgetallorderlistTab({super.key, this.isFromHome = false});

  @override
  State<ParcelgetallorderlistTab> createState() =>
      _ParcelgetallorderlistTabState();
}

class _ParcelgetallorderlistTabState extends State<ParcelgetallorderlistTab> {
  ParcelOrdergetallPaginController parcelordercontroller =
      Get.put(ParcelOrdergetallPaginController());
  Timer? timer; // Timer for countdown
  final Map<int, int> _countdownValues = {};

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      parcelordercontroller.getparcelOrderHistoryController.refresh();
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
      parcelordercontroller.getparcelOrderHistoryController.refresh();
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
        pagingController: parcelordercontroller.getparcelOrderHistoryController,
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

                Get.to(
                    ParcelOrderHistoryDetails(
                      // deliveryType
                      triptype: orders['deliveryType'],
                      dropAddressType: orders['dropAddress'][0]['addressType'],
                      pickupAddresType: orders['pickupAddress'][0]
                          ['addressType'],
                      dropaddress: orders['dropAddress'][0]['fullAddress'],
                      pickupaddress: orders['pickupAddress'][0]['fullAddress'],
                      parcelDetails: orders['parcelDetails'],

                      km: orders['totalKms'],
                      invoicePath: orders["invoicePath"],
                      razorPayRefundId: razorPayRefundId,
                      razorpaymentId: razorpaymentId,
                      ratings: orders["ratings"],
                      vendorAdminid: orders["vendorAdminId"],
                      productCategoryId: orders["productCategoryId"],
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
                      orderId: orders['orderCode'],
                      paymentMethod: orders['paymentDetails']["paymentMode"],
                      resName: orders['pickupAddress'][0]['name']
                          .toString()
                          .capitalizeFirst
                          .toString(),
                      status: orders['orderStatus'],
                      subAdminid: orders['subAdminId'],
                      delivermanid: orders['assignedToId'] ?? "",
                      ordergetid: orders['_id'],
                      couponType: orders['amountDetails']['couponType'] ?? "",
                      deliverymanimg: deliverymanimg,
                      deliverymanname: deliverymanname,
                      orderDate: formatedDate,
                      paymentStatus: razorpaymentstatus,
                      platformfee: orders['platformFeeCharge'],
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
                              Text(orders['orderCode'],
                                  style: CustomTextStyle.smallgrey)
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                              '${orders['deliveryType'].toString().capitalizeFirst} Trip',
                              style: CustomTextStyle.black14),
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
                                          var formatedDate = formatDate(
                                              dateStr: orders['createdAt']);
                                          String createdAt =
                                              orders["paymentDetails"]
                                                  ['createdAt'];

                                          Get.to(
                                            PrcelTrackorder(
                                              dropAddress: orders['dropAddress']
                                                      [0]['fullAddress']
                                                  .toString()
                                                  .capitalizeFirst
                                                  .toString(),
                                              pickupAddress:
                                                  orders['pickupAddress'][0]
                                                          ['fullAddress']
                                                      .toString()
                                                      .capitalizeFirst
                                                      .toString(),
                                              pickupAddressType:
                                                  orders['pickupAddress'][0]
                                                      ['addressType'],
                                              dropAddressType:
                                                  orders['dropAddress'][0]
                                                      ['addressType'],
                                              serviceName:
                                                  orders['parcelDetails'],
                                              createdAt: createdAt,
                                              ordeID: orders['_id'],
                                              status: orders['orderStatus'],
                                              ordercode: orders['orderCode'],
                                              datetime: formatedDate,
                                              resturantlatlng: LatLng(
                                                  orders['pickupAddress'][0]
                                                      ['latitude'],
                                                  orders['pickupAddress'][0]
                                                      ['longitude']),
                                              userlat: LatLng(
                                                  orders['dropAddress'][0]
                                                      ['latitude'],
                                                  orders['dropAddress'][0]
                                                      ['longitude']),
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
        const CustomSizedBox(
          height: 80,
        ),
        Image.asset(
          "assets/images/No orders.png",
          height: 200,
        ),
        const CustomSizedBox(height: 40),
        const Text(
          "You haven’t made any orders yet. Start exploring and place your first order now!",
          style: CustomTextStyle.blacktext,
        ),
      ],
    ),
  );
}
