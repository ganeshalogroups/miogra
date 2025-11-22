// ignore_for_file: must_be_immutable, avoid_print, file_names

import 'dart:async';
import 'dart:io';
import 'package:testing/Features/OrderScreen/Invoice/Invoice.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:testing/Features/OrderScreen/OrderScreenController/Invoicecontroller.dart';
import 'package:testing/Features/OrderScreen/OrderScreenController/RefundController.dart';
import 'package:testing/map_provider/Map%20Screens/markervaluse.dart';
import 'package:testing/Features/OrderScreen/Food%20Ratings.dart';
import 'package:testing/Features/OrderScreen/Orderslist.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:another_stepper/dto/stepper_data.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:open_file/open_file.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/CustomDottedline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Orderstatus extends StatefulWidget {
  dynamic ordergetid;
  dynamic orderId;
  dynamic resName;
  dynamic resAddres;
  dynamic invoicePath;
  dynamic razorpaymentId;
  dynamic delivaryAddresstype;
  dynamic delivaryAddress;
  dynamic orderDate;
  dynamic km;
  dynamic paymentStatus;
  dynamic paymentMethod;
  dynamic status;
  dynamic itemTotal;
  dynamic gst;
  dynamic delivaryFee;
  dynamic deliverytip;
  dynamic couponDiscount;
  dynamic grandtotal;
  List<dynamic>? orderdetails;
  dynamic razorPayRefundId;
  dynamic subAdminid;
  dynamic delivermanid;
  dynamic couponType;
  dynamic deliverymanname;
  dynamic deliverymanimg;
  dynamic vendorAdminid;
  dynamic productCategoryId;
  dynamic ratings;
  dynamic packagingCharge;
  dynamic commission;
  dynamic platformfee;
  dynamic rejectedreason;
  dynamic timeinmins;
  dynamic deliveredAt;
  dynamic cancelledAt;
  dynamic rejectedAt;
  dynamic recievername;
  dynamic recievernumber;
  dynamic instructions;
  Orderstatus(
      {super.key,
      this.couponDiscount,
      required this.invoicePath,
      required this.razorPayRefundId,
      required this.paymentStatus,
      required this.razorpaymentId,
      required this.packagingCharge,
      this.ordergetid,
      this.delivaryAddress,
      this.commission,
      this.delivaryAddresstype,
      this.delivaryFee,
      this.grandtotal,
      this.km,
      this.deliveredAt,
      this.cancelledAt,
      this.rejectedAt,
      required this.deliverytip,
      required this.rejectedreason,
      this.gst,
      this.itemTotal,
      this.orderDate,
      this.orderId,
      required this.platformfee,
      this.paymentMethod,
      this.resAddres,
      this.resName,
      required this.timeinmins,
      this.orderdetails,
      required this.vendorAdminid,
      required this.productCategoryId,
      this.status,
      required this.delivermanid,
      required this.subAdminid,
      required this.deliverymanimg,
      required this.deliverymanname,
      required this.ratings,
      this.couponType,
      required this.recievername,
      required this.recievernumber,
      required this.instructions});

  @override
  State<Orderstatus> createState() => _OrderstatusState();
}

class _OrderstatusState extends State<Orderstatus> {
  Refundcontroller refund = Get.put(Refundcontroller());
  InvoiceController invoice = Get.put(InvoiceController());
  bool isButtonDisabled = false; // To disable the button during the timer
  int countdown = 10; // Time in seconds to disable the button

