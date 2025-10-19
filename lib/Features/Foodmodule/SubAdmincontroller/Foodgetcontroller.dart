// ignore_for_file: avoid_print, file_names

import 'dart:convert';

import 'package:testing/Features/Foodmodule/Domain/Foodnonvegmodel.dart';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Addfoodcontroller.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class FoodProductviewPaginations with ChangeNotifier {
  final Foodcartcontroller foodcart = Get.find(); // Safely inject
//  Foodcartcontroller foodcart = Get.put(Foodcartcontroller());
//   ValueNotifier<int> itemCountNotifier = ValueNotifier<int>(0);

  Logger logg = Logger();
  bool isLoading = false;

  bool moreDataLoading = false;

  int limit = 15;
  List fetchedDatas = [];

  dynamic totalCount;
  dynamic fetchCount;
  ValueNotifier<int> itemCountNotifier = ValueNotifier<int>(0);
  Future<void> clearData() async {
    fetchedDatas.clear();
    totalCount = 0;
    fetchCount = 0;
    isLoading = false;
    notifyListeners();
  }

// List<CategoryList> fetchedDatas = [];
  String? errorMessage;
  dynamic restaurantDetails;
  dynamic foodDetails ={};
  dynamic  foodcom =[] ;



  Future<void> fetchFoodData({
    String? foodtype,
    String? searchvalue,
    String? restaurantid,
    int offset = 0,
  }) async {
    try {
      moreDataLoading = true;
      errorMessage = null;
      notifyListeners();

      if (offset == 0) {
        isLoading = true;
        notifyListeners();
      }
      //NEW CODE
      final url = UserId != null
          ? "${API.getFoodlistbyResgetfastx}?foodType=$foodtype"
              "&limit=50&offset=$offset"
              "&value=$searchvalue"
              "&restaurantId=$restaurantid"
              "&latitude=$initiallat&longitude=$initiallong"
              "&userId=$UserId"
          : "${API.getFoodlistbyResgetfastx}?foodType=$foodtype"
              "&limit=50&offset=$offset"
              "&value=$searchvalue"
              "&restaurantId=$restaurantid"
              "&latitude=$initiallat&longitude=$initiallong";
      //OLD CODE
      // final url = "${API.getFoodlistbyResgetfastx}?foodType=$foodtype"
      //     "&limit=50&offset=$offset"
      //     "&value=$searchvalue"
      //     "&restaurantId=$restaurantid"
      //     "&latitude=$initiallat&longitude=$initiallong&userId=$UserId";

      logg.i("Food match:${url}");

      final response = await http.get(
        Uri.parse(url),
        headers: API().headers,
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        // Parse full response into Foodlist model
        var data = Foodlist.fromJson(result);

        // Assign restaurant details
        restaurantDetails = result['data']['restaurantDetails'];


        final categories = result["data"]["categoryList"] as List;



        
  for (var category in categories) {
    final foods = category["foods"] as List;

    for (var food in foods) {
      // Some food items may not have commission
      final commission = food["commission"] ?? 0;
      final productTypeToFilter = food["productTypeToFilter"] ?? "";

      foodDetails = {
        "commission": commission??0,
        "productTypeToFilter": productTypeToFilter??0,
      };
     
       
      


    }
  }
      //foodDetails =  result['data']["categoryList"]["foods"]["commission"];

        totalCount = data.data?.totalCount;
        fetchCount = data.data?.fetchCount;

       List<CategoryList> newItems = data.data?.categoryList ?? [];

        // Deduplication based on CategoryList.id
        var existingIds = fetchedDatas.map((item) => item.id).toSet();
        var uniqueItems =
            newItems.where((item) => !existingIds.contains(item.id)).toList();

        fetchedDatas.addAll(uniqueItems);

        /// ✅ Update item count from cart
        var itemCount = await foodcart.getfoodcartfood(km: "5");
        // itemCountNotifier.value = itemCount;
        // FIX: Check if it's a List before assigning length
        if (itemCount is List) {
          itemCountNotifier.value = itemCount.length;
        } else if (itemCount is int) {
          itemCountNotifier.value = itemCount;
        } else {
          itemCountNotifier.value = 0; // fallback for unexpected type
        }
        isLoading = false;
        notifyListeners();

        logg.i(
            "Fetched ${uniqueItems.length} new items. Total: ${fetchedDatas.length}");
      } else {
        errorMessage = "Failed to fetch data. Status: ${response.statusCode}";
        logg.i("Food fetch failde:${url}");
        logg.w(errorMessage);
        if (fetchedDatas.isEmpty) {
          isLoading = false;
          notifyListeners();
        }
      }
    } catch (e) {
      errorMessage = "Exception: $e";
      logg.e(errorMessage);
    } finally {
      moreDataLoading = false;
      notifyListeners();
    }
  }
}
