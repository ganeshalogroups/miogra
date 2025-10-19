// ignore_for_file: file_names, avoid_print

import 'dart:async';

import 'package:testing/Features/Authscreen/AuthController/Logincontroller.dart';
import 'package:testing/Features/Authscreen/AuthController/Registercontroller.dart';
import 'package:testing/Features/Authscreen/Loginscreen.dart';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Categorylistcontroller.dart';
import 'package:testing/Features/Homepage/AddressController/Addresscontroller.dart';
import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Redirectcontroller.dart';
import 'package:testing/map_provider/Map%20Screens/markervaluse.dart';
import 'package:testing/map_provider/locationprovider.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Const/localvaluesmanagement.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  RegisterscreenController regcon = Get.put(RegisterscreenController());
  LoginscreenController logincon = Get.put(LoginscreenController());
  AddressController addresscontroller = Get.put(AddressController());
  RedirectController redirect =Get.put(RedirectController());

  Categorylistcontroller categorycontroller = Get.put(Categorylistcontroller());
  RegisterscreenController regi = Get.put(RegisterscreenController());

  late geo.Position position;
  LocationProvider locationProvider = LocationProvider();

  @override
  void initState() {
    checkForUpdate();
  _initializeSplash();
//           Timer(Duration(seconds: 1), () {
//       for (var item in redirect.redirectLoadingDetails["data"]) {
//   if (item["key"] == "imageUrlLink") {
//     globalImageUrlLink = item["value"]; // or item["url"] if that’s the correct key
//     break; // Optional: exit early after finding the match
//   }
//   print("globalimagee from splash${globalImageUrlLink}");
// }});
    super.initState();
    Future.delayed(
      const Duration(seconds: 1),
      () {
        Provider.of<MapDataProvider>(context, listen: false);
        _navigateToNextScreen();
      },
    );
    Timer(const Duration(seconds: 1), () {
      categorycontroller.categoryget();

    });
    Timer(const Duration(seconds: 4), () {
      regi.updateLastSeen();
    });

    checkForUpdate();
  }

  void _navigateToNextScreen() {
    mobilenumb = getStorage.read("mobilenumb");
    Usertoken = getStorage.read("Usertoken");
    UserId = getStorage.read("UserId");
    useremail = getStorage.read("useremail");

    
         addresscontroller.getaddressapi(context: context,latitude: "",longitude: "");

    if (mobilenumb != null) {
      regcon.tokenapi(mobileNo: mobilenumb, cntxt: context);
    } else {
      Get.off(const Loginscreen(), transition: Transition.leftToRight);
    }
  }

  void _initializeSplash() async {
  await redirect.getredirectDetails();

  var data = redirect.redirectLoadingDetails["data"];
  if (data != null && data is List) {
    for (var item in data) {
      if (item["key"] == "imageUrlLink" && item["value"] != null) {
        globalImageUrlLink = item["value"];
        print("Loaded globalImageUrlLink: $globalImageUrlLink");
        break;
      }
    }
  }

  // if (data != null && data is List) {
  //   for (var item in data) {
  //     if (item["key"] == "restaurantDistanceKm" && item["value"] != null) {
  //       kilometre = "${item["value"]} km";
  //       print("Loaded restaurantDistanceKm: $kilometre");
  //       break;
  //     }
  //   }
  // }
}

  AppUpdateInfo? updateInfo;

  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        if (info.updateAvailability == UpdateAvailability.updateAvailable) {
          update();
        } else {}
      });
    }).catchError((e) {
      print(e.toString());
    });
  }

  void update() async {
    await InAppUpdate.startFlexibleUpdate();
    InAppUpdate.completeFlexibleUpdate().then((_) {}).catchError((e) {
      print(e.toString());
    });
  }

  //  else if (useremail != null) {
  //   regcon.tokenemailapi(email: useremail,cntxt: context);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Customcolors.darkpurple,
      body: Container(
        // color: Customcolors.darkpurple,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
               Customcolors.lightpurple,
Customcolors.darkpurple
              // Color(0xFFF98322), // Color code for #F98322
              // Color(0xFFEE4C46), // End color
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 150,
                    child: Image.asset(
                    //  splashImage,
                    "assets/images/Miogra1.png",
                      color: Colors.white,
                    )),
                const CustomSizedBox(
                  height: 10,
                ),
                const Text(
                  "Your Comfort Food Companion",
                  style: CustomTextStyle.splashtext,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
