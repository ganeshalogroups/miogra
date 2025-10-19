// ignore_for_file: avoid_print, file_names

import 'dart:convert';
import 'package:testing/Features/Bottomsheets/AddPaymentmethod.dart';
import 'package:testing/Features/Bottomsheets/Additionalinfo.dart';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Addfoodcontroller.dart';
import 'package:testing/Features/Foodmodule/Foodviewscreen/AddButtonFunctions/Buttonfunctionalities.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Orderprocess.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Cancelorderscreen.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/cancelprogresssing.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatcancelFinalscreen.dart';
import 'package:testing/Meat/MeatOrderscreen/Meatcancelorderprocess.dart';
import 'package:testing/PaymentGateway/Razorpay.dart';
import 'package:testing/parcel/p_parcel_orders/parcel_cancelFinal_screen.dart';
import 'package:testing/parcel/p_parcel_orders/parcel_cancel_process.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Toast/customtoastmessage.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Ordercontroller extends GetxController {
  Foodcartcontroller foodcart = Get.put(Foodcartcontroller());
  PaymentMethodController paymentMethodController =
      Get.put(PaymentMethodController());

  CheckboxController checkboxController = Get.put(CheckboxController());
  var iscreateOrderLoading = false.obs;

  dynamic createOrderDetails;

  
  Future<void> createOrderList({
  //  required dynamic commision,
    required List cartIdList,
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
    required RazorpaymentIntegration integration,
    required dynamic tax,
    required dynamic packagingcharge,
    required dynamic couponsamount,
    dynamic tips,
    required dynamic cartFoodAmountWithoutCoupon,
    required bool isCouponApplied, // Indicates if coupon is applied or not
    dynamic couponid, // Keep dynamic if conditionally passed
    required dynamic paymentMethod,
    required dynamic ordersDetails,
    required dynamic discountAmount,
    required dynamic totalKms,
    required dynamic baseKm,
    required dynamic additionalInstructions,
    required dynamic platformFee,
    required context,
    required amountForDistanceForDeliveryman
  }) async {
    try {
      iscreateOrderLoading(true);

      // Create the body for when a coupon is applied
      Map<String, dynamic> bodyWithCoupon = {
     
        "cartId": cartIdList,
        "shareUserIds": [userid],
        "productCategoryId": productCategoryid,
        "userId": userid,
        "subAdminId": subAdminid,
        "subAdminType": "restaurant",
        "vendorAdminId": vendorAdminId,
        "dropAddress": dropAddress,
        "type": "mobile",
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
          "platformFee": platformFee,
          "tips": tips,
          "payForDeliveryMan":amountForDistanceForDeliveryman
        },
        "ordersDetails": ordersDetails,
        "couponId": couponid,
        "paymentMethod": paymentMethod,
        "orderStatus": paymentMethod == "ONLINE" ? "created" : "initiated",
        "discountAmount": discountAmount,
        "totalKms": totalKms,
        "baseKm": baseKm,
        "additionalInstructions": additionalInstructions,
      };

      // Create the body for when no coupon is applied
      Map<String, dynamic> bodyWithoutCoupon = {
      
        "cartId": cartIdList,
        "shareUserIds": [userid],
        "productCategoryId": productCategoryid,
        "userId": userid,
        "subAdminId": subAdminid,
        "subAdminType": "restaurant",
        "vendorAdminId": vendorAdminId,
        "dropAddress": dropAddress,
        "type": "mobile",
        "amountDetails": {
          "cartAmount": cartAmount,
          "cartFoodAmount": cartFoodamount,
          "couponsAmount": 0, // No coupon applied
          "orderBasicAmount": orderBasicamount,
          "cartFoodAmountWithoutCoupon": cartFoodAmountWithoutCoupon,
          "finalAmount": finalamount,
          "platformFee": platformFee,
          "deliveryCharges": deliveryCharges,
          "tax": tax,
          "packingCharges": packagingcharge,
          "tips": tips,
          "payForDeliveryMan":amountForDistanceForDeliveryman
        },
        "ordersDetails": ordersDetails,
        "paymentMethod": paymentMethod,
        "orderStatus": paymentMethod == "ONLINE" ? "created" : "initiated",
        "discountAmount": discountAmount,
        "totalKms": totalKms,
        "baseKm": baseKm,
        "additionalInstructions": additionalInstructions,
      };

      // Select the appropriate body based on isCouponApplied
      Map<String, dynamic> selectedBody =
          isCouponApplied ? bodyWithCoupon : bodyWithoutCoupon;

      loge.i("selectedBody");
      loge.i(selectedBody);

      var response = await http.post(
        Uri.parse(API.ordercreate),
        headers: API().headers,
        body: jsonEncode(selectedBody),
      );

      print("Create order response ${response.statusCode}");
      print("Create order $ordersDetails");

print("QWQWQWWQW   $selectedBody");
      if (response.statusCode == 200) {
        var resulttt = jsonDecode(response.body);
        print("QQQQQQQQQQ $resulttt");
        createOrderDetails = resulttt;
        if (resulttt['data']['paymentMethod'] == "ONLINE") {
          createrazorpayOrderList(
            amount: resulttt['data']['amountDetails']["finalAmount"],
            integration: integration,
            orderId: resulttt['data']['_id'],
          );
        } 
        else if (resulttt['data']['paymentMethod'] == "OFFLINE" ||
            resulttt['data']['paymentMethod'] == "WALLET") {
              print("TTTTTTTTTTTT$resulttt");
          print(
              "paymentamount:${resulttt['data']['amountDetails']["finalAmount"]}");
          print("paymentamount:${resulttt['data']['_id']}");
          cashAndDelivery(
            paymentamount:
                resulttt['data']['amountDetails']["finalAmount"] + tips,
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

        print("Order details: $ordersDetails");
      } else {
        var result = jsonDecode(response.body);
print("ASASA  ${response.statusCode}");
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
      print("OOOOOOOOO $e");
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
dynamic vedordata;
Vendercash(String id)async{
try{
      var response = await http.post(Uri.parse(API.vendorbasedcash),
          headers: API().headers,
          body: jsonEncode(<String, dynamic>{
         //  "id":"6704ff3134216ff9fe342e46"
          "id":id
          }));
      if (response.statusCode == 200) {
        var resultt = jsonDecode(response.body);
        vedordata = resultt["data"];
        print("QWQW  $vedordata");
        }
        
}
catch(e){


}
}




  var iscreaterazorpayOrderLoading = false.obs;
  createrazorpayOrderList({
    dynamic amount,
    required RazorpaymentIntegration integration,
    dynamic orderId,
  }) async {
    try {
      iscreaterazorpayOrderLoading(true);
      print("razor create");
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
      if (response.statusCode == 200) {
        var resulttt = jsonDecode(response.body);

        integration.openSesssions(
            amount: amount*100,
            orderId: resulttt['data']['razorpayOrderId'].toString());
        // Get.back();
      } else {
        var result = jsonDecode(response.body);
        Get.snackbar(
          'Failed to create Razor Payment',
          result["message"],
          backgroundColor: Colors.blue,
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
    RazorpaymentIntegration? integration,
  }) async {
    try {
      updatecreaterazorpayOrderLoading(true);
      print("razzor update");
      loge.i({
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
      });
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
        foodcart.clearCartItem(context: Get.context);
        Provider.of<ButtonController>(Get.context!, listen: false).hideButton();
        paymentMethodController.clearPaymentMethod();
        checkboxController.clearSelectedCheckboxText();
        foodcart.clearTipAmount();
        // Get.back();
      } else {
        var result = jsonDecode(response.body);
        Get.snackbar(
          'Failed to Update Razor Payment',
          result["message"],
          backgroundColor: Colors.blueGrey,
          titleText: const Text(
            "Failed",
          ),
          messageText: Text(
            result["message"].toString(),
          ),
        );
      }
      // Get.snackbar(
      //     backgroundColor: Color.fromARGB(255, 156, 255, 207),
      //     "Order Placed Successfully",
      //     "");
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
print("NNNNN $orderId  ,  ${API().headers}");

          print("SSS${response.statusCode}");
      if (response.statusCode == 200) {
        print("BVBVBV${response.statusCode}");
        foodcart.clearCartItem(context: Get.context);
        Provider.of<ButtonController>(Get.context!, listen: false).hideButton();
        paymentMethodController.clearPaymentMethod();
        checkboxController.clearSelectedCheckboxText();
        foodcart.clearTipAmount();
        Get.to(const Orderprocess(), // Navigate to Orderprocess on success
            transition: Transition.leftToRight,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeIn);
      } else {
        var result = jsonDecode(response.body);
        Get.snackbar(
          'cashAndDelivery Failed',
          result["message"],
          backgroundColor: Colors.orange,
          titleText: const Text(
            "Failed",
          ),
          messageText: Text(result["message"].toString()),
        );
      }
    } catch (e) {

      print("ZZZZZZ   $e");
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

  dynamic cancelorder;
  var cancelorderloading = false.obs;

  Future<void> caancelorder({
    bool isfromparcel = false,
    bool isfrommeat = false,
    required dynamic orderstatus,
    required dynamic orderid,
    required dynamic instructions,
  }) async {
    DateTime now = DateTime.now();
    String formattedDateTime = now.toIso8601String();
    try {
      cancelorderloading(true);

      // Create the basic body
      Map<String, dynamic> body = {
        "orderStatus": "cancelled",
        "cancelledAt": formattedDateTime,
        "additionalInstructions": instructions
      };

      var response = await http.put(
        // restaurantId
        // Uri.parse("${API.updatefoodfastx}?restaurantId=$resturantId"),
        Uri.parse("${API.cancelorder}/$orderid"),
        headers: API().headers,
        body: jsonEncode(body),
      );
      print("cancelbody:${body}");
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        var result = jsonDecode(response.body);
print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>????????????????????????$isfromparcel");
        if (isfromparcel) {
          Get.to(const ParcelCancelorderprogressingscreen(),
              transition: Transition.leftToRight,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeIn);
          await Future.delayed(const Duration(seconds: 10));
          Get.to(const ParcelCancelFinalScreen(),
              transition: Transition.leftToRight,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeIn);
          AppUtils.showToastTop('${result["message"]}');
          cancelorder = result;
        } else if (isfrommeat) {
          Get.to(const MeatCancelorderprogressingscreen(),
              transition: Transition.leftToRight,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeIn);
          await Future.delayed(const Duration(seconds: 10));
          Get.to(const MeatCancelFinalScreen(),
              transition: Transition.leftToRight,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeIn);
          AppUtils.showToastTop('${result["message"]}');
          cancelorder = result;
        } else {
          Get.to(const Cancelorderprogressingscreen(),
              transition: Transition.leftToRight,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeIn);

          await Future.delayed(const Duration(seconds: 10));
          Get.to(Cancelorderscreen(),
              transition: Transition.leftToRight,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeIn);
          // AppUtils.showToastTop('${result["message"]}');
          AppUtils.showToastTop('Your Order has been Cancelled');
          cancelorder = result;
        }
      } else {
        var result = jsonDecode(response.body);
        Get.snackbar(
          'Something went wrong in cancel order',
          '${result["message"]}',
          backgroundColor: Customcolors.DECORATION_RED,
          colorText: Customcolors.DECORATION_BLACK,
          snackPosition: SnackPosition.TOP,
        );
        cancelorder = null;
      }
    } catch (e) {
      print("error: $e");
    } finally {
      cancelorderloading(false);
    }
  }
}
