// // my new fixed code

// // ignore_for_file: unused_field, unused_local_variable, prefer_final_fields, avoid_print, prefer_typing_uninitialized_variables, unnecessary_null_comparison

// import 'package:animated_visibility/animated_visibility.dart';
// import 'package:flutter/widgets.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
// import 'package:testing/Features/Authscreen/AuthController/Registercontroller.dart';
// import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Addfoodcontroller.dart';
// import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Bannercontroller.dart';
// import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Categorylistcontroller.dart';
// import 'package:testing/Features/Foodmodule/SubAdmincontroller/Inactiverescontroller.dart';
// import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodhomepage.dart';
// import 'package:testing/Features/Foodmodule/SubAdmincontroller/Getnearbyrescontroller.dart';
// import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodsearch.dart';
// import 'package:testing/Features/Foodmodule/getFoodCartProvider.dart';
// import 'package:testing/Features/Homepage/Profile_Orders/Advertisement.dart';
// import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Advertisementcontroller.dart';
// import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Chatbotcontroller.dart';
// import 'package:testing/Features/Homepage/homescreenpage.dart';
// import 'package:testing/Mart/Homepage/MartHomepage.dart';
// import 'package:testing/Meat/Homepage/Meathomepage.dart';
// import 'package:testing/Meat/MeatSearch/MeatTextformfield.dart';
// import 'package:testing/common/commonRotationalTextWidget.dart';
// import 'package:testing/map_provider/Map%20Screens/Address%20search.dart';
// import 'package:testing/map_provider/Map%20Screens/MapSearch.dart/addressnameController.dart';
// import 'package:testing/map_provider/Map%20Screens/MapSearch.dart/homeadresskey.dart';
// import 'package:testing/map_provider/Map%20Screens/circleradious.dart';
// import 'package:testing/map_provider/Map%20Screens/markervaluse.dart';
// import 'package:testing/Features/Homepage/profile.dart';
// import 'package:testing/map_provider/circle_marker.dart';
// import 'package:testing/map_provider/location/locationServices/onlylocationpermission.dart';
// import 'package:testing/map_provider/locationprovider.dart';
// import 'package:testing/parcel/parcel_home.dart';
// import 'package:testing/utils/Buttons/CustomTextstyle.dart';
// import 'package:testing/utils/Const/ApiConstvariables.dart';
// import 'package:testing/utils/Const/constValue.dart';
// import 'package:testing/utils/Const/localvaluesmanagement.dart';
// import 'package:testing/utils/Containerdecoration.dart';
// import 'package:testing/utils/CustomColors/Customcolors.dart';
// import 'package:testing/utils/Shimmers/Restaurantshimmer.dart';
// import 'package:testing/utils/Urlist.dart';
// import 'package:testing/utils/addAddressFun.dart';
// import 'package:testing/utils/exitapp.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:provider/provider.dart';

// //places
// // int selectedIndex = 0;
// class HomeScreenPage extends StatefulWidget {
//   final bool isfrommanualsearchaddress;
//   const HomeScreenPage({super.key, this.isfrommanualsearchaddress = false});

//   @override
//   State<HomeScreenPage> createState() => _HomeScreenPageState();
// }

// class _HomeScreenPageState extends State<HomeScreenPage>
//     with
//         SingleTickerProviderStateMixin,
//         AutomaticKeepAliveClientMixin<HomeScreenPage> {
//   @override
//   bool get wantKeepAlive => true;

//   TextEditingController mapsearchcontroller = TextEditingController();
//   TextEditingController localitycontroller = TextEditingController();
//   TextEditingController streetcontroller = TextEditingController();
//   TextEditingController pincodecontroller = TextEditingController();
//   TextEditingController statecontroller = TextEditingController();

//   RegisterscreenController getProfile = Get.put(RegisterscreenController());
//   Categorylistcontroller categorycontroller = Get.put(Categorylistcontroller());
//   Nearbyrescontroller nearbyreget = Get.put(Nearbyrescontroller());
//   Inactiverescontroller inactiverestt = Get.put(Inactiverescontroller());
//   Foodcartcontroller foodcart = Get.put(Foodcartcontroller());
//   RegisterscreenController regi = Get.put(RegisterscreenController());
//   HomeadresskeyController homeaddress = Get.put(HomeadresskeyController());
//   Chatbotcontroller chathealthchecking = Get.put(Chatbotcontroller());
//    AdvertisementController advertise = Get.put(AdvertisementController());
//   int nearbyrespage = 0;

//   // var latpass;
//   // var lngpass;

//  // Initially, no container is selected
//   // int selectedIndex = 0;
//   bool _showButton = true;
//   bool drag = true;
//   bool _isFullyExpanded = false;
//   bool isLocationDifferent = false;
//   bool _isSheetVisible = true;

//   String? country = 'india';

//   late DraggableScrollableController _draggableController;

//   // GoogleMapController _controller;
//   GoogleMapController? _controller;

//   final Set<Circle> _circles = {};
//   Set<Marker> markersList = {};

//   // final Mode _mode = Mode.overlay;

//  List<Map<String,dynamic>> explore_items = [{"name":"Restaurant","description":"Because Every Parcel \nMatters","content":"Delivery in 15mins","img":"assets/images/restaurant_image.png.png"},
// {"name":"Shop","description":"Groceries Made Easy,\nDelivered With Love","content":"Up to 60% OFF","img":"assets/images/shop_image.png.png"} ];

//   final List<LatLng> polylinePoints = [];
//   final Set<Polyline> polylines = {};
//   final List<Marker> markers = <Marker>[];

//   bool isWithinCircle = true; // Track if the camera is within the circle
//   int currentHintIndex = 0;

//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       // categorycontroller.categoryget();
//        advertise.getadvertisementDetails();
//       getProfile.profileget();
//       regi.fetchProfile(profileImgae);
//       // addinitalmarker();
//       getResturantIdFun();
//       Provider.of<HomepageProvider>(context, listen: false).getHomepagedatas();

//       foodcart.getbillfoodcartfood(km: 0);
//       var foodcartprovider =
//           Provider.of<FoodCartProvider>(context, listen: false);

//       nearbyreget.nearbyresPagingController.refresh();

//       inactiverestt.inactiveresget();

//       homeaddress.gethomeadresskeyDetails();
//       chathealthchecking.getachatstatusDetails();
//       // getloc();
//       await Provider.of<LocationProvider>(context, listen: false)
//           .loadInitialAddressFromSavedData(context);

//     });

//     _isSheetVisible = true;
//     _draggableController = DraggableScrollableController();
//     super.initState();
//   }

//   getResturantIdFun() {
//     Future.delayed(
//       Duration.zero,
//       () async {
//         final foodcartprovider =
//             Provider.of<FoodCartProvider>(context, listen: false);

//         var resID = await foodcartprovider.getfoodcartProvider(km: 0);

//         if (resID != null) {
//           foodcartprovider.searchResById(restaurantId: resID);
//         } else {
//           print('No Restaurant Available...!');
//         }
//       },
//     );
//   }

//   @override
//   void dispose() {
//     _draggableController.dispose();
//     _controller?.dispose();
//     super.dispose();
//   }

//   var address;
//   // final List<Marker> markers = <Marker>[];
//   bool iscurrentlocationGot = false;
//   bool canPop = true;
//   Position? currentPosition;
//   bool isloading = false;

//   addRandomMarker({latitude, longitude}) async {
//     markersList.clear();
//     markersList.add(
//       Marker(
//         markerId: const MarkerId('current_location'),
//         position: LatLng(latitude, longitude),
//         visible: true,
//         draggable: true,
//         icon: await getDotMarker(),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//   // List<dynamic> categories = ["shop", ...categorycontroller.category["data"]];
// List<Map<String, dynamic>> categories =
//     List<Map<String, dynamic>>.from(categorycontroller.category["data"]);

//    categories.insert(1,{"status": true, "productName":"SHOP","productType":"shop"});

//     var locationProvider =
//         Provider.of<LocationProvider>(context, listen: false);
//     var mapDataProvider = Provider.of<MapDataProvider>(context);
//     final foodcartprovider = Provider.of<FoodCartProvider>(context);

//     Size screenSize = MediaQuery.of(context).size;
//     double scrollSize = screenSize.height;
//   final num =  Get.put(Nearbyrescontroller());
//     return PopScope(
//       canPop: false,
//       onPopInvoked: (bool didPop) async {
//         _controller
//             ?.animateCamera(
//           CameraUpdate.newCameraPosition(
//             CameraPosition(
//               target: LatLng(initiallat, initiallong),
//               zoom: 18,
//             ),
//           ),
//         )
//             .whenComplete(() {
//           setState(() {
//             _isSheetVisible = true;
//           });
//         });

//         if (didPop) return;

//         if (_isSheetVisible = true) {
//           await ExitApp.handlePop();
//         }
//       },
//       child: Scaffold(
//         backgroundColor: Color(0xFFA14DDE),
//         // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//         // floatingActionButton: _isFullyExpanded
//         //     ? GestureDetector(
//         //         child: SizedBox(
//         //           height: 30.h,
//         //           width: 70.w,
//         //           child: FloatingActionButton(
//         //             shape: RoundedRectangleBorder(
//         //                 borderRadius: BorderRadius.circular(25)),
//         //             elevation: 5,
//         //             //   backgroundColor: const Color.fromRGBO(245, 92, 36, 0.792),
//         //             backgroundColor: Customcolors.lightpurple,

//         //             onPressed: () {
//         //               setState(() {
//         //                 _isFullyExpanded = false;
//         //               });

//         //               _draggableController.animateTo(0.4,
//         //                   duration: const Duration(milliseconds: 200),
//         //                   curve: Curves.easeOut);
//         //             },
//         //             child: Icon(
//         //               MdiIcons.arrowCollapseUp,
//         //               size: 17,
//         //               color: Customcolors.DECORATION_WHITE,
//         //             ),
//         //           ),
//         //         ),
//         //       )
//         //     : null,

//         body: Stack(children: [
//                                                // Background Map

//           // AnimatedSize(
//           //   duration: const Duration(milliseconds: 300),
//           //   reverseDuration: const Duration(milliseconds: 300),
//           //   child: SizedBox(
//           //     height: _isSheetVisible
//           //         ? MediaQuery.of(context).size.height / 1.1
//           //         : MediaQuery.of(context).size.height / 1,
//           //     width: MediaQuery.of(context).size.width,
//           //     child: Consumer<LocationProvider>(
//           //       builder: (context, locationProvider, child) => Stack(
//           //         children: [
//           //           Builder(builder: (context) {
//           //             return GoogleMap(
//           //               mapType: MapType.normal,
//           //               initialCameraPosition: CameraPosition(
//           //                 target: LatLng(initiallat, initiallong),
//           //                 zoom: 18.0,
//           //               ),
//           //               // style: mapst,
//           //               polylines: isWithinCircle ? polylines : {},
//           //               markers: locationProvider.markers,
//           //               myLocationButtonEnabled: true,
//           //               myLocationEnabled: false,
//           //               zoomControlsEnabled: false,
//           //               compassEnabled: false,
//           //               indoorViewEnabled: false,
//           //               mapToolbarEnabled: false,
//           //               onCameraIdle: () {
//           //                 locationProvider.dragableAddress();
//           //               },

//           //               onCameraMoveStarted: () {
//           //                 _isSheetVisible = false;
//           //               },

//           //               onCameraMove: (position) {
//           //                 final currentLat = position.target.latitude;
//           //                 final currentLng = position.target.longitude;

//           //                 double distance = calculateDistance(
//           //                     currentLat,
//           //                     currentLng,
//           //                     locationProvider.currentL,
//           //                     locationProvider.currentLon);

//           //                 if (distance <= 100) {
//           //                   if (polylinePoints.length == 1) {
//           //                     polylinePoints.add(position.target);
//           //                   } else if (polylinePoints.length == 2) {
//           //                     polylinePoints[1] = position.target;
//           //                   } else {
//           //                     polylinePoints.clear();
//           //                     polylinePoints.add(LatLng(
//           //                         locationProvider.currentL!,
//           //                         locationProvider.currentLon!));
//           //                     polylinePoints.add(position.target);
//           //                   }

//           //                   setState(() {
//           //                     isWithinCircle = true;
//           //                     isLocationDifferent = false;
//           //                   });

//           //                   polylines.add(
//           //                     Polyline(
//           //                       patterns: [
//           //                         PatternItem.gap(10),
//           //                         PatternItem.dot
//           //                       ],
//           //                       polylineId: const PolylineId('route'),
//           //                       points: polylinePoints,
//           //                       color: Colors.black,
//           //                       width: 4,
//           //                     ),
//           //                   );
//           //                 } else {
//           //                   setState(() {
//           //                     isLocationDifferent = true;
//           //                     isWithinCircle = false;
//           //                   });
//           //                 }

//           //                 locationProvider.updatePosition(position);
//           //               },

//           //               onMapCreated: (GoogleMapController controller) async {
//           //                 _controller = controller;
//           //               },
//           //             );
//           //           }),
//           //           Container(
//           //             width: MediaQuery.of(context).size.width,
//           //             alignment: Alignment.center,
//           //             height: _isSheetVisible
//           //                 ? MediaQuery.of(context).size.height / 1.18
//           //                 : MediaQuery.of(context).size.height / 1.08,
//           //             child: Image.asset(
//           //               pinmarker,
//           //               width: 40,
//           //               height: 40,
//           //               fit: BoxFit.contain,
//           //               //  color: Colors.redAccent,
//           //               color: Customcolors.darkpurple
//           //             ),
//           //           ),
//           //           Positioned(
//           //             bottom: _isSheetVisible
//           //                 ? MediaQuery.of(context).size.height / 2.5
//           //                 : 100,
//           //             right: 0,
//           //             left: 0,
//           //             child: Column(
//           //               crossAxisAlignment: CrossAxisAlignment.end,
//           //               children: [
//           //                 InkWell(
//           //                   onTap: () async {
//           //                     bool permissionGranted =
//           //                         await OnlyLocationPermission.instance
//           //                             .checkAndRequestLocationPermission(
//           //                                 context);
//           //                     if (permissionGranted) {
//           //                       await locationProvider.getCurrentLocation(
//           //                           context: context,
//           //                           isLocEnabled: false,
//           //                           mapController: _controller);
//           //                     }
//           //                   },
//           //                   child: Container(
//           //                     width: 35,
//           //                     height: 35,
//           //                     margin: const EdgeInsets.only(right: 20),
//           //                     decoration: const BoxDecoration(
//           //                       shape: BoxShape.circle,
//           //                       color: Colors.white,
//           //                     ),
//           //                     child: const Icon(
//           //                       Icons.my_location,
//           //                       size: 30,
//           //                     ),
//           //                   ),
//           //                 ),
//           //               ],
//           //             ),
//           //           ),
//           //         ],
//           //       ),
//           //     ),
//           //   ),
//           // ),

