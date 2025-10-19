// ignore_for_file: avoid_print, file_names

import 'dart:convert';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Toast/customtoastmessage.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

// parcelPlaceOrder

class CreatePArcelProvider extends ChangeNotifier {
  bool isLoading = false;
  bool get loading => isLoading;

  bool isOrderCreateLoading = false;
  bool get parcelLoading => isOrderCreateLoading;

  dynamic cartModel;

  Future<void> createParcelCart({cartdata}) async {
    isLoading = true;
    notifyListeners();

    try {
      var response = await http.post(Uri.parse(API.createcartApi),
          body: jsonEncode(cartdata), headers: API().headers);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        print('SuccessfullyCreated ... ');

        cartModel = result['data'];
        notifyListeners();
// print('-=-=-=-=-=-=-=-=-=-=--=-=-=-');
//         loge.i(result);
        // print(result);
      } else {
        print(
            'Its An Responce Error  ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Its An CAtch error $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  dynamic getCartModel;

  Future<void> getParcelCart({km}) async {
    isLoading = true;
    notifyListeners();

    try {
      var response = await http.get(Uri.parse('${API.getParcelCart}&km=$km'),
          headers: API().headers);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        print('Cart get SuccessFully ... ');

        getCartModel = result['data'];
        notifyListeners();

        print('=======LLLLL>>>>  $getCartModel');
        loge.i(result);
      } else {
        print(
            'Its An Responce Error  ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Its An CAtch error $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  dynamic packagecontentdata;
  dynamic meshurmentMapDatas;

  Future<void> packageWeightContents({content}) async {
    isLoading = true;
    notifyListeners();

    try {
      var response =
          await http.get(Uri.parse(API.mesurmentsApi), headers: API().headers);

      if (response.statusCode >= 200 || response.statusCode <= 202) {
        var result = jsonDecode(response.body);

        packagecontentdata = result["data"];

        print('vvv==>$packagecontentdata <=====');
        print(
            '------------Find Data Type Of this  -  ${result.runtimeType}  ${response.request}');
        print(packagecontentdata['totalCount'].toString());

        List<Map<String, dynamic>> data = [
          for (int index = 0;
              index < packagecontentdata['data'].length;
              index++)
            {
              'label':
                  '${packagecontentdata['data'][index]['startValue']} ${packagecontentdata['data'][index]['unit']} - ${packagecontentdata['data'][index]['endValue']}  ${packagecontentdata['data'][index]['unit']}',
              'value': index,
              'basePrice': packagecontentdata['data'][index]['basePrice'],
              'unit': packagecontentdata['data'][index]['unit'],
              'maxWeight': packagecontentdata['data'][index]['endValue'],
            }
        ];

        print('-------------HGh');
        print(data);
        meshurmentMapDatas = data;
        notifyListeners();
      } else {
        meshurmentMapDatas = null;
        print('Status Code Error : ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Catch Error == $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  dynamic createParcelOrderModel;

  Future<void> parcelPlaceOrder({parcelOrderData}) async {
    isOrderCreateLoading = true;
    notifyListeners();

    print('cccc  1');

    try {
      var response = await http.post(Uri.parse(API.createParcelOrder),
          body: jsonEncode(parcelOrderData), headers: API().headers);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        print('Cart get SuccessFully ... ');

        print('cccc  2');
        createParcelOrderModel = result['data'];
        notifyListeners();

        print('=====order parcel  $createParcelOrderModel');
        loge.i(result["message"]);

        AppUtils.showToast('Parcel ${result["message"]}');

        clearParcelCart();
      } else {
        print('cccc  3');
        print(
            'Its An Responce Error  ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('cccc  4');
      print('Its An CAtch error $e');
    } finally {
      isOrderCreateLoading = false;
      notifyListeners();
    }
  }

  Future<void> clearParcelCart() async {
    Map<String, dynamic> body = {
      "userId": UserId,
    };

    try {
      var response = await http.put(Uri.parse(API.clearParcelCart),
          body: jsonEncode(body), headers: API().headers);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        AppUtils.showToast('Parcel ${result['message']}');
      } else {
        print(
            'Its An Responce Error The Status Code Is ${response.statusCode} ');
        print('Its An Responce Error The responce body Is ${response.body} ');
      }
    } catch (e) {
      print('Its An Catch error From cartClear api==> $e');
    } finally {}
  }
}
