// ignore_for_file: avoid_print, file_names

import 'dart:convert';
import 'package:testing/Features/OrderScreen/OrdersTab.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatOrderHistoryTabbar/MeatOrdersTab.dart';
import 'package:testing/parcel/p_parcel_orders/orders_tabs.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Toast/customtoastmessage.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Ratingcontroller extends GetxController{

 var isLoading = false.obs;
  addrating({
    dynamic rating,
    dynamic productOrUserId,
    dynamic review,
     dynamic orderId,
     dynamic instruction,
      dynamic productcateid,
     dynamic vendoradminid,
  }) async {
    try {
      isLoading(true);
      var response = await http.post(Uri.parse(API.ratingforrestaurant),
          headers: API().headers,
          body: jsonEncode(<String, dynamic>{
          "rating": rating,
          "productOrUserId": productOrUserId,
          "type": "restaurant",
          "review": review,
          "orderId":orderId,
          "customerId":UserId,
          "instruction":instruction,
          "productCategoryId":productcateid,
          "vendorId":vendoradminid
}));
      print(response.statusCode);
      if (response.statusCode == 200) {
        Get.off(const OrdersHistory());
        print(response.body);
          print("Rating successfully created");
      } else {
        var result = jsonDecode(response.body);
        Get.snackbar(
          '',
          '',
          backgroundColor: Customcolors.DECORATION_ERROR_RED,
          titleText: const Text(
            "Error",
            style:CustomTextStyle.blacktext
          ),
          messageText: Text(
            result["message"],
            style:CustomTextStyle.blacktext
          ),
        );
        // print(response.body);
        // Get.snackbar('Error', 'Please enter all the fields ',
        //     colorText: Colors.red);
      }
    } catch (e) {
      Get.snackbar(
        '',
        '',
        backgroundColor: Colors.white,
        titleText: const Text(
          "Error",
          style:CustomTextStyle.blacktext
        ),
        messageText: Text(
          e.toString(),
          style:CustomTextStyle.blacktext
        ),
      );
      print(e.toString());
      return false;
    } finally {
      isLoading(false);
    }
  }



var isdelLoading = false.obs;

  adddelrating({
     bool    isFromParcelFlow = false,
      bool   isFrommeatFlow = false,
     dynamic rating,
     dynamic productOrUserId,
     dynamic review,
     dynamic orderId,
     dynamic instruction,
     dynamic productcateid,
     dynamic vendoradminid,
     required  dynamic type
  }) async {
    try {
      isdelLoading(true);
      var response = await http.post(Uri.parse(API.ratingforrestaurant),
          headers: API().headers,
          body: jsonEncode(<String, dynamic>{
          "rating": rating,
          "productOrUserId": productOrUserId,
          "type": "deliveryman",
          "review": review,
          "orderId":orderId,
          "customerId":UserId,
          "instruction":instruction,
          "productCategoryId":productcateid,
          "vendorId":vendoradminid,
          "productCateType": type,
    }));


      print(response.statusCode);

      if (response.statusCode == 200) {
      loge.i(response.body);

        AppUtils.showToast('Rating Added Successfully');

          if(isFromParcelFlow){

            Get.off(const ParcelOrdersHistory()); 

          }else if(isFrommeatFlow){
           Get.off(const MeatOrderTab()); 
          }else{

            Get.off(const OrdersHistory());

          }
     


        print(response.body);
          print("Rating successfully created");
      } else {
        var result = jsonDecode(response.body);
        Get.snackbar(
          '',
          '',
          backgroundColor: Customcolors.DECORATION_ERROR_RED,
          titleText: const Text(
            "Error",
            style:CustomTextStyle.blacktext
          ),
          messageText: Text(
            result["message"],
            style:CustomTextStyle.blacktext
          ),
        );
        // print(response.body);
        // Get.snackbar('Error', 'Please enter all the fields ',
        //     colorText: Colors.red);
      }
    } catch (e) {
      Get.snackbar(
        '',
        '',
        backgroundColor: Colors.white,
        titleText: const Text(
          "Error",
          style:CustomTextStyle.blacktext
        ),
        messageText: Text(
          e.toString(),
          style:CustomTextStyle.blacktext
        ),
      );
      print(e.toString());
      return false;
    } finally {
      isdelLoading(false);
    }
  }



// For meat

 var ismeatLoading = false.obs;
  addmeatrating({
    dynamic rating,
    dynamic productOrUserId,
    dynamic review,
     dynamic orderId,
     dynamic instruction,
      dynamic productcateid,
     dynamic vendoradminid,
  }) async {
    try {
      ismeatLoading(true);
      var response = await http.post(Uri.parse(API.ratingforrestaurant),
          headers: API().headers,
          body: jsonEncode(<String, dynamic>{
          "rating": rating,
          "productOrUserId": productOrUserId,
          "type": "meat",
          "review": review,
          "orderId":orderId,
          "customerId":UserId,
          "instruction":instruction,
          "productCategoryId":meatproductCateId,
          "vendorId":vendoradminid
}));
      print(response.statusCode);
      if (response.statusCode == 200) {
        Get.off(const MeatOrderTab());
        print(response.body);
          print("Rating successfully created");
      } else {
        var result = jsonDecode(response.body);
        Get.snackbar(
          '',
          '',
          backgroundColor: Customcolors.DECORATION_ERROR_RED,
          titleText: const Text(
            "Error",
            style:CustomTextStyle.blacktext
          ),
          messageText: Text(
            result["message"],
            style:CustomTextStyle.blacktext
          ),
        );
        // print(response.body);
        // Get.snackbar('Error', 'Please enter all the fields ',
        //     colorText: Colors.red);
      }
    } catch (e) {
      Get.snackbar(
        '',
        '',
        backgroundColor: Colors.white,
        titleText: const Text(
          "Error",
          style:CustomTextStyle.blacktext
        ),
        messageText: Text(
          e.toString(),
          style:CustomTextStyle.blacktext
        ),
      );
      print(e.toString());
      return false;
    } finally {
      ismeatLoading(false);
    }
  }



} 