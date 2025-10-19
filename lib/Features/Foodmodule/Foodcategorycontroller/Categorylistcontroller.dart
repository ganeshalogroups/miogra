// ignore_for_file: avoid_print, file_names

import 'dart:convert';
import 'package:testing/Features/Authscreen/AuthController/Tokenupdate.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Categorylistcontroller extends GetxController {
  TokenController tokenupdate = Get.put(TokenController());
  dynamic category;
  var iscategoryloading = false.obs;
  void categoryget() async {
    try {
      iscategoryloading(true);
      var response = await http.get(
        Uri.parse(API.categoryfastx),
        headers: API().headers,
      );

      print('${response.statusCode}');
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        var result = jsonDecode(response.body);
        category = result;
        print("categorydata${category["data"]}");
        if (category["data"].isNotEmpty) {
          for (var item in category["data"]) {
            if (item["productType"] == "restaurant") {
              getStorage.write("productcateid", item["_id"]);
              productCateId = getStorage.read("productcateid");
              print("productCateId${productCateId}");
              // break; // Exit loop once restaurant type is found and stored
            } else if (item["productType"] == "meat") {
              getStorage.write("meatproductcateid", item["_id"]);
              meatproductCateId = getStorage.read("meatproductcateid");
              break; // Exit loop once restaurant type is found and stored
            }
          }
        }
      } else {
        category == null;

        print(response.body.toString());
      }
    } catch (e) {
      print("error");
    } finally {
      iscategoryloading(false);
    }
  }
}
