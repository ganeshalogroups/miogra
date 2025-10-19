// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:testing/Meat/MeatButtonFunctionalities/MeatAddproductController.dart/AddmeatController.dart';
import 'package:testing/Meat/MeatButtonFunctionalities/TotalitemcountButton.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatOrderprocess.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatPaymentBottomsheet.dart';
import 'package:testing/Meat/MeatOrderscreen/meatadditionalinfo.dart';
import 'package:testing/Meat/MeatRazorPayment/MeatRazorpayment.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class MeatOrdercontroller extends GetxController {
  MeatAddcontroller meatcart = Get.put(MeatAddcontroller());
  MeatPaymentMethodController paymentMethodController =Get.put(MeatPaymentMethodController());
  AdditionalinfocheckboxController checkboxController = Get.put(AdditionalinfocheckboxController());
  var iscreateOrderLoading = false.obs;
  dynamic createOrderDetails;
   Future<void> createOrderList({
    required dynamic productCategoryid,
    required dynamic userid,
    required dynamic subAdminid,
    required dynamic vendorAdminId,
    required dynamic dropAddress,
    required dynamic cartAmount,
    required dynamic cartFoodamount,
    required dynamic orderBasicamount,
    required dynamic finalamount,
    required dynamic deliveryCharges,
    required MeatRazorpaymentIntegration integration,
    required dynamic tax,
      required dynamic packagingcharge,
    required dynamic couponsamount,
    required dynamic cartFoodAmountWithoutCoupon,
    required bool isCouponApplied, // Indicates if coupon is applied or not
    dynamic couponid, // Keep dynamic if conditionally passed
    required dynamic paymentMethod,
    required dynamic ordersDetails,
    required dynamic discountAmount,
    required dynamic totalKms,
    required dynamic baseKm,
    required dynamic additionalInstructions,
    required context,
  }) async {


    try {

      iscreateOrderLoading(true);

      // Create the body for when a coupon is applied
      Map<String, dynamic> bodyWithCoupon = {
        "shareUserIds": [userid],
        "productCategoryId": productCategoryid,
        "userId": userid,
        "subAdminId": subAdminid,
        "subAdminType": "meat",
        "vendorAdminId": vendorAdminId,
        "dropAddress": dropAddress,
        "type": "consumer",
        "amountDetails": {
          "cartAmount": cartAmount,
          "cartFoodAmount": cartFoodamount,
          "couponsAmount": couponsamount,
          "orderBasicAmount": orderBasicamount,
          "cartFoodAmountWithoutCoupon": cartFoodAmountWithoutCoupon,
          "finalAmount": finalamount,
          "deliveryCharges": deliveryCharges,
          "tax": tax,
          "packingCharges": packagingcharge,
        },
        "ordersDetails": ordersDetails,
        "couponId": couponid,
        "paymentMethod": paymentMethod,
        "orderStatus":paymentMethod == "ONLINE" ? "created":"initiated",
        "discountAmount": discountAmount,
        "totalKms": totalKms,
        "baseKm": baseKm,
        "additionalInstructions": additionalInstructions,
      };



      // Create the body for when no coupon is applied
      Map<String, dynamic> bodyWithoutCoupon = {
        "deliveryType": "single",
        "shareUserIds": [userid],
        "productCategoryId": productCategoryid,
        "userId": userid,
        "subAdminId": subAdminid,
        "subAdminType": "meat",
        "vendorAdminId": vendorAdminId,
        "dropAddress": dropAddress,
        "type": "consumer",
        "amountDetails": {
          "cartAmount": cartAmount,
          "cartFoodAmount": cartFoodamount,
          "couponsAmount": 0, // No coupon applied
          "orderBasicAmount": orderBasicamount,
          "cartFoodAmountWithoutCoupon": cartFoodAmountWithoutCoupon,
          "finalAmount": finalamount,
          "deliveryCharges": deliveryCharges,
          "tax": tax,
          "packingCharges": packagingcharge,
        },
        "ordersDetails": ordersDetails,
        "paymentMethod": paymentMethod,
        "orderStatus": paymentMethod == "ONLINE" ?"created":"initiated",
        "discountAmount": discountAmount,
        "totalKms": totalKms,
        "baseKm":   baseKm,
        "additionalInstructions": additionalInstructions,
      };

      // Select the appropriate body based on isCouponApplied
      Map<String, dynamic> selectedBody =  isCouponApplied ? bodyWithCoupon : bodyWithoutCoupon;
        

loge.i(selectedBody);


      var response = await http.post(
        Uri.parse(API.createorderformeat),
        headers: API().headers,
        body: jsonEncode(selectedBody),
      );

      print("Create order response ${response.statusCode}");


      if (response.statusCode == 200) {
        var resulttt = jsonDecode(response.body);
        createOrderDetails = resulttt;
        if (resulttt['data']['paymentMethod'] == "ONLINE") {
          meatcreaterazorpayOrderList(
            amount: resulttt['data']['amountDetails']["finalAmount"],
            integration: integration,
            orderId: resulttt['data']['_id'],
          );
        }else if(resulttt['data']['paymentMethod'] == "OFFLINE"){
        cashAndDelivery(paymentamount: resulttt['data']['amountDetails']["finalAmount"],
        orderId: resulttt['data']['_id'],
         );
        
        }
    
loge.i('for order create :  ${resulttt['data']['_id'].toString()}');


    Future.delayed(const Duration(seconds: 2),() {

              createFirebaseRealtimeDatabase(
              accuracy       : 0,
              altitude       : 0,
              heading        : 0,
              headingAccuracy: 0,
              latitude       : 0,
              longitude      : 0,
              speed          : 0,
              speedAccuracy  : 0,
              timestamp      : DateTime.now(),
              orderId: resulttt['data']['_id'].toString(),
            );
          },
    );


        print("Order details: $ordersDetails");


    
      } else {


        var result = jsonDecode(response.body);


        Get.snackbar(
          'Failed',
          '${result["message"] ?? "Something went wrong."}\nCart Food Amount: $cartFoodamount\nFinal Amount: $finalamount',
          backgroundColor: Customcolors.DECORATION_RED,
          titleText: const Text("Failed"),
          messageText: Text(
            '${result["message"] ?? "Something went wrong."}\nCart Food Amount: $cartFoodamount\nFinal Amount: $finalamount',
            overflow: TextOverflow.ellipsis,
          ),
        );



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
         meatcart.clearmeatCartItem(context: Get.context);
        Provider.of<MeatButtonController>(Get.context!, listen: false).hidemeatButton();
        paymentMethodController.clearmeatPaymentMethod();
         checkboxController.clearSelectedCheckboxText(); 
         Get.to(const MeatOrderprocess(), // Navigate to Orderprocess on success
            transition: Transition.leftToRight, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
      
      } else {
        var result = jsonDecode(response.body);
        Get.snackbar(
          'Failed',
          result["message"],
          backgroundColor: Colors.orange,
          titleText: const Text(
            "Failed",
          ),
          messageText: Text( result["message"].toString()),
          
        );
      }
    }
     catch (e) {
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



  var iscreaterazorpayOrderLoading = false.obs;
  meatcreaterazorpayOrderList({
    dynamic amount,
    required MeatRazorpaymentIntegration integration,
    dynamic orderId,
  }) async {
    try {
      iscreaterazorpayOrderLoading(true);
      var response = await http.post(Uri.parse(API.razorpayordercreate),
          headers: API().headers,
          body: jsonEncode(<String, dynamic>{
            "amount": amount*100,
            "currency": "INR",
            "receipt": orderId,
            "notes": {"from": "payment request create from consumer"},
            "paymentFrom": "consumer"
          }));
      if (response.statusCode == 200) {
        var resulttt = jsonDecode(response.body);

        integration.openSesssions(
            amount: amount,
            orderId: resulttt['data']['razorPayOrderId'].toString());
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
    MeatRazorpaymentIntegration? integration,
  }) async {
    try {
        updatecreaterazorpayOrderLoading(true);
      
      var response = await http.post(
          Uri.parse(API.razorpayPayment),
          headers: API().headers,
          body: jsonEncode(<String, dynamic>{
            "orderId": [createOrderDetails['data']['_id']],
            "cartId": [],
            "razorPayPaymentId": razorpaymentId,
            "paymentStatus": "success",
            "paymentAmount": createOrderDetails['data']['amountDetails']["finalAmount"],
            "paymentMode": "online payment",
            "razorpayOrderId" : razorpayOrderId,
            "razorpaySignature": razorpaySIgnature,
            "paymentFrom": "consumer"
          }));
      if (response.statusCode == 200) {
        meatcart.clearmeatCartItem(context: Get.context);
        Provider.of<MeatButtonController>(Get.context!, listen: false).hidemeatButton();
        paymentMethodController.clearmeatPaymentMethod();
         checkboxController.clearSelectedCheckboxText(); 
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
      DatabaseReference locationRef =  FirebaseDatabase.instance.ref('deliveryManPositions/$orderId');
        

      // Set data for the document
      await locationRef.set({
        'longitude': longitude,
        'latitude' : latitude,
        'timestamp': timestamp.toIso8601String(), // Convert DateTime to a string format
        'accuracy' : accuracy,
        'altitude' : altitude,
        'heading'  : heading,
        'speed'    : speed,
        'speedAccuracy': speedAccuracy,
        'headingAccuracy': headingAccuracy,
      });

    } catch (e) {
      print('Failed to add data to Firebase Realtime Database: $e');
    }
  }
}
