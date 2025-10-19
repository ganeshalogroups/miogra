// ignore_for_file: avoid_print, file_names
import 'dart:convert';
import 'package:testing/Features/Authscreen/Domain/Model/Tokenmodel.dart';
import 'package:testing/Features/Authscreen/Domain/Model/profileModel.dart';
import 'package:testing/Features/Authscreen/GoogleSignin/GoogleSignInApi.dart';
import 'package:testing/Features/Authscreen/Register.dart';
import 'package:testing/Features/Authscreen/Splashscreen.dart';
import 'package:testing/Features/Foodmodule/Data/cartprovider.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Restaurantcard.dart';
import 'package:testing/Features/Homepage/AddressController/Addresscontroller.dart';
import 'package:testing/map_provider/request_permission_page.dart';
import 'package:testing/utils/Buttons/CustomAlertDialoug.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Toast/customtoastmessage.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'controllerForFavAdd.dart';

class RegisterscreenController extends GetxController {
  var isdataLoading = false.obs;
  dynamic regdetails;
  AddressController addresscontroller = Get.put(AddressController());
  void registerapi(
      {dynamic name, dynamic email, dynamic mobileNo, context}) async {
    try {
      isdataLoading(true);

      var response = await http.post(Uri.parse(API.registerfastx),
          headers: API().headersWithoutToken,
          body: jsonEncode(<String, dynamic>{
            "name": name,
            "email": email,
            "mobileNo": mobileNo,
            "role": "consumer",
          }));

      print(response.statusCode);

      if (response.statusCode == 200) {
        // var result = jsonDecode(response.body);

        tokenapi(mobileNo: mobileNo, cntxt: context);

        print('Register successfully');

        AppUtils.showToast('Registered Successfully');

        // Get.snackbar(
        //   'Registered',
        //   'Successfully',
        //   backgroundColor: Customcolors.DECORATION_BLURORANGE,
        //   colorText: Customcolors.DECORATION_WHITE,
        //   snackPosition: SnackPosition.BOTTOM,
        // );
      } else {
        var ree = jsonDecode(response.body);

        AppUtils.showToast(ree['data']);

        Logger log = Logger();
        log.w(ree);

        Get.snackbar(
          'Something went wrong',
          '${regdetails["message"]}',
          backgroundColor: Customcolors.DECORATION_BLURORANGE,
          colorText: Customcolors.DECORATION_BLACK,
          snackPosition: SnackPosition.BOTTOM,
        );

        regdetails == null;
        print(response.body.toString());
      }
    } catch (e) {
      print("Its An Catch Error - $e");
    } finally {
      isdataLoading(false);
    }
  }

//token mobile
  var istokendataLoading = false.obs;
  Tokenmodel? tokendetails;

  /////////////////////////////////////////////////
  ///////////////// phone Number Token ////////////
  /////////////////////////////////////////////////

