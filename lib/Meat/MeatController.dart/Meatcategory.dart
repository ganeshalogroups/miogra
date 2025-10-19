// ignore_for_file: avoid_print, file_names

import 'dart:convert';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class Categorymeatlistcontroller extends GetxController {
  dynamic categorymeat;
  var iscategorymeatloading = false.obs;
  void meatcategoryget() async {
    try {
      iscategorymeatloading(true);
      var response = await http.get(
        Uri.parse("${API.meatgetcategorylist}?cusineType=meat&status=true"),
        headers: API().headers,
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
          print("get categoryyy");
          loge.i(response.body);
        var result = jsonDecode(response.body);
        categorymeat = result;
      } else {
        categorymeat == null;

        print(response.body.toString());
      }
    } catch (e) {
      print("error");
    } finally {
      iscategorymeatloading(false);
    }
  }
}
