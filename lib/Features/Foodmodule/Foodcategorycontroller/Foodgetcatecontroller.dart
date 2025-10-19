// ignore_for_file: avoid_print, file_names

import 'dart:convert';
import 'package:testing/Features/Authscreen/AuthController/Tokenupdate.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class FoodCategorycontroller extends GetxController {
TokenController tokenupdate=Get.put(TokenController());


  final PagingController<int, dynamic> imagePagingController =  PagingController(firstPageKey: 0);
  
     
  static const int perPage = 4;
  @override
  void onInit() {
    super.onInit();
    imagePagingController.addPageRequestListener((pageKey) {
      fetchImagePage(pageKey);
    });
  }

  Future<void> fetchImagePage(int pageKey) async {
    await foodcategoryget(
      pageKey,
      API.foodcategetfastx,
      imagePagingController,
    );
  }
Future<void> foodcategoryget(int pageKey, String apiUrl, PagingController<int, dynamic> pagingController) async {
  // print("Food category request: $UserId, Token: $Usertoken");
  try {
    var response = await http.get(
      Uri.parse("$apiUrl?hashtagType=category&productCateId=$productCateId&default=true&offset=$pageKey&limit=$perPage"),
      headers: API().headers,
    );

    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
      final result = jsonDecode(response.body);
      final newItems = result["data"]["searchList"] ?? [];

      if (newItems.isEmpty) {
        // If no items are returned, append an empty page to indicate no more data.
        pagingController.appendLastPage([]);
      } else {
        final isLastPage = newItems.length < perPage;
        final filteredNewItems = _filterExistingItems(pagingController.itemList ?? [], newItems);

        if (isLastPage) {
          pagingController.appendLastPage(filteredNewItems);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(filteredNewItems, nextPageKey);
        }
      }
    } else {
      
      pagingController.appendLastPage([]);
      // Handle the error
      pagingController.error = 'Error loading data';
    }
  } catch (e) {
    // Handle exceptions
    pagingController.error = e.toString();
  }
}

// Helper function to filter already existing items
List<dynamic> _filterExistingItems(List<dynamic> existingItems, List<dynamic> newItems) {
  final existingItemIds = existingItems.map((item) => item["_id"]).toSet();
  return newItems.where((item) => !existingItemIds.contains(item["_id"])).toList();
}



  @override
  void onClose() {
    imagePagingController.dispose();
    super.onClose();
  }
}
