// ignore_for_file: avoid_print, file_names, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ReorderGetcontroller extends GetxController {
dynamic reordertofoodgetmodel;
  var reordertofoodloading = false.obs;

  Future<dynamic> reordertofoodget({restaurantId}) async {
    try {
    print("restaurantId${restaurantId}");
      reordertofoodloading(true);
      var response = await http.get(
        Uri.parse('${API.searchFoodlistbyResgetfastx}?subAdminType=restaurant&latitude=$initiallat&longitude=$initiallong&userId=$UserId&subAdminId=$restaurantId'),
        headers: API().headers,
      );
print('reodertofoodget${API.searchFoodlistbyResgetfastx}?subAdminType=restaurant&latitude=$initiallat&longitude=$initiallong&userId=$UserId&subAdminId=$restaurantId');
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
          loge.i(response.body);
          print("Reorder to food fetch sucessfully");
        var result = jsonDecode(response.body);
        reordertofoodgetmodel = result;
      } else {
        reordertofoodgetmodel == null;

        print(response.body.toString());
      }
    } catch (e) {
      print("error");
    } finally {
      reordertofoodloading(false);
    }
  }

///For reorder coupon totalFoodAmount

   double getreordercarttoken = 0;

  getfoodreordercartforToken({orderid} ) async {
    try {
      var response = await http.get(
        Uri.parse( "${API.reorderfood}/$orderid"),
        headers: API().headers,
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
          print("sucess");
        var result = jsonDecode(response.body);

        getreordercarttoken =
            double.parse(result["data"]['totalFoodAmount'].toString());

          print(result["data"]['totalFoodAmount'].toString());
        //  return result["data"]['totalFoodAmount'];
      } else {
        getreordercarttoken = 0.0;

        return [];
      }
    } catch (e) {
      print("error: $e");
      return [];
    }
  }


    var isreorderloading = false.obs;
      dynamic reoredercart;
  reordercart({
    dynamic cartidlist,
  }) async {
    try {
      isreorderloading(true);
      var response = await http.post(Uri.parse(API.reordercart),
          headers: API().headers,
          body: jsonEncode(<String, dynamic>{
          "cartList":cartidlist, 
          "userId": UserId
      }));
      if (response.statusCode == 200) {
      print("reorderApi:${API.reordercart}");
          print({
"cartList":"${cartidlist}",
"userId":UserId
});
      print("reoredercart Sucessfully ");
      print("reorder response:${response.body}");
      var result = jsonDecode(response.body);
          reoredercart = result;
      



      } else {
      print(API.reordercart);
      print({
"cartList":"${cartidlist}",
"userId":UserId
});
      print(response.body);
      print("failed");
        reoredercart = null;
      }
    } catch (e) {
      Get.snackbar(
        '',
        '',
        backgroundColor: Colors.white,
        titleText: const Text("Error", style: CustomTextStyle.blacktext),
        messageText: Text(e.toString(), style: CustomTextStyle.blacktext),
      );
      return false;
    } finally {
      isreorderloading(false);
    }
  }
  }