// ignore_for_file: avoid_print, file_names

import 'dart:async';
import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:testing/Features/Homepage/homeStyles/FoodHomedecorations.dart';
import 'package:testing/Features/OrderScreen/OrderScreenController/trackOrderController.dart';
import 'package:testing/Features/OrderScreen/Orderstatus.dart';
import 'package:testing/map_provider/Map%20Screens/markervaluse.dart';
import 'package:testing/parcel/p_parcel_orders/parcel_cancelOrder.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/CustomDottedline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class PrcelTrackorder extends StatefulWidget {
  String ordeID;
  dynamic status;
  dynamic ordercode;
  dynamic datetime;
  LatLng userlat;
  dynamic createdAt;
  LatLng resturantlatlng;

  dynamic pickupAddress;
  dynamic pickupAddressType;
  dynamic dropAddress;
  dynamic dropAddressType;
  dynamic serviceName;

  PrcelTrackorder(
      {this.status,
      this.ordercode,
      this.datetime,
      required this.ordeID,
      required this.resturantlatlng,
      required this.userlat,
      this.pickupAddressType,
      this.dropAddressType,
      this.dropAddress,
      this.pickupAddress,
      this.serviceName,
      this.createdAt,
      super.key});

  @override
  State<PrcelTrackorder> createState() => _PrcelTrackorderState();
}

class _PrcelTrackorderState extends State<PrcelTrackorder> {
  Timer? canceltimer; // Timer for countdown
  final Map<int, int> _countdownValues = {};

  Timer? _timer;
  int _activeIndex = 0;
  var orderState = '';