  void tokenapi({dynamic mobileNo, cntxt}) async {
    Location location = Location();

    try {
      istokendataLoading(true);

      var response = await http.post(Uri.parse(API.tokenfastx),
          headers: API().headersWithoutToken,
          body: jsonEncode(
              <String, dynamic>{"mobileNo": mobileNo, "role": "consumer"}));

      mobilenumb = mobileNo;

      var result = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode <= 202) {
        tokendetails = Tokenmodel.fromJson(result);
        print("tokendetails${result}");
        if (tokendetails!.status == true) {
          getStorage.write('username', tokendetails!.data.data.userName);
          getStorage.write("mobilenumb", tokendetails!.data.data.mobileNo);
          getStorage.write("Usertoken", tokendetails!.data.token);
          getStorage.write("UserId", tokendetails!.data.data.userId);
          getStorage.write("useremail", tokendetails!.data.data.email);

          UserId = getStorage.read("UserId");
          Usertoken = getStorage.read("Usertoken");
          username = getStorage.read('username');
          mobilenumb = getStorage.read('mobilenumb');
          useremail = getStorage.read('useremail');
          profileImgae = result!["data"]["data"]["imgUrl"].toString();

          updateLastSeen();

          Provider.of<InitializeFavProvider>(cntxt, listen: false)
              .favInitiliteProvider(cntxtt: cntxt);
          PermissionStatus permission = await location.hasPermission();
          var servicestatus = await location.serviceEnabled();

          if (permission == PermissionStatus.granted && servicestatus) {
            await Get.offAll(RequestPermissionPage(isEnabled: true),
                transition: Transition.upToDown);
          } else {
            await Get.offAll(RequestPermissionPage(isEnabled: false),
                transition: Transition.upToDown);
          }
        } else {
          //  Get.offAll(Loginscreen(),transition: Transition.leftToRight);

          Get.off(RegisterScreen(mobnumber: mobileNo),
              transition: Transition.leftToRight);
        }
      } else {
        tokendetails = null;

        var resss = jsonDecode(response.body);

        if (resss['message'] == "User Has Blocked By Admin") {
          AppUtils.showToast(resss['message']);

          CustomLogoutDialog.show(
            title: resss['data'],
            buttonname: 'Exit',
            content: resss['message'],
            context: cntxt,
            onConfirm: () {
              SystemNavigator.pop();
            },
            oncancel: () {
              Navigator.pop(cntxt);
            },
          );
        } else {
          // Get.offAll(Loginscreen(),transition: Transition.leftToRight);
          Get.off(RegisterScreen(mobnumber: mobileNo),
              transition: Transition.leftToRight);
        }
      }
      // ignore: empty_catches
    } catch (error) {
    } finally {
      istokendataLoading(false);
    }
  }

  /////////////////////////////////////////////////
  ///////////////// Email Token ///////////////////
  /////////////////////////////////////////////////

  //token email
  var isLoading = false.obs;
  Tokenmodel? tokenmaildetails;

  void tokenemailapi({dynamic email, cntxt}) async {
    // Location location = Location();

    print('Check...1');

    try {
      isLoading(true);

      print('Check...2');

      var response = await http.post(
        Uri.parse(API.tokenfastx),
        headers: API().headersWithoutToken,
        body: jsonEncode(<String, dynamic>{
          "email": email,
          "role": "consumer",
        }),
      );

      useremail = email;

      if (response.statusCode >= 200 && response.statusCode <= 202) {
        // Try parsing the response safely
        var result = jsonDecode(response.body);

        if (result['data'] != null) {
          // Store data in GetStorage
          getStorage.write("username", result['data']['data']?["userName"]);
          getStorage.write("useremail", result['data']['data']?['email']);
          getStorage.write("UserId", result['data']['data']?["userId"]);
          getStorage.write("Usertoken", result['data']?["token"]);
          getStorage.write('mobilenumb', result['data']['data']?["mobileNo"]);

          print('Check...4');

          // Retrieve data from GetStorage
          UserId = getStorage.read("UserId");
          Usertoken = getStorage.read("Usertoken");
          username = getStorage.read('username');
          email = getStorage.read('useremail');
          mobilenumb = getStorage.read('mobilenumb');

          updateLastSeen();

          Provider.of<InitializeFavProvider>(cntxt, listen: false)
              .favInitiliteProvider(cntxtt: cntxt);
          Get.offAll(RequestPermissionPage(isEnabled: true),
              transition: Transition.upToDown);
        } else {
          print('Check...5');

          // Handle case where 'data' is missing

          Get.off(RegisterScreen(user: email),
              transition: Transition.leftToRight);
        }
      } else {
        var resss = jsonDecode(response.body);

        if (resss['message'] == "User Has Blocked By Admin") {
          AppUtils.showToast(resss['message']);
        } else {
          Get.off(RegisterScreen(user: email),
              transition: Transition.leftToRight);
        }
      }
    } catch (e) {
      print('Exception occurred: $e');
    } finally {
      isLoading(false);
    }
  }

  /////////////////////////////////////////////////
  ///////////////// Update Last Seen //////////////
  /////////////////////////////////////////////////

  Future<void> updateLastSeen() async {
    DateTime now = DateTime.now();

    // Format the date and time as needed (e.g., ISO 8601 format)
    String formattedDateTime = now.toIso8601String();

    try {
      var response = await http.put(Uri.parse('${API.updateLastSeen}/$UserId'),
          headers: API().headers,
          body: jsonEncode(<String, dynamic>{
            "lastSeen": formattedDateTime,
            "fcmToken": tokenFCM
          }));

      if (response.statusCode >= 200 && response.statusCode <= 202) {
        print(DateTime.now().toString());
      } else {}
    } catch (e) {
      debugPrint('The Error is $e');
    }
  }

