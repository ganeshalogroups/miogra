// ignore_for_file: must_be_immutable, avoid_print, file_names

import 'dart:async';
import 'dart:io';
import 'package:testing/Features/OrderScreen/Invoice/Invoice.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:testing/Features/OrderScreen/OrderScreenController/Invoicecontroller.dart';
import 'package:testing/Features/OrderScreen/OrderScreenController/RefundController.dart';
import 'package:testing/map_provider/Map%20Screens/markervaluse.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:open_file/open_file.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/CustomDottedline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'parcel_rating_screen.dart';

class ParcelOrderDetails extends StatefulWidget {
  dynamic ordergetid;
  dynamic resName;
  dynamic invoicePath;
  dynamic razorpaymentId;
  dynamic delivaryAddresstype;
  dynamic delivaryAddress;

  // List<dynamic>? orderdetails;
  dynamic razorPayRefundId;
  dynamic subAdminid;
  dynamic delivermanid;
  dynamic deliverymanname;
  dynamic deliverymanimg;
  dynamic vendorAdminid;
  dynamic productCategoryId;
  dynamic ratings;

  ///
  dynamic pickupaddress;
  dynamic dropaddress;
  dynamic orderId;
  dynamic orderItem;
  dynamic orderDate;
  dynamic paymentMethod;
  dynamic status;
  dynamic delivaryFee;
  dynamic delivaryTips;
  dynamic parcelDetails;
  dynamic pickupAddresType;
  dynamic dropAddressType;
  dynamic gst;
  dynamic platformCharge;
  dynamic couponDiscount;
  dynamic couponType;
  dynamic paymentStatus;
  dynamic itemTotal;
  dynamic grandtotal;
  dynamic km;
  dynamic triptype;

  ParcelOrderDetails({
    super.key,
    this.couponDiscount,
    required this.invoicePath,
    required this.razorPayRefundId,
    required this.paymentStatus,
    required this.razorpaymentId,
    this.ordergetid,
    this.delivaryAddress,
    this.delivaryAddresstype,
    this.delivaryFee,
    this.delivaryTips,
    this.grandtotal,
    this.km,
    this.gst,
    this.platformCharge,
    this.itemTotal,
    this.orderDate,
    this.orderId,
    this.paymentMethod,
    // this.resAddres,
    this.resName,
    // this.orderdetails,
    required this.vendorAdminid,
    required this.productCategoryId,
    this.status,
    required this.delivermanid,
    required this.subAdminid,
    required this.deliverymanimg,
    required this.deliverymanname,
    required this.ratings,
    this.couponType,
    this.dropAddressType,
    this.dropaddress,
    this.orderItem,
    this.parcelDetails,
    this.pickupAddresType,
    this.pickupaddress,
    this.triptype,
  });

  @override
  State<ParcelOrderDetails> createState() => _ParcelOrderDetailsState();
}