  // Function to handle the countdown logic
  void startDownloadInvoiceTimer() {
    setState(() {
      isButtonDisabled = true; // Disable the button when countdown starts
    });

    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (countdown > 0) {
          countdown--; // Decrease the countdown every second
        } else {
          timer.cancel(); // Stop the timer when it reaches 0
          isButtonDisabled = false; // Enable the button
          countdown = 10; // Reset countdown for future use
        }
      });
    });
  }

  @override
  void initState() {
    fetchRefundStatus();
    super.initState();
  }

  void fetchRefundStatus() async {
    await refund.refundstatus(
        refundId: widget.razorPayRefundId); // Pass the refundId if needed
    setState(() {
      if (refund.refundsstatus != null &&
          refund.refundsstatus["data"] != null) {
        _activeIndex =
            _getActiveIndex(status: refund.refundsstatus["data"]["status"]);
      } else {
        _activeIndex = 0; // Handle default case when refund data is null
      }
    });
  }

  int _activeIndex = 0;

  int _getActiveIndex({status}) {
    switch (status) {
      case "request_raised":
      //   return 1; // Highlight "Raise the Request for refund"
      // case "processed":
      //   return 2; // Highlight "Raise the Request" and "Fastx Initiated your refund"
      case "processed":
        return 3; // Highlight "Refund credited successfully"
      default:
        return 0; // Default to first step
    }
  }

  List<StepperData> _buildStepperData() {
    bool isSuccess = _activeIndex == 3;

    return [
      StepperData(
        title: StepperText(
          "Raise the Request for refund",
          textStyle: _activeIndex >= 1
              ? (isSuccess
                  ? CustomTextStyle.greentextstyle
                  : CustomTextStyle.DECORATION_regulartext)
              : CustomTextStyle.chipgrey,
        ),
        iconWidget: Container(
          decoration: BoxDecoration(
            color: _activeIndex >= 1
                ? (isSuccess ? Colors.green : Customcolors.darkpurple)
                : Customcolors.DECORATION_GREY,
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
          child: _activeIndex >= 1
              ? const Center(
                  child: Icon(Icons.check, size: 13, color: Colors.white))
              : null,
        ),
      ),
      StepperData(
        title: StepperText(
          "Fastx Initiated your refund",
          textStyle: _activeIndex >= 2
              ? (isSuccess
                  ? CustomTextStyle.greentextstyle
                  : CustomTextStyle.DECORATION_regulartext)
              : CustomTextStyle.chipgrey,
        ),
        iconWidget: Container(
          decoration: BoxDecoration(
            color: _activeIndex >= 2
                ? (isSuccess ? Colors.green : Customcolors.darkpurple)
                : Customcolors.DECORATION_GREY,
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
          child: _activeIndex >= 2
              ? const Icon(Icons.check, size: 13, color: Colors.white)
              : null,
        ),
      ),
      StepperData(
        title: StepperText(
          "Refund credited successfully",
          textStyle: _activeIndex >= 3
              ? CustomTextStyle.greentextstyle
              : CustomTextStyle.chipgrey,
        ),
        iconWidget: Container(
          decoration: BoxDecoration(
            color:
                _activeIndex >= 3 ? Colors.green : Customcolors.DECORATION_GREY,
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
          child: _activeIndex >= 3
              ? const Icon(Icons.check, size: 13, color: Colors.white)
              : null,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final rawTime = widget.timeinmins;
    final timeInMins = rawTime is int
        ? rawTime
        : int.tryParse(rawTime?.toString() ?? '0') ?? 0;

    final timeDisplay = timeInMins > 60
        ? '${(timeInMins / 60).toStringAsFixed(1)} hours'
        : '$timeInMins minutes';
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

    TextStyle getStatusTextStyle(String status) {
      switch (status) {
        case "delivered":
          return CustomTextStyle.trackgreenordertext;
        case "cancelled":
        case "rejected":
          return CustomTextStyle.trackredmarktext;
        default:
          return CustomTextStyle.orangeeetext;
      }
    }

    return Scaffold(
      backgroundColor: Customcolors.DECORATION_CONTAINERGREY,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .start, // Align children to the start (left) of the column

              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment
                      .start, // Align children to the start (left) of the row

                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Customcolors.DECORATION_BLACK,
                      ),
                    ),
                    const SizedBox(
                        width: 13), // Add some space between the icon and text

                    Expanded(
                      flex: 20,
                      // width: MediaQuery.of(context).size.width/1.8,
                      child: Text(
                        widget.resName.toString(),
                        style: CustomTextStyle.boldblack2,
                        overflow: TextOverflow.clip,
                      ),
                    ),

                    const Spacer(),
                    // Expanded(
                    // flex: 15,
                    // // width: 300,
                    //   child: Text(
                    //                          getStatusLabel(widget.status ?? ''),
                    //                          style: getStatusTextStyle(widget.status ?? ''),overflow: TextOverflow.clip,),
                    // ),
                    Expanded(
                      flex: 15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text(
                              getStatusLabel(widget.status ?? ''),
                              style: getStatusTextStyle(widget.status ?? ''),
                              overflow: TextOverflow.visible,
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 36, top: 10),
                  child: Text(
                    "${widget.resAddres}",
                    style: CustomTextStyle.mapgrey,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Customcolors.DECORATION_WHITE,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              "Deliver to",
                              style: CustomTextStyle.orderdetailstext,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 5.w,
                              ),
                              widget.delivaryAddresstype == 'Home'
                                  ? addressicon(image: homeicon,)
                                  : widget.delivaryAddresstype == 'Other' ||
                                          widget.delivaryAddresstype ==
                                              'Current' ||
                                          widget.delivaryAddresstype ==
                                              'Selected'
                                      ? addressicon(image: othersicon)
                                      : addressicon(image: workicon),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //  widget.delivaryAddresstype == 'Other' && widget.instructions!=null?Text(
                                    //     widget.instructions,
                                    //     style: CustomTextStyle.boldblack2,
                                    //   ): Text(
                                    //     widget.delivaryAddresstype,
                                    //     style: CustomTextStyle.boldblack2,
                                    //   ),
                                    (widget.delivaryAddresstype == 'Other' &&
                                            widget.instructions != null &&
                                            widget.instructions.toLowerCase() !=
                                                'null' &&
                                            widget.instructions
                                                .trim()
                                                .isNotEmpty)
                                        ? Text(widget.instructions,
                                            style: CustomTextStyle.boldblack2)
                                        : Text(widget.delivaryAddresstype,
                                            style: CustomTextStyle.boldblack2),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2),
                                      child: Text(
                                        "${widget.delivaryAddress}",
                                        maxLines: null,
                                        style: CustomTextStyle.chipgrey,
                                      ),
                                    ),
                                    // Padding(
                                    //     padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                                    //   child: Text(
                                    //     "${widget.recievername}",
                                    //     maxLines: null,
                                    //     style: CustomTextStyle.chipgrey,
                                    //   ),
                                    // ),
                                    // Padding(
                                    // padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                                    //   child: Text(
                                    //     "${widget.recievernumber}",
                                    //     maxLines: null,
                                    //     style: CustomTextStyle.chipgrey,
                                    //   ),
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2),
                                      child: RichText(
                                        text: TextSpan(
                                          style: CustomTextStyle
                                              .chipgrey, // base style
                                          children: [
                                            const TextSpan(
                                              text: 'Customer name: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(
                                              text: '${widget.recievername}\n',
                                            ),
                                            const TextSpan(
                                              text: 'Customer number: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(
                                              text: '${widget.recievernumber}',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: CustomDottedContainer(),
                          ),
                          widget.status == "delivered"
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/Timer.png",
                                      height: 20,
                                      width: 20,color:  Color(0xFF623089),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Your order delivered within $timeDisplay",
                                      style: CustomTextStyle.noboldblack,
                                    )

                                    //  widget.timeinmins!=null?
                                    //  Text(
                                    //   "Your order arrives within ${  int.parse(widget.timeinmins) > 60
                                    //  ? '${(int.parse(widget.timeinmins) / 60).toStringAsFixed(1)} hrs'
                                    //  : '${widget.timeinmins} minutes'} ",
                                    //   style: CustomTextStyle.noboldblack,
                                    //                              ):
                                    //                              Text(
                                    //   "Your order arrives within 0 minutes ",
                                    //   style: CustomTextStyle.noboldblack,
                                    //                              ),
                                  ],
                                )
                              : const SizedBox(),
                        ],
                      ),
                    )),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Customcolors
                        .DECORATION_WHITE, // Set your desired background color

                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Details',
                        style: CustomTextStyle.orderdetailstext,
                      ),
                      const CustomSizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Order ID',
                            style: CustomTextStyle.carttblack,
                          ),
                          // Spacer(),
                          Text(
                            "${widget.orderId}",
                            style: CustomTextStyle.carttblack,
                          )
                        ],
                      ),
                      const CustomSizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                                right:
                                    16), // Adjust the right padding as needed
                            child: Text(
                              'Order Date',
                              style: CustomTextStyle.carttblack,
                            ),
                          ),
                          Text(
                            "${widget.orderDate}",
                            style: CustomTextStyle.carttblack,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          if ((widget.status == "delivered" &&
                                  widget.deliveredAt.isNotEmpty) ||
                              (widget.status == "cancelled" &&
                                  widget.cancelledAt.isNotEmpty) ||
                              (widget.status == "rejected" &&
                                  widget.rejectedAt.isNotEmpty)) ...[
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: Text(
                                    widget.status == "delivered"
                                        ? 'Delivered Date'
                                        : widget.status == "cancelled"
                                            ? 'Cancelled Date'
                                            : 'Rejected Date',
                                    style: CustomTextStyle.carttblack,
                                  ),
                                ),
                                Text(
                                  widget.status == "delivered"
                                      ? widget.deliveredAt
                                      : widget.status == "cancelled"
                                          ? widget.cancelledAt
                                          : widget.rejectedAt,
                                  style: CustomTextStyle.carttblack,
                                ),
                              ],
                            ),
                          ]
                        ],
                      ),

