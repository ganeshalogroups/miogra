// ignore_for_file: must_be_immutable, avoid_print, file_names, unnecessary_string_interpolations

import 'dart:async';
import 'dart:io';
import 'package:testing/Features/OrderScreen/Invoice/Invoice.dart';
import 'package:testing/Features/OrderScreen/OrderScreenController/OrdersControllerPagination.dart';
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
import 'package:testing/utils/Containerdecoration.dart';
import 'package:open_file/open_file.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/CustomDottedline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';




class Orderviewscreen extends StatefulWidget {
  dynamic orderId;
  Orderviewscreen({
    super.key,
    this.orderId,
  });



  @override
  State<Orderviewscreen> createState() => _OrderviewscreenState();
}

class _OrderviewscreenState extends State<Orderviewscreen> {
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
@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    final ordersProvider = Provider.of<GetOrdersProvider>(context, listen: false);
    await ordersProvider.getOdersbyid(orderid: widget.orderId);

    // Safely extract razorPayRefundId
    final orderData = ordersProvider.orderModel; // assuming this is a list or map
    String razorPayRefundId = "";

    if (orderData != null && orderData is List && orderData.isNotEmpty) {
      final item = orderData.first; // Or .where((e) => e['id'] == widget.orderId)
      if (item.containsKey('paymentDetails')) {
        razorPayRefundId = item['paymentDetails']["razorPayRefundId"] ?? "";
      }
    }

    fetchRefundStatus(razorPayRefundId); // pass it here
  });
}


void fetchRefundStatus(String razorPayRefundId) async {
  if (razorPayRefundId.isEmpty) return; // optional: skip if invalid
  await refund.refundstatus(refundId: razorPayRefundId);
  setState(() {
    // handle the status update
  });
}


  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      backgroundColor: Customcolors.DECORATION_CONTAINERGREY,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child:Consumer<GetOrdersProvider>(builder: (BuildContext context, value, Widget? child) { 
             if (value.isordergetbyidloading) {
          return const Padding(
            padding: EdgeInsets.all(12.0),
            child: CircularProgressIndicator(),
          );
          } else if (value.ordergetbyorderModel == null || value.ordergetbyorderModel.isEmpty) {
            return const Center(child: Text("No data"));
          } else {

 var formatedDate = formatDate(dateStr: value.ordergetbyorderModel['createdAt']);
                      
                              dynamic deliverymanimg = value.ordergetbyorderModel.containsKey('deliverymanDetails')  ? value.ordergetbyorderModel['deliverymanDetails']["imgUrl"]  :  "";
                                
    
                          dynamic deliverymanname = value.ordergetbyorderModel.containsKey('deliverymanDetails')? value.ordergetbyorderModel['deliverymanDetails']["name"]  : "";
                          dynamic razorpaymentstatus =value.ordergetbyorderModel.containsKey('paymentDetails') ? value.ordergetbyorderModel['paymentDetails']["paymentStatus"] : "";
                          dynamic couponType= value.ordergetbyorderModel['amountDetails']['couponType']??"";
    
            final rawTime = value.ordergetbyorderModel['tripDetails'] != null &&  value.ordergetbyorderModel['tripDetails']["tripTime"] != null
                                      ?  value.ordergetbyorderModel['tripDetails']["tripTime"] : 0;
            final timeInMins = rawTime is int ? rawTime
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
      return CustomTextStyle.greenordertext;
    case "cancelled":
    case "rejected":
      return CustomTextStyle.redmarktext;
    default:
      return CustomTextStyle.yellowordertext;
  }
}
           return   Column(

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
                      // width: MediaQuery.of(context).size.width/1.8,
                      child: Text(
                        value.ordergetbyorderModel['pickupAddress'][0]['name'].toString().capitalizeFirst.toString(),
                        style: CustomTextStyle.boldblack2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),


                    const Spacer(),
                    Column(
                      children: [
                        // Text(
                        //   value.ordergetbyorderModel['orderStatus'].toString().capitalizeFirst.toString(),
                        //   style: value.ordergetbyorderModel['orderStatus'] == "delivered"
                        //       ? CustomTextStyle.greenordertext
                        //       : value.ordergetbyorderModel['orderStatus'] == "cancelled"||value.ordergetbyorderModel['orderStatus'] == "rejected"
                        //           ? CustomTextStyle.redmarktext
                        //           : CustomTextStyle.yellowordertext,
                        // ),
                         SizedBox(
                        width: 100,
                          child: Text(
                                                 getStatusLabel(value.ordergetbyorderModel['orderStatus'] ?? ''),
                                                 style: getStatusTextStyle(value.ordergetbyorderModel['orderStatus'] ?? ''),overflow: TextOverflow.ellipsis,),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 36, top: 10),
                  child: Text(
                    value.ordergetbyorderModel['pickupAddress'][0]['fullAddress'].toString().capitalizeFirst.toString(),
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
                          const Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Text(
                              "Deliver to",
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
                              value.ordergetbyorderModel['dropAddress'][0]['addressType'].toString() == 'Home'
                                  ? addressicon(image: homeicon)
                                  : value.ordergetbyorderModel['dropAddress'][0]['addressType'].toString() == 'Other' ||
                                          value.ordergetbyorderModel['dropAddress'][0]['addressType'].toString() ==
                                              'Current' ||
                                         value.ordergetbyorderModel['dropAddress'][0]['addressType'].toString() ==
                                              'Selected'
                                      ? addressicon(image: othersicon)
                                      : addressicon(image: workicon),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      value.ordergetbyorderModel['dropAddress'][0]['addressType'].toString().capitalizeFirst.toString(),
                                      style: CustomTextStyle.boldblack2,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${value.ordergetbyorderModel['dropAddress'][0]['fullAddress'].toString().capitalizeFirst.toString()}",
                                        maxLines: null,
                                        style: CustomTextStyle.chipgrey,
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
                          value.ordergetbyorderModel['orderStatus'] == "delivered"
                              ?  Row(mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                               Image.asset("assets/images/Timer.png",height: 20,width: 20,),
                               const SizedBox(width: 10,),
                               Text(
  "Your order delivered within $timeDisplay",
  style: CustomTextStyle.noboldblack,
)
                               ],
                             ):const SizedBox(),
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
                            "${value.ordergetbyorderModel['orderCode']}",
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
                            "${formatedDate}",
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
                            "${value.ordergetbyorderModel['paymentDetails']["paymentMode"].toString().capitalizeFirst}",
                            style: CustomTextStyle.carttblack,
                          ),
                        ],
                      ),
                       value.ordergetbyorderModel['rejectedNote']!=null &&
                          value.ordergetbyorderModel['rejectedNote'].isNotEmpty? 
                        const SizedBox(height: 10):const SizedBox(height: 0),
                           value.ordergetbyorderModel['rejectedNote']!=null &&
                           value.ordergetbyorderModel['rejectedNote'].isNotEmpty? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Rejected Reason',
                            style: CustomTextStyle.carttblack,
                          ),
                          // Spacer(),
                          Text(
                            "${ value.ordergetbyorderModel['rejectedNote'].toString().capitalizeFirst}",
                            style: CustomTextStyle.carttblack,
                          )
                        ],
                      ):const SizedBox(),
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
                      const Text(
                        'Bill Summary',
                        style: CustomTextStyle.minblacktext,
                      ),
                      const SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount:  value.ordergetbyorderModel['ordersDetails'].length,
                        itemBuilder: (context, index) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
