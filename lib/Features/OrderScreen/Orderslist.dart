// ignore_for_file: file_names

import 'dart:async';
import 'package:testing/Features/OrderScreen/OrderScreenController/OrdersControllerPagination.dart';
import 'package:testing/Features/OrderScreen/Trackorder.dart';
import 'package:testing/Features/OrderScreen/cancel%20order%20details.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/CustomDottedline.dart';
import 'package:testing/utils/Shimmers/FavouriteResgetshimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Redirectcontroller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
//import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'Orderstatus.dart';

// ignore: must_be_immutable
class Orderlist extends StatefulWidget {
  bool isFromHome;
  Orderlist({super.key, this.isFromHome = false});

  @override
  State<Orderlist> createState() => _OrderlistState();
}

class _OrderlistState extends State<Orderlist> {
  RedirectController redirect = Get.put(RedirectController());

  Timer? _timer; // Timer for countdown
  final Map<int, int> _countdownValues = {};
  int _cancelTimeLimit = 60;

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Provider.of<GetOrdersProvider>(context, listen: false).getOders();
    //    redirect.getredirectDetails();
    // });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      print("_OrderlistStateprint");
      await Provider.of<GetOrdersProvider>(context, listen: false).getOders();
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
    _timer!.cancel();
    super.dispose();
  }

  refresh() async {
    await Future.delayed(
      const Duration(seconds: 2),
      () {
        Provider.of<GetOrdersProvider>(context, listen: false).getOders();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Customcolors.darkpurple,
      onRefresh: () async {
        await refresh();
      },
      child: Consumer<GetOrdersProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Padding(
              padding: EdgeInsets.all(12.0),
              child: Favouriteresgetshimmer(),
            );
          } else if (value.orderModel == null || value.orderModel.isEmpty) {
            return Center(child: _buildNoDataScreen(context));
          } else {
            return ListView.separated(
              itemCount: value.orderModel.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                var statusDate = value.orderModel[index]['orderStatus'] == "new"
                    ? "Order is Being Prepared"
                    : value.orderModel[index]['orderStatus'] == "initiated"
                        ? "Order Placed"
                        : value.orderModel[index]['orderStatus'] ==
                                "orderAssigned"
                            ? "Order Assigned"
                            : value.orderModel[index]['orderStatus'] ==
                                    "deliverymanReachedDoor"
                                ? "Deliveryman Reached Door"
                                : "Order Picked Up";
                // dynamic createdAtforcancellation = value.orderModel[index].containsKey('paymentDetails') ? value.orderModel[index]['paymentDetails']["createdAt"] : "";
                dynamic createdAtforcancellation =
                    value.orderModel[index]["createdAt"] ?? "";

                if (_countdownValues.isEmpty) {
                  for (int index = 0;
                      index < value.orderModel.length;
                      index++) {
                    DateTime createdAt =
                        DateTime.parse(createdAtforcancellation);

                    _countdownValues[index] = getCountdownValue(createdAt);
                  }
                  _startCountdown();
                }

                var createdAt = DateTime.parse(createdAtforcancellation);

                int countdownValue = getCountdownValue(createdAt);
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        var formatedDate = formatDate(
                            dateStr: value.orderModel[index]['createdAt']);

                        dynamic deliverymanimg = value.orderModel[index]
                                .containsKey('assigneeDetails')
                            ? value.orderModel[index]['assigneeDetails']
                                ["imgUrl"]
                            : "";

                        dynamic platformfee =
                            value.orderModel[index].containsKey('amountDetails')
                                ? value.orderModel[index]['amountDetails']
                                    ["platformFee"]
                                : "";
                        dynamic deliverymanname = value.orderModel[index]
                                .containsKey('assigneeDetails')
                            ? value.orderModel[index]['assigneeDetails']["name"]
                            : "";
                        dynamic razorpaymentId = value.orderModel[index]
                                .containsKey('paymentDetails')
                            ? value.orderModel[index]['paymentDetails']
                                ["razorPayPaymentId"]
                            : "";
                        dynamic razorpaymentstatus = value.orderModel[index]
                                .containsKey('paymentDetails')
                            ? value.orderModel[index]['paymentDetails']
                                ["paymentStatus"]
                            : "";
                        dynamic razorPayRefundId = value.orderModel[index]
                                .containsKey('paymentDetails')
                            ? value.orderModel[index]['paymentDetails']
                                ["razorPayRefundId"]
                            : "";

                        Get.to(
                            Orderstatus(
                              platformfee: platformfee,
                              packagingCharge: value.orderModel[index]
                                  ['amountDetails']['packingCharges'],
                              km: value.orderModel[index]['totalKms'],
                              timeinmins: value.orderModel[index]
                                              ['tripDetails'] !=
                                          null &&
                                      value.orderModel[index]['tripDetails']
                                              ["tripTime"] !=
                                          null
                                  ? value.orderModel[index]['tripDetails']
                                      ["tripTime"]
                                  : 0,
                              invoicePath: value.orderModel[index]
                                  ["invoicePath"],
                              razorPayRefundId: razorPayRefundId,
                              razorpaymentId: razorpaymentId,
                              ratings: value.orderModel[index]["ratings"],
                              vendorAdminid: value.orderModel[index]
                                  ["vendorAdminId"],
                              productCategoryId: value.orderModel[index]
                                  ["productCategoryId"],
                              couponDiscount: value.orderModel[index]
                                  ['amountDetails']['couponsAmount'],
                              delivaryAddress: value.orderModel[index]
                                      ['dropAddress'][0]['fullAddress']
                                  .toString()
                                  .capitalizeFirst
                                  .toString(),
                              delivaryAddresstype: value.orderModel[index]
                                      ['dropAddress'][0]['addressType']
                                  .toString()
                                  .capitalizeFirst
                                  .toString(),
                              delivaryFee: value.orderModel[index]
                                  ['amountDetails']['deliveryCharges'],
                              instructions: value.orderModel[index]
                                      ['dropAddress'][0]['instructions']
                                  .toString()
                                  .capitalizeFirst
                                  .toString(),
                              deliverytip: value.orderModel[index]
                                  ['amountDetails']['tips'],
                              recievername: value.orderModel[index]
                                      ['dropAddress'][0]['contactPerson']
                                  .toString()
                                  .capitalizeFirst
                                  .toString(),
                              recievernumber: value.orderModel[index]
                                      ['dropAddress'][0]['contactPersonNumber']
                                  .toString()
                                  .capitalizeFirst
                                  .toString(),
                              rejectedreason: value.orderModel[index]
                                  ['rejectedNote'],
                              grandtotal: value.orderModel[index]
                                  ['amountDetails']['finalAmount'],
                              gst: value.orderModel[index]['amountDetails']
                                  ['tax'],
                              itemTotal: value.orderModel[index]
                                      ['amountDetails']
                                  ['cartFoodAmountWithoutCoupon'],
                              orderDate: formatedDate,
                              orderId: value.orderModel[index]['orderCode'],
                              paymentMethod: value.orderModel[index]
                                  ["paymentMethod"],
                              resAddres: value.orderModel[index]
                                      ['pickupAddress'][0]['fullAddress']
                                  .toString()
                                  .capitalizeFirst
                                  .toString(),
                              resName: value.orderModel[index]['pickupAddress']
                                      [0]['name']
                                  .toString()
                                  .capitalizeFirst
                                  .toString(),
                              status: value.orderModel[index]['orderStatus'],
                              orderdetails: value.orderModel[index]
                                  ['ordersDetails'],
                              subAdminid: value.orderModel[index]['subAdminId'],
                              delivermanid:
                                  value.orderModel[index]['assignedToId'] ?? "",
                              ordergetid: value.orderModel[index]['_id'],
                              couponType: value.orderModel[index]
                                      ['amountDetails']['couponType'] ??
                                  "",
                              deliverymanimg: deliverymanimg,
                              deliverymanname: deliverymanname,
                              paymentStatus: razorpaymentstatus,
                            ),
                            transition: Transition.leftToRight);
                      },
                      child: Container(
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
                                  statusDate,
                                  style: CustomTextStyle.orangeeetext,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width /
                                        2.2.w,
                                    child: Text(
                                      value.orderModel[index]['pickupAddress']
                                              [0]['name']
                                          .toString()
                                          .capitalizeFirst
                                          .toString(),
                                      style: CustomTextStyle.boldblack2,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                  Text(
                                      formatDate(
                                          dateStr: value.orderModel[index]
                                              ['createdAt']),
                                      style: CustomTextStyle.smallgrey)
                                ],
                              ),
                              const SizedBox(height: 20),
                              CustomPaint(
                                size: Size(
                                    MediaQuery.of(context).size.width / 1,
                                    20), // Adjust size here
                                painter: DottedLinePainter(),
                              ),
                              ListView.builder(
                                itemCount: value
                                    .orderModel[index]['ordersDetails'].length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, ind) {
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 6),
                                        child: value.orderModel[index]
                                                        ['ordersDetails'][ind]
                                                    ['foodType'] ==
                                                'veg'
                                            ? iconfun(imageName: vegIcon)
                                            : value.orderModel[index]
                                                            ['ordersDetails']
                                                        [ind]['foodType'] ==
                                                    'nonveg'
                                                ? iconfun(imageName: nonvegIcon)
                                                : iconfun(imageName: eggIcon),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 6),
                                        child: SizedBox(
                                          width: 260,
                                          child: Text(
                                            "${value.orderModel[index]['ordersDetails'][ind]['quantity']} X ${value.orderModel[index]['ordersDetails'][ind]['foodName'].toString().capitalizeFirst.toString()}",
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
                                size: Size(
                                    MediaQuery.of(context).size.width / 1,
                                    20), // Adjust size here
                                painter: DottedLinePainter(),
                              ),
                              if (countdownValue > 0 &&
                                  value.orderModel[index]['orderStatus'] ==
                                      "initiated")

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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "₹ ${double.parse(value.orderModel[index]['amountDetails']['finalAmount'].toString()).toStringAsFixed(2)}",
                                          style: CustomTextStyle.black14bold,
                                        ),

                                        // Text(
                                        //   "₹ ${value.orderModel[index]['amountDetails']['finalAmount']}",
                                        //   style: CustomTextStyle.black14bold,
                                        // ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Icon(Icons.arrow_forward_ios,
                                            color:
                                                Customcolors.DECORATION_BLACK,
                                            size: 15)
                                      ],
                                    ),
                                    // if (countdownValue > 0 &&value.orderModel[index]['orderStatus'] == "initiated" )
                                    if (!(countdownValue > 0 &&
                                        value.orderModel[index]
                                                ['orderStatus'] ==
                                            "initiated"))
                                      InkWell(
                                        onTap: () {
                                          var formatedDate = formatDate(
                                              dateStr: value.orderModel[index]
                                                  ['createdAt']);

                                          String createdAt = value
                                                  .orderModel[index]
                                              ["paymentDetails"]['createdAt'];

                                          Get.to(
                                              Trackorder(
                                                isfromhome: widget.isFromHome,
                                                createdAt: createdAt,
                                                ordeID: value.orderModel[index]
                                                    ['_id'],
                                                resname: value.orderModel[index]
                                                        ['pickupAddress'][0]
                                                    ['name'],
                                                status: value.orderModel[index]
                                                    ['orderStatus'],
                                                ordercode:
                                                    value.orderModel[index]
                                                        ['orderCode'],
                                                datetime: formatedDate,
                                                resturantlatlng: LatLng(
                                                    value.orderModel[index]
                                                            ['pickupAddress'][0]
                                                        ['latitude'],
                                                    value.orderModel[index]
                                                            ['pickupAddress'][0]
                                                        ['longitude']),
                                                userlat: LatLng(
                                                    value.orderModel[index]
                                                            ['dropAddress'][0]
                                                        ['latitude'],
                                                    value.orderModel[index]
                                                            ['dropAddress'][0]
                                                        ['longitude']),
                                              ),
                                              transition:
                                                  Transition.leftToRight);
                                        },
                                        child: CustomContainer(
                                          decoration: CustomContainerDecoration
                                              .gradientbuttondecoration(),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 20),
                                            child: Center(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Track Order",
                                                    style: CustomTextStyle
                                                        .smallwhitetext,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              if (countdownValue > 0 &&
                                  value.orderModel[index]['orderStatus'] ==
                                      "initiated")
                                InkWell(
                                  onTap: () {
                                    Get.off(
                                        CancelOrderDetails(
                                          orderid: value.orderModel[index]
                                              ['_id'],
                                          resname: value.orderModel[index]
                                              ['pickupAddress'][0]['name'],
                                          ordercode: value.orderModel[index]
                                              ['orderCode'],
                                          status: value.orderModel[index]
                                              ['orderStatus'],
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
                                                style:
                                                    CustomTextStyle.white12text,
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
                    ),
                    const SizedBox(height: 15),
                  ],
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 5),
            );
          }
        },
      ),
    );
  }

  // Start a timer to update countdown values every second
  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
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

Widget _buildNoDataScreen(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //  CustomSizedBox(height: 50,),
        Image.asset(
          "assets/images/No orders.png",
          height: 180,
        ),
        const CustomSizedBox(
          height: 40,
        ),
        const Text("No Orders", style: CustomTextStyle.googlebuttontext),
        const Text("You haven’t made any orders yet.",
            style: CustomTextStyle.blacktext)
      ],
    ),
  );
}

Widget iconfun({imageName}) {
  return Image(
    image: AssetImage(
      imageName,
    ),
    height: 15,
    width: 20,
  );
}

String formatDate({required String dateStr}) {
  DateTime dateTime = DateTime.parse(dateStr);
  dateTime = dateTime.add(const Duration(hours: 5, minutes: 30));
  String formattedDate =
      DateFormat("d MMM yyyy 'at' h:mma").format(dateTime).toLowerCase();
  return formattedDate;
}

//For parcel and meat

int getCountdownValue(DateTime createdAt) {
  DateTime currentTime = DateTime.now().toUtc();
  DateTime endTime = createdAt.add(const Duration(seconds: 60));
  Duration difference = endTime.difference(currentTime);
  return difference.isNegative ? 0 : difference.inSeconds;
}
