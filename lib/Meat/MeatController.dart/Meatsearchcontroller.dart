// ignore_for_file: file_names, avoid_print

import 'dart:convert';
import 'package:testing/Features/Authscreen/AuthController/Tokenupdate.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Meatsearchcontroller extends GetxController {
//Create Recent Search Meat list Api
  TokenController tokenupdate = Get.put(TokenController());
  dynamic meatcreatesearch;
  var meatcreatesearchloading = false.obs;
  void createmeatrecentsearch(
      {String? hashtagName, meatproductcategoryid}) async {
    try {
      meatcreatesearchloading(true);
      var response = await http.post(Uri.parse(API.createrecentsearchfastx),
          headers: API().headers,
          body: jsonEncode(<String, dynamic>{
            "hashtagName": hashtagName,
            "hashtagType": "recentsearch",
            "hashtagImage": "",
            "productCateId": meatproductcategoryid,
            "parentAdminId": UserId
          }));

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        getrecentmeatsearch(meatproductcategoryid: meatproductcategoryid);
        var result = jsonDecode(response.body);
        meatcreatesearch = result;

        loge.i('$result');
      } else {
        meatcreatesearch == null;
      }
    } catch (e) {
      print("error");
    } finally {
      meatcreatesearchloading(false);
    }
  }

//Get Recent Search Meat list Api
  dynamic meatgetrecentsearch;
  var meatgetrecentsearchloading = false.obs;
  void getrecentmeatsearch({meatproductcategoryid}) async {
    try {
      meatgetrecentsearchloading(true);
      var response = await http.get(
        Uri.parse(
            "${API.createmeatrecentsearch}?productCateId=$meatproductcategoryid&hashtagType=recentsearch&parentAdminId=$UserId"),
        headers: API().headers,
      );
      print('${response.statusCode}');
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        var result = jsonDecode(response.body);
        meatgetrecentsearch = result;
      } else {
        meatgetrecentsearch == null;
      }
    } catch (e) {
      print(e.toString());
    } finally {
      meatgetrecentsearchloading(false);
    }
  }

//Get Meat list Api
  dynamic meatlist;
  var meatlistloading = false.obs;
  void meatsearchlistbyshop(String? valuee) async {
    try {
      meatlistloading(true);
      var response = await http.get(
        Uri.parse(
            "${API.meatsearchlist}?latitude=$initiallat&longitude=$initiallong&value=$valuee&userId=$UserId"),
        headers: API().headers,
      );
      print('${response.statusCode}');
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
          loge.i("searchurlll${API.meatsearchlist}?latitude=$initiallat&longitude=$initiallong&value=$valuee&userId=$UserId");
        var result = jsonDecode(response.body);
        meatlist = result;
        print('meatlistbyshop fetched Sucessfully');
      } else {
        meatlist == null;
      }
    } catch (e) {
      print(e.toString());
    } finally {
      meatlistloading(false);
    }
  }
}
