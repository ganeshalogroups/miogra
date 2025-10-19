// ignore_for_file: file_names, avoid_print

import 'dart:convert';
import 'package:testing/utils/Urlist.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
 
 
 class Menucountgetcontroller  extends GetxController{
 dynamic menucountModel;
  var ismenucountloading = false.obs;

  void menucountget({restaurantid}) async {
    try {
      ismenucountloading(true);
      var response = await http.get(
        Uri.parse("${API.menucount}?restaurantId=$restaurantid"),
        headers: API().headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
        var result = jsonDecode(response.body);
        menucountModel = result;
      } else {
        menucountModel == null;
      }
    } catch (e) {
      print("error");
    } finally {
      ismenucountloading(false);
    }
  }

 
 }
 
 
 
 
 
 
 
 
 
 
 
 