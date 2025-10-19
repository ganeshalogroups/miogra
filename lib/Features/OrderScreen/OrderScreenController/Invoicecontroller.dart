// ignore_for_file: avoid_print, file_names

import 'dart:convert';
import 'package:testing/Features/OrderScreen/OrdersTab.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class InvoiceController extends GetxController {
  var isSendOrderLoading = false.obs;
  sendBillOrderList(
      {dynamic orderId, dynamic subAdminId, bool isAgain = false}) async {
    try {
      isSendOrderLoading(true);
      var response = await http.post(Uri.parse(API.invoice),
          headers: API().headers,
          body: jsonEncode(<String, dynamic>{
            "orderId": orderId,
            "productCategoryId": "668fa27055e1aec84a92820c",
            "invoiceType": "user",
            "subAdminId": subAdminId
          }));
      print("update order response ${response.statusCode} $orderId");
      if (response.statusCode == 200) {
        if (isAgain == true) {
          Get.back();
        } else {
          Get.off(const OrdersHistory());
        }
        // Get.back();
      } else {
        var result = jsonDecode(response.body);
        Get.snackbar(
          'Failed',
          result["message"],
          backgroundColor: Colors.white,
          titleText: const Text(
            "Failed",
            style: CustomTextStyle.blacktext,
          ),
          messageText: Text(
            result["message"].toString(),
            style: CustomTextStyle.blacktext,
          ),
        );
        print(response.body);
      }
    } catch (e) {
      Get.snackbar(
        'Failed',
        e.toString(),
        backgroundColor: Colors.red,
        titleText: const Text(
          "Failed",
          style: CustomTextStyle.blacktext,
        ),
        messageText: Text(
          e.toString(),
          style: CustomTextStyle.blacktext,
        ),
      );
      print(e.toString());
      return false;
    } finally {
      isSendOrderLoading(false);
    }
  }
}
