
// ignore_for_file: file_names, avoid_print

import 'dart:convert';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';




class TrackOrderController extends ChangeNotifier {




  bool _loading = false;
  bool get isLoading => _loading;


  dynamic orderModel;

  // Create a logger instance
  final Logger _logger = Logger();

  Future<dynamic> getOrders({required String orderId}) async {
    try {
      _loading = true;
      notifyListeners();

      final response = await http.get(
        Uri.parse('${API.microservicedev}api/order/order/orderGetPagination/?shareUserId=$UserId&_id=$orderId'),
        headers: API().headers,
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        if (result['data'] != null && result['data']['data'] != null && result['data']['data'].isNotEmpty) {

          orderModel = result['data']['data'][0];
       

          _logger.i('Order retrieved successfully: ${orderModel['orderStatus']}');


          return orderModel['orderStatus'];
          
        } else {
          
          _logger.w('No data found');
        }
      } else {


        print('Error : ${response.body}');
        _logger.e('Error: ${response.body}, Status Code: ${response.statusCode}');
      }
      return null;
    } catch (e) {
      _logger.e('Exception occurred: $e');
      return null;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }




  bool parcelloading = false;
  bool get pLoading  => parcelloading;




  dynamic parcelOrderModel;

  // Create a logger instance
  Future<dynamic> getParcelOrders({required String orderId}) async {
    try {
      _loading = true;
      notifyListeners();

      final response = await http.get(
        Uri.parse('${API.microservicedev}api/order/order/orderGetPagination/?shareUserId=$UserId&_id=$orderId'),
        headers: API().headers,
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        if (result['data'] != null && result['data']['data'] != null && result['data']['data'].isNotEmpty) {

            parcelOrderModel = result['data']['data'][0];

          _logger.i('Order retrieved successfully: ${parcelOrderModel['orderStatus']}');


          return parcelOrderModel['orderStatus'];
          
        } else {
          
          _logger.w('No data found');

        }
      } else {


        print('Error : ${response.body}');
        _logger.e('Error: ${response.body}, Status Code: ${response.statusCode}');
      }
      return null;
    } catch (e) {
      _logger.e('Exception occurred: $e');
      return null;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }


















}