//           Visibility(
//             visible: _isSheetVisible,
//             child: Positioned(
//               top: 50,
//               left: 10,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [

//                           //Address Showing

//                   Container(
//                     width: MediaQuery.of(context).size.width * 0.76,
//                     height: MediaQuery.of(context).size.height * 0.085,

//                   //  decoration: CustomContainerDecoration.boxshadowdecoration(),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: InkWell(
//                               onTap: () {
//                                 Get.to(AddressSearchScreen(),
//                                     transition: Transition.rightToLeft,
//                                     duration:
//                                         const Duration(milliseconds: 200));
//                               },
//                               child: Consumer<LocationProvider>(
//                                 builder: (context, value, child) {
//                                   if (value.isloading == true) {
//                                     return const CupertinoActivityIndicator();
//                                   } else if (value.fullAddresss == null) {
//                                     return const Text(' No Data ');
//                                   } else {
//                                     return Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           vertical: 5),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceAround,

//                                         children: [
//                                           Row(crossAxisAlignment: CrossAxisAlignment.center,
//                                             children: [
//                                             IconButton(
//                                                  padding: EdgeInsets.zero, // 👈 removes extra padding from IconButton
//             constraints: const BoxConstraints(), // 👈 makes IconButton shrink-wrap
//                                                                       onPressed: () {
//                                                                         String fullAddress = [
//                                                                           locationProvider.address.street,
//                                                                           locationProvider.address.subLocality,
//                                                                           locationProvider.address.locality,
//                                                                           locationProvider.address.administrativeArea,
//                                                                           locationProvider.address.postalCode,
//                                                                           locationProvider.address.country
//                                                                         ]
//                                                                             .where(
//                                                                                 (part) => part != null && part.isNotEmpty)
//                                                                             .join(', ');

//                                                                         addAddressBottomSheet(
//                                                                           context: context,
//                                                                           address: fullAddress,
//                                                                           locality: locationProvider.address.locality,
//                                                                           country: locationProvider.address.country,
//                                                                           state:
//                                                                               locationProvider.address.administrativeArea,
//                                                                           pincode: locationProvider.address.postalCode,
//                                                                           street: locationProvider.address.street,
//                                                                           lattitude: locationProvider.position.latitude,
//                                                                           longitude: locationProvider.position.longitude,
//                                                                           ishomescreen: true,
//                                                                         );
//                                                                       },
//                                                                       icon: Image.asset(othersicon, scale: 3,color: Colors.white,),
//                                                                       //  const Icon(Icons.location_pin),
//                                                                     ),

//                                               Text(mapDataProvider.addressType,
//                                                   style: CustomTextStyle
//                                                       .smallheadtext),

//                                                       IconButton(onPressed: (){}, icon: Icon(Icons.keyboard_arrow_down_sharp,color: Colors.white,))

//                                             ],
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.only(left: 8.0),
//                                             child: Text(
//                                               value.fullAddresss,
//                                               maxLines: 1,
//                                               style:
//                                              TextStyle(
//     fontSize: 12,
//     fontWeight: FontWeight.w300,
//    // color: Customcolors.DECORATION_WHITE,
//   color: Customcolors.DECORATION_WHITE,
//     fontFamily: 'Poppins-Medium',
//   ),
//                                                //   CustomTextStyle.smallblacktext,
//                                               overflow: TextOverflow.ellipsis,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   }
//                                 },
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 12),

//                         ],
//                       ),
//                     ),
//                   ),

//                                   // Profile Image

//                  const SizedBox(width: 10),

//  InkWell(
//                     onTap: () {
//                       regi.fetchProfile(profileImgae);
//                       Get.to(const ProfileScreen(),
//                           transition: Transition.leftToRight,
//                           duration: const Duration(milliseconds: 250),
//                           curve: Curves.easeInOut);
//                     },
//                     child: Container(
//                       width: MediaQuery.of(context).size.width * 0.13,
//                       height: MediaQuery.of(context).size.width * 0.13,

//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: const Color.fromRGBO(254, 236, 227, 8),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             spreadRadius: 2,
//                             blurRadius: 5,
//                             offset: const Offset(0, 1),
//                           ),
//                         ],
//                       ),

//                       child: GetBuilder<RegisterscreenController>(
//                         builder: (controller) {
//                           final hasProfileImage =
//                               controller.profileImageUrl.isNotEmpty;

//                           return Center(
//                             child: CircleAvatar(
//                               radius: 40,
//                               backgroundColor: Colors.blue.shade100,
//                               child: ClipOval(
//                                 child: SizedBox(
//                                   height: 115,
//                                   width: 115,
//                                   child: hasProfileImage && UserId != null
//                                       ? Image.network(
//                                           controller.profileImageUrl,
//                                           key: ValueKey(controller
//                                               .profileImageUrl), // Helps force rebuild
//                                           fit: BoxFit.cover,
//                                           errorBuilder:
//                                               (context, error, stackTrace) {
//                                             return Image.asset(
//                                               "assets/images/Profile.png",
//                                               fit: BoxFit.cover,
//                                             );
//                                           },
//                                         )
//                                       : Image.asset(
//                                           "assets/images/Profile.png",
//                                           key: const ValueKey(
//                                               'default'), // Force rebuild when profileImageUrl is empty
//                                           fit: BoxFit.cover,
//                                         ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ),

//                 ],
//               ),
//             ),
//           ),
//           _isSheetVisible
//               ? const SizedBox()
//               : SizedBox(),
// //Map Location  Bottom button

//               // : Positioned(
//               //     left: 0,
//               //     right: 0,
//               //     bottom: 20,
//               //     child: Center(
//               //       child: Padding(
//               //         padding: const EdgeInsets.all(8.0),
//               //         child: isloading
//               //             ? Container(
//               //                 width: MediaQuery.of(context).size.width * 0.9,
//               //                 height: 50,
//               //                 decoration: CustomContainerDecoration
//               //                     .gradientbuttondecoration(),
//               //                 child: const CupertinoActivityIndicator(),
//               //               )
//               //             : Center(
//               //                 child: Container(
//               //                   width: MediaQuery.of(context).size.width * 0.9,
//               //                   decoration: CustomContainerDecoration
//               //                       .gradientbuttondecoration(),
//               //                   child: ElevatedButton(
//               //                     onPressed: () {
//               //                       var getAddressDetails =
//               //                           Provider.of<AddressNameController>(
//               //                               context,
//               //                               listen: false);

//               //                       setState(() {
//               //                         _isSheetVisible = true;
//               //                       });

//               //                       String fullAddress = [
//               //                         locationProvider.address.street,
//               //                         locationProvider.address.subLocality,
//               //                         locationProvider.address.locality,
//               //                         locationProvider
//               //                             .address.administrativeArea,
//               //                         locationProvider.address.postalCode,
//               //                         locationProvider.address.country
//               //                       ]
//               //                           .where((part) =>
//               //                               part != null && part.isNotEmpty)
//               //                           .join(', ');

//               //                       mapDataProvider.updateMapData(
//               //                         addresstype: 'Current',
//               //                         statee:
//               //                             locationProvider.address.subLocality,
//               //                         contactpersionNo: mobilenumb,
//               //                         contacypersion: username,
//               //                         fulladdres: fullAddress,
//               //                         houseno: locationProvider.address.street,
//               //                         landmark:
//               //                             locationProvider.address.subLocality,
//               //                         localiti:
//               //                             locationProvider.address.locality,
//               //                         postalcode:
//               //                             locationProvider.address.postalCode,
//               //                         streett: locationProvider.address.street,
//               //                         latitude:
//               //                             locationProvider.position.latitude,
//               //                         longitude:
//               //                             locationProvider.position.longitude,
//               //                       );

//               //                       locationProvider.updateMarker(
//               //                           latitude:
//               //                               locationProvider.position.latitude,
//               //                           longitude: locationProvider
//               //                               .position.longitude);

//               //                       addRandomMarker(
//               //                           latitude:
//               //                               locationProvider.position.latitude,
//               //                           longitude: locationProvider
//               //                               .position.longitude);

//               //                       foodcartprovider.getfoodcartProvider(
//               //                           km: '5');

//               //                       Get.to(
//               //                           Foodscreen(
//               //                             isfrommanualsearchaddress:
//               //                                 widget.isfrommanualsearchaddress,
//               //                           ),
//               //                           transition: Transition.leftToRight);
//               //                     },
//               //                     style: ElevatedButton.styleFrom(
//               //                       backgroundColor: Colors.transparent,
//               //                       shadowColor: Colors.transparent,
//               //                     ),
//               //                     child: const Text(
//               //                       'Confirm Location',
//               //                       style: TextStyle(
//               //                           color: Customcolors.DECORATION_WHITE,
//               //                           fontFamily: 'Poppins-Regular'),
//               //                     ),
//               //                   ),
//               //                 ),
//               //               ),
//               //       ),
//               //     )),

// // Map back button in top

//           // AnimatedVisibility(
//           //   enterDuration: const Duration(milliseconds: 500),
//           //   exitDuration: const Duration(milliseconds: 500),
//           //   visible: _isSheetVisible == false,
//           //   enter: slideInVertically(
//           //       initialOffsetY: -1, curve: Curves.fastEaseInToSlowEaseOut),
//           //   exit: slideOutVertically(
//           //       targetOffsetY: -1, curve: Curves.fastEaseInToSlowEaseOut),
//           //   child: SizedBox(
//           //     // color: Colors.amber,
//           //     height: screenSize.height * 0.25,
//           //     child: Stack(
//           //       children: [
//           //         Column(
//           //           children: [
//           //             Container(
//           //               // height: MediaQuery.of(context).size.height * 0.11,
//           //               width: double.infinity,
//           //               color: Colors.white,
//           //               child: Column(
//           //                 children: [
//           //                   AppBar(
//           //                     backgroundColor: Colors.white,
//           //                     automaticallyImplyLeading: false,
//           //                     leading: IconButton(
//           //                       onPressed: () {
//           //                         _controller
//           //                             ?.animateCamera(
//           //                           CameraUpdate.newCameraPosition(
//           //                             CameraPosition(
//           //                               target: LatLng(initiallat, initiallong),
//           //                               zoom: 18,
//           //                             ),
//           //                           ),
//           //                         )
//           //                             .whenComplete(() {
//           //                           setState(() {
//           //                             _isSheetVisible = true;
//           //                           });
//           //                         });
//           //                       },
//           //                       icon: const Icon(Icons.arrow_back),
//           //                     ),
//           //                     title: const Text(
//           //                       'Select Delivery Location ',
//           //                       style: CustomTextStyle.splashpermissionTitle,
//           //                     ),
//           //                   ),
//           //                   Consumer<LocationProvider>(
//           //                     builder: (context, value, child) {
//           //                       if (value.isloading) {
//           //                         return const LinearProgressIndicator(
//           //                           //   color: Customcolors.darkpurple,
//           //                           color: Customcolors.darkpurple
//           //                         );
//           //                       } else {
//           //                         return const SizedBox();
//           //                       }
//           //                     },
//           //                   )
//           //                 ],
//           //               ),
//           //             ),
//           //             const SizedBox(height: 10),
//           //           ],
//           //         ),
//           //         Positioned(
//           //           top: 80.h,
//           //           left: 20,
//           //           right: 20,
//           //           child: Container(
//           //             height: 42.h,
//           //             width: MediaQuery.of(context).size.width / 1.1,
//           //             decoration:
//           //                 CustomContainerDecoration.boxshadowdecoration(),
//           //             child: Padding(
//           //               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//           //               child: Row(
//           //                 mainAxisAlignment: MainAxisAlignment.start,
//           //                 children: [
//           //                   const SizedBox(width: 12),
//           //                   const Icon(
//           //                     Icons.circle,
//           //                     color: Colors.red,
//           //                     size: 10,
//           //                   ),
//           //                   const SizedBox(width: 12),
//           //                   Expanded(
//           //                     child: InkWell(
//           //                       onTap: () {
//           //                         Get.to(AddressSearchScreen(),
//           //                             transition: Transition.rightToLeft,
//           //                             duration:
//           //                                 const Duration(milliseconds: 200));
//           //                       },
//           //                       child: Consumer<LocationProvider>(
//           //                         builder: (context, value, child) {
//           //                           if (value.loading == true) {
//           //                             return const CupertinoActivityIndicator();
//           //                           } else if (value.fullAddresss == null) {
//           //                             return const Text(
//           //                               ' Loading .. ',
//           //                               style: CustomTextStyle.smallblacktext,
//           //                             );
//           //                           } else {
//           //                             return Text(
//           //                               value.fullAddresss,
//           //                               maxLines: 1,
//           //                               style: CustomTextStyle.smallblacktext,
//           //                               overflow: TextOverflow.ellipsis,
//           //                             );
//           //                           }
//           //                         },
//           //                       ),
//           //                     ),
//           //                   ),
//           //                   const SizedBox(width: 12),
//           //                 ],
//           //               ),
//           //             ),
//           //           ),
//           //         ),
//           //       ],
//           //     ),
//           //   ),
//           // ),

//           Stack(
//             children: [

