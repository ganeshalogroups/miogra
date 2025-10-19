// ignore_for_file: avoid_print, file_names

import 'dart:convert';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class FavresGetcontroller extends GetxController {
  late PagingController<int, dynamic> favresPagingController;
  static const int limit = 5;

  @override
  void onInit() {
    super.onInit();
    favresPagingController = PagingController(firstPageKey: 0);
    favresPagingController.addPageRequestListener((pageKey) {
      fetchResPage(pageKey);
    });
  }

  @override
  void onReady() {
    super.onReady();
    favresPagingController.refresh();
  }

  Future<void> fetchResPage(int pageKey) async {
    try {
      await favouritegetres(
          pageKey, API.restaurantfavget, favresPagingController);
    } catch (e) {
      favresPagingController.error = 'Error: $e';
    }
  }

  Future<void> favouritegetres(int pageKey, String apiUrl,
      PagingController<int, dynamic> favpagingController) async {
    try {
      // Fetch data from the API
      var response = await http.get(
        Uri.parse(
            "$apiUrl?limit=$limit&offset=$pageKey&latitude=$initiallat&longitude=$initiallong&favouriteType=normal&userId=$UserId&productCategoryId=$productCateId"),
        headers: API().headers,
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        final result = jsonDecode(response.body);
        print("favvresgettt$apiUrl?limit=$limit&offset=$pageKey&latitude=$initiallat&longitude=$initiallong&favouriteType=normal&userId=$UserId&productCategoryId=$productCateId");
        var newItems = result["data"]["data"];

        // Filter only items with availableStatus = true
        newItems = newItems.where((item) => item["availableStatus"] == true).toList();

        final isLastPage = newItems.length < limit;

        // Get existing items and their IDs
        final existingItems = favpagingController.itemList ?? [];
        final existingItemIds =
            existingItems.map((item) => item["_id"]).toSet();

        // Filter out new items that are already in the existing list
        final filteredNewItems = newItems
            .where((item) => !existingItemIds.contains(item["_id"]))
            .toList();

        // Handle pagination based on whether it's the last page
        if (isLastPage) {
          favpagingController.appendLastPage(filteredNewItems);
        } else {
          final nextPageKey = pageKey + 1;
          favpagingController.appendPage(filteredNewItems, nextPageKey);
        }
      } else {
        favpagingController.error = 'Unexpected error: ${response.statusCode}';
      }
    } catch (e) {
      favpagingController.error = 'Error: $e';
    }
  }

// Future<void> favouritegetres(int pageKey, String apiUrl, PagingController<int, dynamic> favpagingController) async {

//   try {
//       print('==================>>');
//       print(initiallat);
//       print(initiallong);

//     // Fetch data from the API
//     var response = await http.get(
//       Uri.parse("$apiUrl?limit=$limit&offset=$pageKey&latitude=$initiallat&longitude=$initiallong&favouriteType=normal&userId=$UserId"),
//       headers: API().headers,
//     );

//     if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
//       final result = jsonDecode(response.body);
//       final newItems = result["data"]["data"];
//       final isLastPage = newItems.length < limit;

//       // Get existing items and their IDs
//       final existingItems = favpagingController.itemList ?? [];
//       final existingItemIds = existingItems.map((item) => item["_id"]).toSet();

//       // Filter out new items that are already in the existing list
//       final filteredNewItems = newItems.where((item) => !existingItemIds.contains(item["_id"])).toList();

//       // Handle pagination based on whether it's the last page
//       if (isLastPage) {
//         favpagingController.appendLastPage(filteredNewItems);
//       } else {
//         final nextPageKey = pageKey + 1;
//         favpagingController.appendPage(filteredNewItems, nextPageKey);
//       }
//     } else {
//       favpagingController.error = 'Unexpected error: ${response.statusCode}';
//     }
//   } catch (e) {
//     favpagingController.error = 'Error: $e';
//   }
// }

  @override
  void onClose() {
    favresPagingController.dispose();
    super.onClose();
  }

  Future getFavouritesWithoutPagination() async {
    try {
      var response = await http.get(
          Uri.parse(
              '${API.restaurantfavget}?favouriteType=normal&userId=$UserId'),
          headers: API().headers);

      print('comon Identifier...');

      if (response.statusCode == 200) {
        print(response.body);

        print(' ---- its fav get ');

        var result = jsonDecode(response.body);

        print(result['data']['data']);

        return result['data']['data'];
      } else {
        print(response.body);
        print('------ else part in fav get ...');

        var result = jsonDecode(response.body);

        return result['data'];
      }
    } catch (e) {
      print('Its An Catch error $e');
    }
  }
}
