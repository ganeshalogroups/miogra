// ignore_for_file: avoid_print

import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class OrdergetallPaginController extends GetxController {
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
            '${API.microservicedev}api/order/order/orderGetPagination/?userId=$UserId&limit=$perPage&offset=$pageKey&orderStatus=delivered,cancelled,rejected,new,orderAssigned,orderPickedUped,deliverymanReachedDoor,initiated'),
        headers: API().headers,
      );
print("QPQPQPQ    ${API.microservicedev}api/order/order/orderGetPagination/?userId=$UserId&limit=$perPage&offset=$pageKey&orderStatus=delivered,cancelled,rejected,new,orderAssigned,orderPickedUped,deliverymanReachedDoor,initiate");
      print('${response.statusCode}');

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        final result = jsonDecode(response.body);
        final newItems = result["data"]["data"];
        print("RESULT $newItems");
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
