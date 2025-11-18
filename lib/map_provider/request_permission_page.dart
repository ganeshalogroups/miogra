// ignore_for_file: library_private_types_in_public_api

import 'package:testing/Features/Authscreen/AuthController/controllerForFavAdd.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodhomepage.dart';
import 'package:testing/Features/Homepage/AddressController/Addresscontroller.dart';
import 'package:testing/Features/Homepage/homepage.dart';
import 'package:testing/map_provider/Map%20Screens/Address%20search.dart';
import 'package:testing/map_provider/Map%20Screens/MapSearch.dart/Manualsearchbottomsheet.dart';
import 'package:testing/map_provider/locationprovider.dart';
import 'package:testing/utils/Buttons/CustomButton.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/Const/localvaluesmanagement.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'AddressProvider/addressProvider.dart';

// ignore: must_be_immutable
class RequestPermissionPage extends StatefulWidget {
  bool isEnabled;

  RequestPermissionPage({super.key, required this.isEnabled});

  @override
  _RequestPermissionPageState createState() => _RequestPermissionPageState();
}

class _RequestPermissionPageState extends State<RequestPermissionPage> with WidgetsBindingObserver {
   
   bool isLoading = false;
  //  Bannerlistcontroller bannerlist = Get.put(Bannerlistcontroller());
  AddressController addresscontroller = Get.put(AddressController());


  @override
  void initState() {
    super.initState();
    if (widget.isEnabled) {

      WidgetsBinding.instance.addPostFrameCallback((_) {

        setState(() {
          isLoading = true;
        });

        // bannerlist.bannerget();
        // bannerlist.bottmbannerget();
        getLocationAndNavigate(context);
        
      });
    } else {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1)); // Ensure widget renders
    checkIfLocationExistsAndNavigate(context);
  });
     }
  }


// void checkIfLocationExistsAndNavigate(BuildContext context) {
//   final mapData = Provider.of<MapDataProvider>(context, listen: false).llcldta;

//   final double lat = (mapData['latitude'] ?? 0).toDouble();
//   final double lng = (mapData['longitude'] ?? 0).toDouble();

//   if (lat != 0 && lng != 0) {
//     // Already have a saved location → skip permission screen
//     Future.delayed(Duration.zero, () {
//       Get.offAll(() => const HomeScreenPage(), transition: Transition.leftToRight);
//     });
//   }
// }
void checkIfLocationExistsAndNavigate(BuildContext context) {
  final mapData = Provider.of<MapDataProvider>(context, listen: false).llcldta;

  final double lat = (mapData['latitude'] ?? 0).toDouble();
  final double lng = (mapData['longitude'] ?? 0).toDouble();

  if (lat != 0 && lng != 0) {
    // Already have a saved location → skip permission screen
    Future.delayed(Duration.zero, () {
      Get.offAll(() => const Foodscreen(categoryFilter: "restaurant",), transition: Transition.leftToRight)!.whenComplete(() {
    // Get.offAll(() => const HomeScreenPage(), transition: Transition.leftToRight)!.whenComplete(() {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      });
    });
  } else {
    if (mounted) {
      setState(() {
        isLoading = false; // Hide loader if no location found
      });
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // 🔴 THIS IS IMPORTANT
      backgroundColor: const Color(0xffFFFFFF),
      body: isLoading
          ? Center(
             // child: Image.asset("assets/images/SplashLoading.gif",color: const Color.fromARGB(255, 40, 36, 34), height: 220)
              child: Image.asset("assets/images/SplashLoading.gif",color: 
 Customcolors.darkpurple, height: 220)
              // LottieBuilder.asset(spoonLoadion, height: 200),
            )
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(locationBanner),
                  SizedBox(height: 60.h),
                  const Text( 'Set your location to unlock nearby food experiences you’ll love!',
                    style: CustomTextStyle.splashpermissionTitle,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40.h),
                  CustomButton(
                    width: MediaQuery.of(context).size.width / 1.2,
                    borderRadius: BorderRadius.circular(5),
                    onPressed: () {
                      getLocationAndNavigate(context);
                    },
                    child: const Text(
                      'Continue',
                      style: CustomTextStyle.loginbuttontext,
                    ),
                  ),
                  const SizedBox(height: 15,),
                  // CustomButton(
                  //   width: MediaQuery.of(context).size.width / 1,
                  //   borderRadius: BorderRadius.circular(30),
                  //   onPressed: () {
                  //     showAddressSearchBottomSheet(context);
                  //   },
                  //   child: Text(
                  //     'Enter your Location Manually',
                  //     style: CustomTextStyle.loginbuttontext,
                  //   ),
                  // ),
                 GestureDetector(
                 onTap: () {
                   showAddressSearchBottomSheet(context);
                 },
                   child: Container(
                     height: 44,
                     width: MediaQuery.of(context).size.width/1.2,
                     decoration: BoxDecoration(
                     //  border: Border.all(color: Colors.orange),
                       border: Border.all(color: 
Customcolors.darkpurple,),
                       borderRadius: BorderRadius.circular(5),
                     ),
                     child: Center(
                       child: Text(
                         'Enter your Location Manually',
                         style: CustomTextStyle.orangeeetext,
                         textAlign: TextAlign.center,
                       ),
                     ),
                   ),
                 ),


                  SizedBox(height: 15.h),
                ],
              ),
            ),
    );
  }
void showAddressSearchBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      final screenHeight = MediaQuery.of(context).size.height;

      return Stack(
        clipBehavior: Clip.none,
        children: [
          /// Bottom Sheet Container with fixed height
          Container(
            margin: const EdgeInsets.only(top: 30), // Space for floating button
            height: screenHeight * 0.8, // 80% of screen height
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: MediaQuery.removeViewInsets(
              removeBottom: true,
              context: context,
              child: SingleChildScrollView(
                child: BottomsheetSearchScreen(),
              ),
            ),
          ),

          /// Floating Close Button
          Positioned(
             top: -40,
              right: 0,
              left: 0,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black87,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.close, color: Colors.white),
              ),
            ),
          ),
        ],
      );
    },
  );
}


  Location location   = Location();
  bool serviceEnabled = false;
  PermissionStatus? grantedPermission;



  Future<bool> checkPermission() async {
    if (await checkService()) {
      grantedPermission = await location.hasPermission();
      if (grantedPermission == PermissionStatus.denied || grantedPermission == PermissionStatus.deniedForever) {
          
        grantedPermission = await location.requestPermission();
      }

      if (grantedPermission == PermissionStatus.deniedForever) {
        await Geolocator.openAppSettings();
        return false;
      }
    }
    return grantedPermission == PermissionStatus.granted;
  }

  Future<bool> checkService() async {
    try {
      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
      }
    } on PlatformException catch (error) {
      debugPrint('Error code: ${error.code}, message: ${error.message}');
      serviceEnabled = false;
    }
    return serviceEnabled;
  }

  Future<bool> checkBothServices() async {
    bool permissionGranted = await checkPermission();
    if (permissionGranted) {
      bool serviceAvailable = await checkService();
      return serviceAvailable;
    }
    return false;
  }

