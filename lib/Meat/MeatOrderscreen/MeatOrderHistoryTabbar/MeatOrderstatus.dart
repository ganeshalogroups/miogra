// ignore_for_file: file_names, must_be_immutable, avoid_print

import 'dart:async';
import 'dart:io';

import 'package:another_stepper/another_stepper.dart';
import 'package:dio/dio.dart';
import 'package:testing/Features/OrderScreen/Invoice/Invoice.dart';
import 'package:testing/Features/OrderScreen/OrderScreenController/Invoicecontroller.dart';
import 'package:testing/Features/OrderScreen/OrderScreenController/RefundController.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatOrderHistoryTabbar/OrderDetailsview.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatRatings.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class MeatOrderstatus extends StatefulWidget {
 dynamic ordergetid;
  dynamic orderId;
  dynamic shopName;
  dynamic shopAddres;
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
  MeatOrderstatus({
    this.couponDiscount,
    required this.invoicePath,
    required this.razorPayRefundId,
    required this.paymentStatus,
    required this.razorpaymentId,
    required this.packagingCharge,
    this.ordergetid,
    this.delivaryAddress,
    this.delivaryAddresstype,
    this.delivaryFee,
    this.grandtotal,
    this.km,
    this.gst,
    this.itemTotal,
    this.orderDate,
    this.orderId,
    this.paymentMethod,
    this.shopAddres,
    this.shopName,
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
    super.key});

  @override
  State<MeatOrderstatus> createState() => _MeatOrderstatusState();
}

class _MeatOrderstatusState extends State<MeatOrderstatus> {
 Refundcontroller refund = Get.put(Refundcontroller());
  InvoiceController invoice = Get.put(InvoiceController());
  bool isButtonDisabled = false; // To disable the button during the timer
  int countdown = 10; 
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start (left) of the column
                  
              children: [

                Row(

                  mainAxisAlignment: MainAxisAlignment.start, // Align children to the start (left) of the row
                      
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
                    const SizedBox(width: 13), // Add some space between the icon and text
                       
                    SizedBox(
                      width: MediaQuery.of(context).size.width/1.8,
                      child: Text(
                        widget.shopName.toString(),
                        style: CustomTextStyle.boldblack2,
                        overflow: TextOverflow.clip,
                      ),
                    ),


                    const Spacer(),
                    Text(
                      widget.status.toString().capitalizeFirst.toString(),
                      style: widget.status == "delivered"
                          ? CustomTextStyle.greenordertext
                          : widget.status == "cancelled"
                              ? CustomTextStyle.redmarktext
                              : CustomTextStyle.yellowordertext,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 36, top: 10),
                  child: Text(
                    "${widget.shopAddres}",
                    style: CustomTextStyle.mapgrey,
                  ),
                ),
               OrderDetailsview(
               orderId:widget.orderId,
               delivaryAddress: widget.delivaryAddress,
               delivaryAddresstype: widget.delivaryAddresstype,
               orderDate: widget.orderDate,
               km: widget.km,
               paymentMethod: widget.paymentMethod,
               itemTotal: widget.itemTotal,
               gst: widget.gst,
               delivaryFee: widget.delivaryFee,
               couponDiscount: widget.couponDiscount,
               grandtotal: widget.grandtotal,
               orderdetails: widget.orderdetails,
               couponType: widget.couponType,
               packagingCharge: widget.packagingCharge,
               ),
                if (widget.status == "cancelled" &&  widget.paymentMethod == "online payment" &&   widget.paymentStatus != "refund")
                  
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
             
               else if (widget.paymentStatus == "refund" &&  widget.status == "cancelled" && widget.paymentMethod == "online payment"||widget.paymentStatus == "refund" && widget.status == "rejected" && widget.paymentMethod == "online payment")
                  
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors
                                        .red[100], // Optional: background color
                                    borderRadius: BorderRadius.circular(
                                        8), // Rounded corners
                                  ),
                                  child: const Text(
                                    "Refunds are processed within 7 to 10 business days after approval.",
                                    style: CustomTextStyle.rederrortext,
                                    textAlign: TextAlign
                                        .center, // Centers the text horizontally
                                  ),
                                ),
                   
                    ],
                  ),
                              
                  widget.status == "delivered"

    ? Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Aligns items in the center
              children: [
                InkWell(
                  onTap: () {
                    Get.to(MeatRatings(
                      vendorAdminid: widget.vendorAdminid,
                      productCategoryId: widget.productCategoryId,
                      ratings: widget.ratings,
                      orderId: widget.ordergetid,
                      status: widget.status,
                      address: widget.delivaryAddress,
                      shopName: widget.shopName.toString(),
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
                const SizedBox(width: 20), // Adds space between the buttons
                // Check if the invoice path is not null before showing the Download Invoice button
                if (widget.invoicePath != null) ...[
                  InkWell(
                    onTap: () {
                      openFIle(
                        url: widget.invoicePath.toString(),
                        fileName: 'FastX.pdf',
                      ).catchError((error) {
                        print("Error downloading invoice: $error");
                      });
                    },
                    child: CustomContainer(
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: CustomContainerDecoration.gradientbuttondecoration(),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Download Invoice",
                              style: CustomTextStyle.smallwhitetext,
                            ),
                            Icon(
                              Icons.download,
                              color: Customcolors.DECORATION_WHITE,
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

