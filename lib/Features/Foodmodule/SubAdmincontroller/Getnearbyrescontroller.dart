// ignore_for_file: unnecessary_overrides, file_names, avoid_print

import 'dart:convert';
import 'package:testing/Features/Authscreen/AuthController/Tokenupdate.dart';
import 'package:testing/Features/Homepage/homepage.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Toast/customtoastmessage.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
 


class Nearbyrescontroller extends GetxController {

TokenController tokenupdate=Get.put(TokenController());

 late PagingController<int, dynamic> nearbyresPagingController;
  static const int limit = 15;
   var selectedIndex =0.obs;

  @override
  void onInit() {
    super.onInit();
    nearbyresPagingController = PagingController(firstPageKey: 0);
    nearbyresPagingController.addPageRequestListener((pageKey) {
      fetchResPage(pageKey);
    });
  }



  void updateIndex(var index) {
    selectedIndex.value = index;
   
  }


Future <void> refreshNearbyRes() async {
 Future.delayed(Duration.zero, () {
//   // Clear the list immediately to prevent flickering
  nearbyresPagingController.itemList?.clear();
   fetchResPage(0);
 }).whenComplete(() =>   nearbyresPagingController.refresh());
}

  Future<void> fetchResPage(int pageKey) async {
    try {
      await foodgetres(pageKey, API.nearestresapi, nearbyresPagingController);
    } catch (e, stackTrace) {
      loge.e("Error fetching page: $e", error: e, stackTrace: stackTrace);
      nearbyresPagingController.error = 'Error loading data';
    }
  }

  Future<void> foodgetres(int pageKey, String apiUrl, PagingController<int, dynamic> pagingController,{String category = ""}) async {
    try {
      // int offset = pageKey * limit; // Correct offset calculation

      var response = await http.post(
        Uri.parse(apiUrl),
        headers: API().headers,
        body: jsonEncode(
          <String, dynamic>{"lat":initiallat,"lng":initiallong,"page":pageKey,"perPage":limit,"activeStatus": "online","productTypeToFilter": selectedIndex.value==0?"restaurant":"shop"},
         // <String, dynamic>{"lat":initiallat,"lng":initiallong,"page":pageKey,"perPage":limit,"productTypeToFilter": selectedIndex.value==0?"restaurant":"shop"},
        ),
      );
   print({"lat":initiallat,"lng":initiallong,"page":pageKey,"perPage":limit,"activeStatus": "online","productTypeToFilter": selectedIndex.value==0?"restaurant":"shop"});
print("nearest res");
      if (response.statusCode >= 200 && response.statusCode < 300) {
        loge.i("Fetching nearees: $apiUrl?limit=$limit&offset=$pageKey&latitude=$initiallat&longitude=$initiallong&subAdminType=restaurant&userId=$UserId&value=");
        // loge.i("kilometre from nearest restuarant${kilometre}");
        final result = jsonDecode(response.body);
        final newItems = result["data"]["data"] ?? [];
        final isLastPage = newItems.length < limit;
       print(newItems);
        if (pageKey == 0) {
          pagingController.itemList?.clear(); // Clear items on refresh
        }

        /// Prevent duplicate entries based on `_id`
        final existingItems = pagingController.itemList ?? [];
        final existingItemIds = existingItems.map((item) => item["document"]["_id"]).toSet();

        final filteredNewItems = newItems.where((item) => item["document"]["_id"] != null && !existingItemIds.contains(item["document"]["_id"])).toList();

        if (isLastPage) {
          pagingController.appendLastPage(filteredNewItems);
        } else {
          pagingController.appendPage(filteredNewItems, pageKey + 1); // Ensure proper sequential offset
        }
      } else {
        pagingController.error = 'Unexpected error: ${response.statusCode}';
      }
    } catch (e, stackTrace) {
      loge.e("Error fetching data: $e", error: e, stackTrace: stackTrace);
      pagingController.error = 'Error: $e';
    }
  }

  @override
  void onClose() {
    nearbyresPagingController.dispose();
    super.onClose();
  }


////////////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

  // add restaurant to favourites
   
  dynamic favourites;
  var favouritesloading = false.obs;
 
  void addfavouritesApi({dynamic productCategoryId, dynamic productId, userId, context}) async {
   
    try {
      favouritesloading(true);
      var response = await http.post(
        Uri.parse(API.addfavresfastx),
        headers: API().headers,
        body: jsonEncode(
          <String, dynamic>{
            "productCategoryId": productCategoryId, //fronthomepageproductID
            "productId": productId, //resID
            "userId": userId,
            "favouriteType":"normal"
          },
        ),
      );
 
 
      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
         
         
        var result = jsonDecode(response.body);
 
            favourites = result;


            if(favourites["message"]=='favouriteList Added Successfully'){

                  AppUtils.showToast('Restaurant added to favourites.');


              } 


 
 
      } else {
 
        favourites == null;
      }
    } catch (e) {
      print("error");
    } finally {
      favouritesloading(false);
    }
  }
 
 
 
 
 
 dynamic removefavourites;
  var removeitesloading = false.obs;

  void removefavouritesApi(String? favouriteid) async {
    try {
      removeitesloading(true);
      var response = await http.delete(
        Uri.parse("${API.removefavresfastx}/$favouriteid"),
        headers: API().headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
        var result = jsonDecode(response.body);
        favourites = result;
              AppUtils.showToast('Item removed from favourites.');
        
      } else {
        // Handle 400 status code specifically
        if (response.statusCode == 400) {
          AppUtils.showToast('Failed to remove favourite. Please try again.');
        }
        favourites = null;

      }
    } catch (e) {
      AppUtils.showToast('An error occurred. Please try again.');
    } finally {
      removeitesloading(false);
    }
  }











    // update api


    dynamic updatefavourite;
  var updateFavourite = false.obs;

   updateFavouriteFun({dynamic productCategoryId, dynamic productId, userId, context}) async {
   loge.i("update fav");
    loge.i({
            "productCategoryId": productCategoryId, //fronthomepageproductID
            "productId": productId, //resID
            "userId": userId
          });
    try {
      favouritesloading(true);
      var response = await http.post(
        Uri.parse(API.updatefavourite),
        headers: API().headers,
        body: jsonEncode(
          <String, dynamic>{
            "productCategoryId": productCategoryId, //fronthomepageproductID
            "productId": productId, //resID
            "userId": userId
          },
        ),
      );


      if (response.statusCode == 200 ||  response.statusCode == 201 ||  response.statusCode == 202) {
        var result = jsonDecode(response.body);
        favourites = result;
      print("favstatuscode${response.statusCode}");

            if(favourites['data']['deleted']==true)  {

              AppUtils.showToast('Restaurant removed from Favorites.');


            }else{



              AppUtils.showToast(favourites['message']);

            }


         


      } else {
print("favstatuscode${response.statusCode}");
        favourites == null;
     

      }

    } catch (e) {

        print("error");


    } finally {
          removeitesloading(false);
    }
  }




}





