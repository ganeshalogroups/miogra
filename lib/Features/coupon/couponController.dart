 // ignore_for_file: avoid_print, file_names

import 'dart:convert';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class CouponController extends ChangeNotifier {
  bool loading = false;
  bool get isLoading => loading;

  dynamic coupons;
  dynamic parcelCoupons;

  Future<void> getCouponFunction({value, serviceType = 'service'}) async {
    print('Service Type : $serviceType');

    print('ddffdf ... 1');

    loading = true;
    notifyListeners();

    try {
      print('ddffdf ... 2');

      var response = await http.get(
          Uri.parse(
              '${API.couponApi}subAdminType=$serviceType&vendRorAdminId=$vendorIdforParcel'),
          headers: API().headers);

      if (response.statusCode >= 200 || response.statusCode <= 202) {
        var result = jsonDecode(response.body);
        parcelCoupons = result;
        loge.i(parcelCoupons);
        print(
            '${API.couponApi}subAdminType=$serviceType&vendRorAdminId=$vendorIdforParcel');
      } else if (response.statusCode == 400) {
        Get.snackbar(
          'Something went wrong',
          'Invalid Coupoun',
          backgroundColor: Customcolors.DECORATION_BLURORANGE,
          colorText: Customcolors.DECORATION_BLACK,
          snackPosition: SnackPosition.TOP,
        );

        print('ddffdf ... 9');
      } else {
        parcelCoupons == null;
        print('ddffdf ... 10');

        debugPrint('response status code error ${response.statusCode}');
      }
    } catch (e) {
      print('ddffdf ... 11');

      debugPrint('Error in Catch Area  $e');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  String? errorMessage; // 🔴 Add this to hold the API error message
  Future<bool> getrestaurantCouponFunction({
    required String value,
    required String restaurantid,
    required String venorAdminid,
  }) async {
    loading = true;
    notifyListeners();
    try {
      final url =
          '${API.overallcouponApi}userId=$UserId&subAdminId=$restaurantid&vendorAdminId=$venorAdminid&availableStatus=active&value=$value';

      final response = await http.get(Uri.parse(url), headers: API().headers);
      final result = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode <= 202) {
        coupons = result["data"] != null ? result : {};
        errorMessage = null;
        return true;
      } else {
        coupons = {};
        errorMessage = result["message"] ?? "Something went wrong";
        return false;
      }
    } catch (e) {
      coupons = {};
      errorMessage = "Something went wrong: $e";
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }
//   Future<void> getrestaurantCouponFunction(
//       {value, serviceType = 'restaurant', restaurantid,venorAdminid}) async {
//     print('Service Type : $serviceType');

//     print('ddffdf ... 1');

//     loading = true;
//     notifyListeners();

//     try {
//       print('ddffdf ... 2');

//       var response = await http.get(
//           Uri.parse(
//               '${API.overallcouponApi}userId=$UserId&subAdminId=$restaurantid&vendorAdminId=$venorAdminid&availableStatus=active&value=$value'),
//           headers: API().headers);
// print('coupon:${API.overallcouponApi}userId=$UserId&subAdminId=$restaurantid&vendorAdminId=$venorAdminid&availableStatus=active&value=$value');

//       if (response.statusCode >= 200 || response.statusCode <= 202) {
//         loge.i('coupon:${API.overallcouponApi}userId=$UserId&subAdminId=$restaurantid&vendorAdminId=$venorAdminid&availableStatus=active&value=$value');
//         var result = jsonDecode(response.body);
//         coupons = result;
//       } else if (response.statusCode == 400) {
//         coupons == null;
//         Get.snackbar(
//           'Something went wrong',
//           'Invalid Coupoun',
//           backgroundColor: Customcolors.DECORATION_BLURORANGE,
//           colorText: Customcolors.DECORATION_BLACK,
//           snackPosition: SnackPosition.TOP,
//         );

//         print('ddffdf ... 9');
//       } else {
//         coupons == null;
//         print('ddffdf ... 10');

//         debugPrint('response status code error ${response.statusCode}');
//       }
//     } catch (e) {
//       print('ddffdf ... 11');

//       debugPrint('Error in res Catch Area  $e');
//     } finally {
//       loading = false;
//       notifyListeners();
//     }
//   }

//for getting total AmountValue

  double getcarttoken = 0;

  getfoodcartforToken({required dynamic km}) async {
    try {
      var response = await http.get(
        Uri.parse("${API.addfoodfastx}?userId=$UserId&km=$km"),
        headers: API().headers,
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        var result = jsonDecode(response.body);

        getcarttoken =
            double.parse(result["data"]['totalFoodAmount'].toString());
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
    if (coupons != null && coupons is List) {
      coupons.clear();
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

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /// For Parcel Coupon ManageMent
  ///

  String pcoupontitle = '';
  String pcouponId = '';
  String pcouponamount = '';
  String pcoupontype = "";
  bool pisPrecentage = false;
  dynamic paboveVal;
  bool pisCouponapplied = false;

  bool get pisCouponApplied => pisCouponapplied;
  String get pcouponTitle => pcoupontitle;
  String get pcouponIdd => pcouponId;
  String get pcouponAmt => pcouponamount;
  String get pcouponTypee => pcoupontype;
  bool get pisPrecentagee => pisPrecentage;

  void parcelsetCouponApplied(bool value) {
    pisCouponapplied = value;
    // _saveCouponState();
    notifyListeners();
  }

  void parcelremoveCoupon() {
    // Clear coupon data
    pcoupontitle = '';
    pcouponId = '';
    pcouponamount = '';
    pcoupontype = '';
    pisPrecentage = false;
    pisCouponapplied = false;
    paboveVal = 0.0;
    // parcelCoupons.clear();
    if (parcelCoupons != null && parcelCoupons is List) {
      parcelCoupons.clear();
    }
    print('coupon removed');
    notifyListeners();
  }

  parcelcouponlocalData(
      {coupontitl,
      couponid,
      couponAmount,
      isPrecntage,
      couponType,
      double? aboveAmount}) {
    pcoupontitle = coupontitl;
    pcouponId = couponid;
    pcouponamount = couponAmount;
    pisPrecentage = isPrecntage;
    pcoupontype = couponType;
    paboveVal = aboveAmount!.toDouble();
    notifyListeners();
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////// For Parcel Coupon ManageMent  Round Trip /////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  String rTrippcoupontitle = '';
  String rTrippcouponId = '';
  String rTrippcouponamount = '';
  String rTrippcoupontype = "";
  bool rTrippisPrecentage = false;
  dynamic rTrippaboveVal;
  bool rTrippisCouponapplied = false;

  bool get rTrippisCouponApplied => pisCouponapplied;
  String get rTrippcouponTitle => pcoupontitle;
  String get rTrippcouponIdd => pcouponId;
  String get rTrippcouponAmt => pcouponamount;
  String get rTrippcouponTypee => pcoupontype;
  bool get rTrippisPrecentagee => pisPrecentage;

  void rTripparcelsetCouponApplied(bool value) {
    pisCouponapplied = value;
    // _saveCouponState();
    notifyListeners();
  }

  void rTripparcelremoveCoupon() {
    // Clear coupon data
    rTrippcoupontitle = '';
    rTrippcouponId = '';
    rTrippcouponamount = '';
    rTrippcoupontype = '';
    rTrippisPrecentage = false;
    rTrippisCouponapplied = false;
    rTrippaboveVal = 0.0;
    // parcelCoupons.clear();
    if (parcelCoupons != null && parcelCoupons is List) {
      parcelCoupons.clear();
    }
    print('coupon removed');
    notifyListeners();
  }

  rTripparcelcouponlocalData(
      {coupontitl,
      couponid,
      couponAmount,
      isPrecntage,
      couponType,
      double? aboveAmount}) {
    pcoupontitle = coupontitl;
    pcouponId = couponid;
    pcouponamount = couponAmount;
    pisPrecentage = isPrecntage;
    pcoupontype = couponType;
    paboveVal = aboveAmount!.toDouble();
    notifyListeners();
  }
}
