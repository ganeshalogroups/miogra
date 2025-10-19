

import 'package:testing/Features/Authscreen/AuthController/Logincontroller.dart';
import 'package:testing/Features/Authscreen/AuthController/Registercontroller.dart';
import 'package:testing/Features/Authscreen/Loginscreen.dart';
import 'package:testing/Features/Homepage/AddressController/Addresscontroller.dart';
import 'package:testing/map_provider/locationprovider.dart';
import 'package:testing/utils/Buttons/CustomButton.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

// ignore: must_be_immutable
class PermissionDenideScreen extends StatefulWidget {

  bool isPermanentlyDenied ;

   PermissionDenideScreen({super.key,this.isPermanentlyDenied = false});

  @override
  State<PermissionDenideScreen> createState() => _PermissionDenideScreenState();
}

class _PermissionDenideScreenState extends State<PermissionDenideScreen> {


  LocationProvider locationProvider = LocationProvider();
  RegisterscreenController regcon = Get.put(RegisterscreenController());
  LoginscreenController logincon = Get.put(LoginscreenController());
  AddressController addresscontroller = Get.put(AddressController());


  dynamic serviceEnabled;
  Future<bool> getPermission() async {
    Location location = Location();

    serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        await Geolocator.openAppSettings();
        return false;
      }
    }

    // Check and request location permission
    PermissionStatus permission = await location.hasPermission();

    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) {
        await Geolocator.openAppSettings();
        return false;
      }
    } else if (permission == PermissionStatus.deniedForever) {
      await Geolocator.openAppSettings();
      return false;
    }

    // Permission is granted
    return true;
  }

  void _navigateToNextScreen() {

    mobilenumb = getStorage.read("mobilenumb");
    Usertoken = getStorage.read("Usertoken");
    UserId = getStorage.read("UserId");
    useremail = getStorage.read("useremail");

    addresscontroller.getaddressapi(context: context,latitude: "",longitude: "");

    if (mobilenumb != null) {
      regcon.tokenapi(mobileNo: mobilenumb,cntxt: context);
    } else if (useremail != null) {
      regcon.tokenemailapi(email: useremail);
    } else {
      Get.off(const Loginscreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 2.8),
                  Image.asset('assets/images/splash1.png'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 8,
                  ),
                  const Text(
                    'Location & Permissions Required',
                    style: CustomTextStyle.splashpermissionTitle,
                  ),
                  const Spacer(),
                  CustomButton(
                    width: MediaQuery.of(context).size.width / 1,
                    borderRadius: BorderRadius.circular(30),
                    onPressed: ()  async{


                     


                  await  getPermission().then((permissionGranted) {
                          if (permissionGranted) {
                            // Execute your function here, now that permissions are granted
                            // For example:
                            LocationProvider()
                                .getCurrentLocation(context: context,isLocEnabled: false)
                                .whenComplete(() => _navigateToNextScreen());
                          } 
                      });
                    },
                    child: const Text(
                      'Allow',
                      style: CustomTextStyle.loginbuttontext,
                    ),
                  )
                ],
         )
      )
    );
  }
}



