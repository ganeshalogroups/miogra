import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodhomepage.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodsearch.dart';
import 'package:testing/Features/Homepage/Profile_Orders/your_order.dart';
import 'package:testing/Features/Homepage/homepage.dart';
import 'package:testing/Features/OrderScreen/OrdersTab.dart';
import 'package:testing/Mart/Homepage/MartHomepage.dart';
import 'package:testing/Meat/Homepage/Meathomepage.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatOrderHistoryTabbar/MeatOrdersTab.dart';
import 'package:testing/parcel/parcel_home.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
 
class ExitApp {
 
  static DateTime? currentBackPressTime;
 
  static Future<void> handlePop() async {
 
    DateTime now = DateTime.now();
 
    if (currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds:2)) {
       
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'Double tap to Exit');
 
    } else {
 
      SystemNavigator.pop();
     
    }
  }
 
 
  static Future<void> handlenavigatetohome(BuildContext context) async {
 
    DateTime now = DateTime.now();
 
    if (currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds:2)) {
       
       
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'Double tap to Exit');
 

    } else {
 
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Foodscreen()));
 
    }
  }
 
     static Future<void> homepopp() async {
         Get.back();
    }
 
 
    // static Future<void> homepop() async {

    //       Get.off(const HomeScreenPage(),transition: Transition.leftToRight);
    //}
  
   static Future<void> foodsearchpop() async {

          Get.off(const Foodsearchscreen(),transition: Transition.leftToRight);
    }
 
    static Future<void> foodhomepop(BuildContext context) async {
        
        Navigator.pop(context);
   
    }
 
    static Future<void> foodhomepage() async {
          Get.off(const Foodscreen());
    }
 

static Future<void> meathomepage() async {
          Get.off(Meathomepage(meatproductcategoryid: meatproductCateId,));
    }
 


    static Future<void> navigatePop(BuildContext context) async {
            
            Navigator.pop(context);
    }
  


    static Future<void> ratingpop() async {

          Get.off(const OrdersHistory(),transition: Transition.leftToRight);
    }
 
 static Future<void> meatratingpop() async {

          Get.off(const MeatOrderTab(),transition: Transition.leftToRight);
    }
 

   static Future<void> yourOrdersPop() async {

          Get.off(const YourOrdersTabsScreen(),transition: Transition.leftToRight);
    }
 



  static Future<void> backPop() async {

          // Get.off(foodhomepage(),transition: Transition.rightToLeft);
          Get.back();
    }
 






 
    static Future<void> parcelHome() async {
      
          Get.off(const ParcelHomeScreen());
    }
 

    static Future<void> marthomepop() async {

          Get.off(const MartHomepage(),transition: Transition.leftToRight);
    }

}