//  profile screen controller ....

  ProfileModel? profilege;

  String profileImageUrl = '';

  Future<void> fetchProfile(String image) async {
    print("oimageeee  $image");
    await Future.delayed(Duration(seconds: 0));
    profileImageUrl = image;
    print("syususs $profileImageUrl"); // triggers GetBuilder to rebuild
    update();
  }

  var isuserDataLoading = false.obs;
  Future<void> profileget() async {
    try {
      isuserDataLoading(true);
      final url = "${API.profileget}/$UserId";
      print('Fetching profile from $url');

      final response = await http.get(
        Uri.parse(url),
        headers: API().headers,
      );

      if (response.statusCode >= 200 && response.statusCode <= 202) {
        final result = jsonDecode(response.body);
        final userData = result['data'];
        profilege = ProfileModel.fromJson(result);

        getStorage.write("username", userData["name"] ?? "Unknown");
        getStorage.write("useremail", userData['email'] ?? "Unknown");
        getStorage.write('mobilenumb', userData['mobileNo'] ?? "Unknown");
      } else {}
    } catch (e) {
      print("Exception: $e");
    } finally {
      isuserDataLoading(false);
    }
  }

  //profile update

  var updateloading = false.obs;

  Future profileUpdate({
    dynamic name,
    dynamic email,
    dynamic mobilenumber,
    dynamic imageurl,
  }) async {
    // Create an empty map to hold the fields to update
    Map<String, dynamic> updateData = {};

    // Add name to the update map if it's not null
    if (name != null) {
      updateData['name'] = name;
    }

    // Add imageUrl to the update map if it's not null
    if (imageurl != null) {
      updateData['imgUrl'] = imageurl;
    }

    // If no data is provided, exit the function early
    if (updateData.isEmpty) {
      print("Nothing to update");
      return;
    }

    try {
      updateloading(true);

      var response = await http.put(
        Uri.parse("${API.profileupdate}/$UserId"),
        headers: API().headers,
        body: jsonEncode(updateData), // Only send fields that are being updated
      );

      print('Profile update response: ${response.statusCode}');

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        print(result["data"]["imgUrl"]);
        profileImgae = result["data"]["imgUrl"].toString();

        fetchProfile(result["data"]["imgUrl"].toString());
        profileget(); // Call profileget if the update is successful
      } else {
        profileget(); // Call profileget if the update is successful

        print('Error... ${response.statusCode}');
        print(response.body.toString());
      }
    } catch (e) {
      print("Error $e");
    } finally {
      updateloading(false);
    }
  }

  // account delete
  var deleteUserLoading = false.obs;
  Future profileDeleteUser() async {
    try {
      deleteUserLoading(true);

      var response = await http.delete(
        Uri.parse("${API.profileupdate}/$UserId"),
        headers: API().headers,
      );

      print('Profile deleted response: ${response.statusCode}');

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        print("profile delete res : $result");
        GoogleSignInApi.logout();

        ///====\\\====///\\\===|===|===|===|
        getStorage.remove("mobilenumb");

        ///====\\\====///\\\===|===|===|===|
        getStorage.remove("Usertoken");

        ///====\\\====///\\\===|===|===|===|
        getStorage.remove("UserId");

        ///====\\\====///\\\===|===|===|===|
        getStorage.remove("useremail");

        ///====\\\====///\\\===|===|===|===|
        getStorage.remove("username");

        ///====\\\====///\\\===|===|===|===|
        getStorage.remove("imgUrl");

        ///====\\\====///\\\===|===|===|===|
        addresscontroller.logout();

        ///====\\\====///\\\===|===|===|===|
        logoutfunction();
        newListData.clear();

        // SystemNavigator.pop();
        Get.offAll(SplashScreen(), transition: Transition.leftToRight);
      } else {
        print('Error... ${response.statusCode}');
        print(response.body.toString());
      }
    } catch (e) {
      print("Error $e");
    } finally {
      deleteUserLoading(false);
    }
  }
}
