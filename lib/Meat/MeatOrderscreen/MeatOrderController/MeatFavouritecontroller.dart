// ignore_for_file: file_names, avoid_print

import 'dart:convert';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Toast/customtoastmessage.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class MeatFavouritegetPagination with ChangeNotifier {
  Logger logg = Logger();
  bool isLoading = false;
  bool moreDataLoading = false;
  int limit = 5;
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
  Future<void> meatfavget({int offset = 0}) async {
  if (moreDataLoading) return; // Prevent multiple simultaneous requests

  moreDataLoading = true;
  if (offset == 0) isLoading = true; // Initial load
  notifyListeners();

  try {
    final response = await http.get(
      Uri.parse("${API.favgetformeat}?limit=$limit&offset=$offset&latitude=$initiallat&longitude=$initiallong&userId=$UserId&favouriteType=normal&productCategoryId=$meatproductCateId"),
      headers: API().headers,
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);

      totalCount = result['data']['totalCount'];
      fetchCount = result['data']['fetchCount'];
      final newItems = result['data']['data'];

      // Filter items with availableStatus = true
      final filteredItems = newItems.where((item) => item['availableStatus'] == true).toList();

      if (offset == 0) fetchedDatas.clear(); // Clear data for a fresh load

      // Prevent duplicates
      fetchedDatas.addAll(filteredItems.where((item) => !fetchedDatas.any((fetched) => fetched['_id'] == item['_id'])));

      logg.i('Fetched ${filteredItems.length} items with availableStatus = true');
    } else {
      logg.e('API Error: ${response.statusCode}');
    }
  } catch (e) {
    logg.e('Exception: $e');
  } finally {
    isLoading = false;
    moreDataLoading = false;
    notifyListeners();
  }
}

  }

class MeatFavgetcontroller extends GetxController {

  
  dynamic addfavourites;
  var addfavouritesloading = false.obs;
 
  void meataddfavouritesApi({ dynamic productId, userId, context}) async {
   
    try {
      addfavouritesloading(true);
      var response = await http.post(
        Uri.parse(API.addfavresfastx),
        headers: API().headers,
        body: jsonEncode(
          <String, dynamic>{
            "productCategoryId": meatproductCateId, //fronthomepageproductID
            "productId": productId, //shopID
            "userId": userId,
            "favouriteType":"normal"
          },
        ),
      );
 
 
      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
         
         
        var result = jsonDecode(response.body);
 
            addfavourites = result;


            if(addfavourites["message"]=='favouriteList Added Successfully'){

                  AppUtils.showToast('Shop added to favourites.');


              } 


 
 
      } else {
 
        addfavourites == null;
      }
    } catch (e) {
      print("error");
    } finally {
      addfavouritesloading(false);
    }
  }




   dynamic updatefavourite;
  var updateFavouriteloading = false.obs;

    meatupdateFavouriteFun({ dynamic productId, userId, context}) async {
    
    try {
      updateFavouriteloading(true);
      var response = await http.post(
        Uri.parse(API.updatefavourite),
        headers: API().headers,
        body: jsonEncode(
          <String, dynamic>{
            "productCategoryId": meatproductCateId, //fronthomepageproductID
            "productId": productId, //resID
            "userId": userId
          },
        ),
      );
      print("vbhjbnkjnkjnkjnmn");
loge.i(productId);
loge.i(meatproductCateId);
loge.i(userId);


      if (response.statusCode == 200 ||  response.statusCode == 201 ||  response.statusCode == 202) {
        var result = jsonDecode(response.body);
        updatefavourite = result;
      

            if(updatefavourite['data']['deleted']==true)  {

              AppUtils.showToast('Shop removed from Favorites.');


            }else{



              AppUtils.showToast(updatefavourite['message']);

            }


         


      } else {

        updatefavourite == null;
     

      }

    } catch (e) {

        print("error");


    } finally {
          updateFavouriteloading(false);
    }
  }

 

 
 dynamic meatremovefavourites;
  var meatremoveitesloading = false.obs;

  void meatremovefavouritesApi(String? favouriteid) async {
    try {
      meatremoveitesloading(true);
      var response = await http.delete(
        Uri.parse("${API.removefavresfastx}/$favouriteid"),
        headers: API().headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
        var result = jsonDecode(response.body);
        meatremovefavourites = result;
              AppUtils.showToast('Item removed from favourites.');
        
      } else {
        // Handle 400 status code specifically
        if (response.statusCode == 400) {
          AppUtils.showToast('Failed to remove from favourite. Please try again.');
        }
        meatremovefavourites = null;

      }
    } catch (e) {
      AppUtils.showToast('An error occurred. Please try again.');
    } finally {
      meatremoveitesloading(false);
    }
  }
}