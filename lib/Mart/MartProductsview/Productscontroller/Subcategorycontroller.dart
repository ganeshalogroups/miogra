// ignore_for_file: avoid_print, file_names

import 'dart:convert';
import 'package:testing/utils/Urlist.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MartsubCategoriescontroller extends GetxController {
 dynamic subcategory;
  var issubcategoryloading = false.obs;

  var searchproductnamesearch = "".obs;

var selectedSubcategoryid = ''.obs;

  void setSelectedSubcateid(String id) {
    selectedSubcategoryid.value = id;
    print('Selected Subcategoryid: ID: $id');
  }

  void searchmartproductname(String name) {
    searchproductnamesearch.value = name;
    print('Selected cuisine: $name');
 }
   void clearmartproductname() {
   searchproductnamesearch.value = '';
   print('martproductname cleared');
  }

  void martsubcategoryget({required categoryid}) async {
    try {
      issubcategoryloading(true);
      var response = await http.get(
        Uri.parse("${API.martsubcategory}?categoryId=$categoryid"),
        headers: API().headers,
      );
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
          print("Subcategory fetched sucess");
        var result = jsonDecode(response.body);
        subcategory = result;
      } else {
        subcategory == null;
      }
    } catch (e) {
      print("error");
    } finally {
      issubcategoryloading(false);
    }
  }
}