//                                                                  Positioned(top: 160,left: 8,right: 8,
//                                                                    child: SearchForBarWidget(
//                                                                                                                                          onTap:
//                                                                      () {
//                                                                    Get.to(
//                                                                        const Foodsearchscreen(),
//                                                                        transition:
//                                                                            Transition.leftToRight);
//                                                                                                                                          },
//                                                                                                                                          rotationTexts:
//                                                                      foodrotationTexts,
//                                                                                                                                        ),
//                                                                  ),

//                                                      //Bottom Sheet

//               AnimatedVisibility(
//                   visible: _isSheetVisible,
//                   enter: slideInVertically(),
//                   exit: slideOutVertically(),
//                   child: DraggableScrollableSheet(
//                     controller: _draggableController,
//                    initialChildSize: 0.73,
//                     minChildSize: 0.73,
//                     maxChildSize: 0.73,
//                     expand: true,
//                     builder: (BuildContext context,
//                         ScrollController scrollController) {
//                       return NotificationListener<
//                           DraggableScrollableNotification>(
//                         onNotification: (notification) {
//                           setState(() {
//                             _isFullyExpanded = notification.extent == 1.0;
//                             scrollSize = notification.extent;
//                           });

//                           return true;
//                         },
//                         child: Container(
//                           height: screenSize.height,
//                           decoration:
//                               CustomContainerDecoration.whitebordercontainer(),
//                           child: CustomScrollView(
//                             physics: const ClampingScrollPhysics(),
//                             controller: scrollController,
//                             shrinkWrap: true,
//                             slivers: [
//                               SliverList(
//                                 delegate: SliverChildListDelegate([
//                                   Container(
//                                     decoration: CustomContainerDecoration
//                                         .whitebordercontainer(),
//                                     // height: _isFullyExpanded
//                                     //     ? screenSize.height
//                                     //     : screenSize.height / 2.3,
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(0),
//                                       child: Column(
//                                         mainAxisAlignment:

//                                              MainAxisAlignment.start,
//                                         children: [
//                                           // if (_isFullyExpanded) 15.toHeight,
//                                           // if (!_isFullyExpanded)
//                                             Obx(() {
//                                               // Check if the data is still loading
//                                               if (categorycontroller
//                                                   .iscategoryloading.isTrue) {
//                                                 return const HomeScreenShimmer();
//                                               }

//                                               // Check if the entire category object or its data field is null, or if data is empty

//                                               // if (categorycontroller
//                                               //             .category ==
//                                               //         null ||
//                                               //     categorycontroller
//                                               //             .category["data"] ==
//                                               //         null ||
//                                               //     categorycontroller
//                                               //             .category["data"]
//                                               //             .toString() ==
//                                               //         "null" ||
//                                               //     categorycontroller
//                                               //         .category["data"]
//                                               //         .isEmpty) {
//                                               //   return const Center(
//                                               //       child: SizedBox());
//                                               // }

//                                               return SingleChildScrollView(

//                                                 child: Padding(
//                                                   padding: const EdgeInsets.only(top: 20,left: 8,right: 8,bottom: 10),
//                                                   child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                                                     children: [

//                                                       Text("EXPLORE ITEMS",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
//                                                       SizedBox(height: 20,),
//                                                       Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment.spaceBetween,
//                                                         children:
//                                                       //  List.generate(categories.length,
//                                                         List.generate(explore_items.length,

//                                                           (index) {

//                                                           //  var productname = categories[index]["productName"];
//                                                             var productname = explore_items[index]["name"];
//                                                             var productdescription = explore_items[index]["description"];
//                                                             var productcontent = explore_items[index]["content"];
//                                                             var productimg = explore_items[index]["img"];

//                                                                 if(categories

//                                                                             [index]
//                                                                         ["status"] ==
//                                                                     false

//                                                                 )

//                                                             {
//                                                               return const SizedBox(); // Skips rendering this item
//                                                             }
//                                                             return InkWell(
//                                                               onTap: () {
//                                                                  num.updateIndex(index);
//                                                                                                                               Get.to( Foodscreen(categoryFilter: nearbyreget.selectedIndex.value==0?"restaurant":"shop"),
//                                                                                                                                           transition: Transition.rightToLeft);
//                                                               },
//                                                               child: Container(
//                                                               //  height: 137,
//                                                                    width: 200,
//                                                                     padding: const EdgeInsets.all(16),
//                                                                     decoration: BoxDecoration(
//                                                                                                                           color: Colors.white,
//                                                                                                                           borderRadius: BorderRadius.circular(16),
//                                                                                                                           boxShadow: [
//                                                                                                                             BoxShadow(
//                                                                                                                               color: Colors.grey.shade300,
//                                                                                                                               blurRadius: 6,
//                                                                                                                               spreadRadius: 2,
//                                                                                                                               offset: const Offset(2, 2),
//                                                                                                                             ),
//                                                                                                                           ],
//                                                                     ),
//                                                                     child: Column(
//                                                                                                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                                                                                                           children: [
//                                                                                                                             // Title
//                                                                                                                             Text(
//                                                                                                                             productname,
//                                                                                                                               style: TextStyle(
//                                                                                                                                 fontSize: 16,
//                                                                                                                                 fontWeight: FontWeight.bold,
//                                                                                                                                 color:  Color(0xFF623089)

//                                                                                                                               ),
//                                                                                                                             ),
//                                                                                                                             const SizedBox(height: 4),

//                                                                                                                             // Subtitle
//                                                                                                                             Text(
//                                                                                                                              productdescription,
//                                                                                                                               style: TextStyle(
//                                                                                                                                 fontSize: 11,
//                                                                                                                                 color: Colors.grey[600],
//                                                                                                                               ),
//                                                                                                                             ),
//                                                                                                                             const SizedBox(height: 8),

//                                                                                                                             // Delivery Tag
//                                                                                                                             Stack(clipBehavior: Clip.none,
//                                                                                                                               children: [Container(
//                                                                                                                                 padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                                                                                                                                 decoration: BoxDecoration(

//                                                                                                                                  gradient: LinearGradient(
//                                                                                                                                   begin: Alignment.centerLeft,
//                                                                                                                                   end: Alignment.centerRight,
//                                                                                                                                   colors: [ Colors.green.shade100,Colors.white]),
//                                                                                                                                  // color: Colors.green.shade100,
//                                                                                                                                   borderRadius: BorderRadius.circular(8),
//                                                                                                                                 ),
//                                                                                                                                 child: Text(
//                                                                                                                                 productcontent,
//                                                                                                                                   style:TextStyle(
//                                                                                                                                     fontSize:10 ,
//                                                                                                                                     color: Colors.green[800],
//                                                                                                                                     fontWeight: FontWeight.w500,
//                                                                                                                                   ),
//                                                                                                                                 ),
//                                                                                                                               ),

//                                                                                                                                Positioned(
//                                                                                                                                 bottom: -42,right: -65,
//                                                                                                                                  child: Image.asset(
//                                                                                                                                    productimg,
//                                                                                                                                     height: 60,
//                                                                                                                                   ),
//                                                                                                                                ),
//                                                                                                                              ]   ),
//                                                                                                                             const SizedBox(height: 12),

//                                                                                                                             // Image + Arrow Button
//                                                                                                                             InkWell(
//                                                                                                                               onTap: () {

//                                                                                                                               // num.updateIndex(index);
//                                                                                                                               //   Get.to( Foodscreen(categoryFilter: nearbyreget.selectedIndex.value==0?"restaurant":"shop"),
//                                                                                                                               //               transition: Transition.rightToLeft);
//                                                                                                                                      },
//                                                                                                                               child: Row(
//                                                                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                                                                                                 children: [
//                                                                                                                                  Text("Explore",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
//                                                                         SizedBox(width: 5,)  ,
//                                                                   Icon(Icons.arrow_forward_rounded,size: 16,color: Color(0xFF623089)
//                                                                     ,),
//                                                                                                                                   // Food Image

//                                                                                                                                 ],
//                                                                                                                               ),
//                                                                                                                             ),
//                                                                                                                           ],
//                                                                     ),
//                                                                   ),
//                                                             );
//                                                           },
//                                                         ),
//                                                         ),
//                                                         SizedBox(height: 30,),

// // Container(height: 70,width: double.maxFinite,
// // decoration: BoxDecoration(color:  Color(0xFF623089),
// // borderRadius: BorderRadius.circular(10)),),
// //SizedBox(height: 20,),

// Row(mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//   Image.asset("assets/images/Line 1.png"),
//   SizedBox(width: 10,),

//     Text("TOP PICKS FOR YOU",style: TextStyle(color: Colors.black,fontSize: 18),),
//      SizedBox(width: 10,),
//      Image.asset("assets/images/Line 1.png"),
//   ],
// ),

// AdvertisementScreen(),

// Padding(
//   padding: const EdgeInsets.symmetric(vertical: 10),
//   child: Image.asset("assets/images/Frame 1597881775.png"),
// )

//                                                     ],
//                                                   ),
//                                                 ),
//                                               );
//                                             }),
//                                           if (_showButton)
//                                             Obx(() {
//                                               if (categorycontroller
//                                                   .iscategoryloading.isTrue) {
//                                                 return const SizedBox();
//                                               } else if (categorycontroller
//                                                       .category ==
//                                                   null) {
//                                                 return const Center(
//                                                   child: Column(
//                                                     children: [
//                                                       Image(
//                                                         image: AssetImage(
//                                                             "assets/images/Categorygif.gif"),
//                                                         fit: BoxFit.cover,
//                                                       ),
//                                                       Text(
//                                                         "Unable to reach the server. Please check your internet connection and restart the application...",
//                                                         style: CustomTextStyle
//                                                             .blackbold14,
//                                                       )
//                                                     ],
//                                                   ),
//                                                 );
//                                               } else if (categorycontroller
//                                                   .category["data"].isEmpty) {
//                                                 return Center(
//                                                     child: Container());
//                                               } else {

//                                                 return Container(
//                                                   alignment:
//                                                       Alignment.topCenter,
//                                                   child: ListView.builder(
//                                                     shrinkWrap: true,
//                                                     physics:
//                                                         const NeverScrollableScrollPhysics(),
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             top: 0),
//                                                     itemCount:
//                                                         categorycontroller
//                                                             .category["data"]
//                                                             .length,
//                                                     itemBuilder:
//                                                         (context, index) {
//                                                       var productTitle =
//                                                           categorycontroller
//                                                               .category["data"]
//                                                                   [index][
//                                                                   "productTitle"]
//                                                               .toString();
//                                                       var productName =
//                                                           categorycontroller
//                                                                       .category[
//                                                                   "data"][index]
//                                                               ["productName"];
//                                                       var productType =
//                                                          categories[index]
//                                                               ["productType"];
//                                                       // var productType =
//                                                       //     categorycontroller
//                                                       //                 .category[
//                                                       //             "data"][index]
//                                                       //         ["productType"];
//                                                       var description =
//                                                           categorycontroller
//                                                                       .category[
//                                                                   "data"][index]
//                                                               [
//                                                               "productDescription"];
//                                                       var productCatId =
//                                                           categorycontroller
//                                                                       .category[
//                                                                   "data"][index]
//                                                               ["_id"];
//                                                       var status =
//                                                       categories[index]
//                                                               ["status"];
//                                                       // var status =
//                                                       //     categorycontroller
//                                                       //                 .category[
//                                                       //             "data"][index]
//                                                       //         ["status"];

//                                                       if (num.selectedIndex ==
//                                                           index) {
//                                                         return Column(
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .start,
//                                                           children: [

//                                                          //  HI Ganesh Text

//                                                             // SizedBox(
//                                                             //     height: 15.h),
//                                                             // Padding(
//                                                             //   padding:
//                                                             //       const EdgeInsets
//                                                             //           .symmetric(
//                                                             //           horizontal:
//                                                             //               10),
//                                                             //   child: productTitle ==
//                                                             //               'null' ||
//                                                             //           productTitle ==
//                                                             //               ""
//                                                             //       ? Text(
//                                                             //           '${(UserId == null || UserId.isEmpty) ? "Hi " : username.toString().capitalizeFirst.toString()}, what’s on your mind?',
//                                                             //           style: CustomTextStyle
//                                                             //               .boldblack,
//                                                             //           overflow:
//                                                             //               TextOverflow
//                                                             //                   .ellipsis,
//                                                             //           maxLines:
//                                                             //               1,
//                                                             //         )
//                                                             //       : RichText(
//                                                             //           text:
//                                                             //               TextSpan(
//                                                             //             children: [
//                                                             //               TextSpan(
//                                                             //                 text:
//                                                             //                     '${(UserId == null || UserId.isEmpty) ? "Hi " : username.toString().capitalizeFirst.toString()}, ',
//                                                             //                 style:
//                                                             //                     CustomTextStyle.blackbold14,
//                                                             //               ),
//                                                             //               TextSpan(
//                                                             //                 text:
//                                                             //                     productTitle.capitalizeFirst.toString(),
//                                                             //                 style:
//                                                             //                     CustomTextStyle.blackbold14,
//                                                             //               ),
//                                                             //             ],
//                                                             //           ),
//                                                             //         ),
//                                                             // ),

//                                                             // SizedBox(
//                                                             //     height: MediaQuery.of(
//                                                             //                 context)
//                                                             //             .size
//                                                             //             .height *
//                                                             //         0.015),
//                                                   //Description Text

//                                                             // Padding(
//                                                             //   padding:
//                                                             //       const EdgeInsets
//                                                             //           .fromLTRB(
//                                                             //           12,
//                                                             //           0,
//                                                             //           0,
//                                                             //           0),
//                                                             //   child:
//                                                             //       description ==
//                                                             //               null
//                                                             //           ? const Text(
//                                                             //               "no data",
//                                                             //               style:
//                                                             //                   CustomTextStyle.mapgrey,
//                                                             //             )
//                                                             //           : Text(
//                                                             //               description,
//                                                             //               style:
//                                                             //                   CustomTextStyle.mapgrey,
//                                                             //             ),
//                                                             // ),

//                                                             // SizedBox(
//                                                             //     height: MediaQuery.of(
//                                                             //                 context)
//                                                             //             .size
//                                                             //             .height *
//                                                             //         0.015),

//                                                                   //  Search Button

