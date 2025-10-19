// ignore_for_file: avoid_print, file_names

import 'dart:convert';
import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Redirectcontroller.dart';
import 'package:testing/Meat/MeatButtonFunctionalities/MeatAddproductController.dart/AddmeatController.dart';
import 'package:testing/map_provider/Map%20Screens/MapSearch.dart/apiKey.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'Foodcategorycontroller/Addfoodcontroller.dart';

class FoodCartProvider extends ChangeNotifier {
  RedirectController redirect =Get.put(RedirectController());
  bool isHaveFood = false; // .obs makes it reactive
  bool get isHaveFoodInCart => isHaveFood;

///for meat
  bool isHaveMeat = false; // .obs makes it reactive
  bool get isHaveMeatInCart => isHaveMeat;


  bool loading = false;
  bool get isLoading => loading;

  Logger log = Logger();

  dynamic foodCartDetails;
  dynamic vendorid;
  dynamic meatCartDetails;

  Foodcartcontroller foodcart = Get.put(Foodcartcontroller());
  MeatAddcontroller meatcart = Get.put(MeatAddcontroller());

  Future<dynamic> getfoodcartProvider({required dynamic km}) async {
    loading = true;
    notifyListeners();

    try {
      var response = await http.get(
          Uri.parse('${API.microservicedev}api/food/foodCart?userId=$UserId&km=$km'),
          headers: API().headers);
print("kmmmmmm::${API.microservicedev}api/food/foodCart?userId=$UserId&km=$km}");
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        foodCartDetails = result['data'];
        vendorid = foodCartDetails["foods"][0]['restaurantDetails']["parentAdminUserId"];
        print("XXXXXX$vendorid");
        print("ASASSA$foodCartDetails");

        if (result['data']['foods'].isNotEmpty ||
            result['data']['foods'] != null) {
          isHaveFood = true;
          notifyListeners();
        }

print( "restaurantId:${result['data']['restaurantDetails']['_id']}");
        searchResById(restaurantId: result['data']['restaurantDetails']['_id']);

        return result['data']['restaurantDetails']['_id'];
      } else {
        var result = jsonDecode(response.body);

        if (result['data'].isEmpty || result['data'] == 'null') {
          foodCartDetails == null;
print("No data in getfoodcartProvider");
          loge.i(result);

          isHaveFood = false;
          notifyListeners();
        }

        log.w('Error In Status Code ${response.statusCode}');

        return null;
      }
    } catch (e) {
      log.w('Its An Catch Error $e');
    } finally {
      loading = false;
      notifyListeners();
    }
  }


  Future<dynamic> getmeatcartProvider({required dynamic km}) async {
    loading = true;
    notifyListeners();

    try {
      var response = await http.get(
          Uri.parse('${API.baseUrl}api/meatCart?userId=$UserId&km=$km'),
          headers: API().headers);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        meatCartDetails = result['data'];

        if (result['data']['meats'].isNotEmpty ||
            result['data']['meats'] != null) {
          isHaveMeat = true;
          notifyListeners();
        }

        searchShopbyId(shopid: result['data']['_id']);

        return result['data']['_id'];
      } else {
        var result = jsonDecode(response.body);

        if (result['data'].isEmpty || result['data'] == 'null') {
          meatCartDetails == null;

          loge.i(result);

          isHaveMeat = false;
          notifyListeners();
        }

        log.w('Error In Status Code ${response.statusCode}');

        return null;
      }
    } catch (e) {
      log.w('Its An Catch Error $e');
    } finally {
      loading = false;
      notifyListeners();
    }
  }


  List<dynamic> searchResModel = [];

  Future<List<dynamic>> searchResById({required String restaurantId}) async {
    loading = true;
    notifyListeners();

    try {
      var url = Uri.parse(
        '${API.microservicedev}api/user/subAdmin/searchFoodListByRes?subAdminType=restaurant&value=&latitude=$initiallat&longitude=$initiallong&userId=$UserId&subAdminId=$restaurantId',
      );

      var response = await http.get(url, headers: API().headers);

      // log.i('Restaurant Search for userId: $UserId');
      if (response.statusCode == 200) {
        print('searchResById:${API.microservicedev}api/user/subAdmin/searchFoodListByRes?subAdminType=restaurant&value=&latitude=$initiallat&longitude=$initiallong&userId=$UserId&subAdminId=$restaurantId');
        var result = jsonDecode(response.body);

        searchResModel = result['data']['AdminUserList'] ?? [];
        notifyListeners();
        print("searchResModel:${searchResModel}");
        dynamic latitude = searchResModel[0]['address']['latitude'];
        dynamic longitude = searchResModel[0]['address']['longitude'];

        var diss = await getDistance(destLat: latitude, destLng: longitude);

        print(diss);

        return searchResModel;
      } else {
        log.w('StatusCode Error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log.w('Error occurred: $e');

      return [];
    } finally {
      loading = false;
      notifyListeners();
    }
  }
  ///----For meat----///
 List<dynamic> searchshopModel = [];

  Future<List<dynamic>> searchShopbyId({required String shopid}) async {
    loading = true;
    notifyListeners();

    try {
      var url = Uri.parse("${API.meatsearchlist}?latitude=$initiallat&longitude=$initiallong&value=&userId=$UserId&subAdminId=$shopid&subAdminType=meat");

      var response = await http.get(url, headers: API().headers);

      // log.i('Restaurant Search for userId: $UserId');
      if (response.statusCode == 200) {
        print('favouriteurl${API.meatsearchlist}?latitude=$initiallat&longitude=$initiallong&value=&userId=$UserId&subAdminId=$shopid&subAdminType=meat');
        var result = jsonDecode(response.body);

        searchshopModel = result['data']['AdminUserList'] ?? [];
        notifyListeners();

        dynamic latitude = searchshopModel[0]['address']['latitude'];
        dynamic longitude = searchshopModel[0]['address']['longitude'];

        var diss = await getDistance(destLat: latitude, destLng: longitude);

        print(diss);

        return searchshopModel;
      } else {
        log.w('StatusCode Error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log.w('Error occurred: $e');

      return [];
    } finally {
      loading = false;
      notifyListeners();
    }
  }
  String totalDis = '';
  String totalDur = '';
  double totalDist = 0;

  String get totalDistance => totalDis;
  String get totalDuration => totalDur;

  Future<dynamic> getDistance(
      {required double destLat, required double destLng}) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?origin=$initiallat,$initiallong&destination=$destLat,$destLng&mode=driving&key=$kGoogleApiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      var totaldist = processDirectionsResponse(data);

      totaldist = double.parse(totalDis.split(' ').first.toString());
      notifyListeners();

      return totaldist;
    } else {
      throw Exception('Failed to load directions');
    }
  }

  processDirectionsResponse(Map<String, dynamic> data) {
    final routes = data['routes'] as List;

    if (routes.isNotEmpty) {
      final route = routes[0];
      final legs = route['legs'] as List;

      // if (legs.isNotEmpty) {
      //   final leg = legs[0];
      //   totalDis = leg['distance']['text'];
      //   totalDur = leg['duration']['text'];
      //   notifyListeners();

      //   double totalDistance =
      //       double.parse(totalDis.split(' ').first.toString());

      //   foodcart.getbillfoodcartfood(km: totalDistance);
      //   meatcart.getbillmeatcartmeat(km: totalDistance);

      //   resGlobalKM = totalDistance;
      //   notifyListeners();

      //   return totalDis;
      // }
      if (legs.isNotEmpty) {
  final leg = legs[0];
  totalDis = leg['distance']['text']; // e.g., "4 m" or "1.5 km"
  totalDur = leg['duration']['text'];
  notifyListeners();

  List<String> parts = totalDis.split(' ');
  String distanceStr = parts.first.replaceAll(',', ''); // Remove commas
  // double distanceValue = double.parse(parts.first);
  double distanceValue = double.tryParse(distanceStr) ?? 0.0;
  String unit = parts.last.toLowerCase();

  double totalDistanceInKm;

  if (unit == 'm') {
    totalDistanceInKm = distanceValue / 1000;

    // Update totalDis to be in km for display purposes
    totalDis = "${totalDistanceInKm.toStringAsFixed(3)} km";
  } else {
    totalDistanceInKm = distanceValue;

    // Standardize the formatting to two decimal places
    totalDis = "${totalDistanceInKm.toStringAsFixed(2)} km";
  }

  print("Converted totalDistance: $totalDistanceInKm ($totalDis)");
// Enforce max COD rule
final data = redirect.redirectLoadingDetails?["data"];
if (data != null && data is List) {
  final codItem = data.firstWhere(
    (item) => item['key'] == 'restaurantDistanceKm',
    orElse: () => null,
  );

  if (codItem != null) {
    final codMax = double.tryParse(codItem['value'].toString()) ?? 0;

    if (totalDistanceInKm > codMax) {
      totalDistanceInKm = 5.0;
      // totalDis = "5.00 km";
      print("COD limit exceeded. Distance set to 5 km.");
    }
  }
}
  foodcart.getbillfoodcartfood(km: totalDistanceInKm);
  meatcart.getbillmeatcartmeat(km: totalDistanceInKm);

  resGlobalKM = totalDistanceInKm;
  notifyListeners();

  return totalDis;
}

    } else {
      debugPrint('check....Api Routs Are Empty');
    }
  }

// only for getting restaurant...................

  dynamic totalDistanceModel;

  Future<dynamic> searchRes({required String restaurantId}) async {
    loading = true;
    notifyListeners();

    try {
      var url = Uri.parse(
        '${API.microservicedev}api/user/subAdmin/searchFoodListByRes?subAdminType=restaurant&value=&latitude=$initiallat&longitude=$initiallong&userId=$UserId&subAdminId=$restaurantId',
      );

      var response = await http.get(url, headers: API().headers);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        totalDistanceModel = result['data']['AdminUserList'] ?? [];
        notifyListeners();

        print('Restaurant tttVVVttt>><< ');

        dynamic latitude = totalDistanceModel[0]['address']['latitude'];
        dynamic longitude = totalDistanceModel[0]['address']['longitude'];

        return getDistance(destLat: latitude, destLng: longitude);
      } else {
        log.w('StatusCode Error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log.w('Error occurred: $e');
      return [];
    } finally {
      loading = false;
      notifyListeners();
    }
  }



  // only for getting meat shop...................

  dynamic totalDistancemeatModel;

  Future<dynamic> searchShop({required String shopId}) async {
    loading = true;
    notifyListeners();

    try {
      var url = Uri.parse("${API.baseUrl}api/subAdmin/searchMeatList?latitude=$initiallat&longitude=$initiallong&value=&userId=$UserId&subAdminId=$shopId&subAdminType=meat");

      var response = await http.get(url, headers: API().headers);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        totalDistancemeatModel = result['data']['AdminUserList'] ?? [];
        notifyListeners();

        print('Shop tttVVVttt>><< ');

        dynamic latitude = totalDistancemeatModel[0]['address']['latitude'];
        dynamic longitude = totalDistancemeatModel[0]['address']['longitude'];

        return getDistance(destLat: latitude, destLng: longitude);
      } else {
        log.w('StatusCode Error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log.w('Error occurred: $e');
      return [];
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
