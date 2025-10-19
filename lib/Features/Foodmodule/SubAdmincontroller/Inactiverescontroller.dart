// ignore_for_file: file_names, avoid_print

import 'dart:convert';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/Getnearbyrescontroller.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
 
 
 class Inactiverescontroller  extends GetxController{
 dynamic inactiveresModel;
  Nearbyrescontroller nearbyreget = Get.put(Nearbyrescontroller());
  var  inactiveresloading = false.obs;

  void inactiveresget() async {
    try {
      inactiveresloading(true);
       var response = await http.post(
        Uri.parse( API.nearestresapi,),
        headers: API().headers,
        body: jsonEncode(
          <String, dynamic>{"lat":initiallat,"lng":initiallong,"page":0,"perPage":50,"activeStatus": "offline","productTypeToFilter":nearbyreget.selectedIndex.value ==
                                                                              0
                                                                          ? "restaurant"
                                                                          : "shop"},
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
        var result = jsonDecode(response.body);
        inactiveresModel = result;
      print("THE RES ${{"lat":initiallat,"lng":initiallong,"page":0,"perPage":50,"activeStatus": "offline"}}");
      } else {
        inactiveresModel == null;
      }
    } catch (e) {
      print("error");
    } finally {
      inactiveresloading(false);
    }
  }

 
 }
 
 
 
 
 
 
 
 
 
 
 
 