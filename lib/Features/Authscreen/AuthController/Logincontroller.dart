// ignore_for_file: avoid_print, file_names

import 'dart:convert';
import 'package:testing/Features/Authscreen/AuthController/Registercontroller.dart';
import 'package:testing/Features/Authscreen/Domain/Model/Otpmodel.dart';
import 'package:testing/Features/Authscreen/Otpscreen.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Toast/customtoastmessage.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;




class LoginscreenController extends GetxController {
  var islogindataLoading = false.obs;

  dynamic logindetails;
  void loginApi({
    dynamic mobileNo,
  }) async {
    try {

      print("try login");

      islogindataLoading(true);
      var response = await http.post(Uri.parse(API.loginfastx),
          headers: API().headers,
          body: jsonEncode(<String, dynamic>{"mobileNo": mobileNo}));


      print("Get Login response body${response.body}");


      // getStorage.write("mobilenumb", mobileNo);
      // mobilenumb = getStorage.read("mobilenumb");
      // print('stored value.....but not');
      // print(mobilenumb);

      
      print('${response.statusCode}');

      if (response.statusCode == 200 ||  response.statusCode == 201 || response.statusCode == 202) {
        
         
        var result = jsonDecode(response.body);
        logindetails = result;
        print(result["data"]["otpId"]);
        print(result["code"]);


        Get.to(Otpscreen(mobilenum: mobileNo),transition: Transition.leftToRight);

        
        print('Otp Sent Successfully ');
      } else {
        print("else login");
        logindetails == null;
        AppUtils.showToast('Error In Login Area');
        // print(response.body.toString());
      }
    } catch (e) {
      print("catch  login");
      print(e.toString());
    } finally {
      islogindataLoading(false);
    }
  }



  var isLoading = false.obs;
  Otpverficationmodel? otpmodel;
  var successMessage = ''.obs;
  var showSmsCallMethod = false.obs;
  var isOtpFilled = false.obs;
   verifyotp({dynamic otpId, dynamic otp ,dynamic phno, contxt}) async {
    try {
      isLoading(true);
      var response = await http.post(Uri.parse(API.otpverifyfastx),
          headers: API().headers,
          body: jsonEncode(<String, dynamic>{"otpId": otpId, "otp": otp}));

        
          var result = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201 ||response.statusCode == 202) {
          
          
        print("Otp verified Sucessfully");

        mobilenumb = phno;
        RegisterscreenController().tokenapi(mobileNo:phno,cntxt: contxt);


        
          otpmodel = Otpverficationmodel.fromJson(result);


      } else {
    
        successMessage.value = "Uh oh! The OTP you entered is invalid.. Retry via";
           
        showSmsCallMethod.value = true;
        otpmodel = null;

        print("Failed");
      }
      // ignore: empty_catches
    } catch (error) {
    } finally {
      isLoading(false);
    }
  }

    
}
