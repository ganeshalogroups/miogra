// ignore_for_file: avoid_print, file_names

import 'dart:convert';
import 'package:testing/Features/Authscreen/AuthController/Tokenupdate.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/Getnearbyrescontroller.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Foodsearchcontroller extends GetxController {
  TokenController tokenupdate = Get.put(TokenController());
  Nearbyrescontroller nearbyreget = Get.put(Nearbyrescontroller());
  dynamic createsearch;
  var createsearchloading = false.obs;
  void createrecentsearch({String? hashtagName, String? hashtagType,
      hashtagImage, productCateid,searchType,restaurantid}) async {
    try {
      createsearchloading(true);
      var response = await http.post(Uri.parse(API.createrecentsearchfastx),
          headers: API().headers,
          body: jsonEncode(<String, dynamic>{
            "hashtagName": hashtagName,
            "hashtagType": "recentsearch",
            "searchType": searchType,
            "hashtagImage": "",
            "navigateId":restaurantid,
            "productCateId": productCateId,
            "parentAdminId": UserId
          }));

      print('${response.statusCode}');

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        var result = jsonDecode(response.body);
        createsearch = result;

        loge.i('$result');

        print("$result");
        print("UserIddddddddd$UserId");
        print('createrecentsearch fetched Sucessfully');
      } else {
        createsearch == null;

        print(response.body.toString());
      }
    } catch (e) {
      print("error");
    } finally {
      createsearchloading(false);
    }
  }

  dynamic foodsearchlist;
  var foodsearchlistloading = false.obs;
  void foodsearchlistbyres(String? valuee, restaurantid) async {
    try {
      foodsearchlistloading(true);
      var response = await http.get(
        Uri.parse(
            "${API.searchFoodlistbyResgetfastx}?latitude=$initiallat&longitude=$initiallong&value=$valuee&limit=50&offset=0&subAdminType=restaurant&userId=$UserId&subAdminId=$restaurantid"),
        headers: API().headers,
      );
     print('${response.statusCode}');
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        var result = jsonDecode(response.body);
        foodsearchlist = result;

      //  print(response.body);

        print('From The list ===>');
        // loge.i(result);

        print("UserIddddddddd$UserId");
        print(
            "searchapi${API.searchFoodlistbyResgetfastx}?latitude=$initiallat&longitude=$initiallong&value=$valuee&limit=50&offset=0&subAdminType=restaurant&userId=$UserId&subAdminId=$restaurantid");
              print("+++++++++++++++++++++++++++++++++++++++++ check");
      print(
          "${API.searchFoodlistbyResgetfastx}?latitude=$initiallat&longitude=$initiallong&value=$valuee&limit=50&offset=0&subAdminType=restaurant&userId=$UserId&subAdminId=$restaurantid");
     
        print('foodsearchlistbyres fetched Sucessfully');
      } else {
        foodsearchlist == null;

        print(response.body.toString());
      }
    } catch (e) {
      print(e.toString());
    } finally {
      foodsearchlistloading(false);
    }
  }


   dynamic fetchsearchlist;
  var fetchsearchlistloading = false.obs;
  void fetchsearchlistbyres(String? valuee,) async {
    try {
      fetchsearchlistloading(true);
      var response = await http.post(
        Uri.parse(API.searchList),
        headers: API().headers,
        body: jsonEncode(
          <String, dynamic>{"lat":initiallat,"lng":initiallong,"page":0,"perPage":30,"value": valuee,"productTypeToFilter": nearbyreget.selectedIndex.value==0?"restaurant":"shop"},
        ),
      );
     print('${response.body}');
     print({"lat":initiallat,"lng":initiallong,"page":0,"perPage":30,"value": valuee});
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        var result = jsonDecode(response.body);
        fetchsearchlist = result;

      //  print(response.body);
        print('From The list ===>');
        // loge.i(result);

        print("UserIddddddddd$UserId");
        print(
            "searchlistapi${API.searchList}");
              print("+++++++++++++++++++++++++++++++++++++++++ check");
        print('Search List fetched Sucessfully');
      } else {
        fetchsearchlist = null;

        print(response.body.toString());
      }
    } catch (e) {
       fetchsearchlist = null;
      print(e.toString());
    } finally {
     fetchsearchlistloading(false);
    }
  }

    dynamic dishessearchlist;
  var dishessearchlistloading = false.obs;
  void dishessearchlistbyres(String? valuee,dynamic isResSearch) async {
    try {
      dishessearchlistloading(true);
      var response = await http.post(
        Uri.parse(API.dishessearch),
        headers: API().headers,
        body: jsonEncode(
          <String, dynamic>{"lat":initiallat,"lng":initiallong,"page":0,"perPage":50,"value": valuee, "isResSearch": isResSearch,"productTypeToFilter": nearbyreget.selectedIndex.value==0?"restaurant":"shop"},
        ),
      );
     print('dishhhhhsearchhhhh');
     print({"lat":initiallat,"lng":initiallong,"page":0,"perPage":50,"value": valuee, "isResSearch": isResSearch});
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        var result = jsonDecode(response.body);
        dishessearchlist = result;

      //  print(response.body);
        print('From The list ===>');
        // loge.i(result);

        print("UserIddddddddd$UserId");
        print(
            "dishessearchlist${API.dishessearch}");
              print("+++++++++++++++++++++++++++++++++++++++++ check");
        print('dishessearchlist fetched Sucessfully');
      } else {
      
    print("checkkk");
        dishessearchlist = null;

        print(response.body.toString());
      }
    } catch (e) {
    print("checkkk");
      print(e.toString());
    } finally {
     dishessearchlistloading(false);
    }
  }
}
