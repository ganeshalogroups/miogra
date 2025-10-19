// ignore_for_file: avoid_print, file_names, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class MeatCouponController extends ChangeNotifier {
  bool loading = false;
  bool get isLoading => loading;
  dynamic meatCoupons;

 Future<void> getmeatCouponFunction({value, serviceType = 'meat', shopid}) async {
    print('Service Type : $serviceType');

    print('ddffdfmeat ... 1');

    loading = true;
    notifyListeners();

    try {
      print('ddffdfmeat ... 2');

      var response = await http.get(
          Uri.parse('${API.couponApi}subAdminType=$serviceType&userId=$UserId&availableUsersId=$shopid'),
          headers: API().headers);

      if (response.statusCode >= 200 || response.statusCode <= 202) {
        print("shopid${shopid}");
        print("meaatservice type${serviceType}");
        loge.i('${API.couponApi}subAdminType=$serviceType&userId=$UserId&availableUsersId=$shopid');
        var result = jsonDecode(response.body);
        meatCoupons = result;
        loge.i("meatCoupons${meatCoupons}");
      } else if (response.statusCode == 400) {
        meatCoupons == null;
        Get.snackbar(
          'Something went wrong',
          'Invalid Coupoun',
          backgroundColor: Customcolors.DECORATION_BLURORANGE,
          colorText: Customcolors.DECORATION_BLACK,
          snackPosition: SnackPosition.TOP,
        );

        print('ddffdfmeat ... 9');
      } else {
        meatCoupons == null;
        print('ddffdfmeat ... 10');

        debugPrint('response status code error ${response.statusCode}');
      }
    } catch (e) {
      print('ddffdfmeat ... 11');

      debugPrint('Error in res Catch Area  $e');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

//for getting total AmountValue

  double getcarttoken = 0;

  getmeatcartforToken({required dynamic km}) async {
    try {
      var response = await http.get(
        Uri.parse("${API.getmeat}?userId=$UserId&km=$km"),
        headers: API().headers,
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        var result = jsonDecode(response.body);

        getcarttoken =double.parse(result["data"]['totalMeatAmount'].toString());
        notifyListeners();

        //  return result["data"]['totalFoodAmount'];
      } else {
        getcarttoken = 0.0;
        notifyListeners();

        return [];
      }
    } catch (e) {
      print("error: $e");
      return [];
    }
  }

  String coupontitle = '';
  String couponId = '';
  String couponamount = '';
  String coupontype = "";
  bool isPrecentage = false;
  dynamic aboveVal;
  bool _isCouponApplied = false;

  bool get isCouponApplied => _isCouponApplied;
  String get couponTitle => coupontitle;
  String get couponIdd => couponId;
  String get couponAmt => couponamount;
  String get couponTypee => coupontype;
  bool get isPrecentagee => isPrecentage;

  void setCouponApplied(bool value) {
    _isCouponApplied = value;
    // _saveCouponState();
    notifyListeners();
  }

  void removeCoupon() {
    // Clear coupon data
    coupontitle = '';
    couponId = '';
    couponamount = '';
    coupontype = '';
    isPrecentage = false;
    _isCouponApplied = false;
    aboveVal = 0.0;
    // coupons.clear();
     if (meatCoupons != null && meatCoupons is List) {
    meatCoupons.clear();
  }
    print('coupon removed');
    // _saveCouponState();
    notifyListeners();
  }

  couponlocalData(
      {coupontitl,
      couponid,
      couponAmount,
      isPrecntage,
      couponType,
      double? aboveAmount}) {
    coupontitle = coupontitl;
    couponId = couponid;
    couponamount = couponAmount;
    isPrecentage = isPrecentage;
    coupontype = couponType;
    aboveVal = aboveAmount!.toDouble();
    notifyListeners();
  }
}
