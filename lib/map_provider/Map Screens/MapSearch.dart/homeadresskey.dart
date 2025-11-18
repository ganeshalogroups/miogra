// ignore_for_file: file_names

import 'dart:convert';

import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class HomeadresskeyController extends GetxController {
  var isadresskeyLoading = false.obs;
  dynamic adresskey;

  var isHomeDisabled = false.obs;
  var isWorkDisabled = false.obs;

  Future<void> gethomeadresskeyDetails() async {
    try {
      isadresskeyLoading(true);

      final response = await http.post(
        Uri.parse(API.findhomeaddress),
        headers: API().headers,
          body: jsonEncode(<String, dynamic>{
          "userId": UserId,
        }),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        adresskey = result;
       
print("USER ID  $UserId    $Usertoken");
print(API.findhomeaddress);
 print(result);
        // Extract disable flags
        isHomeDisabled.value = result['data']['isHome'] ?? false;
        isWorkDisabled.value = result['data']['isWork'] ?? false;
print(isHomeDisabled.value);
      } else {
        adresskey = null;
        isHomeDisabled.value = false;
        isWorkDisabled.value = false;
        print("ELSE");
      }
    } catch (e) {
      adresskey = null;
      isHomeDisabled.value = false;
      isWorkDisabled.value = false;
    } finally {
      isadresskeyLoading(false);
    }
  }
}
