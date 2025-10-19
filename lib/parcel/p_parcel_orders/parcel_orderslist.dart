// ignore_for_file: file_names, avoid_print
import 'dart:async';
import 'package:testing/Features/OrderScreen/OrderScreenController/OrdersControllerPagination.dart';
import 'package:testing/Features/OrderScreen/cancel%20order%20details.dart';
import 'package:testing/parcel/p_parcel_orders/parcelOrderDetailsScreen.dart';
import 'package:testing/parcel/p_parcel_orders/parcelTrackOrderScreen.dart';
import 'package:testing/parcel/p_parcel_orders/parcel_cancelOrder.dart';
import 'package:testing/parcel/parcelordershimmers.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/CustomDottedline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
//import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ParcelOrdersList extends StatefulWidget {
  bool isFromHome;
  ParcelOrdersList({super.key, this.isFromHome = false});

  @override
  State<ParcelOrdersList> createState() => _ParcelOrdersListState();
}

class _ParcelOrdersListState extends State<ParcelOrdersList> {
  Timer? _timer; // Timer for countdown
  final Map<int, int> _countdownValues = {};

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetOrdersProvider>(context, listen: false).parcelGetOders();
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
        Provider.of<GetOrdersProvider>(context, listen: false).parcelGetOders();
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
            return ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: 3,
                padding: const EdgeInsets.all(16.0),
                itemBuilder: (context, index) {
                  return shimmmmerrr();
                });
          } else if (value.parcelOrderModel == null ||
              value.parcelOrderModel.isEmpty) {
            return Center(child: _buildNoDataScreen(context));
          } else {
            return ListView.separated(
              itemCount: value.parcelOrderModel.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                dynamic createdAtforcancellation =
                    value.parcelOrderModel[index].containsKey('paymentDetails')
                        ? value.parcelOrderModel[index]['paymentDetails']
                            ["createdAt"]
                        : null;

                // Validate the date before parsing
                if (createdAtforcancellation == null ||
                    createdAtforcancellation.isEmpty) {
                  print("Invalid or missing date for index $index");
                  return const Text("Invalid date");
                }
                //  dynamic createdAtforcancellation = value.parcelOrderModel[index].containsKey('paymentDetails') ? value.parcelOrderModel[index]['paymentDetails']["createdAt"] : "";

                if (_countdownValues.isEmpty) {
                  for (int index = 0;
                      index < value.parcelOrderModel.length;
                      index++) {
                    DateTime createdAt =
                        DateTime.parse(createdAtforcancellation);
                    _countdownValues[index] = _getCountdownValue(createdAt);
                  }
                  _startCountdown();
                }

                var createdAt = DateTime.parse(createdAtforcancellation);
                int countdownValue = _getCountdownValue(createdAt);

                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        print(
                            "||||||||||||||||||||||||||||||||>>>>>>>>>>>>>.${value.parcelOrderModel[index]['platformFeeCharge']}");
                        var formatedDate = formatDate(
                            dateStr: value.parcelOrderModel[index]
                                ['createdAt']);

                        dynamic deliverymanimg = value.parcelOrderModel[index]
                                .containsKey('assigneeDetails')
                            ? value.parcelOrderModel[index]['assigneeDetails']
                                ["imgUrl"]
                            : "";

                        dynamic deliverymanname = value.parcelOrderModel[index]
                                .containsKey('assigneeDetails')
                            ? value.parcelOrderModel[index]['assigneeDetails']
                                ["name"]
                            : "";
                        dynamic razorpaymentId = value.parcelOrderModel[index]
                                .containsKey('paymentDetails')
                            ? value.parcelOrderModel[index]['paymentDetails']
                                ["razorPayPaymentId"]
                            : "";
                        dynamic razorpaymentstatus = value
                                .parcelOrderModel[index]
                                .containsKey('paymentDetails')
                            ? value.parcelOrderModel[index]['paymentDetails']
                                ["paymentStatus"]
                            : "";
                        dynamic razorPayRefundId = value.parcelOrderModel[index]
                                .containsKey('paymentDetails')
                            ? value.parcelOrderModel[index]['paymentDetails']
                                ["razorPayRefundId"]
                            : "";

                        Get.to(
                            ParcelOrderDetails(
                              dropAddressType: value.parcelOrderModel[index]
                                  ['dropAddress'][0]['addressType'],
                              pickupAddresType: value.parcelOrderModel[index]
                                  ['pickupAddress'][0]['addressType'],
                              dropaddress: value.parcelOrderModel[index]
                                  ['dropAddress'][0]['fullAddress'],
                              pickupaddress: value.parcelOrderModel[index]
                                  ['pickupAddress'][0]['fullAddress'],
                              parcelDetails: value.parcelOrderModel[index]
                                  ['parcelDetails'],
                              triptype: value.parcelOrderModel[index]
                                  ['deliveryType'],
                              km: value.parcelOrderModel[index]['totalKms'],
                              invoicePath: value.parcelOrderModel[index]
                                  ["invoicePath"],
                              razorPayRefundId: razorPayRefundId,
                              razorpaymentId: razorpaymentId,
                              ratings: value.parcelOrderModel[index]["ratings"],
                              vendorAdminid: value.parcelOrderModel[index]
                                  ["vendorAdminId"],
                              productCategoryId: value.parcelOrderModel[index]
                                  ["productCategoryId"],
                              couponDiscount: value.parcelOrderModel[index]
                                  ['amountDetails']['couponsAmount'],
                              delivaryAddress: value.parcelOrderModel[index]
                                      ['dropAddress'][0]['fullAddress']
                                  .toString()
                                  .capitalizeFirst
                                  .toString(),
                              delivaryAddresstype: value.parcelOrderModel[index]
                                      ['dropAddress'][0]['addressType']
                                  .toString()
                                  .capitalizeFirst
                                  .toString(),
                              delivaryFee: value.parcelOrderModel[index]
                                  ['amountDetails']['deliveryCharges'],
                              delivaryTips: value.parcelOrderModel[index]
                                  ["amountDetails"]["tips"],
                              grandtotal: value.parcelOrderModel[index]
                                  ['amountDetails']['finalAmount'],
                              gst: value.parcelOrderModel[index]
                                  ['amountDetails']['tax'],
                              platformCharge: value.parcelOrderModel[index]
                                      ['amountDetails']['platformFee'] ??
                                  0,
                              itemTotal: value.parcelOrderModel[index]
                                      ['amountDetails']
                                  ['cartFoodAmountWithoutCoupon'],
                              orderDate: formatedDate,
                              orderId: value.parcelOrderModel[index]
                                  ['orderCode'],
                              paymentMethod: value.parcelOrderModel[index]
                                  ['paymentDetails']["paymentMode"],
                              resName: value.parcelOrderModel[index]
                                      ['pickupAddress'][0]['name']
                                  .toString()
                                  .capitalizeFirst
                                  .toString(),
                              status: value.parcelOrderModel[index]
                                  ['orderStatus'],
                              subAdminid: value.parcelOrderModel[index]
                                  ['subAdminId'],
                              delivermanid: value.parcelOrderModel[index]
                                      ['assignedToId'] ??
                                  "",
                              ordergetid: value.parcelOrderModel[index]['_id'],
                              couponType: value.parcelOrderModel[index]
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
                                  value.parcelOrderModel[index]['orderStatus']
                                      .toString()
                                      .capitalizeFirst
                                      .toString(),
                                  style: CustomTextStyle.yellowtext,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    value.parcelOrderModel[index]
                                            ['parcelDetails']['packageType']
                                        .toString()
                                        .capitalizeFirst
                                        .toString(),
                                    style: CustomTextStyle.boldblack2,
                                  ),
                                  Text(
                                      formatDate(
                                          dateStr: value.parcelOrderModel[index]
                                                  ['paymentDetails']
                                                  ['createdAt']
                                              .toString()),
                                      style: CustomTextStyle.smallgrey)
                                  // Text(
                                  //     value.parcelOrderModel[index]['orderCode']
                                  //         .toString(),
                                  //     style: CustomTextStyle.smallgrey),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      '${value.parcelOrderModel[index]['deliveryType'].toString().capitalizeFirst} Trip',
                                      style: CustomTextStyle.black14),
                                ],
                              ),
                              const SizedBox(height: 20),
                              CustomPaint(
                                size: Size(
                                    MediaQuery.of(context).size.width / 1,
                                    20), // Adjust size here
                                painter: DottedLinePainter(),
                              ),
                              if (countdownValue > 0 &&
                                  value.parcelOrderModel[index]
                                          ['orderStatus'] ==
                                      "initiated")
                                SizedBox(
                                  height: 30,
                                  child: Marquee(
                                    text:
                                        "You can cancel within ${countdownValue}s of placing your order. After that, cancellation isn’t available.",
                                    style: CustomTextStyle.rederrortext,
                                    scrollAxis: Axis.horizontal,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "₹ ${value.parcelOrderModel[index]['amountDetails']['finalAmount']}",
                                        style: CustomTextStyle.black14bold,
                                      ),
                                      10.toWidth,
                                      const Icon(Icons.arrow_forward_ios,
                                          color: Customcolors.DECORATION_BLACK,
                                          size: 15)
                                    ],
                                  ),
                                  if (!(countdownValue > 0 &&
                                      value.parcelOrderModel[index]
                                              ['orderStatus'] ==
                                          "initiated"))
                                    InkWell(
                                      onTap: () {
                                        var formatedDate = formatDate(
                                            dateStr:
                                                value.parcelOrderModel[index]
                                                    ['createdAt']);
                                        String createdAt =
                                            value.parcelOrderModel[index]
                                                ["paymentDetails"]['createdAt'];

                                        print('=====aca======== ==dvd');
                                        loge.i(value.parcelOrderModel[index]);

                                        Get.to(
                                            PrcelTrackorder(
                                              dropAddress: value
                                                  .parcelOrderModel[index]
                                                      ['dropAddress'][0]
                                                      ['fullAddress']
                                                  .toString()
                                                  .capitalizeFirst
                                                  .toString(),
                                              pickupAddress: value
                                                  .parcelOrderModel[index]
                                                      ['pickupAddress'][0]
                                                      ['fullAddress']
                                                  .toString()
                                                  .capitalizeFirst
                                                  .toString(),
                                              pickupAddressType:
                                                  value.parcelOrderModel[index]
                                                          ['pickupAddress'][0]
                                                      ['addressType'],
                                              dropAddressType:
                                                  value.parcelOrderModel[index]
                                                          ['dropAddress'][0]
                                                      ['addressType'],
                                              serviceName:
                                                  value.parcelOrderModel[index]
                                                      ['parcelDetails'],
                                              createdAt: createdAt,
                                              ordeID:
                                                  value.parcelOrderModel[index]
                                                      ['_id'],
                                              status:
                                                  value.parcelOrderModel[index]
                                                      ['orderStatus'],
                                              ordercode:
                                                  value.parcelOrderModel[index]
                                                      ['orderCode'],
                                              datetime: formatedDate,
                                              resturantlatlng: LatLng(
                                                  value.parcelOrderModel[index]
                                                          ['pickupAddress'][0]
                                                      ['latitude'],
                                                  value.parcelOrderModel[index]
                                                          ['pickupAddress'][0]
                                                      ['longitude']),
                                              userlat: LatLng(
                                                  value.parcelOrderModel[index]
                                                          ['dropAddress'][0]
                                                      ['latitude'],
                                                  value.parcelOrderModel[index]
                                                          ['dropAddress'][0]
                                                      ['longitude']),
                                            ),
                                            transition: Transition.leftToRight);
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
                                    ),
                                  if (countdownValue > 0 &&
                                      value.parcelOrderModel[index]
                                              ['orderStatus'] ==
                                          "initiated")
                                    InkWell(
                                      onTap: () {
                                        Get.off(
                                            ParcelCancelOrderDetails(
                                              orderid:
                                                  value.parcelOrderModel[index]
                                                      ['_id'],
                                              packagetype:
                                                  value.parcelOrderModel[index]
                                                          ['parcelDetails']
                                                      ['packageType'],
                                              ordercode:
                                                  value.parcelOrderModel[index]
                                                      ['orderCode'],
                                              status:
                                                  value.parcelOrderModel[index]
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
                                              decoration:
                                                  CustomContainerDecoration
                                                      .reddecoration(),
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8,
                                                    horizontal: 20),
                                                child: Center(
                                                  child: Text(
                                                    "Cancel Order",
                                                    style: CustomTextStyle
                                                        .white12text,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
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
            print('check...2');
            _countdownValues[index] = countdownValue - 1;
          }
        });
        print('check...3');
      });
      print('check...4');
    });
    print('check...5');
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