// nonveg

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 6),
                                child:value.ordergetbyorderModel['ordersDetails']![index]
                                            ['foodType'] ==
                                        'veg'
                                    ? iconfun(imageName: vegIcon)
                                    : value.ordergetbyorderModel['ordersDetails']![index]['foodType'] ==
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
                                    "${value.ordergetbyorderModel['ordersDetails']![index]['quantity']} X ${value.ordergetbyorderModel['ordersDetails']![index]['foodName']}",
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
                          const InkWell(
                            child: Text(
                              'Item Total',
                              style: CustomTextStyle.carttblack,
                            ),
                          ),
                          Text(
                            "₹ ${value.ordergetbyorderModel['amountDetails']['cartFoodAmountWithoutCoupon'].toStringAsFixed(2)}",
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
                            "₹ ${ value.ordergetbyorderModel['amountDetails']['tax'].toStringAsFixed(2)}",
                            style: CustomTextStyle.carttblack,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Delivery partner fee(up to ${ value.ordergetbyorderModel['totalKms']} km)',
                            style: CustomTextStyle.carttblack,
                          ),
                          Text(
                            "₹ ${value.ordergetbyorderModel['amountDetails']['deliveryCharges'].toStringAsFixed(2)}",
                            style: CustomTextStyle.carttblack,
                          ),
                        ],
                      ),
                     const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Packaging Charge',
                            style: CustomTextStyle.carttblack,
                          ),
                          Text(
                            "₹ ${value.ordergetbyorderModel['amountDetails']['packingCharges'].toStringAsFixed(2)}",
                            style: CustomTextStyle.carttblack,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                                right:
                                    16), // Adjust the right padding as needed
                            child: Text(
                              'Delivery Tip',
                              style: CustomTextStyle.carttblack,
                            ),
                          ),
                          value.ordergetbyorderModel['amountDetails']['tips']!=null?Text(
                            "₹ ${value.ordergetbyorderModel['amountDetails']['tips'].toStringAsFixed(2)}",
                            style: CustomTextStyle.carttblack,
                          ):const Text(
                            "₹ 0.00",
                            style: CustomTextStyle.carttblack,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                                right:
                                    16), // Adjust the right padding as needed
                            child: Text(
                              'Platform Charge',
                              style: CustomTextStyle.carttblack,
                            ),
                          ),
                          value.ordergetbyorderModel['amountDetails']['platformFee']!=null?Text(
                            "₹ ${value.ordergetbyorderModel['amountDetails']['platformFee'].toStringAsFixed(2)}",
                            style: CustomTextStyle.carttblack,
                          ):const Text(
                            "₹ 0.00",
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
                            "${couponType == 'percentage' ? '%' : '₹'} ${value.ordergetbyorderModel['amountDetails']['couponsAmount']}",
                            style: const TextStyle(
                                fontSize: 13,
                                color: Customcolors.darkpurple,
                                fontFamily: 'Poppins-Regular'),
                          )
                        ],
                      ),
                      20.toHeight,
                      CustomPaint(
                            size: Size(MediaQuery.of(context).size.width / 1,20), // Adjust size here
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
                            "₹ ${value.ordergetbyorderModel['amountDetails']['finalAmount'].toStringAsFixed(2)}",

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
                 if (razorpaymentstatus== "refund" &&  value.ordergetbyorderModel['orderStatus'] == "cancelled" && value.ordergetbyorderModel['paymentDetails']["paymentMode"] == "online payment"||razorpaymentstatus == "refund" && value.ordergetbyorderModel['orderStatus'] == "rejected" && value.ordergetbyorderModel['paymentDetails']["paymentMode"] == "online payment")
                  
                  Column(
                    children: [
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
                   if (razorpaymentstatus == "refundFailure" &&  value.ordergetbyorderModel['orderStatus'] == "cancelled" && value.ordergetbyorderModel['paymentDetails']["paymentMode"] == "online payment"||razorpaymentstatus == "refundFailure" && value.ordergetbyorderModel['orderStatus'] == "rejected" && value.ordergetbyorderModel['orderStatus'] == "cancelled" && value.ordergetbyorderModel['paymentDetails']["paymentMode"] == "online payment")
                  
                  Column(
                    children: [
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
                                    "Refunds aren't applicable for failed payments. Please contact our customer service for help.",
                                    style: CustomTextStyle.rederrortext,
                                    textAlign: TextAlign
                                        .center, // Centers the text horizontally
                                  ),
                                ),
                   
                    ],
                  ),
                   if (razorpaymentstatus == "refundSuccess" &&  value.ordergetbyorderModel['orderStatus'] == "cancelled" && value.ordergetbyorderModel['paymentDetails']["paymentMode"] == "online payment"||razorpaymentstatus == "refundSuccess" && value.ordergetbyorderModel['orderStatus'] == "rejected" && value.ordergetbyorderModel['orderStatus'] == "online payment")
                  
                  Column(
                    children: [
                       Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color:Customcolors.DECORATION_GREEN, // Optional: background color
                                    borderRadius: BorderRadius.circular(
                                        8), // Rounded corners
                                  ),
                                  child: const Text(
                                    "The amount has been successfully refunded to your account.",
                                    style: CustomTextStyle.rederrortext,
                                    textAlign: TextAlign
                                        .center, // Centers the text horizontally
                                  ),
                                ),
                   
                    ],
                  ),
                              
                  value.ordergetbyorderModel['orderStatus'] == "delivered"

    ? Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Aligns items in the center
              children: [
                InkWell(
                  onTap: () {
                    Get.to(FoodRatings(
                      vendorAdminid: value.ordergetbyorderModel["vendorAdminId"],
                      productCategoryId:value.ordergetbyorderModel["productCategoryId"],
                      ratings: value.ordergetbyorderModel["ratings"],
                      orderId:value.ordergetbyorderModel['_id'],
                      status: value.ordergetbyorderModel['orderStatus'],
                      address:  value.ordergetbyorderModel['dropAddress'][0]['fullAddress'].toString().capitalizeFirst.toString(),
                      resName: value.ordergetbyorderModel['pickupAddress'][0]['name'].toString().capitalizeFirst.toString(),
                      subAdminid: value.ordergetbyorderModel['subAdminId'],// resid
                      delivermanid: value.ordergetbyorderModel['assignedToId']??"",
                      deliverymanname:deliverymanname,
                      delivermanimg: deliverymanimg,
                    ));
                  },
                  child: const Text(
                    "Rate Order",
                    style: CustomTextStyle.oRANGEtext,
                  ),
                ),
                const SizedBox(width: 20), // Adds space between the buttons
                // Check if the invoice path is not null before showing the Download Invoice button
                if (value.ordergetbyorderModel["invoicePath"] != null) ...[
                  InkWell(
                    onTap: () {
                      openFIle(
                        url: value.ordergetbyorderModel["invoicePath"].toString(),
                        fileName: 'FastX.pdf',
                      ).catchError((error) {
                        // Handle the error here (e.g., show a snackbar)
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
            );
          
          
          }
            
             },)
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
    color: Color(0xFF623089) ,
  );
}
