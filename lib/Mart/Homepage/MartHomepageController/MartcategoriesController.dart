// ignore_for_file: avoid_print, file_names

import 'dart:convert';
import 'package:testing/utils/Urlist.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MartCategoriescontroller extends GetxController {
 dynamic category;
  var iscategoryloading = false.obs;

 dynamic falsecategory;
  var isfalsecategoryloading = false.obs;

  void martcategorygettrue() async {
    try {
      iscategoryloading(true);
      var response = await http.get(
        Uri.parse(
            "${API.martcategory}?productCategoryType=mart&defaultStatus=true"),
        headers: API().headers,
      );
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        print("martcattrue:${API.martcategory}?productCategoryType=mart&defaultStatus=true");
        var result = jsonDecode(response.body);
        category = result;
      } else {
        category == null;
      }
    } catch (e) {
      print("error");
    } finally {
      iscategoryloading(false);
    }
  }

 void martcategorygetfalse() async {
    try {
      isfalsecategoryloading(true);
      var response = await http.get(
        Uri.parse(
            "${API.martcategory}?productCategoryType=mart&defaultStatus=false"),
        headers: API().headers,
      );
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        print("martcatfalse:${API.martcategory}?productCategoryType=mart&defaultStatus=false");
        var result = jsonDecode(response.body);
        falsecategory = result;
      } else {
        falsecategory == null;
      }
    } catch (e) {
      print("error");
    } finally {
      isfalsecategoryloading(false);
    }
  }


}

