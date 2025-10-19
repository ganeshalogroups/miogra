// ignore_for_file: file_names, avoid_print
import 'dart:convert';
import 'package:testing/Features/Authscreen/AuthController/Tokenupdate.dart';
import 'package:testing/Meat/MeatButtonFunctionalities/TotalitemcountButton.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatOrderController/MeatCouponcontroller.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class MeatAddcontroller extends GetxController {
  TokenController tokenupdate = Get.put(TokenController());
  Logger log = Logger();
  dynamic meatcart;
  var meatcartloading = false.obs;

  Future<void> addmeat({
    required dynamic meatid,
    required String shopId,
    required bool isCustomized,
    required dynamic quantity,
    String? selectedVariantId,
    List<dynamic>? selectedAddOns,
  }) async {
    try {
      meatcartloading(true);

      Map<String, dynamic> body = {
        "meatId": meatid,
        "subAdminId": shopId,
         "isCustomized": isCustomized,
        "quantity": quantity,
        "userId": UserId
      };
  if (isCustomized) {
  if (selectedVariantId != null && selectedVariantId.isNotEmpty) {
    body["selectedVariantId"] = selectedVariantId; // Add only if selectedVariantId is not empty or null
  }
  body["selectedAddOns"] = selectedAddOns ?? []; // Add selectedAddOns, default to empty list if null
}
      var response = await http.post(
        Uri.parse(API.addmeat),
        headers: API().headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        print("meat product added sucessfulyyyyyy");
        var result = jsonDecode(response.body);
        meatcart = result;
        log.i(meatcart);
      } else {
        meatcart = null;
      }
    } catch (e) {
      print("error: $e");
    } finally {
      meatcartloading(false);
    }
  }

  dynamic updatemeatcart;
  var updatemeatcartloading = false.obs;

  Future<void> updatemeatItem({
    required dynamic meatid,
    required dynamic quantity,
    // required dynamic resturantId,
  }) async {
    try {
      updatemeatcartloading(true);

      // Create the basic body
      Map<String, dynamic> body = {
        "meatId": meatid,
        "quantity": quantity,
        "userId": UserId
      };

      var response = await http.put(
        Uri.parse("${API.updatemeat}?userId=$UserId"),
        headers: API().headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        var result = jsonDecode(response.body);

        updatemeatcart = result;
      } else {
        updatemeatcart = null;
      }
    } catch (e) {
      print("error: $e");
    } finally {
      updatemeatcartloading(false);
    }
  }

  dynamic getmeatcart;
  var getmeatcartloading = false.obs;

  Future getmeatcartmeat({required dynamic km}) async {
    try {
      getmeatcartloading(true);
      var response = await http.get(
        Uri.parse("${API.getmeat}?userId=$UserId&km=$km"),
        headers: API().headers,
      );

      // print('${response.statusCode}');
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        var result = jsonDecode(response.body);
        getmeatcart = result;
        log.i("gettcarttt${API.getmeat}?userId=$UserId&km=$km");
         log.i(getmeatcart);
        // Ensure this is the correct path for your data

        return List<dynamic>.from(result["data"]["meats"] ?? []);
      } else {
        getmeatcart = null;

        return [];
      }
    } catch (e) {
      print("error: $e");
      // return [];
    } finally {
      getmeatcartloading(false);
    }
  }


  dynamic getbillmeatcart;
  var getbillmeatcartloading = false.obs;

  Future<List<dynamic>> getbillmeatcartmeat({required dynamic km}) async {

    try {

      getbillmeatcartloading(true);
      update(); // Notify GetBuilder of loading state

      var response = await http.get(
        Uri.parse("${API.getmeat}?userId=$UserId&km=$km"),
        headers: API().headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
        var result = jsonDecode(response.body);
        getbillmeatcart = result;
        update(); // Notify GetBuilder of data update

        // Ensure this is the correct path for your data
        return List<dynamic>.from(result["data"]["meats"] ?? []);

      } else {

        getbillmeatcart = null;
        update(); // Notify GetBuilder of null data
        return [];
        
      }


    } catch (e) {

      print("error: $e");
      return [];

    } finally {

      getbillmeatcartloading(false);
      update(); // Notify GetBuilder of final loading state

    }
  }










  dynamic deletemeatCart;
  var deletemeatCartLoading = false.obs;

  Future<void> deleteCartItem({
    required dynamic meatid,
  }) async {
    try {
      deletemeatCartLoading(true);

      // Create the basic body
      Map<String, dynamic> body = {
        "meatId": meatid,
        "userId": UserId,
      };

      var response = await http.delete(
        Uri.parse(API.deletemeatcart),
        headers: API().headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        var result = jsonDecode(response.body);

        deletemeatCart = result;
      } else {
        deletemeatCart = null;

        if (response.statusCode == 401) {
          tokenupdate.tokenupdateapi(mobileNo: mobilenumb);
        } else {}
      }
    } catch (e) {
      print("error: $e");
    } finally {
      deletemeatCartLoading(false);
    }
  }

  dynamic clearmeatcart;
  var clearmeatcartloading = false.obs;

  Future<void> clearmeatCartItem({required context}) async {
    try {
      clearmeatcartloading(true);

      // Create the basic body
      Map<String, dynamic> body = {
        "userId": UserId,
      };

      var response = await http.put(
        Uri.parse(API.clearmeatcart),
        headers: API().headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        var result = jsonDecode(response.body);

        Provider.of<MeatButtonController>(context, listen: false).hidemeatButton();
        Provider.of<MeatCouponController>(context, listen: false).removeCoupon();
        clearmeatcart = result;
      } else {
        if (response.statusCode == 401) {
          tokenupdate.tokenupdateapi(mobileNo: mobilenumb);
        } else {}

        clearmeatcart = null;
      }
    } catch (e) {
      print("error: $e");
    } finally {
      clearmeatcartloading(false);
    }
  }
}