  @override
  void initState() {
    super.initState();
    // Ensure this runs after the widget is fully built
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      orderState = widget.status;
      orderState =
          await Provider.of<TrackOrderController>(context, listen: false)
              .getOrders(orderId: widget.ordeID);
      _updateStepper(orderStatus: orderState);
      _startTimer();
    });
  }

  String orderSts = '';

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) async {
      try {
        // Check if the widget is still mounted before making async calls
        if (!mounted) return;

        var newOrderState =
            await Provider.of<TrackOrderController>(context, listen: false)
                .getOrders(orderId: widget.ordeID);

        if (!mounted) return;

        // Safely update the state
        setState(() {
          orderState = newOrderState;
          orderSts = orderState.toString();
        });

        _updateStepper(orderStatus: orderSts);

        if (orderSts == 'delivered' || orderSts == 'cancelled') {
          _timer?.cancel(); // Stop the timer
          _timer = null; // Set timer to null to avoid potential memory leaks
        }
      } catch (e) {
        print('Error fetching order status: $e');
      }
    });
  }

  void _updateStepper({required String orderStatus}) {
    int newIndex = _getActiveIndex(status: orderStatus);
    if (newIndex != _activeIndex) {
      setState(() {
        _activeIndex = newIndex;
      });
    }
  }

  @override
  void dispose() {
    canceltimer?.cancel();
    _timer?.cancel();
    super.dispose();
  }

  List<StepperData> _buildStepperData() {
    List<String> stepTitles = [
      "Your Order Has Been Received",
      "Delivery Man Assigned",
      "Your Package has been picked up for delivery.",
      "Delivery man at your drop location",
      "Package delivered"
    ];

    if (widget.serviceName['parcelTripType'] == 'round') {
      stepTitles.insert(4, 'Delivery man on round trip');
    }

    return List.generate(stepTitles.length, (index) {
      return StepperData(
        title: StepperText(
          stepTitles[index],
          textStyle: _activeIndex >= index + 1
              ? CustomTextStyle.DECORATION_regulartext
              : CustomTextStyle.chipgrey,
        ),
        iconWidget: _buildIconWidget(index),
      );
    });
  }

  Widget _buildIconWidget(int index) {
    return Container(
      decoration: BoxDecoration(
        color: _activeIndex >= index + 1
            ? Customcolors.darkpurple
            : Customcolors.DECORATION_GREY,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: _activeIndex >= index + 1
          ? const Icon(Icons.check, size: 13, color: Colors.white)
          : null,
    );
  }

  List<StepperData> rejectedSteperData({statuss}) {
    return [
      StepperData(
        title: StepperText(
          "Your Order Has Been Received",
          textStyle: _activeIndex >= 1
              ? CustomTextStyle.DECORATION_regulartext
              : CustomTextStyle.chipgrey,
        ),
        iconWidget: Container(
          decoration: const BoxDecoration(
            color: Customcolors.darkpurple,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: const Icon(Icons.check, size: 13, color: Colors.white),
        ),
      ),
      StepperData(
        title: StepperText(
          statuss == 'cancelled'
              ? 'Order Canceled'
              : "Order rejected By Vendor",
          textStyle: _activeIndex >= 2
              ? CustomTextStyle.DECORATION_regulartext
              : CustomTextStyle.chipgrey,
        ),
        iconWidget: Container(
          decoration: const BoxDecoration(
            color: Customcolors.darkpurple,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: const Icon(Icons.check, size: 13, color: Colors.white),
        ),
      ),
    ];
  }

  int _getActiveIndex({status}) {
    if (widget.serviceName['parcelTripType'] == 'round') {
      switch (status) {
        case "new":
          return 1; // Highlight "Restaurant accepted the order"
        case "orderAssigned":
          return 2; // Highlight "Your order is being prepared"
        case "orderPickedUped":
          return 3; // Highlight "Delivery partner picked up the order"
        case "deliverymanReachedDoor":
          return 4; // Highlight "Delivery partner at your door step"
        case "roundTripStarted":
          return 5;
        case "delivered":
          return 6;
        default:
          return 0; // Default to first step
      }
    } else {
      switch (status) {
        case "new":
          return 1; // Highlight "Restaurant accepted the order"
        case "orderAssigned":
          return 2; // Highlight "Your order is being prepared"
        case "orderPickedUped":
          return 3; // Highlight "Delivery partner picked up the order"
        case "deliverymanReachedDoor":
          return 4; // Highlight "Delivery partner at your door step"
        case "delivered":
          return 5;
        default:
          return 0; // Default to first step
      }
    }
  }

  Future<void> makePhoneCall({required String phoneNumber}) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> makeSms(
      {required String phoneNumber, required String message}) async {
    final Uri launchUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      query: 'body=${Uri.encodeComponent(message)}',
      // queryParameters: <String, String>{
      //   'body': message,
      // },
    );

    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch SMS';
    }
  }

  @override
  Widget build(BuildContext context) {
    var orderProvider = Provider.of<TrackOrderController>(context).orderModel;

    var createdAt = DateTime.parse(widget.createdAt);
    // var formattedTime = formatTime(dateStr: value.orderModel[index]['createdAt']);
    int countdownValue = _getCountdownValue(createdAt);

    return PopScope(
      //   canPop: false,
      //     onPopInvoked: (didPop) async{

      //      if (didPop) return;

      // Get.back();
      //       // Get.off(OrdersHistory(),transition: Transition.rightToLeft);

      // },
      child: Scaffold(
        backgroundColor: Customcolors.DECORATION_WHITE,
        appBar: AppBar(
          title: const Text('Track Order', style: CustomTextStyle.darkgrey),
          centerTitle: true,
          surfaceTintColor: Customcolors.DECORATION_WHITE,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: FoodDecorations().stepperDecParcel,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${widget.serviceName['packageType'].toString().capitalizeFirst}",
                                  style: CustomTextStyle.boldblack2,
                                ),
                                Text(
                                  "${orderState.toString().capitalizeFirst}",
                                  style: CustomTextStyle.yellowtext,
                                ),
                              ],
                            ),
                            Text(
                              "Order Id :  ${widget.ordercode.toString()}",
                              style: CustomTextStyle.mapgrey,
                            ),
                            Text(
                              "${widget.datetime}",
                              style: CustomTextStyle.mapgrey,
                            ),
                            20.toHeight,
                            CustomPaint(
                              size: Size(MediaQuery.of(context).size.width / 1,
                                  20), // Adjust size here
                              painter: DottedLinePainter(),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: orderSts == 'rejected' ||
                                      orderSts == 'cancelled'
                                  ? AnotherStepper(
                                      stepperList:
                                          rejectedSteperData(statuss: orderSts),
                                      stepperDirection: Axis.vertical,
                                      iconWidth: 20,
                                      iconHeight: 20,
                                      activeBarColor:
                                          Customcolors.darkpurple,
                                      inActiveBarColor:
                                          Customcolors.DECORATION_GREY,
                                      inverted: false,
                                      verticalGap: 12,
                                      activeIndex: _activeIndex,
                                      barThickness: 1,
                                    )
                                  : AnotherStepper(
                                      stepperList: _buildStepperData(),
                                      stepperDirection: Axis.vertical,
                                      iconWidth: 20,
                                      iconHeight: 20,
                                      activeBarColor:
                                          Customcolors.darkpurple,
                                      inActiveBarColor:
                                          Customcolors.DECORATION_GREY,
                                      inverted: false,
                                      verticalGap: 12,
                                      activeIndex: _activeIndex,
                                      barThickness: 1,
                                    ),
                            ),
                            10.toHeight,
                            CustomPaint(
                              size: Size(MediaQuery.of(context).size.width / 1,
                                  20), // Adjust size here
                              painter: DottedLinePainter(),
                            ),
                          ],
                        ),
                      )),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: Text(
                                      "Pickup Location",
                                      style: CustomTextStyle.smallblacktext,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      widget.pickupAddressType == 'Home'
                                          ? addressicon(image: homeicon)
                                          : widget.pickupAddressType ==
                                                      'Other' ||
                                                  widget.pickupAddressType ==
                                                      'Current' ||
                                                  widget.pickupAddressType ==
                                                      'Selected'
                                              ? addressicon(image: othersicon)
                                              : addressicon(image: workicon),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.pickupAddressType,
                                              style: CustomTextStyle.boldblack2,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "${widget.pickupAddress}",
                                                maxLines: null,
                                                style: CustomTextStyle.chipgrey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                        const SizedBox(height: 10),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: Text(
                                      "Drop Location",
                                      style: CustomTextStyle.smallblacktext,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      widget.dropAddressType == 'Home'
                                          ? addressicon(image: homeicon)
                                          : widget.dropAddressType == 'Other' ||
                                                  widget.dropAddressType ==
                                                      'Current' ||
                                                  widget.dropAddressType ==
                                                      'Selected'
                                              ? addressicon(image: othersicon)
                                              : addressicon(image: workicon),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.dropAddressType,
                                              style: CustomTextStyle.boldblack2,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "${widget.dropAddress}",
                                                maxLines: null,
                                                style: CustomTextStyle.chipgrey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: FoodDecorations().stepperDecParcel,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  orderProvider != null &&
                                          orderProvider['assigneeDetails'] !=
                                              null &&
                                          orderProvider['assigneeDetails']
                                                  ['imgUrl'] !=
                                              null
                                      ? CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              orderProvider['assigneeDetails']
                                                      ['imgUrl']
                                                  .toString()),
                                          radius: 25,
                                        )
                                      : Container(
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          child: Image.asset(
                                            "assets/images/Profile.png",
                                            height: 45,
                                            width: 45,
                                          ),
                                        ),

                                  const SizedBox(width: 10),
                                  // Display delivery partner's name
                                  Consumer<TrackOrderController>(
                                    builder: (context, value, child) {
                                      if (value.orderModel == null) {
                                        return const Text(
                                            'Waiting for delivery partner...');
                                      } else if (value
                                              .orderModel['assigneeDetails'] ==
                                          null) {
                                        return const Text(
                                          'No delivery partner assigned yet.',
                                          style: CustomTextStyle.smallgrey,
                                        );
                                      } else {
                                        if (_countdownValues.isEmpty) {
                                          for (int index = 0;
                                              index < value.orderModel.length;
                                              index++) {
                                            DateTime createdAt = DateTime.parse(
                                                widget.createdAt);
                                            _countdownValues[index] =
                                                _getCountdownValue(createdAt);
                                          }
                                          _startCountdown();
                                        }

                                        return Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  value.orderModel[
                                                              'assigneeDetails']
                                                          ['name'] ??
                                                      'No name',
                                                  style: CustomTextStyle
                                                      .boldblack2,
                                                ),
                                                const SizedBox(height: 5),
                                                const Text(
                                                  "Delivery Partner",
                                                  style:
                                                      CustomTextStyle.smallgrey,
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),

                              // Call button and mail icon
                              orderProvider != null &&
                                      orderProvider['assigneeDetails'] !=
                                          null &&
                                      orderProvider['assigneeDetails']
                                              ['mobileNo'] !=
                                          null
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            if (orderProvider != null &&
                                                orderProvider[
                                                        'assigneeDetails'] !=
                                                    null &&
                                                orderProvider['assigneeDetails']
                                                        ['mobileNo'] !=
                                                    null) {
                                              String mobileno = orderProvider[
                                                          'assigneeDetails']
                                                      ['mobileNo']
                                                  .toString();

                                              await makePhoneCall(
                                                  phoneNumber: mobileno);
                                            }
                                          },
                                          child: Image.asset(
                                            height: 40,
                                            width: 30,
                                            "assets/images/Fill call.png",
                                          ),
                                        ),
                                        SizedBox(width: 15.w),
                                        InkWell(
                                          onTap: () {
                                            if (orderProvider != null &&
                                                orderProvider[
                                                        'assigneeDetails'] !=
                                                    null &&
                                                orderProvider['assigneeDetails']
                                                        ['mobileNo'] !=
                                                    null) {
                                              String mobileno = orderProvider[
                                                          'assigneeDetails']
                                                      ['mobileNo']
                                                  .toString();

                                              makeSms(
                                                  phoneNumber: mobileno,
                                                  message:
                                                      'When Will I Get My Parcel');
                                            } else {}
                                            // makeSms(phoneNumber: '9751460125');
                                          },
                                          child: Image.asset(
                                            height: 40,
                                            width: 30,
                                            "assets/images/Fill mail.png",
                                          ),
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Cancel and Map buttons
                  if (countdownValue > 0 && widget.status == "initiated")
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.off(
                                  ParcelCancelOrderDetails(
                                      orderid: orderProvider['_id'],
                                      packagetype:
                                          widget.serviceName['packageType'],
                                      ordercode: widget.ordercode,
                                      status: orderState),
                                  transition: Transition.leftToRight);
                            },
                            child: CustomContainer(
                              decoration:
                                  CustomContainerDecoration.greyborder(),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 20),
                                child: Center(
                                  child: Text(
                                    "Cancel Order",
                                    style: CustomTextStyle.mapgrey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _startCountdown() {
    canceltimer = Timer.periodic(const Duration(seconds: 1), (timer) {
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

int _getCountdownValue(DateTime createdAt) {
  DateTime currentTime = DateTime.now().toUtc();
  DateTime endTime = createdAt.add(const Duration(seconds: 60));
  Duration difference = endTime.difference(currentTime);
  return difference.isNegative ? 0 : difference.inSeconds;
}
