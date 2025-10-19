// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;



class ChipController extends GetxController {
  var isLoading = false.obs;

  dynamic chipData;

  Future<void> chipGetFunction() async {
    isLoading(true);
    update();

    try {


      var responce =  await http.get(Uri.parse(API.getchipCate), headers: API().headers);
    
      var result = jsonDecode(responce.body);
      

      if (responce.statusCode >= 200 || responce.statusCode <= 202) {
         
         
                print('====>>');

               chipData = result;
               update();



      } else {

        loge.i(result);

      }

    } catch (e) {
      print('Its An CAtch Error :$e');

    } finally {

      isLoading(false);
      
    }
  }

}









class RoundTripChipController extends GetxController {
  var isLoading = false.obs;

  dynamic chipData;

  Future<void> chipGetFunction() async {
    isLoading(true);
    update();

    try {


      var responce =  await http.get(Uri.parse(API.getchipCate), headers: API().headers);
    
      var result = jsonDecode(responce.body);
      

      if (responce.statusCode >= 200 || responce.statusCode <= 202) {
         
         
                print('====>>');

               chipData = result;
               update();



      } else {

        loge.i(result);

      }

    } catch (e) {
      print('Its An CAtch Error :$e');

    } finally {

      isLoading(false);
      
    }
  }

}