//                                                             // productType ==
//                                                             //         "restaurant"
//                                                             //     ? Center(
//                                                             //         child:
//                                                             //             SearchForBarWidget(
//                                                             //           onTap:
//                                                             //               () {
//                                                             //             Get.to(
//                                                             //                 const Foodsearchscreen(),
//                                                             //                 transition:
//                                                             //                     Transition.leftToRight);
//                                                             //           },
//                                                             //           rotationTexts:
//                                                             //               foodrotationTexts,
//                                                             //         ),
//                                                             //       )
//                                                             //     : productType ==
//                                                             //             "meat"
//                                                             //         ? Center(
//                                                             //             child:
//                                                             //                 SearchForBarWidget(
//                                                             //               onTap:
//                                                             //                   () {
//                                                             //                 Get.to(
//                                                             //                     MeatTextformfield(
//                                                             //                       meatproductcategoryid: meatproductCateId,
//                                                             //                     ),
//                                                             //                     transition: Transition.leftToRight);
//                                                             //               },
//                                                             //               rotationTexts:
//                                                             //                   rotationTextsMeatFlow,
//                                                             //             ),
//                                                             //           )
//                                                             //         : const SizedBox(),

//                                                             // SizedBox(
//                                                             //     height: MediaQuery.of(
//                                                             //                 context)
//                                                             //             .size
//                                                             //             .height *
//                                                             //         0.05),

//                                                          //    status == true
//                                                             //     ? Center(
//                                                             //         child:
//                                                             //             Container(
//                                                             //           width: MediaQuery.of(context)
//                                                             //                   .size
//                                                             //                   .width *
//                                                             //               0.9,
//                                                             //           height:
//                                                             //               35.h,
//                                                             //           decoration:
//                                                             //               CustomContainerDecoration
//                                                             //                   .gradientbuttondecoration(),
//                                                             //           child:
//                                                             //               ElevatedButton(
//                                                             //             onPressed:
//                                                             //                 () {
//                                                             //               if (status ==
//                                                             //                   true && productType=="restaurant" ) {
//                                                             //                 setState(() {
//                                                             //                   productCategoryId = productCatId;
//                                                             //                 });
//                                                             //             //  num.foodgetres(0,API.nearestresapi, pagingController: null, category: "restaurant");
//                                                             //                 Get.to( Foodscreen(categoryFilter: nearbyreget.selectedIndex.value==0?"restaurant":"shop"),
//                                                             //                     transition: Transition.rightToLeft);
//                                                             //               }
//                                                             //               // if (productType ==
//                                                             //               //     "restaurant") {
//                                                             //               //   setState(() {
//                                                             //               //     productCategoryId = productCatId;
//                                                             //               //   });
//                                                             //               //   Get.to(const Foodscreen(),
//                                                             //               //       transition: Transition.rightToLeft);
//                                                             //               // }

//                                                             //               // else if (productType ==
//                                                             //               //     "meat") {
//                                                             //               //   Get.to(
//                                                             //               //     Foodscreen(),
//                                                             //               //     transition: Transition.leftToRight,
//                                                             //               //   );
//                                                             //             //  }
//                                                             //               else if (status==true && productType ==
//                                                             //                   "shop") {
//                                                             //                 setState(() {
//                                                             //                  productCategoryId = productCatId;
//                                                             //                 });

//                                                             //                 //   num.foodgetres(0,API.nearestresapi, pagingController: null, category: "shop");
//                                                             //                 Get.to( Foodscreen(categoryFilter:  nearbyreget.selectedIndex.value==1?"shop":"restaurant"),
//                                                             //                     transition: Transition.leftToRight);
//                                                             //               }

//                                                             //               //  else if (productType ==
//                                                             //               //     parcelservice) {
//                                                             //               //   setState(() {
//                                                             //               //     productCategoryId = productCatId;
//                                                             //               //   });
//                                                             //               //   Get.to(const ParcelHomeScreen(),
//                                                             //               //       transition: Transition.leftToRight);
//                                                             //               // }
//                                                             //               // else {
//                                                             //               //   Get.to(const MartHomepage(),
//                                                             //               //       transition: Transition.leftToRight);
//                                                             //               // }
//                                                             //             },
//                                                             //             style: ElevatedButton
//                                                             //                 .styleFrom(
//                                                             //               fixedSize: Size(
//                                                             //                   0,
//                                                             //                   30.h),
//                                                             //               backgroundColor:
//                                                             //                   Colors.transparent,
//                                                             //               shadowColor:
//                                                             //                   Colors.transparent,
//                                                             //             ),
//                                                             //             child:
//                                                             //                 Text(
//                                                             //               buttonName(
//                                                             //                   productType: productType),
//                                                             //               style:
//                                                             //                   CustomTextStyle.smallwhitetext,
//                                                             //             ),
//                                                             //           ),
//                                                             //         ),
//                                                             //       )
//                                                             //     : const SizedBox(),

//                                                             // if (_isFullyExpanded)
//                                                             //   AdvertisementScreen(),

//                                                           ],
//                                                         );
//                                                       } else {
//                                                         return const SizedBox
//                                                             .shrink();
//                                                       }
//                                                     },
//                                                   ),
//                                                 );
//                                               }
//                                             }),
//                                           // if (_isFullyExpanded)
//                                           //   const AdvertisementScreen(),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ]),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   )),
//             ],
//           )
//         ]),
//       ),
//     );
//   }

//   String buttonName({required String productType}) {
//     switch (productType) {
//       case 'restaurant':
//         return 'Order Now';
//       case 'services':
//         return 'Continue';
//       case 'shop':
//         return 'Order Now';
//       case 'meat':
//         return 'Shop Now';
//       default:
//         return 'Continue';
//     }
//   }
// }


















// import 'package:animated_visibility/animated_visibility.dart';
// import 'package:flutter/widgets.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
// import 'package:testing/Features/Authscreen/AuthController/Registercontroller.dart';
// import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Addfoodcontroller.dart';
// import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Bannercontroller.dart';
// import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Categorylistcontroller.dart';
// import 'package:testing/Features/Foodmodule/SubAdmincontroller/Inactiverescontroller.dart';
// import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodhomepage.dart';
// import 'package:testing/Features/Foodmodule/SubAdmincontroller/Getnearbyrescontroller.dart';
// import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodsearch.dart';
// import 'package:testing/Features/Foodmodule/getFoodCartProvider.dart';
// import 'package:testing/Features/Homepage/Profile_Orders/Advertisement.dart';
// import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Advertisementcontroller.dart';
// import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Chatbotcontroller.dart';
// import 'package:testing/Features/Homepage/homescreenpage.dart';
// import 'package:testing/Mart/Homepage/MartHomepage.dart';
// import 'package:testing/Meat/Homepage/Meathomepage.dart';
// import 'package:testing/Meat/MeatSearch/MeatTextformfield.dart';
// import 'package:testing/common/commonRotationalTextWidget.dart';
// import 'package:testing/map_provider/Map%20Screens/Address%20search.dart';
// import 'package:testing/map_provider/Map%20Screens/MapSearch.dart/addressnameController.dart';
// import 'package:testing/map_provider/Map%20Screens/MapSearch.dart/homeadresskey.dart';
// import 'package:testing/map_provider/Map%20Screens/circleradious.dart';
// import 'package:testing/map_provider/Map%20Screens/markervaluse.dart';
// import 'package:testing/Features/Homepage/profile.dart';
// import 'package:testing/map_provider/circle_marker.dart';
// import 'package:testing/map_provider/location/locationServices/onlylocationpermission.dart';
// import 'package:testing/map_provider/locationprovider.dart';
// import 'package:testing/parcel/parcel_home.dart';
// import 'package:testing/utils/Buttons/CustomTextstyle.dart';
// import 'package:testing/utils/Const/ApiConstvariables.dart';
// import 'package:testing/utils/Const/constValue.dart';
// import 'package:testing/utils/Const/localvaluesmanagement.dart';
// import 'package:testing/utils/Containerdecoration.dart';
// import 'package:testing/utils/CustomColors/Customcolors.dart';
// import 'package:testing/utils/Shimmers/Restaurantshimmer.dart';
// import 'package:testing/utils/Urlist.dart';
// import 'package:testing/utils/addAddressFun.dart';
// import 'package:testing/utils/exitapp.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:provider/provider.dart';

// //places
// // int selectedIndex = 0;
// class HomeScreenPage extends StatefulWidget {
//   final bool isfrommanualsearchaddress;
//   const HomeScreenPage({super.key, this.isfrommanualsearchaddress = false});

//   @override
//   State<HomeScreenPage> createState() => _HomeScreenPageState();
// }

// class _HomeScreenPageState extends State<HomeScreenPage>
//     with
//         SingleTickerProviderStateMixin,
//         AutomaticKeepAliveClientMixin<HomeScreenPage> {
//   @override
//   bool get wantKeepAlive => true;

//   TextEditingController mapsearchcontroller = TextEditingController();
//   TextEditingController localitycontroller = TextEditingController();
//   TextEditingController streetcontroller = TextEditingController();
//   TextEditingController pincodecontroller = TextEditingController();
//   TextEditingController statecontroller = TextEditingController();

//   RegisterscreenController getProfile = Get.put(RegisterscreenController());
//   Categorylistcontroller categorycontroller = Get.put(Categorylistcontroller());
//   Nearbyrescontroller nearbyreget = Get.put(Nearbyrescontroller());
//   Inactiverescontroller inactiverestt = Get.put(Inactiverescontroller());
//   Foodcartcontroller foodcart = Get.put(Foodcartcontroller());
//   RegisterscreenController regi = Get.put(RegisterscreenController());
//   HomeadresskeyController homeaddress = Get.put(HomeadresskeyController());
//   Chatbotcontroller chathealthchecking = Get.put(Chatbotcontroller());
//   AdvertisementController advertise = Get.put(AdvertisementController());
//   int nearbyrespage = 0;

//   // var latpass;
//   // var lngpass;

//   // Initially, no container is selected
//   // int selectedIndex = 0;
//   bool _showButton = true;
//   bool drag = true;
//   bool _isFullyExpanded = false;
//   bool isLocationDifferent = false;
//   bool _isSheetVisible = true;

//   String? country = 'india';

//   late DraggableScrollableController _draggableController;

//   // GoogleMapController _controller;
//   GoogleMapController? _controller;

//   final Set<Circle> _circles = {};
//   Set<Marker> markersList = {};

//   // final Mode _mode = Mode.overlay;

//   List<Map<String, dynamic>> explore_items = [
//     {
//       "name": "Restaurant",
//       "description": "Because Every Parcel \nMatters",
//       "content": "Delivery in 15mins",
//       "img": "assets/images/restaurant_image.png.png"
//     },
//     {
//       "name": "Shop",
//       "description": "Groceries Made Easy,\nDelivered With Love",
//       "content": "Up to 60% OFF",
//       "img": "assets/images/shop_image.png.png"
//     }
//   ];

//   final List<LatLng> polylinePoints = [];
//   final Set<Polyline> polylines = {};
//   final List<Marker> markers = <Marker>[];

//   bool isWithinCircle = true; // Track if the camera is within the circle
//   int currentHintIndex = 0;

//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       // categorycontroller.categoryget();
//       advertise.getadvertisementDetails();
//       getProfile.profileget();
//       regi.fetchProfile(profileImgae);
//       // addinitalmarker();
//       getResturantIdFun();
//       Provider.of<HomepageProvider>(context, listen: false).getHomepagedatas();

//       foodcart.getbillfoodcartfood(km: 0);
//       var foodcartprovider =
//           Provider.of<FoodCartProvider>(context, listen: false);

//       nearbyreget.nearbyresPagingController.refresh();

//       inactiverestt.inactiveresget();

//       homeaddress.gethomeadresskeyDetails();
//       chathealthchecking.getachatstatusDetails();
//       // getloc();
//       await Provider.of<LocationProvider>(context, listen: false)
//           .loadInitialAddressFromSavedData(context);
//     });

//     _isSheetVisible = true;
//     _draggableController = DraggableScrollableController();
//     super.initState();
//   }

//   getResturantIdFun() {
//     Future.delayed(
//       Duration.zero,
//       () async {
//         final foodcartprovider =
//             Provider.of<FoodCartProvider>(context, listen: false);

//         var resID = await foodcartprovider.getfoodcartProvider(km: 0);

//         if (resID != null) {
//           foodcartprovider.searchResById(restaurantId: resID);
//         } else {
//           print('No Restaurant Available...!');
//         }
//       },
//     );
//   }

//   @override
//   void dispose() {
//     _draggableController.dispose();
//     _controller?.dispose();
//     super.dispose();
//   }

//   var address;
//   // final List<Marker> markers = <Marker>[];
//   bool iscurrentlocationGot = false;
//   bool canPop = true;
//   Position? currentPosition;
//   bool isloading = false;

//   addRandomMarker({latitude, longitude}) async {
//     markersList.clear();
//     markersList.add(
//       Marker(
//         markerId: const MarkerId('current_location'),
//         position: LatLng(latitude, longitude),
//         visible: true,
//         draggable: true,
//         icon: await getDotMarker(),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     // List<dynamic> categories = ["shop", ...categorycontroller.category["data"]];
//     List<Map<String, dynamic>> categories =
//         List<Map<String, dynamic>>.from(categorycontroller.category["data"]);

//     categories.insert(
//         1, {"status": true, "productName": "SHOP", "productType": "shop"});

//     var locationProvider =
//         Provider.of<LocationProvider>(context, listen: false);
//     var mapDataProvider = Provider.of<MapDataProvider>(context);
//     final foodcartprovider = Provider.of<FoodCartProvider>(context);

//     Size screenSize = MediaQuery.of(context).size;
//     double scrollSize = screenSize.height;
//     final num = Get.put(Nearbyrescontroller());
//     return PopScope(
//       canPop: false,
//       onPopInvoked: (bool didPop) async {
//         _controller
//             ?.animateCamera(
//           CameraUpdate.newCameraPosition(
//             CameraPosition(
//               target: LatLng(initiallat, initiallong),
//               zoom: 18,
//             ),
//           ),
//         )
//             .whenComplete(() {
//           setState(() {
//             _isSheetVisible = true;
//           });
//         });

