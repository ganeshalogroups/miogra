// ignore_for_file: avoid_print, file_names

import 'dart:convert';
import 'package:testing/Features/Authscreen/AuthController/Tokenupdate.dart';
import 'package:testing/Features/Foodmodule/Foodviewscreen/AddButtonFunctions/Buttonfunctionalities.dart';
import 'package:testing/Features/coupon/couponController.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Foodcartcontroller extends GetxController {
  TokenController tokenupdate = Get.put(TokenController());

  dynamic foodcart;
  var foodcartloading = false.obs;
  dynamic lastAddFoodCode;
  dynamic lastAddFoodMessage;

  Future<void> addfood({
    required dynamic foodid,
    required String restaurantId,
    required bool isCustomized,
    required dynamic quantity,
    String? selectedVariantId,
    List<dynamic>? selectedAddOns,
  }) async {
    try {
      foodcartloading(true);
      // ✅ Reset previous error before making request
      lastAddFoodCode = null;
      lastAddFoodMessage = null;
      // Create the basic body
      Map<String, dynamic> body = {
        "foodId": foodid,
        "restaurantId": restaurantId,
        "quantity": quantity,
        "userId": UserId,
        "isCustomized": isCustomized,
      };
      if (isCustomized) {
        if (selectedVariantId != null && selectedVariantId.isNotEmpty) {
          body["selectedVariantId"] =
              selectedVariantId; // Add only if selectedVariantId is not empty or null
        }
        body["selectedAddOns"] = selectedAddOns ??
            []; // Add selectedAddOns, default to empty list if null
      }

      var response = await http.post(
        Uri.parse(API.addfoodfastx),
        headers: API().headers,
        body: jsonEncode(body),
      );
      print({
        "foodId": foodid,
        "restaurantId": restaurantId,
        "quantity": quantity,
        "userId": UserId,
        "isCustomized": isCustomized,
      });
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        var result = jsonDecode(response.body);

        foodcart = result;

        print("Sucess: in add");
      } else {
        foodcart = null;
        var result = jsonDecode(response.body);
        foodcart = null;
        lastAddFoodCode = result['code'];
        lastAddFoodMessage = result['message'];

        print("Error: in add - $lastAddFoodMessage");
        print("error: in add");
      }
    } catch (e) {
      print("error: $e");
    } finally {
      foodcartloading(false);
    }
  }

  dynamic updatefoodcart;
  var updatefoodcartloading = false.obs;

  Future<void> updateCartItem({
    required dynamic foodid,
    required dynamic quantity,
    String? selectedVariantId,
    List<dynamic>? selectedAddOns,
    required bool isCustomized,
    // required dynamic resturantId,
  }) async {
    try {
      updatefoodcartloading(true);

      // Create the basic body
      Map<String, dynamic> body = {
        "foodId": foodid,
        "quantity": quantity,
        "userId": UserId,
        "isCustomized": isCustomized,
      };
      if (isCustomized) {
        print(quantity);
        if (selectedVariantId != null && selectedVariantId.isNotEmpty) {
          body["selectedVariantId"] =
              selectedVariantId; // Add only if selectedVariantId is not empty or null
        }
        body["selectedAddOns"] = selectedAddOns ??
            []; // Add selectedAddOns, default to empty list if null
      }
      var response = await http.put(
        // restaurantId
        // Uri.parse("${API.updatefoodfastx}?restaurantId=$resturantId"),
        Uri.parse("${API.updatefoodfastx}?userId=$UserId"),
        headers: API().headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        var result = jsonDecode(response.body);

        updatefoodcart = result;
      } else {
        updatefoodcart = null;
      }
    } catch (e) {
      print("error: $e");
    } finally {
      updatefoodcartloading(false);
    }
  }

  dynamic getfoodcart;
  var getfoodcartloading = false.obs;

  Future getfoodcartfood({required dynamic km}) async {
    try {
      getfoodcartloading(true);
      var response = await http.get(
        Uri.parse("${API.addfoodfastx}?userId=$UserId&km=$km"),
        headers: API().headers,
      );

      // print('${response.statusCode}');
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        print("fvfvdvdddd${API.addfoodfastx}?userId=$UserId&km=$km");
        var result = jsonDecode(response.body);
        getfoodcart = result;

        // Ensure this is the correct path for your data

        return List<dynamic>.from(result["data"]["foods"] ?? []);
      } else {
        getfoodcart = null;

        return [];
      }
    } catch (e) {
      print("Food cart error: $e");
      // return [];
    } finally {
      getfoodcartloading(false);
    }
  }


  dynamic getrestaurantCommission;
  //var getfoodcartloading = false.obs;

  Future restaurantCommission() async {
    try {
    //  getfoodcartloading(true);
      var response = await http.get(
        Uri.parse("${API.getrestaurantCommission}commission?status=1&vendorId"),
        headers: API().headers,
      );

      // print('${response.statusCode}');
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        print("RestaurantCommission  ${API.getrestaurantCommission}commission?status=1&vendorId");
        var result = jsonDecode(response.body);
      getrestaurantCommission = result["data"];

        // Ensure this is the correct path for your data

       
      } else {
      

       
      }
    } catch (e) {
      print("Food cart error: $e");
      
    } finally {
      // getfoodcartloading(false);
    }
  }













  dynamic getbillfoodcart;
  var getbillfoodcartloading = false.obs;

  Future<List<dynamic>> getbillfoodcartfood({required dynamic km}) async {
    try {
      getbillfoodcartloading(true);
      update(); // Notify GetBuilder of loading state

      var response = await http.get(
        Uri.parse("${API.addfoodfastx}?userId=$UserId&km=$km"),
        headers: API().headers,
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        print(
            "getbillfoodcartfoodApi:${API.addfoodfastx}?userId=$UserId&km=$km");
        var result = jsonDecode(response.body);
        getbillfoodcart = result;
        update(); // Notify GetBuilder of data update

        // Ensure this is the correct path for your data
        return List<dynamic>.from(result["data"]["foods"] ?? []);
      } else {
        getbillfoodcart = null;
        update(); // Notify GetBuilder of null data
        return [];
      }
    } catch (e) {
      print("error: $e");
      return [];
    } finally {
      getbillfoodcartloading(false);
      update(); // Notify GetBuilder of final loading state
    }
  }

