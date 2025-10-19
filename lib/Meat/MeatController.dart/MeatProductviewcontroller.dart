// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:testing/Features/Authscreen/AuthController/Tokenupdate.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class MeatProductviewController extends GetxController {
  TokenController tokenupdate = Get.put(TokenController());
  var selectedFoodCusineName = ''.obs;
  var searchmeatnamesearch = "".obs;
 var selectedFoodCusineId = ''.obs;

  void setSelectedFoodCusineName(String name, String id) {
    selectedFoodCusineName.value = name;
    selectedFoodCusineId.value = id;
    print('Selected cuisine: $name, ID: $id');
  }

  void clearSelectedFoodCusineName() {
    selectedFoodCusineName.value = '';
    selectedFoodCusineId.value = '';
    print('Cuisine selection cleared');
  }


  void searchmeatname(String name) {
    searchmeatnamesearch.value = name;
    print('Selected cuisine: $name');
 }
  void clearsearchmeatname() {
   searchmeatnamesearch.value = '';
   print('Cuisine selection cleared');
  }

dynamic categorybuttonget;
  var categorybuttongetloading = false.obs;
  void meatcategorybuttonget({shopid,}) async {
    try {
      categorybuttongetloading(true);
      var response = await http.get(
        Uri.parse("${API.shopviewproducts}?latitude=$initiallat&longitude=$initiallong&subAdminId=$shopid&userId=$UserId&value="),
        headers: API().headers,
      );
      print('${response.statusCode}');
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        var result = jsonDecode(response.body);
        categorybuttonget = result;

        print(response.body);

        print('From The list ===>');
        loge.i(result);

        print("UserIddddddddd$UserId");
        print(
            "meatcategorybuttonget${API.shopviewproducts}?latitude=$initiallat&longitude=$initiallong&subAdminId=$shopid&userId=$UserId&value=");
        print('meatcategorybuttonget fetched Sucessfully');
      } else {
        categorybuttonget == null;

        print(response.body.toString());
      }
    } catch (e) {
      print(e.toString());
    } finally {
      categorybuttongetloading(false);
    }
  }
}



class MeatProductviewPaginations with ChangeNotifier {

  Logger logg = Logger();
  bool isLoading = false;

  bool moreDataLoading = false;

  int limit = 5;
  List fetchedDatas = [];

  dynamic totalCount;
  dynamic fetchCount;

  Future<void> clearData() async {
    fetchedDatas.clear();
    totalCount = 0;
    fetchCount = 0;
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchEarningData({meatCategoryId, searchvalue,shopid, int offset = 0}) async {
    try {
      moreDataLoading = true;
      notifyListeners();

      if (offset == 0) {
        isLoading = true;
        notifyListeners();
      }

      var response = await http.get(
        Uri.parse("${API.shopviewproducts}?limit=$limit&offset=$offset&latitude=$initiallat&longitude=$initiallong&subAdminId=$shopid&userId=$UserId&meatCategoryId=$meatCategoryId&value=$searchvalue"),
        headers: API().headers,
      );

      if (response.statusCode == 200) {
      logg.i("${API.shopviewproducts}?limit=$limit&offset=$offset&latitude=$initiallat&longitude=$initiallong&subAdminId=$shopid&userId=$UserId&meatCategoryId=$meatCategoryId&value=$searchvalue");
  
        var result = jsonDecode(response.body);

        totalCount = result['data']['totalCount'];
        fetchCount = result['data']['fetchCount'];

        fetchedDatas.addAll(result['data']['categoryList']);
        notifyListeners();

        if (fetchedDatas.isNotEmpty) {
          isLoading = false;
          notifyListeners();
        }

        print(response.request);
        print('Total Length ... is ..');
        
        logg.i(result['data']['categoryList'].length);
      
        for (int i = 0; i < fetchedDatas.length; i++) {
          print(
              '${fetchedDatas[i]['_id']}  === = =>> $totalCount  $fetchCount');
        }
        logg.i("${API.shopviewproducts}?limit=$limit&offset=$offset&latitude=$initiallat&longitude=$initiallong&subAdminId=$shopid&userId=$UserId&meatCategoryId=$meatCategoryId&value=$searchvalue");
  
      } else {
        if (fetchedDatas.isEmpty) {
          isLoading = false;
          notifyListeners();
        }

        logg.i('${response.statusCode} ====<<status code issue>>');
          logg.i("${API.shopviewproducts}?limit=$limit&offset=$offset&latitude=$initiallat&longitude=$initiallong&userId=$UserId&value");
       
      }
    } catch (e) {
      print('Its an Exception Error $e');
    } finally {
      moreDataLoading = false;
      notifyListeners();
    }
  }


}