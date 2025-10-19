// ignore_for_file: avoid_print, file_names

import 'dart:convert';
import 'package:testing/Features/Authscreen/AuthController/Tokenupdate.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MartBannerlistcontroller extends GetxController {
 TokenController tokenupdate = Get.put(TokenController());

  dynamic banner;
  var isbannerloading = false.obs;

  void martbannerget() async {
    try {
      isbannerloading(true);
      var response = await http.get(
        Uri.parse(
            "${API.bottombanner}?userType=consumer&productType=mart&status=true&bannerType=top&userId=$UserId"),
        headers: API().headers,
      );
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        print(
            "${API.bottombanner}?userType=consumer&productType=mart&status=true&bannerType=top&userId=$UserId");
        var result = jsonDecode(response.body);
        banner = result;
      } else {
        banner == null;
      }
    } catch (e) {
      print("error");
    } finally {
      isbannerloading(false);
    }
  }


   dynamic middlebanner;
  var ismiddlebannerloading = false.obs;

  void middlemartbannerget() async {
    try {
      ismiddlebannerloading(true);
      var response = await http.get(
        Uri.parse(
            "${API.bottombanner}?userType=consumer&productType=mart&status=true&bannerType=middle&userId=$UserId"),
        headers: API().headers,
      );
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        print(
            "${API.bottombanner}?userType=consumer&productType=mart&status=true&bannerType=middle&userId=$UserId");
        var result = jsonDecode(response.body);
        middlebanner = result;
      } else {
        middlebanner == null;
      }
    } catch (e) {
      print("error");
    } finally {
      ismiddlebannerloading(false);
    }
  }
}