//         if (didPop) return;

//         if (_isSheetVisible = true) {
//           await ExitApp.handlePop();
//         }
//       },
//       child: Scaffold(
//         backgroundColor: Color(0xFFA14DDE),
//         body: Stack(children: [
//           Visibility(
//             visible: _isSheetVisible,
//             child: Padding(
//               padding:  EdgeInsets.symmetric(horizontal: 10.w),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     width: MediaQuery.of(context).size.width * 0.76,
//                     height: MediaQuery.of(context).size.height * 0.085,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: InkWell(
//                             onTap: () {
//                               Get.to(AddressSearchScreen(),
//                                   transition: Transition.rightToLeft,
//                                   duration:
//                                       const Duration(milliseconds: 200));
//                             },
//                             child: Consumer<LocationProvider>(
//                               builder: (context, value, child) {
//                                 if (value.isloading == true) {
//                                   return const CupertinoActivityIndicator();
//                                 } else if (value.fullAddresss == null) {
//                                   return const Text(' No Data ');
//                                 } else {
//                                   return Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 5),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceAround,
//                                       children: [
//                                         Row(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.center,
//                                           children: [
//                                             IconButton(
//                                               padding: EdgeInsets
//                                                   .zero, // 👈 removes extra padding from IconButton
//                                               constraints:
//                                                   const BoxConstraints(), // 👈 makes IconButton shrink-wrap
//                                               onPressed: () {
//                                                 String fullAddress = [
//                                                   locationProvider
//                                                       .address.street,
//                                                   locationProvider
//                                                       .address.subLocality,
//                                                   locationProvider
//                                                       .address.locality,
//                                                   locationProvider.address
//                                                       .administrativeArea,
//                                                   locationProvider
//                                                       .address.postalCode,
//                                                   locationProvider
//                                                       .address.country
//                                                 ]
//                                                     .where((part) =>
//                                                         part != null &&
//                                                         part.isNotEmpty)
//                                                     .join(', ');
                                  
//                                                 addAddressBottomSheet(
//                                                   context: context,
//                                                   address: fullAddress,
//                                                   locality: locationProvider
//                                                       .address.locality,
//                                                   country: locationProvider
//                                                       .address.country,
//                                                   state: locationProvider
//                                                       .address
//                                                       .administrativeArea,
//                                                   pincode: locationProvider
//                                                       .address.postalCode,
//                                                   street: locationProvider
//                                                       .address.street,
//                                                   lattitude: locationProvider
//                                                       .position.latitude,
//                                                   longitude: locationProvider
//                                                       .position.longitude,
//                                                   ishomescreen: true,
//                                                 );
//                                               },
//                                               icon: Image.asset(
//                                                 othersicon,
//                                                 scale: 3,
//                                                 color: Colors.white,
//                                               ),
//                                               //  const Icon(Icons.location_pin),
//                                             ),
//                                             Text(mapDataProvider.addressType,
//                                                 style: CustomTextStyle
//                                                     .smallheadtext),
//                                             IconButton(
//                                                 onPressed: () {},
//                                                 icon: Icon(
//                                                   Icons
//                                                       .keyboard_arrow_down_sharp,
//                                                   color: Colors.white,
//                                                 ))
//                                           ],
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.only(
//                                               left: 8.0),
//                                           child: Text(
//                                             value.fullAddresss,
//                                             maxLines: 1,
//                                             style: TextStyle(
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w300,
//                                               // color: Customcolors.DECORATION_WHITE,
//                                               color: Customcolors
//                                                   .DECORATION_WHITE,
//                                               fontFamily: 'Poppins-Medium',
//                                             ),
//                                             //   CustomTextStyle.smallblacktext,
//                                             overflow: TextOverflow.ellipsis,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 }
//                               },
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                       ],
//                     ),
//                   ),
              
//                   // Profile Image
              
//                   const SizedBox(width: 10),
              
//                   InkWell(
//                     onTap: () {
//                       regi.fetchProfile(profileImgae);
//                       Get.to(const ProfileScreen(),
//                           transition: Transition.leftToRight,
//                           duration: const Duration(milliseconds: 250),
//                           curve: Curves.easeInOut);
//                     },
//                     child: Container(
//                       width: MediaQuery.of(context).size.width * 0.13,
//                       height: MediaQuery.of(context).size.width * 0.13,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: const Color.fromRGBO(254, 236, 227, 8),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             spreadRadius: 2,
//                             blurRadius: 5,
//                             offset: const Offset(0, 1),
//                           ),
//                         ],
//                       ),
//                       child: GetBuilder<RegisterscreenController>(
//                         builder: (controller) {
//                           final hasProfileImage =
//                               controller.profileImageUrl.isNotEmpty;
              
//                           return Center(
//                             child: CircleAvatar(
//                               radius: 40,
//                               backgroundColor: Colors.blue.shade100,
//                               child: ClipOval(
//                                 child: SizedBox(
//                                   height: 115,
//                                   width: 115,
//                                   child: hasProfileImage && UserId != null
//                                       ? Image.network(
//                                           controller.profileImageUrl,
//                                           key: ValueKey(controller
//                                               .profileImageUrl), // Helps force rebuild
//                                           fit: BoxFit.cover,
//                                           errorBuilder:
//                                               (context, error, stackTrace) {
//                                             return Image.asset(
//                                               "assets/images/Profile.png",
//                                               fit: BoxFit.cover,
//                                             );
//                                           },
//                                         )
//                                       : Image.asset(
//                                           "assets/images/Profile.png",
//                                           key: const ValueKey(
//                                               'default'), // Force rebuild when profileImageUrl is empty
//                                           fit: BoxFit.cover,
//                                         ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           _isSheetVisible ? const SizedBox() : SizedBox(),
//           Stack(
//             children: [
//               Positioned(
//                 top: 160,
//                 left: 8,
//                 right: 8,
//                 child: SearchForBarWidget(
//                   onTap: () {
//                     Get.to(const Foodsearchscreen(),
//                         transition: Transition.leftToRight);
//                   },
//                   rotationTexts: foodrotationTexts,
//                 ),
//               ),

//               //Bottom Sheet

//               AnimatedVisibility(
//                   visible: _isSheetVisible,
//                   enter: slideInVertically(),
//                   exit: slideOutVertically(),
//                   child: DraggableScrollableSheet(
//                     controller: _draggableController,
//                     initialChildSize: 0.73,
//                     minChildSize: 0.73,
//                     maxChildSize: 0.73,
//                     expand: true,
//                     builder: (BuildContext context,
//                         ScrollController scrollController) {
//                       return NotificationListener<
//                           DraggableScrollableNotification>(
//                         onNotification: (notification) {
//                           setState(() {
//                             _isFullyExpanded = notification.extent == 1.0;
//                             scrollSize = notification.extent;
//                           });

//                           return true;
//                         },
//                         child: Container(
//                           height: screenSize.height,
//                           decoration:
//                               CustomContainerDecoration.whitebordercontainer(),
//                           child: CustomScrollView(
//                             physics: const ClampingScrollPhysics(),
//                             controller: scrollController,
//                             shrinkWrap: true,
//                             slivers: [
//                               SliverList(
//                                 delegate: SliverChildListDelegate([
//                                   Container(
//                                     decoration: CustomContainerDecoration
//                                         .whitebordercontainer(),
//                                     // height: _isFullyExpanded
//                                     //     ? screenSize.height
//                                     //     : screenSize.height / 2.3,
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(0),
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         children: [
//                                           // if (_isFullyExpanded) 15.toHeight,
//                                           // if (!_isFullyExpanded)
//                                           Obx(() {
//                                             // Check if the data is still loading
//                                             if (categorycontroller
//                                                 .iscategoryloading.isTrue) {
//                                               return const HomeScreenShimmer();
//                                             }

//                                             return SingleChildScrollView(
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     top: 20,
//                                                     left: 8,
//                                                     right: 8,
//                                                     bottom: 10),
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     Text(
//                                                       "EXPLORE ITEMS",
//                                                       style: TextStyle(
//                                                           fontSize: 20,
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                           color: Colors.black),
//                                                     ),
//                                                     SizedBox(
//                                                       height: 20,
//                                                     ),

// InkWell(
//   onTap: () {
//      num.updateIndex(0);
//          Get.to( Foodscreen( categoryFilter: nearbyreget.selectedIndex.value ==0 ? "restaurant"
//                                                                           : "shop"), 
//                                                                           transition:
//                                                                       Transition
//                                                                           .rightToLeft);
//   },
//   child:
//   //  Container(height: 137,
//   // decoration: BoxDecoration(
//   // borderRadius: BorderRadius.circular(10),
//   // gradient: LinearGradient(
//   //   begin: Alignment.topCenter,
//   //   end: Alignment.bottomCenter,
//   //   colors: [
//   //    Color(0xFFAE62E8),
//   //  Color(0xFF623089)
  
//   // ])
//   // ),
//   // child: Center(child: Text("Order Now",style: TextStyle(
//   //   color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold
//   // ),)),
//   // ),


//  Container(
//                                                               //  height: 137,
//                                                             //  width: 200,
//                                                               padding:
//                                                                   const EdgeInsets
//                                                                       .all(16),
//                                                               decoration:
//                                                                   BoxDecoration(
//                                                                 color: Colors
//                                                                     .white,
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             16),
//                                                                 boxShadow: [
//                                                                   BoxShadow(
//                                                                     color: Colors
//                                                                         .grey
//                                                                         .shade300,
//                                                                     blurRadius:
//                                                                         6,
//                                                                     spreadRadius:
//                                                                         2,
//                                                                     offset:
//                                                                         const Offset(
//                                                                             2,
//                                                                             2),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                               child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                                                 children: [
//                                                                   Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                                                     crossAxisAlignment:
//                                                                         CrossAxisAlignment
//                                                                             .start,
//                                                                     children: [
//                                                                       // Title
//                                                                       Text(
//                                                                       explore_items[0]["name"],
//                                                                         style: TextStyle(
//                                                                             fontSize:
//                                                                                 22,
//                                                                             fontWeight:
//                                                                                 FontWeight
//                                                                                     .bold,
//                                                                             color: Color(
//                                                                                 0xFF623089)),
//                                                                       ),
//                                                                       const SizedBox(
//                                                                           height:
//                                                                               4),
                                                                   
//                                                                       // Subtitle
//                                                                       Text(
//                                                                       explore_items[0]["description"],
//                                                                         style:
//                                                                             TextStyle(
//                                                                           fontSize:
//                                                                               15,
//                                                                           color: Colors
//                                                                                   .grey[
//                                                                               600],
//                                                                         ),
//                                                                       ),
//                                                                       const SizedBox(
//                                                                           height:
//                                                                               8),
                                                                   
//                                                                       // Delivery Tag
//                                                                       // Container(
//                                                                       //   padding: const EdgeInsets
//                                                                       //       .symmetric(
//                                                                       //       horizontal: 10,
//                                                                       //       vertical: 4),
//                                                                       //   decoration:
//                                                                       //       BoxDecoration(
//                                                                       //     gradient:
//                                                                       //         LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
//                                                                       //       Colors.green.shade100,
//                                                                       //       Colors.white
//                                                                       //     ]),
//                                                                       //     // color: Colors.green.shade100,
//                                                                       //     borderRadius:
//                                                                       //         BorderRadius.circular(8),
//                                                                       //   ),
//                                                                       //   child:
//                                                                       //       Text(
//                                                                       //     explore_items[0]["content"],
//                                                                       //     style:
//                                                                       //         TextStyle(
//                                                                       //       fontSize: 15,
//                                                                       //       color: Colors.green[800],
//                                                                       //       fontWeight: FontWeight.w500,
//                                                                       //     ),
//                                                                       //   ),
//                                                                       // ),
                                                                 
//                                                                     ],

                                                                    
//                                                                   ),

//                                                                   Column(children: [
//                                                                          Container(height: 120,
//                                                                            child: Image.asset(
//                                                                                                                                               explore_items[0]["img"],
                                                                                                                                            
                                                                                                                                                 
//                                                                                                                                            fit: BoxFit.cover, ),
//                                                                          ),
//                                                                       // const SizedBox(
//                                                                       //     height:
//                                                                       //         12),
                                                                   
//                                                                       // Image + Arrow Button
//                                                                       Container(padding: EdgeInsets.only(left: 15,right: 15,top: 8,bottom: 8),
//                                                                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
//                                                                       gradient: LinearGradient(colors: [
//                                                                          Color(0xFFAE62E8),
                                                                      
//                                                                        Color(0xFF623089)
                                                                      
//                                                                       ],
//                                                                       begin: Alignment.centerLeft,
//                                                                       end: Alignment.centerRight,)),
//                                                                         child: Row(
//                                                                           children: [
//                                                                             Text(
//                                                                               "Order Now",
//                                                                               style: TextStyle(
//                                                                                   fontWeight: FontWeight.bold,
//                                                                                   color: Colors.white),
//                                                                             ),
//                                                                              SizedBox(
//                                                                             width:
//                                                                                 5,
//                                                                           ),
//                                                                           Icon(
//                                                                             Icons
//                                                                                 .arrow_forward_rounded,
//                                                                             size:
//                                                                                 16,
//                                                                             color:
//                                                                                 Colors.white,
//                                                                           ),
//                                                                           ],
//                                                                         ),
//                                                                       ),
//                                                                   ],)
//                                                                 ],
//                                                               ),
//                                                             ),

// ),


//                                                     // Row(
//                                                     //   mainAxisAlignment:
//                                                     //       MainAxisAlignment
//                                                     //           .spaceBetween,
//                                                     //   children:
//                                                     //       //  List.generate(categories.length,
//                                                     //       List.generate(
//                                                     //     explore_items.length,
//                                                     //     (index) {
//                                                     //       //  var productname = categories[index]["productName"];
//                                                     //       var productname =
//                                                     //           explore_items[
//                                                     //                   index]
//                                                     //               ["name"];
//                                                     //       var productdescription =
//                                                     //           explore_items[
//                                                     //                   index][
//                                                     //               "description"];
//                                                     //       var productcontent =
//                                                     //           explore_items[
//                                                     //                   index]
//                                                     //               ["content"];
//                                                     //       var productimg =
//                                                     //           explore_items[
//                                                     //               index]["img"];

