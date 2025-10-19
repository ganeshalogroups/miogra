// ignore_for_file: file_names, avoid_print

import 'dart:convert';
import 'package:testing/utils/Urlist.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
class MartCategoryviewPaginations with ChangeNotifier {

  Logger logg = Logger();
  bool isLoading = false;

  bool moreDataLoading = false;

  int limit = 25;
  List fetchedDatas = [];

  dynamic totalCount;
  dynamic fetchCount;

  Future<void> clearData() async {
    fetchedDatas.clear();
    totalCount = 0;
    fetchCount = 0;
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchviewallcategories({ int offset = 0}) async {
    try {
      // moreDataLoading = true;
      // notifyListeners();
if (moreDataLoading) return; // Prevent multiple API calls at the same time
  moreDataLoading = true;
  notifyListeners();  // 
      if (offset == 0) {
        isLoading = true;
        notifyListeners();
      }

      var response = await http.get(
        Uri.parse("${API.martcategory}?productCategoryType=mart&offset=$offset&limit=$limit"),
        headers: API().headers,
      );

      if (response.statusCode == 200) {
      print("View all cat fetched sucess");
      logg.i("${API.martcategory}?productCategoryType=mart&offset=$offset&limit=$limit");
  
        var result = jsonDecode(response.body);

        totalCount = result['data']['totalCount'];
        fetchCount = result['data']['fetchCount'];

        fetchedDatas.addAll(result['data']['data']);
        logg.i("fetchedDatas:$fetchedDatas");
        notifyListeners();

        if (fetchedDatas.isNotEmpty) {
          isLoading = false;
          notifyListeners();
        }

        print(response.request);
        print('Total Length ... is ..');
        
        logg.i(result['data']['data'].length);
      
        for (int i = 0; i < fetchedDatas.length; i++) {
          print(
              '${fetchedDatas[i]['_id']}  === = =>> $totalCount  $fetchCount');
        }
        logg.i("${API.martcategory}?productCategoryType=mart&offset=$offset&limit=$limit");
  
      } else {
        if (fetchedDatas.isEmpty) {
          isLoading = false;
          notifyListeners();
        }
print("fetchedDatas.isEmpty");
        logg.i('${response.statusCode} ====<<status code issue>>');
          logg.i("${API.martcategory}?productCategoryType=mart&offset=$offset&limit=$limit");
       
      }
    } catch (e) {
      print('Its an Exception Error $e');
    } finally {
      moreDataLoading = false;
      notifyListeners();
    }
  }


}