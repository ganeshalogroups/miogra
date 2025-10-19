// ignore_for_file: file_names, avoid_print

import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class GetOrdersProvider with ChangeNotifier {
  bool loading = false;
  bool get isLoading => loading;

  dynamic orderModel;
  Future<void> getOders() async {
    loading = true;
    notifyListeners();

    try {
      var response = await http.get(
          Uri.parse(
              '${API.microservicedev}api/order/order/orderGetPagination/?subAdminType=restaurant&shareUserId=$UserId&orderStatus=new,orderAssigned,orderPickedUped,deliverymanReachedDoor,initiated&limit=75'),
          headers: API().headers); // Updated offset logic

      if (response.statusCode == 200) {
        print(
            'urll:${API.microservicedev}api/order/order/orderGetPagination/?subAdminType=restaurant&shareUserId=$UserId&orderStatus=new,orderAssigned,orderPickedUped,deliverymanReachedDoor,initiated&limit=75');

        var result = jsonDecode(response.body);
        orderModel = result['data']['data'];
      } else {
        print('Responce Error In OrderPage  ${response.statusCode}');
      }
    } catch (e) {
      print('Exception Error ..$e');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
///////////////////////////// Parcel Get Orders///////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

  dynamic parcelOrderModel;
  Future<void> parcelGetOders() async {
    loading = true;
    notifyListeners();

    try {
      var response = await http.get(
          Uri.parse(
              '${API.baseUrl}api/order/order/orderGetPagination/?subAdminType=services&shareUserId=$UserId&orderStatus=new,orderAssigned,orderPickedUped,deliverymanReachedDoor,initiated&limit=75'),
          headers: API().headers); // Updated offset logic

      if (response.statusCode == 200) {
        print(
            "DDDDDDDDDD ${API.baseUrl}api/order/order/orderGetPagination/?subAdminType=services&shareUserId=$UserId&orderStatus=new,orderAssigned,orderPickedUped,deliverymanReachedDoor,initiated&limit=75}");
        print("SSSSSS ${API().headers}");
        var result = jsonDecode(response.body);
        parcelOrderModel = result['data']['data'];
        print("HHHHHHHHHH $parcelOrderModel");
      } else {
        print('Responce Error In OrderPage  ${response.statusCode}');
      }
    } catch (e) {
      print('Exception Error ..$e');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

//For meat

  Future<void> meatgetOders() async {
    loading = true;
    notifyListeners();

    try {
      var response = await http.get(
          Uri.parse(
              '${API.baseUrl}api/order/orderGetPagination/?subAdminType=meat&shareUserId=$UserId&orderStatus=new,orderAssigned,orderPickedUped,deliverymanReachedDoor,initiated&limit=75'),
          headers: API().headers); // Updated offset logic

      if (response.statusCode == 200) {
        print(
            'orderrrgettt${API.baseUrl}api/order/orderGetPagination/?subAdminType=meat&shareUserId=$UserId&orderStatus=new,orderAssigned,orderPickedUped,deliverymanReachedDoor,initiated&limit=75');
        var result = jsonDecode(response.body);
        orderModel = result['data']['data'];
      } else {
        print('Response Error In Meat OrderPage  ${response.statusCode}');
      }
    } catch (e) {
      print('Exception Error ..$e');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

//Ordergetbyid

  bool ordergetbyidloading = false;
  bool get isordergetbyidloading => ordergetbyidloading;

  dynamic ordergetbyorderModel;
  Future<void> getOdersbyid({dynamic orderid}) async {
    ordergetbyidloading = true;
    notifyListeners();

    try {
      var response = await http.get(Uri.parse('${API.ordercreate}/$orderid'),
          headers: API().headers); // Updated offset logic

      if (response.statusCode == 200) {
        print('order get by id:${API.ordercreate}/$orderid');
        print("body:::${response.body}");
        // loge.i(ordergetbyorderModel);
        var result = jsonDecode(response.body);
        ordergetbyorderModel = result['data'];
        // loge.i(ordergetbyorderModel);
      } else {
        print('Responce Error In Ordergetby id  ${response.statusCode}');
      }
    } catch (e) {
      print('Exception Error ..$e');
    } finally {
      ordergetbyidloading = false;
      notifyListeners();
    }
  }
}

class GetOrdersPagination extends GetxController {
  final PagingController<int, dynamic> getOrdersPageController =
      PagingController(firstPageKey: 0);
  static const int perPage = 2;

  @override
  void onInit() {
    super.onInit();
    getOrdersPageController.addPageRequestListener((pageKey) {
      fetchHistoryPage(pageKey);
    });
  }

  Future<void> fetchHistoryPage(int pageKey) async {
    await getOrdersHistory(
      pageKey,
      getOrdersPageController,
    );
  }

  Future<void> getOrdersHistory(
      int pageKey, PagingController<int, dynamic> pagingController) async {
    try {
      var response = await http.get(
        Uri.parse(
            '${API.microservicedev}api/order/order/orderGetPagination/?shareUserId=$UserId&limit=$perPage&offset=$pageKey&orderStatus=new,orderAssigned,orderPickedUped,deliverymanReachedDoor,initiated'),
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
    getOrdersPageController.dispose();
    super.onClose();
  }
}
