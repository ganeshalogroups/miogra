// ignore_for_file: file_names

import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/foodcartscreen.dart';
import 'package:testing/parcel/p_order_processScreen.dart';
import 'package:testing/parcel/p_services_provider/p_order_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ParcelRazorpaymentIntegration {
  ParcelOrdercontroller ordercreate = Get.put(ParcelOrdercontroller());

  AddToCartController addToCartController = Get.put(AddToCartController());
  final Razorpay razorpay = Razorpay();

  openSesssions({dynamic amount, dynamic orderId}) {
    var options = {
      'key': 'rzp_live_RU4HdKgo9ITqKs',
      //'key': 'rzp_test_RNONYkgRZkffRt',
      'amount': amount,
      'currency': 'INR',
      'name': "Miogra",
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
    try {
      razorpay.open(options);
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: ${e.toString()}');
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

    //

    Fluttertoast.showToast(
        msg: 'Payment Success', backgroundColor: Colors.grey);

    // Timer(Durat ion(seconds: 4), () {

    Get.to(const ParcelOrderProcess(),
        transition: Transition.leftToRight,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn);

    // });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // addToCartController.setClicked(false);
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
