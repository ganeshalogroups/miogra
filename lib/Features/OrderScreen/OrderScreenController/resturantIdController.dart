// ignore_for_file: file_names

import 'dart:convert';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;




class SearchResturant extends ChangeNotifier {

  bool loading = false;
  bool get isLoading => loading;

  Logger log = Logger();
  List<dynamic> searchResModel = [];

  Future<List<dynamic>> searchResById({ required String restaurantId,required double latitude, required double longitude }) async {
   
    
    loading = true;
    notifyListeners();

    try {
      var url = Uri.parse(
        '${API.searchFoodlistbyResgetfastx}?subAdminType=restaurant&value=&latitude=$latitude&longitude=$longitude&userId=$UserId&subAdminId=$restaurantId',
      );

      var response = await http.get(url, headers: API().headers);

      log.i('reataurantt Search for userId: $UserId');
      if (response.statusCode == 200) {
      log.i('${API.searchFoodlistbyResgetfastx}?subAdminType=restaurant&value=&latitude=$latitude&longitude=$longitude&userId=$UserId&subAdminId=$restaurantId',
      );
      log.i('reataurantt Search for userId: $UserId');
        var result = jsonDecode(response.body);

        searchResModel = result['data']['AdminUserList'] ?? [];
        notifyListeners();

        log.i(searchResModel);
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
}
