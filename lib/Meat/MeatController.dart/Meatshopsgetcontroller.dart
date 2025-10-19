// ignore_for_file: unnecessary_overrides, file_names

import 'dart:convert';

import 'package:testing/Features/Authscreen/AuthController/Tokenupdate.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MeatShopsGetlist extends GetxController {


TokenController tokenupdate=Get.put(TokenController());

late PagingController<int, dynamic> meatshopPagingController;
  static const int limit = 5;

  @override
  void onInit() {
    super.onInit();
    meatshopPagingController = PagingController(firstPageKey: 0);
    meatshopPagingController.addPageRequestListener((pageKey) {
      fetchResPage(pageKey);
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> fetchResPage(int pageKey) async {
    try {
      await foodgetres(pageKey, API.meatsearchlist, meatshopPagingController);
    } catch (e) {
      meatshopPagingController.error = 'Error: $e';
    }
  }

  Future<void> foodgetres(int pageKey, String apiUrl, PagingController<int, dynamic> pagingController) async {
    try {
      var response = await http.get(
        Uri.parse("$apiUrl?limit=$limit&offset=$pageKey&latitude=$initiallat&longitude=$initiallong&subAdminType=meat&default=true&userId=$UserId&value="),
        headers: API().headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
        final result = jsonDecode(response.body);
        final newItems = result["data"]["AdminUserList"];
        final isLastPage = newItems.length < limit;

        final existingItems = pagingController.itemList ?? [];
        final existingItemIds = existingItems.map((item) => item["_id"]).toSet();

        final filteredNewItems = newItems.where((item) => !existingItemIds.contains(item["_id"])).toList();

        if (isLastPage) {
          pagingController.appendLastPage(filteredNewItems);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(filteredNewItems, nextPageKey);
        }
      } else {
        pagingController.error = 'Unexpected error: ${response.statusCode}';
      }
    } catch (e) {
      pagingController.error = 'Error: $e';
    }
  }

  @override
  void onClose() {
    meatshopPagingController.dispose();
    super.onClose();
  }

}
