// ignore_for_file: file_names, avoid_print

import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PArcelOrderHistoryPaginController extends GetxController {
  final PagingController<int, dynamic> getOrderHistoryController =
      PagingController(firstPageKey: 0);
  static const int perPage = 2;

  @override
  void onInit() {
    super.onInit();
    getOrderHistoryController.addPageRequestListener((pageKey) {
      fetchHistoryPage(pageKey);
    });
  }

  Future<void> fetchHistoryPage(int pageKey) async {
    await getOrdersHistory(
      pageKey,
      getOrderHistoryController,
    );
  }

  Future<void> getOrdersHistory(
      int pageKey, PagingController<int, dynamic> pagingController) async {
    try {
      var response = await http.get(
        Uri.parse(
            '${API.baseUrl}api/order/order/orderGetPagination/?subAdminType=services&userId=$UserId&limit=$perPage&offset=$pageKey&orderStatus=delivered,cancelled,rejected'),
        headers: API().headers,
      );

      print('${response.statusCode}');

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        final result = jsonDecode(response.body);
        final newItems = result["data"]["data"];
        final isLastPage = newItems.length < perPage;

        final existingItems = pagingController.itemList ?? [];
        final existingItemIds =
            existingItems.map((item) => item["_id"]).toSet();
        // Filter out new items that are already in the existing list
        final filteredNewItems = newItems
            .where((item) => !existingItemIds.contains(item["_id"]))
            .toList();

        if (isLastPage) {
          pagingController.appendLastPage(filteredNewItems);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(filteredNewItems, nextPageKey);
        }
      } else {}
    } catch (e) {
      //pagingController.error = e.toString();
    }
  }

  @override
  void onClose() {
    getOrderHistoryController.dispose();
    super.onClose();
  }
}

class ParcelOrdersHistoryProvider with ChangeNotifier {
  bool isLoading = false;
  bool get loading => isLoading;

  bool isNextPageLoad = false;

  List<dynamic> getOrderHistoryData = [];
  List<dynamic> getAllDataHistorys = [];

  int totalCount = 0;

  Future<void> getParcelOrdersPAgination({pageKey = 0}) async {
    try {
      isNextPageLoad = true;
      notifyListeners();

      if (pageKey == 0) {
        isLoading = true;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }

      var response = await http.get(
          Uri.parse(
              '${API.baseUrl}api/order/order/orderGetPagination/?subAdminType=services&userId=$UserId&limit=5&offset=$pageKey&orderStatus=delivered,cancelled,rejected'),
          headers: API().headers);

      var result = jsonDecode(response.body);
print( '${API.baseUrl}api/order/order/orderGetPagination/?subAdminType=services&userId=$UserId&limit=5&offset=$pageKey&orderStatus=delivered,cancelled,rejected');
      if (response.statusCode == 200) {
        getOrderHistoryData = result['data']['data'];
        totalCount = result['data']['totalCount'];
        getAllDataHistorys.addAll(getOrderHistoryData);
        notifyListeners();
        loge.i(result);
      } else {
        loge.e(result);
      }
    } catch (e) {
      print('Its An Catch error From OrderHistory $e');
    } finally {
      isLoading = false;
      isNextPageLoad = false;
      notifyListeners();
    }
  }

  Future<void> clearallData() async {
    getOrderHistoryData.clear();
    getAllDataHistorys.clear();
    notifyListeners();
  }
}