//=========================================================================
  dynamic clearcart;
  var clearcartloading = false.obs;

  Future<void> clearCartItem({required context}) async {
    try {
      clearcartloading(true);

      // Create the basic body
      Map<String, dynamic> body = {
        "userId": UserId,
      };

      var response = await http.put(
        Uri.parse(API.clearfoodfastx),
        headers: API().headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        var result = jsonDecode(response.body);

        Provider.of<ButtonController>(context, listen: false).hideButton();
        Provider.of<CouponController>(context, listen: false).removeCoupon();
        clearTipAmount();
        clearcart = result;
      } else {
        if (response.statusCode == 401) {
          tokenupdate.tokenupdateapi(mobileNo: mobilenumb);
        } else {}

        clearcart = null;
      }
    } catch (e) {
      print("error: $e");
    } finally {
      clearcartloading(false);
    }
  }

  dynamic deleteFoodCart;
  var deleteFoodCartLoading = false.obs;

  Future<void> deleteCartItem({
    required dynamic foodid,
  }) async {
    try {
      deleteFoodCartLoading(true);

      // Create the basic body
      Map<String, dynamic> body = {
        "foodId": foodid,
        "userId": UserId,
      };

      var response = await http.put(
        Uri.parse(API.deletefoodfastx),
        headers: API().headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        var result = jsonDecode(response.body);

        deleteFoodCart = result;
        print("Delete sucess");
      } else {
        deleteFoodCart = null;

        if (response.statusCode == 401) {
          tokenupdate.tokenupdateapi(mobileNo: mobilenumb);
        } else {}
      }
    } catch (e) {
      print("error: $e");
    } finally {
      deleteFoodCartLoading(false);
    }
  }

  var iscustomiseLoading = false.obs;
  dynamic customisationDetails;

  getcustomisationDetails({foodid}) async {
    try {
      iscustomiseLoading(true);
      var response = await http.get(
        Uri.parse("${API.particularcustomisation}?foodId=$foodid"),
        headers: API().headers,
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        customisationDetails = result;

        debugPrint("get customisationDetails status ${response.body}");
      } else {
        //  print(response.body);
        customisationDetails = null;
      }
    } catch (e) {
      customisationDetails = null;
      //print(e.toString());
      return false;
    } finally {
      iscustomiseLoading(false);
    }
  }

  RxString selectedTipAmount = ''.obs;

  void setTipAmount(String value) {
    selectedTipAmount.value = value.replaceAll("₹", "").trim();
    update(); // ⬅️ This triggers GetBuilder to rebuild
  }

  void clearTipAmount() {
    selectedTipAmount.value = '';
    update(); // Notifies listeners (if using GetBuilder)
  }

  RxString parcelselectedTipAmount = ''.obs;

  void etparcelTipAmount(String value) {
    parcelselectedTipAmount.value = value.replaceAll("₹", "").trim();
    //update(); // ⬅️ This triggers GetBuilder to rebuild
  }

  void learparcelTipAmount() {
    parcelselectedTipAmount.value = '';
   // update(); // Notifies listeners (if using GetBuilder)
  }
}
