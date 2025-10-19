
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Selectaddresscontroller extends GetxController{
  var latitude = ''.obs;
 var longtitude = ''.obs;
   var food = ''.obs;
  BuildContext? context;

  void setContext(BuildContext context) {
    this.context = context;
  }

   void fooddeliver(String? address) {
    food = RxString(address.toString());
    Get.back();
    update();
  }
}