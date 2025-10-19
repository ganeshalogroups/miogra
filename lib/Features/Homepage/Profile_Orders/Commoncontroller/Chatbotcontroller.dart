// ignore_for_file: file_names

import 'dart:convert';

import 'package:testing/utils/Urlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Chatbotcontroller extends GetxController {
 var ischatLoading = false.obs;
  dynamic chathealthcheckDetails;

  getachatstatusDetails() async {
    try {
      ischatLoading(true);
      var response = await http.get(
        Uri.parse(API.chathealthcheck),
        headers: API().headers,
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        chathealthcheckDetails = result;
        
      debugPrint("get chathealthcheck status ${response.body}");
      } else {
        //  print(response.body);
        chathealthcheckDetails = null;
      }
    } catch (e) {
      chathealthcheckDetails = null;
      print(e.toString());
      return false;
    } finally {
      ischatLoading(false);
    }
  }

}