// ignore_for_file: file_names

import 'dart:convert';
import 'package:testing/utils/Urlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;




class RedirectController extends GetxController {


 var isredirectLoading = false.obs;
 dynamic redirectLoadingDetails;

  getredirectDetails() async {

  
    try {
      isredirectLoading(true);
      var response = await http.get(
        Uri.parse(API.redirecturl),
        headers: API().headers,
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        redirectLoadingDetails = result;
         debugPrint("get redirect link  ${API.redirecturl}");
      debugPrint("get redirect link status ${response.body}");
      } else {
        redirectLoadingDetails = null;
      }
    } catch (e) {
      redirectLoadingDetails = null;
      //print(e.toString());
      return false;
    } finally {
      isredirectLoading(false);
    }
  }

}