class _ParcelOrderDetailsState extends State<ParcelOrderDetails> {
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
        return 1; // Highlight "Raise the Request for refund"
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
    return Scaffold(
      backgroundColor: Customcolors.DECORATION_CONTAINERGREY,
      appBar: AppBar(
        title: const Text(
          'Order Details',
          style: CustomTextStyle.boldblack2,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .start, // Align children to the start (left) of the column

              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Customcolors.DECORATION_WHITE,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              widget.pickupAddresType == 'Home'
                                  ? addressicon(image: homeicon)
                                  : widget.pickupAddresType == 'Other' ||
                                          widget.pickupAddresType ==
                                              'Current' ||
                                          widget.pickupAddresType == 'Selected'
                                      ? addressicon(image: othersicon)
                                      : addressicon(image: workicon),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.pickupAddresType,
                                      style: CustomTextStyle.boldblack2,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${widget.pickupaddress}",
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
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Customcolors.DECORATION_WHITE,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              widget.dropAddressType == 'Home'
                                  ? addressicon(image: homeicon)
                                  : widget.dropAddressType == 'Other' ||
                                          widget.dropAddressType == 'Current' ||
                                          widget.dropAddressType == 'Selected'
                                      ? addressicon(image: othersicon)
                                      : addressicon(image: workicon),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.dropAddressType,
                                      style: CustomTextStyle.boldblack2,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${widget.dropaddress}",
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
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Customcolors
                        .DECORATION_WHITE, // Set your desired background color

                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Order Details',
                        style: CustomTextStyle.minblacktext,
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
                          const Text(
                            'Order Item',
                            style: CustomTextStyle.carttblack,
                          ),
                          // Spacer(),
                          Text(
                            "${widget.parcelDetails['packageType']}",
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
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Payment Method',
                            style: CustomTextStyle.carttblack,
                          ),
                          Text(
                            "${widget.paymentMethod.toString().capitalizeFirst}",
                            style: CustomTextStyle.carttblack,
                          ),
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
                              'Trip Type',
                              style: CustomTextStyle.carttblack,
                            ),
                          ),
                          Text(
                            "${widget.triptype}",
                            style: CustomTextStyle.carttblack,
                          ),
                        ],
                      ),
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
                      const Text(
                        'Bill Summary',
                        style: CustomTextStyle.minblacktext,
                      ),
                      const SizedBox(height: 10),

                      5.toHeight,

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const InkWell(
                            child: Text(
                              'Item Total',
                              style: CustomTextStyle.carttblack,
                            ),
                          ),
                          Text(
                            "₹ ${widget.itemTotal}",
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
                              'GST',
                              style: CustomTextStyle.carttblack,
                            ),
                          ),
                          Text(
                            "₹ ${widget.gst}",
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
                            "₹ ${widget.delivaryFee}",
                            style: CustomTextStyle.carttblack,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Delivery Tip',
                            style: CustomTextStyle.carttblack,
                          ),
                          Text(
                            "₹ ${widget.delivaryTips}",
                            style: CustomTextStyle.carttblack,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(onTap: () {
                            print(widget.platformCharge);
                            // You can add any action you want to perform on tap
                          },
                            child: Text(
                              'Platform Charge',
                              style: CustomTextStyle.carttblack,
                            ),
                          ),
                          Text(
                            "₹ ${widget.platformCharge}",
                            style: CustomTextStyle.carttblack,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Coupon Discount',
                            style: CustomTextStyle.carttblack,
                          ),
                          Text(
                            "${widget.couponType == 'percentage' ? '%' : '₹'} ${widget.couponDiscount}",
                            style: const TextStyle(
                                fontSize: 13,
                                color: Color.fromARGB(
                                  255,
                                  45,
                                  195,
                                  4,
                                ),
                                fontFamily: 'Poppins-Regular'),
                          )
                        ],
                      ),
                      // SizedBox(height: 10),
                      20.toHeight,
                      CustomPaint(
                        size: Size(MediaQuery.of(context).size.width / 1,
                            20), // Adjust size here
                        painter: DottedLinePainter(),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Grand Total',
                            style: CustomTextStyle.carttblack,
                          ),
                          Text(
                            "₹ ${widget.grandtotal}",
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Customcolors.DECORATION_BLACK,
                                fontFamily: 'Poppins-Regular'),
                          ),
                        ],
                      ),
                      5.toHeight
                    ],
                  ),
                ),
                const CustomSizedBox(
                  height: 10,
                ),
                if (widget.status == "cancelled" &&
                    widget.paymentMethod == "online payment" &&
                    widget.paymentStatus != "refund")
                  refund.isrefundLoading.isTrue
                      ? CustomContainer(
                          width: MediaQuery.of(context).size.width / 3,
                          height: 40,
                          decoration: CustomContainerDecoration
                              .gradientbuttondecoration(),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 3, horizontal: 20),
                            child: Center(
                              child: Text(
                                "Loading..",
                                style: CustomTextStyle.smallwhitetext,
                              ),
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            refund.sendrefund(
                                amount: 100, paymentId: widget.razorpaymentId);
                          },
                          child: CustomContainer(
                            width: MediaQuery.of(context).size.width / 3,
                            height: 40,
                            decoration: CustomContainerDecoration
                                .gradientbuttondecoration(),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 20),
                              child: Center(
                                child: Text(
                                  "Refund",
                                  style: CustomTextStyle.smallwhitetext,
                                ),
                              ),
                            ),
                          ),
                        )
                else if (widget.paymentStatus == "refund" &&
                        widget.status == "cancelled" &&
                        widget.paymentMethod == "online payment" ||
                    widget.paymentStatus == "refund" &&
                        widget.status == "rejected" &&
                        widget.paymentMethod == "online payment")
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: AnotherStepper(
                          stepperList: _buildStepperData(),
                          stepperDirection: Axis.vertical,
                          iconWidth: 20,
                          iconHeight: 20,
                          activeBarColor: _activeIndex == 3
                              ? Colors.green
                              : Customcolors.darkpurple,
                          inActiveBarColor: Customcolors.DECORATION_GREY,
                          inverted: false,
                          verticalGap: 12,
                          activeIndex: _activeIndex,
                          barThickness: 1,
                        ),
                      ),
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
                                    print('-------------av-------------');

                                    print(widget.productCategoryId);
                                    print(widget.ordergetid);
                                    print(widget.subAdminid);
                                    print(widget.vendorAdminid);

                                    print('-------------ad-------------');

                                    Get.to(ParcelRatings(
                                      vendorAdminid: widget.vendorAdminid,
                                      productCategoryId:
                                          widget.productCategoryId,
                                      ratings: widget.ratings,
                                      orderId: widget.ordergetid,
                                      status: widget.status,
                                      address: widget.delivaryAddress,
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
    width: 23,
    height: 23,
  );
}
