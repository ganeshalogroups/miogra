// ignore_for_file: avoid_print, file_names

import 'dart:convert';
import 'package:testing/utils/Urlist.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
class MartProductGetPaginations with ChangeNotifier {

  Logger logg = Logger();
  bool isLoading = false;

  bool moreDataLoading = false;

  int limit = 7;
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

  Future<void> fetchallproducts({subcateid,cateid,searchvalue, int offset = 0}) async {
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
        Uri.parse("${API.martproductget}?limit=$limit&offset=$offset&categoryId=$cateid&subcategoryId=$subcateid&value=$searchvalue"),
        headers: API().headers,
      );

      if (response.statusCode == 200) {
      print("Products fetched sucess");
      logg.i("${API.martproductget}?limit=$limit&offset=$offset&categoryId=$cateid&subcategoryId=$subcateid&value=$searchvalue");
  
        var result = jsonDecode(response.body);

        totalCount = result['data']['totalCount'];
        fetchCount = result['data']['fetchCount'];

        fetchedDatas.addAll(result['data']['data']);
        logg.i("fetchedDatas:${fetchedDatas}");
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
        logg.i("${API.martproductget}?limit=$limit&offset=$offset&categoryId=$cateid&subcategoryId=$subcateid&value=$searchvalue");
  
      } else {
        if (fetchedDatas.isEmpty) {
          isLoading = false;
          notifyListeners();
        }
      print("fetchedDatas.isEmpty");
        logg.i('${response.statusCode} ====<<status code issue>>');
          logg.i("error :${API.martproductget}?limit=$limit&offset=$offset&categoryId=$cateid&subcategoryId=$subcateid&value=$searchvalue");
       
      }
    } catch (e) {
      print('Its an Exception Error $e');
    } finally {
      moreDataLoading = false;
      notifyListeners();
    }
  }


}