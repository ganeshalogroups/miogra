// ignore_for_file: file_names

import 'dart:convert';

import 'package:testing/utils/Urlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AdvertisementController extends GetxController {
 var isLoading = false.obs;
  dynamic advertisementDetails;

  getadvertisementDetails() async {
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse(API.advertisement),
        headers: API().headers,
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        advertisementDetails = result;
        
      debugPrint("get advertisement status ${response.body}");
      } else {
        //  print(response.body);
        advertisementDetails = null;
      }
    } catch (e) {
      advertisementDetails = null;
      //print(e.toString());
      return false;
    } finally {
      isLoading(false);
    }
  }

}

class AddImageLinkController extends GetxController {
 var isLoading = false.obs;
  dynamic imagelink;

  getimagelink() async {
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse(API.addimagelink),
        headers: API().headers,
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
      imagelink = result;
        
      debugPrint("get advertisement image status ${response.body}");
      } else {
        //  print(response.body);
        print("get advertisement image status ${response.statusCode} error");
       imagelink = null;
      }
    } catch (e) {
    imagelink = null;
     print("get advertisement image status catch");
      //print(e.toString());
      return false;
    } finally {
      isLoading(false);
    }
  }

}