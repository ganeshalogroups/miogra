// ignore_for_file: must_be_immutable, file_names

import 'dart:async';
import 'package:testing/Features/OrderScreen/OrderScreenController/getallordercontroller.dart';
import 'package:testing/Features/OrderScreen/Orderstatus.dart';
import 'package:testing/Features/OrderScreen/Trackorder.dart';
import 'package:testing/Features/OrderScreen/cancel%20order%20details.dart';
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
import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Redirectcontroller.dart';
import 'package:marquee/marquee.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Features/OrderScreen/Orderslist.dart';

class GetallorderlistTab extends StatefulWidget {
  bool isFromHome;
  GetallorderlistTab({super.key, this.isFromHome = false});

  @override
  State<GetallorderlistTab> createState() => _GetallorderlistTabState();
}

class _GetallorderlistTabState extends State<GetallorderlistTab> {
  RedirectController redirect = Get.put(RedirectController());
  OrdergetallPaginController meatordercontroller =
      Get.put(OrdergetallPaginController());
  Timer? timer; // Timer for countdown
  final Map<int, int> _countdownValues = {};
  int _cancelTimeLimit = 60;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      meatordercontroller.getOrderHistoryController.refresh();
      await redirect.getredirectDetails();

      for (var item in redirect.redirectLoadingDetails["data"]) {
        if (item["key"] == "canceltimeLimit") {
          final parsed = int.tryParse(item["value"].toString());
          if (parsed != null && parsed > 0) {
            _cancelTimeLimit = parsed;
          } else {
            _cancelTimeLimit = 60; // fallback
          }
          break; // Exit loop once found
        }
      }
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
      meatordercontroller.getOrderHistoryController.refresh();
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
        pagingController: meatordercontroller.getOrderHistoryController,
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(16.0),
        builderDelegate: PagedChildBuilderDelegate<dynamic>(
          animateTransitions: true,
          transitionDuration: const Duration(milliseconds: 500),
          itemBuilder: (context, orders, index) {
            // dynamic createdAtforcancellation = orders.containsKey('paymentDetails') ? orders['paymentDetails']["createdAt"] : "";
            dynamic createdAtforcancellation = orders["createdAt"] ?? "";

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
                dynamic platformfee = orders.containsKey('amountDetails')
                    ? orders['amountDetails']["platformFee"]
                    : "";
                var formatedCancelledDate = orders['cancelledAt'] != null
                    ? formatDate(dateStr: orders['cancelledAt'])
                    : '';
                var formatedDeliveredDate = orders['deliveredAt'] != null
                    ? formatDate(dateStr: orders['deliveredAt'])
                    : '';
                var formatedRejectedDate = orders['rejectedAt'] != null
                    ? formatDate(dateStr: orders['rejectedAt'])
                    : '';

                Get.to(
                    Orderstatus(
                      platformfee: platformfee,
                      packagingCharge: orders['amountDetails']
                          ['packingCharges'],
                      km: orders['totalKms'],
                      timeinmins: orders['tripDetails'] != null &&
                              orders['tripDetails']["tripTime"] != null
                          ? orders['tripDetails']["tripTime"]
                          : 0,
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
                      recievername: orders['dropAddress'][0]['contactPerson']
                          .toString()
                          .capitalizeFirst
                          .toString(),
                      recievernumber: orders['dropAddress'][0]
                              ['contactPersonNumber']
                          .toString()
                          .capitalizeFirst
                          .toString(),
                      instructions: orders['dropAddress'][0]['instructions']
                          .toString()
                          .capitalizeFirst
                          .toString(),
                      delivaryFee: orders['amountDetails']['deliveryCharges'],
                      deliverytip: orders['amountDetails']['tips'],
                      rejectedreason: orders['rejectedNote'],
                      grandtotal: orders['amountDetails']['finalAmount'],
                      gst: orders['amountDetails']['tax'],
                      itemTotal: orders['amountDetails']
                          ['cartFoodAmountWithoutCoupon'],
                      orderDate: formatedDate,
                      deliveredAt: formatedDeliveredDate,
                      cancelledAt: formatedCancelledDate,
                      rejectedAt: formatedRejectedDate,
                      orderId: orders['orderCode'],
                      paymentMethod: orders['paymentMethod'],
                      resAddres: orders['pickupAddress'][0]['fullAddress']
                          .toString()
                          .capitalizeFirst
                          .toString(),
                      resName: orders['pickupAddress'][0]['name'] == null
                          ? orders['parcelDetails']['packageType']
                          : orders['pickupAddress'][0]['name']
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
                      padding:  EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 15.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Text(
                              getStatusLabel(
                                  orders['orderStatus'].toString() ?? ''),
                              // orders['orderStatus'].toString().capitalizeFirst.toString(), // Capitalizing the first letter of the status
                              style: orders['orderStatus'] == "delivered"
                                  ? CustomTextStyle
                                      .trackgreenordertext // Green text for "delivered"
                                  : ([
                                      "new",
                                      "orderAssigned",
                                      "orderPickedUped",
                                      "deliverymanReachedDoor",
                                      "initiated"
                                    ].contains(orders['orderStatus']))
                                      ? CustomTextStyle.orangeeetext
                                      : CustomTextStyle.trackredmarktext,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width / 2.2.w,
                                child: Text(
                                  orders['pickupAddress'][0]['name'] == null
                                      ? orders['parcelDetails']['packageType']
                                      : orders['pickupAddress'][0]['name']
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
                              return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                   if (!(countdownValue > 0 &&
                                  orders['orderStatus'] == "initiated"))
                                  orders['orderStatus'] == "new" ||
                                        orders['orderStatus'] ==
                                            "orderAssigned" ||
                                        orders['orderStatus'] ==
                                            "orderPickedUped" ||
                                        orders['orderStatus'] ==
                                            "deliverymanReachedDoor" ||
                                        orders['orderStatus'] == "initiated"?
                                 InkWell(
                                  onTap: () async{
                                    final Uri url = Uri.parse('tel: ${ orders["adminDetails"]["mobileNo"]}');
if(await canLaunchUrl(url)){
  await launchUrl(url);
}else{
  throw "Could not lanch $url";
}

                              print( orders["adminDetails"]["mobileNo"]);
                                  },
                                  
                                  child: Image.asset("assets/images/Fill call.png",height: 20.h,color: const Color.fromARGB(255, 101, 2, 138),))
                              :SizedBox.shrink()  ],
                              );
                            },
                          ),
                        //  const SizedBox(height: 0),
                          CustomPaint(
                            size: Size(MediaQuery.of(context).size.width / 1,
                               20 ), // Adjust size here
                            painter: DottedLinePainter(),
                          ),
                          if (countdownValue > 0 &&
                              orders['orderStatus'] == "initiated")
                            SizedBox(
                              height: 30,
                              child: Marquee(
                                text:
                                    "You can cancel within ${countdownValue}s of placing your order. After that, cancellation isn’t available.",
                                style: CustomTextStyle.rederrortext,
                                scrollAxis: Axis.horizontal,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                blankSpace: 20.0,
                                velocity: 50.0,
                                startPadding: 10.0,
                                accelerationDuration:
                                    const Duration(seconds: 1),
                                accelerationCurve: Curves.linear,
                                decelerationDuration:
                                    const Duration(milliseconds: 500),
                                decelerationCurve: Curves.easeOut,
                              ),
                            ),
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
                              if (!(countdownValue > 0 &&
                                  orders['orderStatus'] == "initiated"))
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
                                            Trackorder(
                                              isfromhome: widget.isFromHome,
                                              createdAt: createdAt,
                                              ordeID: orders['_id'],
                                              resname: orders['pickupAddress']
                                                  [0]['name'],
                                              status: orders['orderStatus'],
                                              ordercode: orders['orderCode'],
                                              datetime: formattedDate,
                                              resturantlatlng: LatLng(
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
                          ),
                          if (countdownValue > 0 &&
                              orders['orderStatus'] == "initiated")
                            InkWell(
                              onTap: () {
                                Get.off(
                                    CancelOrderDetails(
                                      orderid: orders['_id'],
                                      resname: orders['pickupAddress'][0]
                                          ['name'],
                                      ordercode: orders['orderCode'],
                                      status: orders['orderStatus'],
                                    ),
                                    transition: Transition.leftToRight);
                              },
                              child: Center(
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    CustomContainer(
                                      width: 180,
                                      decoration: CustomContainerDecoration
                                          .reddecoration(),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 20),
                                        child: Center(
                                          child: Text(
                                            "Cancel Order",
                                            style: CustomTextStyle.white12text,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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

  int getCountdownValue(DateTime createdAt) {
    DateTime currentTime = DateTime.now().toUtc();
    DateTime endTime = createdAt.add(Duration(seconds: _cancelTimeLimit));
    Duration difference = endTime.difference(currentTime);
    return difference.isNegative ? 0 : difference.inSeconds;
  }
}

String getStatusLabel(String status) {
  switch (status) {
    case "new":
      return "Order is Being Prepared";
    case "initiated":
      return "Order Placed";
    case "orderAssigned":
      return "Order Assigned";
    case "orderPickedUped":
      return "Order Picked Up";
    case "delivered":
      return "Delivered";
    case "cancelled":
      return "Cancelled";
    case "rejected":
      return "Rejected";
    case "deliverymanReachedDoor":
      return "Deliveryman Reached Door";
    default:
      return "Unknown Status";
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
          "assets/images/empty order.png",
          height: 200,
        ),
        const CustomSizedBox(
          height: 40,
        ),
        const Text("No Orders History Available",
            style: CustomTextStyle.googlebuttontext),
        const Text("No Orders yet Delivered/Cancelled.",
            style: CustomTextStyle.blacktext)
      ],
    ),
  );
}