//                                                     //       if (categories[index]
//                                                     //               ["status"] ==
//                                                     //           false) {
//                                                     //         return const SizedBox(); // Skips rendering this item
//                                                     //       }
//                                                     //       return InkWell(
//                                                     //         onTap: () {
//                                                     //           num.updateIndex(
//                                                     //               index);
//                                                     //           Get.to(
//                                                     //               Foodscreen(
//                                                     //                   categoryFilter: nearbyreget.selectedIndex.value ==
//                                                     //                           0
//                                                     //                       ? "restaurant"
//                                                     //                       : "shop"),
//                                                     //               transition:
//                                                     //                   Transition
//                                                     //                       .rightToLeft);
//                                                     //         },
//                                                     //         child: Container(
//                                                     //           //  height: 137,
//                                                     //           width: 200,
//                                                     //           padding:
//                                                     //               const EdgeInsets
//                                                     //                   .all(16),
//                                                     //           decoration:
//                                                     //               BoxDecoration(
//                                                     //             color: Colors
//                                                     //                 .white,
//                                                     //             borderRadius:
//                                                     //                 BorderRadius
//                                                     //                     .circular(
//                                                     //                         16),
//                                                     //             boxShadow: [
//                                                     //               BoxShadow(
//                                                     //                 color: Colors
//                                                     //                     .grey
//                                                     //                     .shade300,
//                                                     //                 blurRadius:
//                                                     //                     6,
//                                                     //                 spreadRadius:
//                                                     //                     2,
//                                                     //                 offset:
//                                                     //                     const Offset(
//                                                     //                         2,
//                                                     //                         2),
//                                                     //               ),
//                                                     //             ],
//                                                     //           ),
//                                                     //           child: Column(
//                                                     //             crossAxisAlignment:
//                                                     //                 CrossAxisAlignment
//                                                     //                     .start,
//                                                     //             children: [
//                                                     //               // Title
//                                                     //               Text(
//                                                     //                 productname,
//                                                     //                 style: TextStyle(
//                                                     //                     fontSize:
//                                                     //                         16,
//                                                     //                     fontWeight:
//                                                     //                         FontWeight
//                                                     //                             .bold,
//                                                     //                     color: Color(
//                                                     //                         0xFF623089)),
//                                                     //               ),
//                                                     //               const SizedBox(
//                                                     //                   height:
//                                                     //                       4),

//                                                     //               // Subtitle
//                                                     //               Text(
//                                                     //                 productdescription,
//                                                     //                 style:
//                                                     //                     TextStyle(
//                                                     //                   fontSize:
//                                                     //                       11,
//                                                     //                   color: Colors
//                                                     //                           .grey[
//                                                     //                       600],
//                                                     //                 ),
//                                                     //               ),
//                                                     //               const SizedBox(
//                                                     //                   height:
//                                                     //                       8),

//                                                     //               // Delivery Tag
//                                                     //               Stack(
//                                                     //                   clipBehavior:
//                                                     //                       Clip.none,
//                                                     //                   children: [
//                                                     //                     Container(
//                                                     //                       padding: const EdgeInsets
//                                                     //                           .symmetric(
//                                                     //                           horizontal: 10,
//                                                     //                           vertical: 4),
//                                                     //                       decoration:
//                                                     //                           BoxDecoration(
//                                                     //                         gradient:
//                                                     //                             LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
//                                                     //                           Colors.green.shade100,
//                                                     //                           Colors.white
//                                                     //                         ]),
//                                                     //                         // color: Colors.green.shade100,
//                                                     //                         borderRadius:
//                                                     //                             BorderRadius.circular(8),
//                                                     //                       ),
//                                                     //                       child:
//                                                     //                           Text(
//                                                     //                         productcontent,
//                                                     //                         style:
//                                                     //                             TextStyle(
//                                                     //                           fontSize: 10,
//                                                     //                           color: Colors.green[800],
//                                                     //                           fontWeight: FontWeight.w500,
//                                                     //                         ),
//                                                     //                       ),
//                                                     //                     ),
//                                                     //                     Positioned(
//                                                     //                       bottom:
//                                                     //                           -42,
//                                                     //                       right:
//                                                     //                           -65,
//                                                     //                       child:
//                                                     //                           Image.asset(
//                                                     //                         productimg,
//                                                     //                         height:
//                                                     //                             60,
//                                                     //                       ),
//                                                     //                     ),
//                                                     //                   ]),
//                                                     //               const SizedBox(
//                                                     //                   height:
//                                                     //                       12),

//                                                     //               // Image + Arrow Button
//                                                     //               InkWell(
//                                                     //                 onTap: () {
//                                                     //                   // num.updateIndex(index);
//                                                     //                   //   Get.to( Foodscreen(categoryFilter: nearbyreget.selectedIndex.value==0?"restaurant":"shop"),
//                                                     //                   //               transition: Transition.rightToLeft);
//                                                     //                 },
//                                                     //                 child: Row(
//                                                     //                   //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                     //                   children: [
//                                                     //                     Text(
//                                                     //                       "Explore",
//                                                     //                       style: TextStyle(
//                                                     //                           fontWeight: FontWeight.bold,
//                                                     //                           color: Colors.black),
//                                                     //                     ),
//                                                     //                     SizedBox(
//                                                     //                       width:
//                                                     //                           5,
//                                                     //                     ),
//                                                     //                     Icon(
//                                                     //                       Icons
//                                                     //                           .arrow_forward_rounded,
//                                                     //                       size:
//                                                     //                           16,
//                                                     //                       color:
//                                                     //                           Color(0xFF623089),
//                                                     //                     ),
//                                                     //                     // Food Image
//                                                     //                   ],
//                                                     //                 ),
//                                                     //               ),
//                                                     //             ],
//                                                     //           ),
//                                                     //         ),
//                                                     //       );
//                                                     //     },
//                                                     //   ),
//                                                     // ),
//                                                     SizedBox(
//                                                       height: 30,
//                                                     ),
//                                                     Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .center,
//                                                       children: [
//                                                         Image.asset(
//                                                             "assets/images/Line 1.png"),
//                                                         SizedBox(
//                                                           width: 10,
//                                                         ),
//                                                         Text(
//                                                           "TOP PICKS FOR YOU",
//                                                           style: TextStyle(
//                                                               color:
//                                                                   Colors.black,
//                                                               fontSize: 18),
//                                                         ),
//                                                         SizedBox(
//                                                           width: 10,
//                                                         ),
//                                                         Image.asset(
//                                                             "assets/images/Line 1.png"),
//                                                       ],
//                                                     ),
//                                                     AdvertisementScreen(),
//                                                     Center(
//                                                       child: Image.asset(
//                                                           "assets/images/Frame 1597881775.png"),
//                                                     )
//                                                   ],
//                                                 ),
//                                               ),
//                                             );
//                                           }),
//                                           if (_showButton)
//                                             Obx(() {
//                                               if (categorycontroller
//                                                   .iscategoryloading.isTrue) {
//                                                 return const SizedBox();
//                                               } else if (categorycontroller
//                                                       .category ==
//                                                   null) {
//                                                 return const Center(
//                                                   child: Column(
//                                                     children: [
//                                                       Image(
//                                                         image: AssetImage(
//                                                             "assets/images/Categorygif.gif"),
//                                                         fit: BoxFit.cover,
//                                                       ),
//                                                       Text(
//                                                         "Unable to reach the server. Please check your internet connection and restart the application...",
//                                                         style: CustomTextStyle
//                                                             .blackbold14,
//                                                       )
//                                                     ],
//                                                   ),
//                                                 );
//                                               } else if (categorycontroller
//                                                   .category["data"].isEmpty) {
//                                                 return Center(
//                                                     child: Container());
//                                               } else {
//                                                 return Container(
//                                                   alignment:
//                                                       Alignment.topCenter,
//                                                   child: ListView.builder(
//                                                     shrinkWrap: true,
//                                                     physics:
//                                                         const NeverScrollableScrollPhysics(),
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             top: 0),
//                                                     itemCount:
//                                                         categorycontroller
//                                                             .category["data"]
//                                                             .length,
//                                                     itemBuilder:
//                                                         (context, index) {
//                                                       var productTitle =
//                                                           categorycontroller
//                                                               .category["data"]
//                                                                   [index][
//                                                                   "productTitle"]
//                                                               .toString();
//                                                       var productName =
//                                                           categorycontroller
//                                                                       .category[
//                                                                   "data"][index]
//                                                               ["productName"];
//                                                       var productType =
//                                                           categories[index]
//                                                               ["productType"];

//                                                       var description =
//                                                           categorycontroller
//                                                                       .category[
//                                                                   "data"][index]
//                                                               [
//                                                               "productDescription"];
//                                                       var productCatId =
//                                                           categorycontroller
//                                                                       .category[
//                                                                   "data"][index]
//                                                               ["_id"];
//                                                       var status =
//                                                           categories[index]
//                                                               ["status"];

//                                                       if (num.selectedIndex ==
//                                                           index) {
//                                                         return Column(
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .start,
//                                                           children: [],
//                                                         );
//                                                       } else {
//                                                         return const SizedBox
//                                                             .shrink();
//                                                       }
//                                                     },
//                                                   ),
//                                                 );
//                                               }
//                                             }),
//                                           // if (_isFullyExpanded)
//                                           //   const AdvertisementScreen(),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ]),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   )),
//             ],
//           )
//         ]),
//       ),
//     );
//   }

//   String buttonName({required String productType}) {
//     switch (productType) {
//       case 'restaurant':
//         return 'Order Now';
//       case 'services':
//         return 'Continue';
//       case 'shop':
//         return 'Order Now';
//       case 'meat':
//         return 'Shop Now';
//       default:
//         return 'Continue';
//     }
//   }
// }


































import 'package:animated_visibility/animated_visibility.dart';
import 'package:flutter/widgets.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:testing/Features/Authscreen/AuthController/Registercontroller.dart';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Addfoodcontroller.dart';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Bannercontroller.dart';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Categorylistcontroller.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/Inactiverescontroller.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodhomepage.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/Getnearbyrescontroller.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodsearch.dart';
import 'package:testing/Features/Foodmodule/getFoodCartProvider.dart';
import 'package:testing/Features/Homepage/Profile_Orders/Advertisement.dart';
import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Advertisementcontroller.dart';
import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Chatbotcontroller.dart';
import 'package:testing/Features/Homepage/homescreenpage.dart';
import 'package:testing/Mart/Homepage/MartHomepage.dart';
import 'package:testing/Meat/Homepage/Meathomepage.dart';
import 'package:testing/Meat/MeatSearch/MeatTextformfield.dart';
import 'package:testing/common/commonRotationalTextWidget.dart';
import 'package:testing/map_provider/Map%20Screens/Address%20search.dart';
import 'package:testing/map_provider/Map%20Screens/MapSearch.dart/addressnameController.dart';
import 'package:testing/map_provider/Map%20Screens/MapSearch.dart/homeadresskey.dart';
import 'package:testing/map_provider/Map%20Screens/circleradious.dart';
import 'package:testing/map_provider/Map%20Screens/markervaluse.dart';
import 'package:testing/Features/Homepage/profile.dart';
import 'package:testing/map_provider/circle_marker.dart';
import 'package:testing/map_provider/location/locationServices/onlylocationpermission.dart';
import 'package:testing/map_provider/locationprovider.dart';
import 'package:testing/parcel/parcel_home.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Const/localvaluesmanagement.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Shimmers/Restaurantshimmer.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:testing/utils/addAddressFun.dart';
import 'package:testing/utils/exitapp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

