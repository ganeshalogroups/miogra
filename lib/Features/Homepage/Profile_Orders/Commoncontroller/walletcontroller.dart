// // ignore_for_file: file_names

// import 'dart:convert';

// import 'package:testing/utils/Const/ApiConstvariables.dart';
// import 'package:testing/utils/Urlist.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// class Walletcontroller extends GetxController {
//  var isLoading = false.obs;
//   dynamic walletdetails;

//   getwalletDetails() async {
//     try {
//       isLoading(true);
//       var response = await http.get(
//         Uri.parse("${API.wallet}/?userId=$UserId"),
//         headers: API().headers,
//       );
//       if (response.statusCode == 200) {
//         var result = jsonDecode(response.body);
//         walletdetails = result;
//         print("${API.wallet}/?userId=$UserId ");
//       debugPrint("get wallet details ${response.body}");
//       } else {
//          print(response.body);
//          print("${API.wallet}/?userId=$UserId");
//          print("==========================================");
//         walletdetails = null;
//       }
//     } catch (e) {
//       walletdetails = null;
//        print("============================hhhhhhhhhhhhhhhhhhhhhhhhhh==============");
//       //print(e.toString());
//       return false;
//     } finally {
//       isLoading(false);
//     }
//   }

// }