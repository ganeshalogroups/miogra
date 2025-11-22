// ignore_for_file: file_names

import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Orderprocess.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/CreateOrdercontroller.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/foodcartscreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpaymentIntegration {



  
  Ordercontroller ordercreate = Get.put(Ordercontroller());

 AddToCartController addToCartController = Get.put(AddToCartController());
  final Razorpay razorpay = Razorpay();

  openSesssions({dynamic amount, dynamic orderId}) {
    var options = {
      'key'     : 'rzp_live_RU4HdKgo9ITqKs',
      //'key'     : 'rzp_test_RNONYkgRZkffRt',
      'amount'  : amount,
      'currency': 'INR',
      'name'    : "Miogra",
      'order_id': orderId,
      'description': "Purchase description",
      // 'timeout': 60,
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '6380290384', 'email': 'kingslysherinb@gmail.com'},
      'external': {
        'wallets': ['paytm'],
      }
    };
    // try {

  

    //   razorpay.open(options);
    
    // } catch (e) {
    //   Fluttertoast.showToast(msg: 'Error: ${e.toString()}');
    // }
    try {
  razorpay.open(options);
} catch (e, stack) {
  debugPrint('Razorpay open error: $e');
  debugPrintStack(stackTrace: stack);
  Fluttertoast.showToast(msg: 'Payment error occurred');
}

  }

  initiateRazorPay() {
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }



  void _handlePaymentSuccess(PaymentSuccessResponse response) {



    ordercreate.updaterazorpayOrderList(
        razorpaymentId: response.paymentId.toString(),
        razorpaySIgnature: response.signature,
        razorpayOrderId: response.orderId);

    Fluttertoast.showToast( msg: 'Payment Success', backgroundColor: Colors.grey);
       

    // Timer(Duration(seconds: 4), () {
    Get.to(const Orderprocess(), // Navigate to Orderprocess on success
        transition: Transition.leftToRight,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn);
    // });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    //  addToCartController.setClicked(false);
        // ordercreate.buttonload.value=true;
        // print("Razorpay.buttonload.value${ordercreate.buttonload.value}");
    Fluttertoast.showToast(msg: 'Payment failed', backgroundColor: Colors.grey);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {

    // Fluttertoast.showToast(msg: 'Payment failed', backgroundColor: Colors.grey);
  }

  void dispose() {
    razorpay.clear();
  }
}