//                       Column(
//   children: [
//   const SizedBox(height: 10,),
//     if (widget.status == "delivered" && widget.deliveredAt.isNotEmpty)
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Padding(
//             padding: EdgeInsets.only(right: 16),
//             child: Text(
//               'Delivered Date',
//               style: CustomTextStyle.carttblack,
//             ),
//           ),
//           Text(
//             "${widget.deliveredAt}",
//             style: CustomTextStyle.carttblack,
//           ),
//         ],
//       )
//     else if (widget.status == "cancelled" && widget.cancelledAt.isNotEmpty)
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Padding(
//             padding: EdgeInsets.only(right: 16),
//             child: Text(
//               'Cancelled Date',
//               style: CustomTextStyle.carttblack,
//             ),
//           ),
//           Text(
//             "${widget.cancelledAt}",
//             style: CustomTextStyle.carttblack,
//           ),
//         ],
//       )
//     else if (widget.status == "rejected" && widget.rejectedAt.isNotEmpty)
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Padding(
//             padding: EdgeInsets.only(right: 16),
//             child: Text(
//               'Rejected Date',
//               style: CustomTextStyle.carttblack,
//             ),
//           ),
//           Text(
//             "${widget.rejectedAt}",
//             style: CustomTextStyle.carttblack,
//           ),
//         ],
//       )
//     else
//       const SizedBox.shrink(), // fallback if none of the above match
//   ],
// ),

//                       // widget.status == "delivered"||widget.status == "cancelled"||widget.status == "rejected"?
                      //   SizedBox(height: 10):SizedBox.shrink(),
                      //      if (widget.status == "delivered"&&widget.deliveredAt.isNotEmpty)
                      //    Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Padding(
                      //       padding: EdgeInsets.only(
                      //           right:
                      //               16), // Adjust the right padding as needed
                      //       child: Text(
                      //         'Delivered Date',
                      //         style: CustomTextStyle.carttblack,
                      //       ),
                      //     ),
                      //     Text(
                      //       "${widget.deliveredAt}",
                      //       style: CustomTextStyle.carttblack,
                      //     ),
                      //   ],
                      // )
                      // else if(widget.status == "cancelled"&& widget.cancelledAt.isNotEmpty)
                      //  Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Padding(
                      //       padding: EdgeInsets.only(
                      //           right:
                      //               16), // Adjust the right padding as needed
                      //       child: Text(
                      //         'Cancelled Date',
                      //         style: CustomTextStyle.carttblack,
                      //       ),
                      //     ),
                      //     Text(
                      //       "${widget.cancelledAt}",
                      //       style: CustomTextStyle.carttblack,
                      //     ),
                      //   ],
                      // ) else if (widget.status == "rejected" && widget.rejectedAt.isNotEmpty)
                      //  Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Padding(
                      //       padding: EdgeInsets.only(
                      //           right:
                      //               16), // Adjust the right padding as needed
                      //       child: Text(
                      //         'Rejected Date',
                      //         style: CustomTextStyle.carttblack,
                      //       ),
                      //     ),
                      //     Text(
                      //       "${widget.rejectedAt}",
                      //       style: CustomTextStyle.carttblack,
                      //     ),
                      //   ],
                      // ),
                      //                         if (widget.deliveredAt != null)
                      // // show deliveredAt somewhere
                      // Text("Delivered At: ${formatDate(dateStr: widget.deliveredAt)}"),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Payment Method',
                            style: CustomTextStyle.carttblack,
                          ),
                          Text(
                            _getReadablePaymentMethod(widget.paymentMethod),
                            style: CustomTextStyle.carttblack,
                          ),
                        ],
                      ),
                      widget.rejectedreason != null &&
                              widget.rejectedreason.isNotEmpty
                          ? const SizedBox(height: 10)
                          : const SizedBox(height: 0),
                      widget.rejectedreason != null &&
                              widget.rejectedreason.isNotEmpty
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Rejected Reason',
                                    style: CustomTextStyle.redmarktext),
                                // Spacer(),
                                Text(
                                  "${widget.rejectedreason.toString().capitalizeFirst}",
                                  style: CustomTextStyle.redmarktext,
                                )
                              ],
                            )
                          : const SizedBox(),
                      const CustomSizedBox(height: 10),
                    ],
                  ),
                ),
                const CustomSizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Customcolors
                        .DECORATION_WHITE, // Set your desired background color
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Summary',
                        style: CustomTextStyle.orderdetailstext,
                      ),
                      const SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.orderdetails!.length,
                        itemBuilder: (context, index) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
