// ignore_for_file: avoid_print, file_names

import 'dart:convert';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Addfoodcontroller.dart';
import 'package:testing/PaymentGateway/parcel_Razorpay.dart';
import 'package:testing/parcel/model/create_order_model.dart';
import 'package:testing/parcel/p_order_processScreen.dart';
import 'package:testing/parcel/p_services_provider/imagePickerProvider.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Toast/customtoastmessage.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ParcelOrdercontroller extends GetxController {
  Foodcartcontroller foodcart = Get.put(Foodcartcontroller());
  final tipsProvider = Get.find<TipsProvider>();
 
 //final tipsProvider = Provider.of<TipsProvider>(context);
  // PaymentMethodController paymentMethodController = Get.put(PaymentMethodController());

  var iscreateOrderLoading = false.obs;

  dynamic createOrderDetails;

  Future<void> createOrderList({
    bool isFromSingleTrip = false,
    required OrderData orderdata,
    required ParcelRazorpaymentIntegration integration,
    required bool isCouponApplied,
    dynamic couponid,
    // required dynamic paymentMethod,
    required context,
  }) async {
    try {
      iscreateOrderLoading(true);

      Map<String, dynamic> bodyWithCoupon = orderdata.toJson();

      String jsonBody = jsonEncode(bodyWithCoupon);

      loge.i(bodyWithCoupon);

      var response = await http.post(Uri.parse(API.createParcelOrder),
          headers: API().headers, body: jsonBody
          // body: jsonEncode(selectedBody),
          );

      print("parcel order created response");
      print(response.body);

      if (response.statusCode == 200) {
        var resulttt = jsonDecode(response.body);
        createOrderDetails = resulttt;
        print("data , ${resulttt['data']['paymentMethod']}");
        if (resulttt['data']['paymentMethod'] == "ONLINE") {
          createrazorpayOrderList(
            amount: resulttt['data']['amountDetails']["finalAmount"],
            integration: integration,
            orderId: resulttt['data']['_id'],
          );
        } else if (resulttt['data']['paymentMethod'] == "OFFLINE") {
          cashAndDelivery(
            paymentamount: resulttt['data']['amountDetails']["finalAmount"],
            orderId: resulttt['data']['_id'],
          );
        }

        loge.i('for order create :  ${resulttt['data']['_id'].toString()}');

        Future.delayed(
          const Duration(seconds: 2),
          () {
            createFirebaseRealtimeDatabase(
              accuracy: 0,
              altitude: 0,
              heading: 0,
              headingAccuracy: 0,
              latitude: 0,
              longitude: 0,
              speed: 0,
              speedAccuracy: 0,
              timestamp: DateTime.now(),
              orderId: resulttt['data']['_id'].toString(),
            );
          },
        );
      } else {
        var result = jsonDecode(response.body);

        AppUtils.showToast(result);
      }
    } catch (e) {
      Get.snackbar(
        'Failed',
        e.toString(),
        backgroundColor: Customcolors.DECORATION_RED,
        titleText: Text(e.toString()),
        messageText: Text(e.toString()),
      );
    } finally {
      iscreateOrderLoading(false);
    }
  }

  var iscreaterazorpayOrderLoading = false.obs;
  createrazorpayOrderList({
    dynamic amount,
    required ParcelRazorpaymentIntegration integration,
    dynamic orderId,
  }) async {
    try {
      iscreaterazorpayOrderLoading(true);
      loge.i({
        "amount": amount * 100,
        "currency": "INR",
        "receipt": orderId,
        "notes": {"from": "payment request create from consumer"},
        "paymentFrom": "consumer"
      });
      var response = await http.post(Uri.parse(API.razorpayordercreate),
          headers: API().headers,
          body: jsonEncode(<String, dynamic>{
            "amount": amount * 100,
            "currency": "INR",
            "receipt": orderId,
            "notes": {"from": "payment request create from consumer"},
            "paymentFrom": "consumer"
          }));
      print("razor pay url , ${API.razorpayordercreate}");
      print(response.body);

      if (response.statusCode == 200) {
        var resulttt = jsonDecode(response.body);
        print(
            "RAZOR>>>>>>>>>>>>>>>>>>${resulttt['data']['razorpayOrderId'].toString()}");
        integration.openSesssions(
            amount: amount,
            orderId: resulttt['data']['razorpayOrderId'].toString());

        // Get.back();
      } else {
        var result = jsonDecode(response.body);

        Get.snackbar(
          'Failed',
          result["message"],
          backgroundColor: Colors.orange,
          titleText: const Text(
            "Failed",
          ),
          messageText: Text(
            result["message"].toString(),
          ),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Failed',
        e.toString(),
        backgroundColor: Colors.red,
        titleText: const Text(
          "Failed",
        ),
        messageText: Text(
          e.toString(),
        ),
      );
      return false;
    } finally {
      iscreaterazorpayOrderLoading(false);
    }
  }

  var updatecreaterazorpayOrderLoading = false.obs;
  updaterazorpayOrderList({
    required String razorpaymentId,
    razorpayOrderId,
    razorpaySIgnature,
    ParcelRazorpaymentIntegration? integration,
  }) async {
    try {
      updatecreaterazorpayOrderLoading(true);

      var response = await http.post(Uri.parse(API.razorpayPayment),
          headers: API().headers,
          body: jsonEncode(<String, dynamic>{
            "orderId": [createOrderDetails['data']['_id']],
            "cartId": [],
            "razorPayPaymentId": razorpaymentId,
            "paymentStatus": "success",
            "paymentAmount": createOrderDetails['data']['amountDetails']
                ["finalAmount"],
            "paymentMode": "online payment",
            "razorpayOrderId": razorpayOrderId,
            "razorpaySignature": razorpaySIgnature,
            "paymentFrom": "consumer"
          }));

      if (response.statusCode == 200) {
        //foodcart.clearparcelTipAmount();
        tipsProvider.cleaTips();
  
        // paymentMethodController.clearPaymentMethod();
      } else {
        var result = jsonDecode(response.body);
        Get.snackbar(
          'Failed',
          result["message"],
          backgroundColor: Colors.orange,
          titleText: const Text("Failed"),
          messageText: Text(result["message"].toString()),
        );
      }

      Get.snackbar(
          backgroundColor: const Color.fromARGB(255, 156, 255, 207),
          "Order Place Successfully",
          "");
    } catch (e) {
      Get.snackbar(
        'Failed',
        e.toString(),
        backgroundColor: Colors.red,
        titleText: const Text(
          "Failed",
        ),
        messageText: Text(
          e.toString(),
        ),
      );
      return false;
    } finally {
      updatecreaterazorpayOrderLoading(false);
    }
  }

  var isCODLoading = false.obs;
  cashAndDelivery({
    dynamic paymentamount,
    dynamic orderId,
  }) async {
    try {
      isCODLoading(true);
      var response = await http.post(Uri.parse(API.razorpayPayment),
          headers: API().headers,
          body: jsonEncode(<String, dynamic>{
            "orderId": [orderId],
            "cartId": [],
            "paymentStatus": "success",
            "paymentAmount": paymentamount,
            "paymentMode": "cash on delivery",
            "paymentFrom": "consumer"
          }));

      if (response.statusCode == 200) {
       // foodcart.clearparcelTipAmount();
       tipsProvider.cleaTips();
        // paymentMethodController.clearPaymentMethod();
        Get.off(const ParcelOrderProcess(),
            transition: Transition.leftToRight,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeIn);
      } else {
        var result = jsonDecode(response.body);
        Get.snackbar(
          'Failed',
          result["message"],
          backgroundColor: Colors.orange,
          titleText: const Text("Failed"),
          messageText: Text(result["message"].toString()),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Failed',
        e.toString(),
        backgroundColor: Colors.red,
        titleText: const Text(
          "Failed",
        ),
        messageText: Text(
          e.toString(),
        ),
      );
      return false;
    } finally {
      isCODLoading(false);
    }
  }

  var isgetOderLoading = false.obs;

  Future<void> getOrders() async {
    try {
      isgetOderLoading(true);
    } catch (e) {
      print('The Error In Get Orders IS ... $e');
    } finally {
      isgetOderLoading(false);
    }
  }

//For FireBAse DataBase

  Future<void> createFirebaseRealtimeDatabase({
    required String orderId,
    required double longitude,
    required double latitude,
    required DateTime timestamp,
    required double accuracy,
    required double altitude,
    required double heading,
    required double speed,
    required double speedAccuracy,
    required double headingAccuracy,
  }) async {
    try {
      // Get a reference to the Firebase Realtime Database
      DatabaseReference locationRef =
          FirebaseDatabase.instance.ref('deliveryManPositions/$orderId');

      // Set data for the document
      await locationRef.set({
        'longitude': longitude,
        'latitude': latitude,
        'timestamp':
            timestamp.toIso8601String(), // Convert DateTime to a string format
        'accuracy': accuracy,
        'altitude': altitude,
        'heading': heading,
        'speed': speed,
        'speedAccuracy': speedAccuracy,
        'headingAccuracy': headingAccuracy,
      });
    } catch (e) {
      print('Failed to add data to Firebase Realtime Database: $e');
    }
  }

  // dynamic cancelorder;
  // var cancelorderloading = false.obs;

  // Future<void> caancelorder({
  // required dynamic orderstatus,
  //   required dynamic orderid,
  //   required dynamic instructions,
  // }) async {
  //   DateTime now = DateTime.now();
  //   String formattedDateTime = now.toIso8601String();
  //   try {
  //     cancelorderloading(true);

  //     // Create the basic body
  //     Map<String, dynamic> body = {
  //       "orderStatus": "cancelled",
  //       "cancelledAt": formattedDateTime,
  //       "additionalInstructions": instructions
  //     };

  //     var response = await http.put(
  //       // restaurantId
  //       // Uri.parse("${API.updatefoodfastx}?restaurantId=$resturantId"),
  //       Uri.parse("${API.cancelorder}/$orderid"),
  //       headers: API().headers,
  //       body: jsonEncode(body),
  //     );

  //     if (response.statusCode == 200||response.statusCode == 201||response.statusCode == 202) {
  //       var result = jsonDecode(response.body);

  //        Get.to(Cancelorderprogressingscreen(),transition: Transition.leftToRight, duration: Duration(milliseconds: 200), curve: Curves.easeIn);

  //     await Future.delayed(Duration(seconds: 20));
  //       Get.to(Cancelorderscreen(), transition: Transition.leftToRight, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
  //       AppUtils.showToastTop('${result["message"]}');
  //       cancelorder = result;
  //     }
  //     else {
  //       var result = jsonDecode(response.body);
  //       Get.snackbar(
  //         'Something went wrong in cancel order',
  //         '${result["message"]}',
  //         backgroundColor: Customcolors.DECORATION_RED,
  //         colorText: Customcolors.DECORATION_BLACK,
  //         snackPosition: SnackPosition.TOP,
  //       );
  //       cancelorder = null;
  //     }

  //   } catch (e) {
  //     print("error: $e");
  //   } finally {
  //     cancelorderloading(false);
  //   }
  // }
}
