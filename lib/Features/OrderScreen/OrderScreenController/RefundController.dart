// ignore_for_file: file_names

import 'dart:convert';

import 'package:testing/Features/OrderScreen/OrdersTab.dart';
import 'package:testing/parcel/p_parcel_orders/orders_tabs.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Refundcontroller extends GetxController {


  var isrefundLoading = false.obs;
      dynamic refundd;
  sendrefund({
    bool isfromParcelflow = false,
    dynamic amount,
    dynamic paymentId,
  }) async {
    try {
      isrefundLoading(true);
      var response = await http.post(Uri.parse(API.refund),
          headers: API().headers,
          body: jsonEncode(<String, dynamic>{
            "amount": amount,
            "currency": "INR",
            "paymentId": paymentId,
            "speed": "normal",//optimum
            "speed_processed": "normal"//instant
          }));
      if (response.statusCode == 200) {
      loge.i({
            "amount": amount,
            "currency": "INR",
            "paymentId": paymentId,
            "speed": "normal",//optimum
            "speed_processed": "normal"//instant
          });
print("Refunded Sucessfully for paymentid:${paymentId}");
      var result = jsonDecode(response.body);
          refundd = result;


    if(isfromParcelflow){

      Get.off(const ParcelOrdersHistory(),transition: Transition.fadeIn);

    }else{

      Get.off(const OrdersHistory(),transition: Transition.fadeIn);

    }
      



      } else {
        refundsstatus = null;
      }
    } catch (e) {
      Get.snackbar(
        '',
        '',
        backgroundColor: Colors.white,
        titleText: const Text("Error", style: CustomTextStyle.blacktext),
        messageText: Text(e.toString(), style: CustomTextStyle.blacktext),
      );
      return false;
    } finally {
      isrefundLoading(false);
    }
  }



    var isrefundstatusLoading = false.obs;
      dynamic refundsstatus;
  refundstatus({
    dynamic refundId,
  }) async {
    try {
      isrefundstatusLoading(true);
      var response = await http.post(Uri.parse(API.refundstatus),
          headers: API().headers,
          body: jsonEncode(<String, dynamic>{
            "refundId":refundId
          }));
      if (response.statusCode == 200) {
       var result = jsonDecode(response.body);
      refundsstatus = result;
      } else {
        refundsstatus = null;
      }
    } catch (e) {
      Get.snackbar(
        '',
        '',
        backgroundColor: Colors.white,
        titleText: const Text("Error", style: CustomTextStyle.blacktext),
        messageText: Text(e.toString(), style: CustomTextStyle.blacktext),
      );
      return false;
    } finally {
      isrefundstatusLoading(false);
    }
  }
}