// nonveg

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 6),
                                child: widget.orderdetails![index]
                                            ['foodType'] ==
                                        'veg'
                                    ? iconfun(imageName: vegIcon)
                                    : widget.orderdetails![index]['foodType'] ==
                                            'nonveg'
                                        ? iconfun(imageName: nonvegIcon)
                                        : iconfun(imageName: eggIcon),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 6),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  child: Text(
                                    "${widget.orderdetails![index]['quantity']} X ${widget.orderdetails![index]['foodName']}",
                                    style: CustomTextStyle.noboldblack,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomPaint(
                        size: Size(MediaQuery.of(context).size.width / 1,
                            20), // Adjust size here
                        painter: DottedLinePainter(),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           InkWell(
                            child: Text(
                              'Item Total',
                              style: CustomTextStyle.carttblack,
                            ),
                          ),
                          Text(
                            "₹ ${widget.itemTotal.toStringAsFixed(2)}",
                            style: CustomTextStyle.carttblack,
                          )
                        ],
                      ),
                      const CustomSizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Padding(
                            padding: EdgeInsets.only(
                                right:
                                    16), // Adjust the right padding as needed
                            child: Text(
                              'GST and Other Charges',
                              style: CustomTextStyle.carttblack,
                            ),
                          ),
                          Text(
                            "₹ ${widget.gst.toStringAsFixed(2)}",
                            style: CustomTextStyle.carttblack,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Delivery partner fee(up to ${widget.km} km)',
                            style: CustomTextStyle.carttblack,
                          ),
                          Text(
                            "₹ ${widget.delivaryFee.toStringAsFixed(2)}",
                            style: CustomTextStyle.carttblack,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         Text(
                            'Packaging Charge',
                            style: CustomTextStyle.carttblack,
                          ),
                          Text(
                            "₹ ${widget.packagingCharge.toStringAsFixed(2)}",
                            style: CustomTextStyle.carttblack,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      if(widget.commission!=0&& widget.commission!=null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         Text(
                            'Commission',
                            style: CustomTextStyle.carttblack,
                          ),
                          Text(
                            "₹ ${widget.commission}.00",
                            style: CustomTextStyle.carttblack,
                          ),
                        ],
                      ),
                      if(widget.commission!=0&& widget.commission!=null)
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Padding(
                            padding: EdgeInsets.only(
                                right:
                                    16), // Adjust the right padding as needed
                            child: Text(
                              'Platform Fee',
                              style: CustomTextStyle.carttblack,
                            ),
                          ),
                          widget.platformfee != null
                              ? Text(
                                  "₹ ${widget.platformfee.toStringAsFixed(2)}",
                                  style: CustomTextStyle.carttblack,
                                )
                              :  Text(
                                  "₹ 0.00",
                                  style: CustomTextStyle.carttblack,
                                ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      if(widget.deliverytip!=0.0)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Padding(
                            padding: EdgeInsets.only(
                                right:
                                    16), // Adjust the right padding as needed
                            child: Text(
                              'Delivery Tip',
                              style: CustomTextStyle.carttblack,
                            ),
                          ),
                          widget.deliverytip != null
                              ? Text(
                                  "₹ ${widget.deliverytip.toStringAsFixed(2)}",
                                  style: CustomTextStyle.carttblack,
                                )
                              :  Text(
                                  "₹ 0.00",
                                  style: CustomTextStyle.carttblack,
                                ),
                        ],
                      ),
                        if(widget.deliverytip!=0.0)
                      const SizedBox(height: 10),
                      if(widget.couponDiscount!=0.0)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Text(
                            'Coupon Discount',
                            style: CustomTextStyle.carttblack,
                          ),
                          Text(
                            "${widget.couponType == 'percentage' ? '%' : '₹'} ${widget.couponDiscount}",
                            style: const TextStyle(
                                fontSize: 13,
                                color: Customcolors.darkpurple,
                                fontFamily: 'Poppins-Regular'),
                          )
                        ],
                      ),
                    //   if(widget.couponDiscount!=0.0)
                      20.toHeight,
                      CustomPaint(
                        size: Size(MediaQuery.of(context).size.width / 1,
                            20), // Adjust size here
                        painter: DottedLinePainter(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         Text(
                            'Grand Total',
                            style: CustomTextStyle.carttblack,
                          ),
                          Text(
                            "₹ ${widget.grandtotal.toStringAsFixed(2)}",
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Customcolors.DECORATION_BLACK,
                                fontFamily: 'Poppins-Regular'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const CustomSizedBox(
                  height: 10,
                ),
                // if (widget.status == "cancelled" &&  widget.paymentMethod == "online payment" &&   widget.paymentStatus != "refund")

                //   refund.isrefundLoading.isTrue
                //       ? CustomContainer(
                //           width: MediaQuery.of(context).size.width / 3,
                //           height: 40,
                //           decoration: CustomContainerDecoration
                //               .gradientbuttondecoration(),
                //           child: const Padding(
                //             padding: EdgeInsets.symmetric(
                //                 vertical: 3, horizontal: 20),
                //             child: Center(
                //               child: Text(
                //                 "Loading..",
                //                 style: CustomTextStyle.smallwhitetext,
                //               ),
                //             ),
                //           ),
                //         )
                //       : InkWell(
                //           onTap: () {
                //             refund.sendrefund(
                //                 amount: 100, paymentId: widget.razorpaymentId);
                //           },
                //           child: CustomContainer(
                //             width: MediaQuery.of(context).size.width / 3,
                //             height: 40,
                //             decoration: CustomContainerDecoration
                //                 .gradientbuttondecoration(),
                //             child: const Padding(
                //               padding: EdgeInsets.symmetric(
                //                   vertical: 3, horizontal: 20),
                //               child: Center(
                //                 child: Text(
                //                   "Refund",
                //                   style: CustomTextStyle.smallwhitetext,
                //                 ),
                //               ),
                //             ),
                //           ),
                //         )

                if (widget.paymentStatus == "refund" &&
                        widget.status == "cancelled" &&
                        widget.paymentMethod == "ONLINE" ||
                    widget.paymentStatus == "refund" &&
                        widget.status == "rejected" &&
                        widget.paymentMethod == "ONLINE")
                  Column(
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 16),
                      //   child: AnotherStepper(
                      //     stepperList: _buildStepperData(),
                      //     stepperDirection: Axis.vertical,
                      //     iconWidth: 20,
                      //     iconHeight: 20,
                      //     activeBarColor: _activeIndex == 3
                      //         ? Colors.green
                      //         : Customcolors.darkpurple,
                      //     inActiveBarColor: Customcolors.DECORATION_GREY,
                      //     inverted: false,
                      //     verticalGap: 12,
                      //     activeIndex: _activeIndex,
                      //     barThickness: 1,
                      //   ),
                      // ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.red[100], // Optional: background color
                          borderRadius:
                              BorderRadius.circular(8), // Rounded corners
                        ),
                        child: const Text(
                          "Refunds are processed within 7 to 10 business days after approval.",
                          style: CustomTextStyle.rederrortext,
                          textAlign:
                              TextAlign.center, // Centers the text horizontally
                        ),
                      ),
                    ],
                  ),
                if (widget.paymentStatus == "refundFailure" &&
                        widget.status == "cancelled" &&
                        widget.paymentMethod == "ONLINE" ||
                    widget.paymentStatus == "refundFailure" &&
                        widget.status == "rejected" &&
                        widget.paymentMethod == "ONLINE")
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.red[100], // Optional: background color
                          borderRadius:
                              BorderRadius.circular(8), // Rounded corners
                        ),
                        child: const Text(
                          "Refunds aren't applicable for failed payments. Please contact our customer service for help.",
                          style: CustomTextStyle.rederrortext,
                          textAlign:
                              TextAlign.center, // Centers the text horizontally
                        ),
                      ),
                    ],
                  ),
                if (widget.paymentStatus == "refundSuccess" &&
                        widget.status == "cancelled" &&
                        widget.paymentMethod == "ONLINE" ||
                    widget.paymentStatus == "refundSuccess" &&
                        widget.status == "rejected" &&
                        widget.paymentMethod == "ONLINE")
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Customcolors
                              .DECORATION_GREEN, // Optional: background color
                          borderRadius:
                              BorderRadius.circular(8), // Rounded corners
                        ),
                        child: const Text(
                          "The amount has been successfully refunded to your account.",
                          style: CustomTextStyle.rederrortext,
                          textAlign:
                              TextAlign.center, // Centers the text horizontally
                        ),
                      ),
                    ],
                  ),

                widget.status == "delivered"
                    ? Center(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .center, // Aligns items in the center
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(FoodRatings(
                                      vendorAdminid: widget.vendorAdminid,
                                      productCategoryId:
                                          widget.productCategoryId,
                                      ratings: widget.ratings,
                                      orderId: widget.ordergetid,
                                      status: widget.status,
                                      address: widget.delivaryAddress,
                                      resName: widget.resName.toString(),
                                      subAdminid: widget.subAdminid, // resid
                                      delivermanid: widget.delivermanid,
                                      deliverymanname: widget.deliverymanname,
                                      delivermanimg: widget.deliverymanimg,
                                    ));
                                  },
                                  child: const Text(
                                    "Rate Order",
                                    style: CustomTextStyle.oRANGEtext,
                                  ),
                                ),
                                const SizedBox(
                                    width:
                                        20), // Adds space between the buttons
                                // Check if the invoice path is not null before showing the Download Invoice button
                                if (widget.invoicePath != null) ...[
                                  InkWell(
                                    onTap: () {
                                      openFIle(
                                        url: widget.invoicePath.toString(),
                                        fileName: 'FastX.pdf',
                                      ).catchError((error) {
                                        // Handle the error here (e.g., show a snackbar)
                                        print(
                                            "Error downloading invoice: $error");
                                      });
                                    },
                                    child: CustomContainer(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      decoration: CustomContainerDecoration
                                          .gradientbuttondecoration(),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Download Invoice",
                                              style: CustomTextStyle
                                                  .smallwhitetext,
                                            ),
                                            Icon(
                                              Icons.download,
                                              color:
                                                  Customcolors.DECORATION_WHITE,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            const CustomSizedBox(height: 5),
                            // You can add any additional widgets here
                          ],
                        ),
                      )
                    : const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getReadablePaymentMethod(String? method) {
    switch (method) {
      case 'ONLINE':
        return 'Online Payment';
      case 'OFFLINE':
        return 'Cash on Delivery';
      case 'WALLET':
        return 'Wallet Payment';
      default:
        return 'Unknown';
    }
  }

  bool isLoading = false;

  Future openFIle({required String url, String? fileName}) async {
    try {
      setState(() {
        isLoading = true;
      });
      final file = await downloadFile(url, fileName!);
      if (file == null) {
        return;
      } else {
        OpenFile.open(file.path);
        Get.to(PdfViewerPage(
          url: url,
          file: file,
        ));
      }
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
    //file.open(file.path);
    // OpenFile.op\
  }

  Future<File?> downloadFile(String url, String namre) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$namre');
    try {
      final response = await Dio().get(url,
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            // receiveTimeout: 0.0
          ));
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      return file;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}

Widget addressicon({image}) {
  return Image(
    image: AssetImage(image),
    width: 20,
    height: 20,
    color:  Color(0xFF623089),
  );
}
