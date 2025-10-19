// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:testing/utils/Urlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../utils/Const/constValue.dart';

class ParcelRegonProvider with ChangeNotifier {
  bool isLoading = false;
  bool get loading => isLoading;

  dynamic regonModel;

  Future<void> getRegonApi({pincode}) async {
    try {
      print("cheeeeeeeeeeee");
      print('${API.getRegonApi}$pincode');
      isLoading = true;
      notifyListeners();

      var responce = await http.get(Uri.parse('${API.getRegonApi}$pincode'),
          headers: API().headers);
      var result = jsonDecode(responce.body);

      print("get regio cal api");


      if (responce.statusCode == 200) {
        print('Success Result: ');

        regonModel = result['data']['data'][0]['regionPincodes'];
        vendorIdforParcel = result['data']['data'][0]['vendorDetails']['_id'];

        addregonData(reggonList: regonModel);
        notifyListeners();

        loge.i(result);
      } else {
        print(
            'Responce Error Make Sure Params Are Correct ${responce.statusCode}  ${result['message']}');

        loge.i(result);
      }
    } catch (e) {
      print('Exception Error : $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  List regonData = [];

  Future<void> addregonData({reggonList}) async {
    regonData = reggonList;
    notifyListeners();
  }

  bool checkregonData({postcode}) {
    return regonData.contains(postcode);
  }
}