//places
// int selectedIndex = 0;
class HomeScreenPage extends StatefulWidget {
  final bool isfrommanualsearchaddress;
  const HomeScreenPage({super.key, this.isfrommanualsearchaddress = false});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<HomeScreenPage> {
  @override
  bool get wantKeepAlive => true;

  TextEditingController mapsearchcontroller = TextEditingController();
  TextEditingController localitycontroller = TextEditingController();
  TextEditingController streetcontroller = TextEditingController();
  TextEditingController pincodecontroller = TextEditingController();
  TextEditingController statecontroller = TextEditingController();

  RegisterscreenController getProfile = Get.put(RegisterscreenController());
  Categorylistcontroller categorycontroller = Get.put(Categorylistcontroller());
  Nearbyrescontroller nearbyreget = Get.put(Nearbyrescontroller());
  Inactiverescontroller inactiverestt = Get.put(Inactiverescontroller());
  Foodcartcontroller foodcart = Get.put(Foodcartcontroller());
  RegisterscreenController regi = Get.put(RegisterscreenController());
  HomeadresskeyController homeaddress = Get.put(HomeadresskeyController());
  Chatbotcontroller chathealthchecking = Get.put(Chatbotcontroller());
  AdvertisementController advertise = Get.put(AdvertisementController());
  int nearbyrespage = 0;

  // var latpass;
  // var lngpass;

  // Initially, no container is selected
  // int selectedIndex = 0;
  bool _showButton = true;
  bool drag = true;
  bool _isFullyExpanded = false;
  bool isLocationDifferent = false;
  bool _isSheetVisible = true;

  String? country = 'india';

  late DraggableScrollableController _draggableController;

  // GoogleMapController _controller;
  GoogleMapController? _controller;

  final Set<Circle> _circles = {};
  Set<Marker> markersList = {};

  // final Mode _mode = Mode.overlay;

  List<Map<String, dynamic>> explore_items = [
    {
      "name": "Restaurant",
      "description": "Because Every Parcel \nMatters",
      "content": "Delivery in 15mins",
      "img": "assets/images/food.webp"
    },
    {
      "name": "Shop",
      "description": "Groceries Made Easy,\nDelivered With Love",
      "content": "Up to 60% OFF",
      "img": "assets/images/shop_image.png.png"
    }
  ];

  final List<LatLng> polylinePoints = [];
  final Set<Polyline> polylines = {};
  final List<Marker> markers = <Marker>[];

  bool isWithinCircle = true; // Track if the camera is within the circle
  int currentHintIndex = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // categorycontroller.categoryget();
      advertise.getadvertisementDetails();
      getProfile.profileget();
      regi.fetchProfile(profileImgae);
      // addinitalmarker();
      getResturantIdFun();
      Provider.of<HomepageProvider>(context, listen: false).getHomepagedatas();

      foodcart.getbillfoodcartfood(km: 0);
      var foodcartprovider =
          Provider.of<FoodCartProvider>(context, listen: false);

      nearbyreget.nearbyresPagingController.refresh();

      inactiverestt.inactiveresget();

      homeaddress.gethomeadresskeyDetails();
      chathealthchecking.getachatstatusDetails();
      // getloc();
      await Provider.of<LocationProvider>(context, listen: false)
          .loadInitialAddressFromSavedData(context);
    });

    _isSheetVisible = true;
    _draggableController = DraggableScrollableController();
    super.initState();

    
  }

  getResturantIdFun() {
    Future.delayed(
      Duration.zero,
      () async {
        final foodcartprovider =
            Provider.of<FoodCartProvider>(context, listen: false);

        var resID = await foodcartprovider.getfoodcartProvider(km: 0);

        if (resID != null) {
          foodcartprovider.searchResById(restaurantId: resID);
        } else {
          print('No Restaurant Available...!');
        }
      },
    );
  }

  @override
  void dispose() {
    _draggableController.dispose();
    _controller?.dispose();
    super.dispose();
  }

  var address;
  // final List<Marker> markers = <Marker>[];
  bool iscurrentlocationGot = false;
  bool canPop = true;
  Position? currentPosition;
  bool isloading = false;

  addRandomMarker({latitude, longitude}) async {
    markersList.clear();
    markersList.add(
      Marker(
        markerId: const MarkerId('current_location'),
        position: LatLng(latitude, longitude),
        visible: true,
        draggable: true,
        icon: await getDotMarker(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // List<dynamic> categories = ["shop", ...categorycontroller.category["data"]];
    List<Map<String, dynamic>> categories =
        List<Map<String, dynamic>>.from(categorycontroller.category["data"]);

    categories.insert(
        1, {"status": true, "productName": "SHOP", "productType": "shop"});

    var locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    var mapDataProvider = Provider.of<MapDataProvider>(context);
    final foodcartprovider = Provider.of<FoodCartProvider>(context);

    Size screenSize = MediaQuery.of(context).size;
    double scrollSize = screenSize.height;
    final num = Get.put(Nearbyrescontroller());
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        _controller
            ?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(initiallat, initiallong),
              zoom: 18,
            ),
          ),
        )
            .whenComplete(() {
          setState(() {
            _isSheetVisible = true;
          });
        });

        if (didPop) return;

        if (_isSheetVisible = true) {
          await ExitApp.handlePop();
        }
      },
      child: Scaffold(
        backgroundColor: 
 Color(0xFF623089),
 //body: Center(child: Lottie.asset("assets/animations/loader_7_f_00_ff.json")),
 
 extendBodyBehindAppBar: true,

        body: SafeArea(
          child: Stack(children: [
           
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                        
                    width: MediaQuery.of(context).size.width * 0.76,
                    height: MediaQuery.of(context).size.height * 0.085,
                 // color: Colors.amber,
                    child: 
                      
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Get.to(AddressSearchScreen(),
                                      transition: Transition.rightToLeft,
                                      duration:
                                          const Duration(milliseconds: 200));
                                },
                                child: Consumer<LocationProvider>(
                                  builder: (context, value, child) {
                                    if (value.isloading == true) {
                                      return const CupertinoActivityIndicator();
                                    } else if (value.fullAddresss == null) {
                                      return const Text(' No Data ');
                                    } else {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                         
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                   String fullAddress = [
                                                    locationProvider
                                                        .address.street,
                                                    locationProvider
                                                        .address.subLocality,
                                                    locationProvider
                                                        .address.locality,
                                                    locationProvider.address
                                                        .administrativeArea,
                                                    locationProvider
                                                        .address.postalCode,
                                                    locationProvider
                                                        .address.country
                                                  ]
                                                      .where((part) =>
                                                          part != null &&
                                                          part.isNotEmpty)
                                                      .join(', ');
                                                            
                                                  addAddressBottomSheet(
                                                    context: context,
                                                    address: fullAddress,
                                                    locality: locationProvider
                                                        .address.locality,
                                                    country: locationProvider
                                                        .address.country,
                                                    state: locationProvider
                                                        .address
                                                        .administrativeArea,
                                                    pincode: locationProvider
                                                        .address.postalCode,
                                                    street: locationProvider
                                                        .address.street,
                                                    lattitude: locationProvider
                                                        .position.latitude,
                                                    longitude: locationProvider
                                                        .position.longitude,
                                                    ishomescreen: true,
                                                  );
                                                },
                                                child: Image.asset(
                                                    othersicon,
                                                    scale: 3,
                                                    color: Colors.white,
                                                  ),
                                              ),
                                                //  const Icon(Icons.location_pin),
                                              SizedBox(width: 5.w,),
                                              Text(mapDataProvider.addressType,
                                                  style:TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeight.w800,
    color: Customcolors.DECORATION_WHITE,
    fontFamily: 'Poppins-Medium',
  )),
                                                          SizedBox(width: 5.w,),
                                              Icon(
                                                    Icons
                                                        .keyboard_arrow_down_sharp,
                                                    color: Colors.white,
                                                  )
                                            ],
                                          ),
                                          Padding(
                                            padding:  EdgeInsets.only(
                                                left: 5.w),
                                            child: Text(
                                              value.fullAddresss,
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                //fontSize: 14,
                                                fontWeight: FontWeight.w300,
                                                // color: Customcolors.DECORATION_WHITE,
                                                color: Customcolors
                                                    .DECORATION_WHITE,
                                                fontFamily: 'Poppins-Medium',
                                              ),
                                              //   CustomTextStyle.smallblacktext,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                       
                  ),
                          
                  // Profile Image
                          
                //  const SizedBox(width: 10),
                          
                  InkWell(
                    onTap: () {
                      regi.fetchProfile(profileImgae);
                      Get.to(const ProfileScreen(),
                          transition: Transition.leftToRight,
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInOut);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.13,
                      height: MediaQuery.of(context).size.width * 0.13,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color.fromRGBO(254, 236, 227, 8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: GetBuilder<RegisterscreenController>(
                        builder: (controller) {
                          final hasProfileImage =
                              controller.profileImageUrl.isNotEmpty;
                          
                          return Center(
                            child: CircleAvatar(
                              radius: 40.r,
                              backgroundColor: Colors.blue.shade100,
                              child: ClipOval(
                                child: SizedBox(
                                  height: 115.h,
                                  width: 115.w,
                                  child: hasProfileImage && UserId != null
                                      ? Image.network(
                                          controller.profileImageUrl,
                                          key: ValueKey(controller
                                              .profileImageUrl), // Helps force rebuild
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              "assets/images/Profile.png",
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        )
                                      : Image.asset(
                                          "assets/images/Profile.png",
                                          key: const ValueKey(
                                              'default'), // Force rebuild when profileImageUrl is empty
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _isSheetVisible ? const SizedBox() : SizedBox(),
            Stack(
              children: [
                // Positioned(
                //   top: 80.h,
                //   left: 10.w,
                //   right: 10.w,
                //   child: SearchForBarWidget(
                //     onTap: () {
                //       Get.to(const Foodsearchscreen(),
                //           transition: Transition.leftToRight);
                //     },
                //     rotationTexts: foodrotationTexts,
                //   ),
                // ),
          
                //Bottom Sheet
          
                AnimatedVisibility(
                    visible: _isSheetVisible,
                    enter: slideInVertically(),
                    exit: slideOutVertically(),
                    child: DraggableScrollableSheet(
                      controller: _draggableController,
                      initialChildSize: 0.85,
                      minChildSize: 0.85,
                      maxChildSize: 0.85,
                      expand: true,
                      builder: (BuildContext context,
                          ScrollController scrollController) {
                        return NotificationListener<
                            DraggableScrollableNotification>(
                          onNotification: (notification) {
                            setState(() {
                              _isFullyExpanded = notification.extent == 1.0;
                              scrollSize = notification.extent;
                            });
          
                            return true;
                          },
                          child: Container(
                            height: screenSize.height,
                            decoration:
                                CustomContainerDecoration.whitebordercontainer(),
                            child: CustomScrollView(
                              physics: const ClampingScrollPhysics(),
                              controller: scrollController,
                              shrinkWrap: true,
                              slivers: [
                                SliverList(
                                  delegate: SliverChildListDelegate([
                                    Container(
                                      decoration: CustomContainerDecoration
                                          .whitebordercontainer(),
                                    
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                         
                                          Obx(() {
                                          
                                            if (categorycontroller
                                                .iscategoryloading.isTrue) {
                                              return const HomeScreenShimmer();
                                            }
                                                
                                            return SingleChildScrollView(
                                              child: Padding(
                                                padding:  EdgeInsets.only(
                                                    top: 20.h,
                                                    left: 10.w,
                                                    right: 10.w,
                                                    bottom: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "EXPLORE ITEMS",
                                                      style: TextStyle(
                                                          fontSize: 17.sp,
                                                        //  fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                    ),
                                                    SizedBox(
                                                      height: 20.h,
                                                    ),
                                                
                                                InkWell(
                                                  onTap: () {
                                                     num.updateIndex(0);
                                                 Get.to( Foodscreen( categoryFilter: nearbyreget.selectedIndex.value ==0 ? "restaurant"
                                                                          : "shop"), 
                                                                          transition:
                                                                      Transition
                                                                          .rightToLeft);
                                                  },
                                                  child:
                                                  //  Container(height: 137,
                                                  // decoration: BoxDecoration(
                                                  // borderRadius: BorderRadius.circular(10),
                                                  // gradient: LinearGradient(
                                                  //   begin: Alignment.topCenter,
                                                  //   end: Alignment.bottomCenter,
                                                  //   colors: [
                                                  //    Color(0xFFAE62E8),
                                                  //  Color(0xFF623089)
                                                  
                                                  // ])
                                                  // ),
                                                  // child: Center(child: Text("Order Now",style: TextStyle(
                                                  //   color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold
                                                  // ),)),
                                                  // ),
                                                
          
          //  Container(
          //       margin: EdgeInsets.all(12.w),
          //       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(16.r),
          //         gradient: const LinearGradient(
          //           colors: [
          //             Color(0xFFAE62E8),
          
          //  Color(0xFF623089)
          
          //           ], // Purple shades
          //           begin: Alignment.topCenter,
          //           end: Alignment.bottomCenter,
          //         ),
          //       ),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           // Left side text
          //           Expanded(
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text(
          //                   "Get a Free Delivery",
          //                   style: TextStyle(
          //                     fontSize: 18.sp,
          //                     fontWeight: FontWeight.bold,
          //                     color: Colors.white,
          //                   ),
          //                 ),
          //                 SizedBox(height: 4.h),
          //                 Text(
          //                   "on your first order",
          //                   style: TextStyle(
          //                     fontSize: 14.sp,
          //                     color: Colors.white.withOpacity(0.9),
          //                   ),
          //                 ),
          //                 SizedBox(height: 12.h),
          //                 Container( padding: EdgeInsets.symmetric(
          //                       horizontal: 20.w,
          //                       vertical: 8.h,
          //                     ),
          //                     decoration: BoxDecoration(color:Colors.white,
          //                       borderRadius: BorderRadius.circular(5.r)),
          //                   child: Text(
          //                     "Order Now",
          //                     style: TextStyle(fontSize: 14.sp,color:  Color(0xFF623089),fontWeight: FontWeight.w400),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          
          //           // Right side image
          //           Image.asset(
          //           "assets/images/biriyaniLogo.png",
          //             height: 100.h,
          //             fit: BoxFit.cover,
          //           ),
          //         ],
          //       ),
          //     )
          
          
                                                
                                                
                                                 Container(
                                                              //  height: 150,
                                                            //  width: 200,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(0),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16.r),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade300,
                                                                    blurRadius:
                                                                        6,
                                                                    spreadRadius:
                                                                        2,
                                                                    offset:
                                                                        const Offset(
                                                                            2,
                                                                            2),
                                                                  ),
                                                                ],
                                                              ),
                                                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                children: [
                                                                  Column(//mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      // Title
                                                                      Text(
                                                                      explore_items[0]["name"],
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18.sp,
                                                                            fontWeight:
                                                                                FontWeight
                                                                                    .bold,
                                                                            color: Color(
                                                                                0xFF623089)),
                                                                      ),
                                                                     SizedBox(
                                                                          height:
                                                                              4.h),
                                                                   
                                                                      // Subtitle
                                                                      Text(
                                                                      explore_items[0]["description"],
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              13.sp,
                                                                              fontWeight: FontWeight.w400,
                                                                          color: Colors
                                                                                  .grey[
                                                                              600],
                                                                        ),
                                                                      ),
                                                                SizedBox(
                                                                          height:
                                                                              8.h),
                                                                                Container(padding: EdgeInsets.only(left: 30,right: 30,top: 10,bottom: 10),
                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r),
                                                                      gradient: LinearGradient(colors: [
                                                                        Color(0xFF623089),
                                                                       
                                                                         Color(0xFFAE62E8),
                                                                      
                                                                      
                                                                      
                                                                      ],
                                                                      begin: Alignment.centerLeft,
                                                                      end: Alignment.centerRight,)),
                                                                        child: Center(
                                                                          child: Row(
                                                                            children: [
                                                                              Text(
                                                                                "Order Now",
                                                                                style: TextStyle(
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.white),
                                                                              ),
                                                                               SizedBox(
                                                                              width:
                                                                                  5.w,
                                                                            ),
                                                                            Icon(
                                                                              Icons
                                                                                  .arrow_forward_rounded,
                                                                              size:
                                                                                  16,
                                                                              color:
                                                                                  Colors.white,
                                                                            ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                   
                                                                      // Delivery Tag
                                                                      // Container(
                                                                      //   padding: const EdgeInsets
                                                                      //       .symmetric(
                                                                      //       horizontal: 10,
                                                                      //       vertical: 4),
                                                                      //   decoration:
                                                                      //       BoxDecoration(
                                                                      //     gradient:
                                                                      //         LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
                                                                      //       Colors.green.shade100,
                                                                      //       Colors.white
                                                                      //     ]),
                                                                      //     // color: Colors.green.shade100,
                                                                      //     borderRadius:
                                                                      //         BorderRadius.circular(8),
                                                                      //   ),
                                                                      //   child:
                                                                      //       Text(
                                                                      //     explore_items[0]["content"],
                                                                      //     style:
                                                                      //         TextStyle(
                                                                      //       fontSize: 15,
                                                                      //       color: Colors.green[800],
                                                                      //       fontWeight: FontWeight.w500,
                                                                      //     ),
                                                                      //   ),
                                                                      // ),
                                                                 
                                                                    ],
                                                
                                                                    
                                                                  ),
                                                
                                                                  Column(children: [
                                                                         Container(height:115.h,
                                                                           child: Image.asset(
                                                                                                                                              explore_items[0]["img"],
                                                                                                                                            
                                                                                                                                                 
                                                                                                                                           fit: BoxFit.cover, ),
                                                                         ),
                                                                      // const SizedBox(
                                                                      //     height:
                                                                      //         12),
                                                                   
                                                                      // Image + Arrow Button
                                                                    
                                                                  ],)
                                                                ],
                                                              ),
                                                            ),
                                                
                                                ),
          
                                                SizedBox(height: 10.h,),
                                                
          
               InkWell(
                                                  onTap: () {
                                                     num.updateIndex(1);
                                                 Get.to( Foodscreen( categoryFilter: nearbyreget.selectedIndex.value ==1 ? "shop": "restaurant"
                                                                        ), 
                                                                          transition:
                                                                      Transition
                                                                          .rightToLeft);
                                                  },
                                                  child:
                                                 
          
          
                                                
                                                
                                                 Container(
                                                              //  height: 150,
                                                            //  width: 200,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(0),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade300,
                                                                    blurRadius:
                                                                        6,
                                                                    spreadRadius:
                                                                        2,
                                                                    offset:
                                                                        const Offset(
                                                                            2,
                                                                            2),
                                                                  ),
                                                                ],
                                                              ),
                                                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                children: [
                                                                  Column(//mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      // Title
                                                                      Text(
                                                                      explore_items[1]["name"],
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18.sp,
                                                                            fontWeight:
                                                                                FontWeight
                                                                                    .bold,
                                                                            color: Color(
                                                                                0xFF623089)),
                                                                      ),
                                                                   SizedBox(
                                                                          height:
                                                                              4.h),
                                                                   
                                                                      // Subtitle
                                                                      Text(
                                                                      explore_items[1]["description"],
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              13.sp,
                                                                              fontWeight: FontWeight.w400,
                                                                          color: Colors
                                                                                  .grey[
                                                                              600],
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              8.h),
                                                                                Container(padding: EdgeInsets.only(left: 30,right: 30,top: 10,bottom: 10),
                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r),
                                                                      gradient: LinearGradient(colors: [
                                                                        Color(0xFF623089),
                                                                       
                                                                         Color(0xFFAE62E8),
                                                                      
                                                                      
                                                                      
                                                                      ],
                                                                      begin: Alignment.centerLeft,
                                                                      end: Alignment.centerRight,)),
                                                                        child: Center(
                                                                          child: Row(
                                                                            children: [
                                                                              Text(
                                                                                "Order Now",
                                                                                style: TextStyle(
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.white),
                                                                              ),
                                                                               SizedBox(
                                                                              width:
                                                                                  5,
                                                                            ),
                                                                            Icon(
                                                                              Icons
                                                                                  .arrow_forward_rounded,
                                                                              size:
                                                                                  16,
                                                                              color:
                                                                                  Colors.white,
                                                                            ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                   
                                                                   
                                                                    ],
                                                
                                                                    
                                                                  ),
                                                
                                                                  Column(children: [
                                                                         Container(height: 115.h,
                                                                           child: Image.asset(
                                                                                                                                              explore_items[0]["img"],
                                                                                                                                            
                                                                                                                                                 
                                                                                                                                           fit: BoxFit.cover, ),
                                                                         ),
                                                                     
                                                                    
                                                                  ],)
                                                                ],
                                                              ),
                                                            ),
                                                
                                                ),
                                                
          
          
          
          
                                                
                                                    // Row(
                                                    //   mainAxisAlignment:
                                                    //       MainAxisAlignment
                                                    //           .spaceBetween,
                                                    //   children:
                                                    //       //  List.generate(categories.length,
                                                    //       List.generate(
                                                    //     explore_items.length,
                                                    //     (index) {
                                                    //       //  var productname = categories[index]["productName"];
                                                    //       var productname =
                                                    //           explore_items[
                                                    //                   index]
                                                    //               ["name"];
                                                    //       var productdescription =
                                                    //           explore_items[
                                                    //                   index][
                                                    //               "description"];
                                                    //       var productcontent =
                                                    //           explore_items[
                                                    //                   index]
                                                    //               ["content"];
                                                    //       var productimg =
                                                    //           explore_items[
                                                    //               index]["img"];
                                                
                                                    //       if (categories[index]
                                                    //               ["status"] ==
                                                    //           false) {
                                                    //         return const SizedBox(); // Skips rendering this item
                                                    //       }
                                                    //       return InkWell(
                                                    //         onTap: () {
                                                    //           num.updateIndex(
                                                    //               index);
                                                    //           Get.to(
                                                    //               Foodscreen(
                                                    //                   categoryFilter: nearbyreget.selectedIndex.value ==
                                                    //                           0
                                                    //                       ? "restaurant"
                                                    //                       : "shop"),
                                                    //               transition:
                                                    //                   Transition
                                                    //                       .rightToLeft);
                                                    //         },
                                                    //         child: Container(
                                                    //           //  height: 137,
                                                    //           width: 200,
                                                    //           padding:
                                                    //               const EdgeInsets
                                                    //                   .all(16),
                                                    //           decoration:
                                                    //               BoxDecoration(
                                                    //             color: Colors
                                                    //                 .white,
                                                    //             borderRadius:
                                                    //                 BorderRadius
                                                    //                     .circular(
                                                    //                         16),
                                                    //             boxShadow: [
                                                    //               BoxShadow(
                                                    //                 color: Colors
                                                    //                     .grey
                                                    //                     .shade300,
                                                    //                 blurRadius:
                                                    //                     6,
                                                    //                 spreadRadius:
                                                    //                     2,
                                                    //                 offset:
                                                    //                     const Offset(
                                                    //                         2,
                                                    //                         2),
                                                    //               ),
                                                    //             ],
                                                    //           ),
                                                    //           child: Column(
                                                    //             crossAxisAlignment:
                                                    //                 CrossAxisAlignment
                                                    //                     .start,
                                                    //             children: [
                                                    //               // Title
                                                    //               Text(
                                                    //                 productname,
                                                    //                 style: TextStyle(
                                                    //                     fontSize:
                                                    //                         16,
                                                    //                     fontWeight:
                                                    //                         FontWeight
                                                    //                             .bold,
                                                    //                     color: Color(
                                                    //                         0xFF623089)),
                                                    //               ),
                                                    //               const SizedBox(
                                                    //                   height:
                                                    //                       4),
                                                
                                                    //               // Subtitle
                                                    //               Text(
                                                    //                 productdescription,
                                                    //                 style:
                                                    //                     TextStyle(
                                                    //                   fontSize:
                                                    //                       11,
                                                    //                   color: Colors
                                                    //                           .grey[
                                                    //                       600],
                                                    //                 ),
                                                    //               ),
                                                    //               const SizedBox(
                                                    //                   height:
                                                    //                       8),
                                                
                                                    //               // Delivery Tag
                                                    //               Stack(
                                                    //                   clipBehavior:
                                                    //                       Clip.none,
                                                    //                   children: [
                                                    //                     Container(
                                                    //                       padding: const EdgeInsets
                                                    //                           .symmetric(
                                                    //                           horizontal: 10,
                                                    //                           vertical: 4),
                                                    //                       decoration:
                                                    //                           BoxDecoration(
                                                    //                         gradient:
                                                    //                             LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
                                                    //                           Colors.green.shade100,
                                                    //                           Colors.white
                                                    //                         ]),
                                                    //                         // color: Colors.green.shade100,
                                                    //                         borderRadius:
                                                    //                             BorderRadius.circular(8),
                                                    //                       ),
                                                    //                       child:
                                                    //                           Text(
                                                    //                         productcontent,
                                                    //                         style:
                                                    //                             TextStyle(
                                                    //                           fontSize: 10,
                                                    //                           color: Colors.green[800],
                                                    //                           fontWeight: FontWeight.w500,
                                                    //                         ),
                                                    //                       ),
                                                    //                     ),
                                                    //                     Positioned(
                                                    //                       bottom:
                                                    //                           -42,
                                                    //                       right:
                                                    //                           -65,
                                                    //                       child:
                                                    //                           Image.asset(
                                                    //                         productimg,
                                                    //                         height:
                                                    //                             60,
                                                    //                       ),
                                                    //                     ),
                                                    //                   ]),
                                                    //               const SizedBox(
                                                    //                   height:
                                                    //                       12),
                                                
                                                    //               // Image + Arrow Button
                                                    //               InkWell(
                                                    //                 onTap: () {
                                                    //                   // num.updateIndex(index);
                                                    //                   //   Get.to( Foodscreen(categoryFilter: nearbyreget.selectedIndex.value==0?"restaurant":"shop"),
                                                    //                   //               transition: Transition.rightToLeft);
                                                    //                 },
                                                    //                 child: Row(
                                                    //                   //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    //                   children: [
                                                    //                     Text(
                                                    //                       "Explore",
                                                    //                       style: TextStyle(
                                                    //                           fontWeight: FontWeight.bold,
                                                    //                           color: Colors.black),
                                                    //                     ),
                                                    //                     SizedBox(
                                                    //                       width:
                                                    //                           5,
                                                    //                     ),
                                                    //                     Icon(
                                                    //                       Icons
                                                    //                           .arrow_forward_rounded,
                                                    //                       size:
                                                    //                           16,
                                                    //                       color:
                                                    //                           Color(0xFF623089),
                                                    //                     ),
                                                    //                     // Food Image
                                                    //                   ],
                                                    //                 ),
                                                    //               ),
                                                    //             ],
                                                    //           ),
                                                    //         ),
                                                    //       );
                                                    //     },
                                                    //   ),
                                                    // ),
                                                    // SizedBox(
                                                    //   height: 30,
                                                    // ),
                                                    // Row(
                                                    //   mainAxisAlignment:
                                                    //       MainAxisAlignment
                                                    //           .center,
                                                    //   children: [
                                                    //     Image.asset(
                                                    //         "assets/images/Line 1.png"),
                                                    //     SizedBox(
                                                    //       width: 10,
                                                    //     ),
                                                    //     Text(
                                                    //       "TOP PICKS FOR YOU",
                                                    //       style: TextStyle(
                                                    //           color:
                                                    //               Colors.black,
                                                    //           fontSize: 18),
                                                    //     ),
                                                    //     SizedBox(
                                                    //       width: 10,
                                                    //     ),
                                                    //     Image.asset(
                                                    //         "assets/images/Line 1.png"),
                                                    //   ],
                                                    // ),
                                                    // AdvertisementScreen(),
          
                                                    SizedBox(height: 100.h,),
                                                    Center(
                                                      child: Image.asset(
                                                          "assets/images/miogra_frame.png"),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                          if (_showButton)
                                            Obx(() {
                                              if (categorycontroller
                                                  .iscategoryloading.isTrue) {
                                                return const SizedBox();
                                              } else if (categorycontroller
                                                      .category ==
                                                  null) {
                                                return const Center(
                                                  child: Column(
                                                    children: [
                                                      Image(
                                                        image: AssetImage(
                                                            "assets/images/Categorygif.gif"),
                                                        fit: BoxFit.cover,
                                                      ),
                                                      Text(
                                                        "Unable to reach the server. Please check your internet connection and restart the application...",
                                                        style: CustomTextStyle
                                                            .blackbold14,
                                                      )
                                                    ],
                                                  ),
                                                );
                                              } else if (categorycontroller
                                                  .category["data"].isEmpty) {
                                                return Center(
                                                    child: Container());
                                              } else {
                                                return Container(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 0),
                                                    itemCount:
                                                        categorycontroller
                                                            .category["data"]
                                                            .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      var productTitle =
                                                          categorycontroller
                                                              .category["data"]
                                                                  [index][
                                                                  "productTitle"]
                                                              .toString();
                                                      var productName =
                                                          categorycontroller
                                                                      .category[
                                                                  "data"][index]
                                                              ["productName"];
                                                      var productType =
                                                          categories[index]
                                                              ["productType"];
                                                
                                                      var description =
                                                          categorycontroller
                                                                      .category[
                                                                  "data"][index]
                                                              [
                                                              "productDescription"];
                                                      var productCatId =
                                                          categorycontroller
                                                                      .category[
                                                                  "data"][index]
                                                              ["_id"];
                                                      var status =
                                                          categories[index]
                                                              ["status"];
                                                
                                                      if (num.selectedIndex ==
                                                          index) {
                                                        return Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [],
                                                        );
                                                      } else {
                                                        return const SizedBox
                                                            .shrink();
                                                      }
                                                    },
                                                  ),
                                                );
                                              }
                                            }),
                                          // if (_isFullyExpanded)
                                          //   const AdvertisementScreen(),
                                        ],
                                      ),
                                    ),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )),
              ],
            )
          ]),
        ),
      ),
    );
  }

  String buttonName({required String productType}) {
    switch (productType) {
      case 'restaurant':
        return 'Order Now';
      case 'services':
        return 'Continue';
      case 'shop':
        return 'Order Now';
      case 'meat':
        return 'Shop Now';
      default:
        return 'Continue';
    }
  }
}


