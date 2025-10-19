// ignore_for_file: file_names

import 'dart:convert';
import 'package:testing/map_provider/locationprovider.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class GetAddressProvider extends ChangeNotifier {
  LocationProvider locationProvider = LocationProvider();

  bool loading = false;
  bool get isLoading => loading;

  dynamic addressModel;
  List<dynamic> addRess=[];


Future<void> getAddresProvider() async {
  loading = true;
  notifyListeners();

  try {

    var response = await http.get(
      Uri.parse("${API.getaddressfastx}?userId=$UserId"),
      headers: API().headers,
    );

    if (response.statusCode == 200) {

      var result = jsonDecode(response.body);
      // Ensure 'AdminUserList' is treated as a List<dynamic> and cast to List<Map<String, dynamic>>

      // List<dynamic> rawAddresses = result['data']['AdminUserList'];

        addRess = result['data']['AdminUserList'];

      // Convert rawAddresses to List<Map<String, dynamic>>
      // List<Map<String, dynamic>> addresses = rawAddresses.map((address) => address as Map<String, dynamic>).toList();

      //     print('=========vv===========');
      //     loge.i(addresses);


      // double shortestDistance = double.infinity; // Initialize with a very large number
      // Map<String, dynamic>? nearestAddress;


      // locationProvider.getCurrentLocation().then((value) async {


      //   for (int i = 0; i < addresses.length; i++) {

      //     double lati  = addresses[i]['latitude'];
      //     double longi = addresses[i]['longitude'];


      //     double distance = Geolocator.distanceBetween(
      //       locationProvider.position.latitude,
      //       locationProvider.position.longitude,
      //       lati,
      //       longi,
      //     );


      //     loge.i('current : ${locationProvider.position.latitude}, ${locationProvider.position.longitude}    = Saved ${addresses[i]['latitude']},${addresses[i]['longitude']}');
      //     loge.i('Distance to ${addresses[i]['addressType']}: $distance meters');

      //     // Check if this distance is the shortest
      //     if (distance < shortestDistance) {
      //       shortestDistance = distance;
      //       nearestAddress = addresses[i];
      //     }


      //   }



      //       if (nearestAddress != null && shortestDistance < 50 ) {

      //         loge.i('${locationProvider.position.latitude}, ${locationProvider.position.longitude}');
                
      //         loge.i('Nearest Address is: ${nearestAddress!['addressType']}, ' 'Location: ${nearestAddress!['latitude']}, ${nearestAddress!['longitude']}, ''Distance: $shortestDistance meters, ''Full Address: ${nearestAddress!['fullAddress']}    ');
                                
      //       }



      //   }
      // );

      // addressModel = addresses; // Update the model

    } else {


addRess =[];

      loge.w('Status Code Error ${response.statusCode}  ${response.body}');
    }

  } catch (e) {
    loge.w('Exception Error $e');
  } finally {
    loading = false;
    notifyListeners();
  }
}


  // Future<void> getAddresProvider() async {
  //   loading = true;
  //   notifyListeners();

  //   try {
  //     var response = await http.get(
  //       Uri.parse("${API.getaddressfastx}?userId=$UserId"),
  //       headers: API().headers,
  //     );

  //     if (response.statusCode == 200) {
  //       var result = jsonDecode(response.body);

  //       locationProvider.getCurrentLocation().then((value) async {
  //         for (int i = 0; i < result['data']['AdminUserList'].length; i++) {
  //           double lati = result['data']['AdminUserList'][i]['latitude'];
  //           double longi = result['data']['AdminUserList'][i]['longitude'];

  //           String resultt = await checkDistance(
  //             centerLat: locationProvider.position.latitude,
  //             centerLon: locationProvider.position.longitude,
  //             destLat: lati,
  //             destLon: longi,
  //           );

  //           // double distance = calculateDistance(lat1: locationProvider.position.latitude,lon1: locationProvider.position.longitude,lat2: lati,lon2: longi );

  //           loge.i(
  //               '$resultt   ${locationProvider.position.latitude},${locationProvider.position.longitude}        Address = $lati,$longi  ${result['data']['AdminUserList'][i]['addressType']}');
  //         }
  //       });

  //       addressModel = result['data']['AdminUserList'];
  //     } else {
  //       loge.w('Status Code Error ${response.statusCode}  ${response.body}');
  //     }
  //   } catch (e) {
  //     loge.w('Exception Error $e');
  //   } finally {
  //     loading = false;
  //     notifyListeners();
  //   }
  // }

  Future<String> checkDistance({
    required double centerLat,
    required double centerLon,
    required double destLat,
    required double destLon,
  }) async {
    double distance =
        Geolocator.distanceBetween(centerLat, centerLon, destLat, destLon);


    if (distance > 50) {
      return "Outside the Circle";
    } else {
      return "Inside the Circle";
    }
  }
}
