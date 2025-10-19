// ignore_for_file: avoid_print, file_names

import 'package:testing/Features/Authscreen/Domain/Model/Tokenmodel.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TokenController extends GetxController {
  var istokendataLoading = false.obs;
  Tokenmodel? tokendetails;

  void tokenupdateapi({dynamic mobileNo}) async {
 

    try {



      istokendataLoading(true);

      var response = await http.post(Uri.parse(API.tokenfastx),
          headers: API().headersWithoutToken,
          body: jsonEncode(<String, dynamic>{"mobileNo": mobileNo, "role": "consumer"}));
              

            mobilenumb = mobileNo; // for temperory

            var result = jsonDecode(response.body);

            if (response.statusCode >= 200 && response.statusCode <= 202) {

              tokendetails = Tokenmodel.fromJson(result);


            getStorage.write('username',   tokendetails!.data.data.userName);
            getStorage.write("mobilenumb", tokendetails!.data.data.mobileNo);
            getStorage.write("Usertoken",  tokendetails!.data.token);
            getStorage.write("UserId",     tokendetails!.data.data.userId);
            getStorage.write("useremail",  tokendetails!.data.data.email);

            UserId     =  getStorage.read("UserId");
            Usertoken  =  getStorage.read("Usertoken");
            username   =  getStorage.read('username');
            mobilenumb =  getStorage.read('mobilenumb');
            useremail  =  getStorage.read('useremail');

      }else{






      }
      // ignore: empty_catches
    } catch (error) {


      print('Catch Error in kjskjs  $error');
    } finally {
      istokendataLoading(false);
    }
  }



  //token email
  var isLoading = false.obs;
  Tokenmodel? tokenmaildetails;

  void tokenupdateemailapi({dynamic email}) async {

    try {
      isLoading(true);
      var response = await http.post(Uri.parse(API.tokenfastx),
          headers: API().headers,
          body: jsonEncode(
              <String, dynamic>{"email": email, "role": "consumer"}));

      var result = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode <= 202) {



        getStorage.write("username", result['data']['data']["userName"]);
        getStorage.write("useremail", result['data']['data']['email']);
        getStorage.write("UserId", result['data']['data']["userId"]);
        getStorage.write("Usertoken", result['data']["token"]);
        getStorage.write('mobilenumb', result['data']['data']["mobileNo"]);

        // "mobileNo"

        UserId = getStorage.read("UserId");
        Usertoken = getStorage.read("Usertoken");
        username = getStorage.read('username');
        email = getStorage.read('useremail');
        mobilenumb = getStorage.read('mobilenumb');
      } else {
        tokenmaildetails = null;
      }
      // ignore: empty_catches
    } catch (e) {
      print('Its An Exception error  $e');
    } finally {
      isLoading(false);
    }
  }}