// new method

  void getLocationAndNavigate(context) async {

    try {
      var mapDataProvider    =  Provider.of<MapDataProvider>(context, listen: false);
      final locationProvider =  Provider.of<LocationProvider>(context, listen: false);
      var addresProvider     =  Provider.of<GetAddressProvider>(context, listen: false);
         

      Future.delayed(
        Duration.zero,
        () async {
          await checkBothServices().then((permissions) async {
            if (permissions) {
              setState(() {
                isLoading = true;
              });


              await addresProvider.getAddresProvider();

              await locationProvider.getCurrentLocation(context: context, isLocEnabled: permissions).then((value) {
                  
                if (locationProvider.position.latitude == 0 &&  locationProvider.position.longitude == 0) {
                  
                  setState(() {
                    isLoading = false;
                  });


                } else {

                  Future.delayed(const Duration(seconds: 2), () {

                    List<dynamic> addResss  = addresProvider.addRess;
                    double shortestDistance =  double.infinity; // Initialize with a very large number
                    Map<String, dynamic>? nearestAddress;
                    List<Map<String, dynamic>> addresses = addResss.map((address) => address as Map<String, dynamic>).toList();
                        
                        

                    for (int i = 0; i < addresses.length; i++) {
                      double lati = addresses[i]['latitude'];
                      double longi = addresses[i]['longitude'];

                      double distance = Geolocator.distanceBetween(
                        locationProvider.position.latitude,
                        locationProvider.position.longitude,
                        lati,
                        longi,
                      );

                      // Check if this distance is the shortest
                      if (distance < shortestDistance) {
                        shortestDistance = distance;
                        nearestAddress = addresses[i];
                      }
                    }

                    if (nearestAddress != null && shortestDistance < 50) {

                      mapDataProvider.updateMapData(
                        addresstype  : nearestAddress['addressType'],
                        statee       : nearestAddress['state'],
                        contactpersionNo: mobilenumb,
                        contacypersion: username,
                        fulladdres   : nearestAddress['fullAddress'],
                        houseno      : nearestAddress['houseNo'],
                        landmark     : nearestAddress['landMark'],
                        localiti     : nearestAddress['locality'],
                        postalcode   : nearestAddress['postalCode'],
                        streett      : nearestAddress['street'],
                        latitude     : nearestAddress['latitude'],
                        longitude    : nearestAddress['longitude'],
                        otheristructions : nearestAddress['instructions'],
                      )
                          .whenComplete(() {


                              addresscontroller.updateaddressapi(addressid: nearestAddress!['_id']);
                              InitializeFavProvider().favInitiliteProvider(cntxtt: context);
                            

                        if (mounted) {

                          Get.offAll(const Foodscreen(categoryFilter: "restaurant",), transition: Transition.fade) ?.whenComplete(() {
                         // Get.offAll(const HomeScreenPage(), transition: Transition.fade) ?.whenComplete(() {
                                 
                            if (mounted) {
                              setState(() {
                                isLoading = false;
                              });
                            }

                          });
                        }
                      });


                    } else {


                          String fullAddress = [
                            locationProvider.address.street,
                            locationProvider.address.subLocality,
                            locationProvider.address.locality,
                            locationProvider.address.administrativeArea,
                            locationProvider.address.postalCode,
                            locationProvider.address.country
                          ]
                          .where((part) => part != null && part.isNotEmpty).join(', ');
                          

                      mapDataProvider.updateMapData(
                        addresstype: 'Current',
                        statee: locationProvider.address.street,
                        contactpersionNo: mobilenumb,
                        contacypersion: username,
                        fulladdres: fullAddress,
                        houseno: locationProvider.address.street,
                        landmark: locationProvider.address.subLocality,
                        localiti: locationProvider.address.locality,
                        postalcode: locationProvider.address.postalCode,
                        streett  : locationProvider.address.street,
                        latitude  : locationProvider.position.latitude,
                        longitude: locationProvider.position.longitude,
                      ).whenComplete(() {
                          
                        Provider.of<InitializeFavProvider>(context,listen: false).favInitiliteProvider(cntxtt: context);
                        // InitializeFavProvider().favInitiliteProvider(cntxtt: context);
                        GetAddressProvider().getAddresProvider();

                        if (mounted) {

                         Get.offAll(const Foodscreen(categoryFilter: "restaurant",),transition: Transition.fade) ?.whenComplete(() {
                      //   Get.offAll(const HomeScreenPage(), transition: Transition.fade)?.whenComplete(() {

                            if (mounted) {
                              setState(() {
                                isLoading = false;
                              });
                            }


                          });
                        }
                      });
                    }
                  });
                }
              });
            }
          });
        },
      );


    } catch (e) {
      debugPrint('Error: xx $e');
    }
  }
}
