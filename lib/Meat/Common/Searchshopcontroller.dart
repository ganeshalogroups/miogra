
// ignore_for_file: file_names

import 'dart:convert';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
class SearchShop extends ChangeNotifier {
  bool loading = false;
  bool get isLoading => loading;

  Logger log = Logger();
  List<dynamic> searchResshopModel = [];

  Future<List<dynamic>> searchShopbyshopId(
      {required String shopId,
      required double latitude,
      required double longitude}) async {
    loading = true;
    notifyListeners();

    try {
      var url = Uri.parse(
          "${API.baseUrl}api/subAdmin/searchMeatList?latitude=$latitude&longitude=$longitude&value=&userId=$UserId&subAdminId=$shopId&subAdminType=meat");
      var response = await http.get(url, headers: API().headers);

      log.i('Shop Search for userId: $UserId');
      if (response.statusCode == 200) {
       log.i("${API.baseUrl}api/subAdmin/searchMeatList?latitude=$latitude&longitude=$longitude&value=&userId=$UserId&subAdminId=$shopId&subAdminType=meat");
        var result = jsonDecode(response.body);

        searchResshopModel = result['data']['AdminUserList'] ?? [];
        notifyListeners();

        log.i(searchResshopModel);
        return searchResshopModel;
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
