// ignore_for_file: file_names

import 'dart:convert';
import 'package:testing/Features/Authscreen/AuthController/Tokenupdate.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
 
 class Restaurantcontroller extends GetxController {

  TokenController tokenupdate=Get.put(TokenController());
  final PagingController<int, dynamic> resPagingController = PagingController(firstPageKey: 0);
  static const int perPage = 5;


  @override
  void onInit() {
    super.onInit();
    resPagingController.addPageRequestListener((pageKey) {
      fetchResPage(pageKey);
    });
  }


  @override
  void onReady() {
    super.onReady();
    // Reset the paging controller when the screen is ready to avoid duplicates
    resPagingController.refresh();
  }

  Future<void> fetchResPage(int pageKey) async {
    try {
      await foodgetres(pageKey, API.searchFoodlistbyResgetfastx, resPagingController);
    } catch (e) {
      resPagingController.error = 'Error: $e';
    }
  }


  

Future<void> foodgetres(int pageKey, String apiUrl, PagingController<int, dynamic> pagingController) async {


  try {
    var response = await http.get(
      Uri.parse("$apiUrl?limit=$perPage&offset=$pageKey&latitude=$initiallat&longitude=$initiallong&subAdminType=restaurant&userId=$UserId&isRecommended=true&value"),
      headers: API().headers,
    );


    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {

print("urlllll$apiUrl?limit=$perPage&offset=$pageKey&latitude=$initiallat&longitude=$initiallong&subAdminType=restaurant&userId=$UserId&isRecommended=true&value");
      final result     = jsonDecode(response.body);
      final newItems   = result["data"]["AdminUserList"];
      final isLastPage = newItems.length < perPage;


      // Get IDs of existing items
      final existingItems = pagingController.itemList ?? [];
      final existingItemIds = existingItems.map((item) => item["_id"]).toSet();

      // Filter out new items that are already in the existing list
      final filteredNewItems = newItems.where((item) => !existingItemIds.contains(item["_id"])).toList();

      if (isLastPage) {
        pagingController.appendLastPage(filteredNewItems);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(filteredNewItems, nextPageKey);
      }
    } else {
      pagingController.error = 'Unexpected error: ${response.statusCode}';



      //  if (mobilenumb != null) {

      //   tokenupdate.tokenupdateapi(mobileNo: mobilenumb);

      // } else if (useremail != null) {

      //  tokenupdate.tokenupdateemailapi(email: useremail);

      // }
    }
  } catch (e) {
    pagingController.error = 'Error: $e';
  }
}



  @override
  void onClose() {
    resPagingController.dispose();
    super.onClose();
  }


}

 


