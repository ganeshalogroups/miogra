// ignore_for_file: avoid_print, file_names

import 'dart:convert';
import 'package:testing/Features/Authscreen/AuthController/Tokenupdate.dart';
import 'package:testing/Features/Authscreen/Domain/Model/ResturantByIdMode.dart';
import 'package:testing/Features/Homepage/homepage.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Bannerlistcontroller extends GetxController {
  TokenController tokenupdate = Get.put(TokenController());

  dynamic banner;
  var isbannerloading = false.obs;

  void bannerget({productType = 'restaurant'}) async {
    try {
      isbannerloading(true);
      var response = await http.get(
        Uri.parse(
            "${API.bannerParcelfastx}?userType=consumer&productType=$productType&bannerType=top&limitSearch=20&productCateId=$productCateId&status=true&userId=$UserId"),
        headers: API().headers,
      ); 
      print("banner response");
      print(Usertoken);
      print(UserId);
      print(
          "${API.bannergetfastx}?userType=consumer&productType=$productType&bannerType=top&limitSearch=20&productCategoryId=$productCateId&status=true&userId=$UserId");
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        print(
            "${API.bannergetfastx}?userType=consumer&productType=$productType&bannerType=top&limitSearch=20&productCategoryId=$productCateId&status=true&userId=$UserId");
        var result = jsonDecode(response.body);
        banner = result;
      } else {
        banner == null;
      }
    } catch (e) {
      print("error");
    } finally {
      isbannerloading(false);
    }
  }

  // dynamic bottombannerModel;
  // var isbannerbottomloading = false.obs;

  // void bottmbannerget() async {
  //   try {
  //     isbannerbottomloading(true);
  //     var response = await http.get(
  //       Uri.parse(
  //           "${API.bottombanner}?userType=consumer&productType=restaurant&bannerType=bottom&status=true"),
  //       headers: API().headers,
  //     );

  //     if (response.statusCode == 200 ||
  //         response.statusCode == 201 ||
  //         response.statusCode == 202) {
  //       var result = jsonDecode(response.body);
  //       bottombannerModel = result;
  //     } else {
  //       bottombannerModel == null;

  //       print(response.body.toString());
  //     }
  //   } catch (e) {
  //     print("error");
  //   } finally {
  //     isbannerbottomloading(false);
  //   }
  // }



  ResturantByIdModel? resModel;

  getResturantsById({resturantId}) async {
    try {
      var response = await http.get(
        Uri.parse(
            '${API.getResturantDetailsById}restaurantId=$resturantId&userId=$UserId'),
        headers: API().headers,
      );

      print(response);

      if (response.statusCode == 200) {
        print('-----------ss--33------s');

        var result = jsonDecode(response.body);

        resModel = ResturantByIdModel.fromJson(result);

        print(response.body);
      } else {
        print('Statuc Code Issue ');
        print(response.statusCode);
        resModel = null; // Clear the model if the status code is not 200
      }
    } catch (e) {
      resModel = null; // Clear the model if the status code is not 200
      print('Its An Exception Error : $e');
    } finally {}
  }
}



class HomepageProvider with ChangeNotifier {
  bool loading = false;
  bool get isLoading => loading;
List topBanners =[];
List  bottomBanners =[];

  dynamic orderModel;

  Future<void> getHomepagedatas({
    
    String categoryFilter=""
    
    }) async {
    loading = true;
    notifyListeners();

    try {
      var response = await http.get(
        Uri.parse(//"http://ffastx.ddns.net/api/utility/banner/mobileAppBanner?userType=consumer&productType=restaurant&bannerType=top&limitSearch=20&productCateId=670504c534216ff9fe343068&status=true&userId=687dfe2f48f21a030ccaad0c&latitude=8.1990524&longitude=77.3830748&subAdminType=restaurant&productTypeToFilter=$categoryFilter"),
         //   "${API.bannergetfastx}?userType=consumer&productType=restaurant&bannerType=top&limitSearch=20&productCateId=$productCateId&status=true&userId=$UserId&latitude=$initiallat&longitude=$initiallong&subAdminType=restaurant"),
            "${API.bannergetfastx}?userType=consumer&productType=restaurant&bannerType=top&limitSearch=20&productCateId=$productCateId&status=true&userId=$UserId&latitude=$initiallat&longitude=$initiallong&subAdminType=restaurant&productTypeToFilter=$categoryFilter"),
        headers: API().headers,
      );

      if (response.statusCode == 200) {
        print(
         
            "${API.bannergetfastx}?userType=consumer&productType=restaurant&bannerType=top&limitSearch=20&productCateId=$productCateId&status=true&userId=$UserId&latitude=$initiallat&longitude=$initiallong&subAdminType=restaurant&productTypeToFilter=$categoryFilter");
        
        print("SSSSUUUUUUSSSSSEEEESSSS");

        var result = jsonDecode(response.body);
        orderModel = result['data'];
        print("AAAAAAAAAA$orderModel");
         print(
        
            "${API.bannergetfastx}?userType=consumer&productType=restaurant&bannerType=top&limitSearch=20&productCateId=$productCateId&status=true&userId=$UserId&latitude=$initiallat&longitude=$initiallong&subAdminType=restaurant&productTypeToFilter=$categoryFilter");
      } else {
        orderModel = null;
        print(
            "${API.bannergetfastx}?userType=consumer&productType=restaurant&bannerType=top&limitSearch=20&productCateId=$productCateId&status=true&userId=$UserId&latitude=$initiallat&longitude=$initiallong&subAdminType=restaurant");
        print('Response Error In Homepagedata  ${response.statusCode}');
        print('Response Error In Homepagedata body  ${response.body}');
      }
    } catch (e) {
      print('Exception Error ..$e');
      orderModel = null; // ✅ Prevent future NoSuchMethodError
    } finally {
      loading = false;
      notifyListeners();
    }
  }








Future<void> getBanner({
    
    String categoryFilter=""
    
    }) async {
    // loading = true;
    // notifyListeners();

    try {
      var response = await http.post(
        Uri.parse(
            API.banner),
        headers: API().headers,
        body: jsonEncode({
          
    "lat": initiallat,
    "lng": initiallong,
    "productTypeToFilter": categoryFilter,
  

        })
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
       var decodedData = jsonDecode(response.body);
List list = decodedData["data"]["data"];

print("BANNER RESPONSE   $list");




 topBanners =
    list.where((e) => e['document']['bannerType'] == 'top').toList();

 bottomBanners =
    list.where((e) => e['document']['bannerType'] == 'bottom').toList();


      }
      else{
     
      }
    
}
catch(e){

  print("CATCH ERROR BANNER     $e");}
// finally {
//       loading = false;
//       notifyListeners();
//     }

    }
}
      

// class NumProvider with ChangeNotifier {
//   int selectedIndex = 0;

//   void updateIndex(int index) {
//     selectedIndex = index;
//     notifyListeners(); // tells UI to rebuild
//   }
// }





// class NumProvider extends GetxController{
//   var selectedIndex =0.obs;

//   void updateIndex(var index) {
//     selectedIndex = index;
   
//   }
// }