// "2024-11-16T06:19:41.950Z"

int _getCountdownValue(DateTime createdAt) {
  DateTime currentTime = DateTime.now().toUtc();
  DateTime endTime = createdAt.add(const Duration(seconds: 60));
  Duration difference = endTime.difference(currentTime);
  return difference.isNegative ? 0 : difference.inSeconds;
}

//  ==========  \\     // String formatTime({required String dateStr}) {
//  ==========  \\     //   DateTime dateTime = DateTime.parse(dateStr);
//  ==========  \\     //   // Convert to Indian Standard Time (UTC +5:30)
//  ==========  \\     //   dateTime = dateTime.add(Duration(hours: 5, minutes: 30));
//  ==========  \\     //   // Format to show only hours, minutes, and seconds
//  ==========  \\     //   String formattedTime = DateFormat("h:mm:ss a").format(dateTime).toLowerCase();
//  ==========  \\     //   return formattedTime;
//  ==========  \\     // }
// String formatDate({String? dateStr}) {
//   if (dateStr == null || dateStr.isEmpty) {
//     return '';
//   }

//   try {
//     DateTime dateTime = DateTime.parse(dateStr);
//     dateTime = dateTime.add(const Duration(hours: 5, minutes: 30));
//     String formattedDate =
//         DateFormat("d MMM yyyy 'at' h:mma").format(dateTime).toLowerCase();
//     return formattedDate;
//   } catch (e) {
//     return 'Invalid date';
//   }
// }