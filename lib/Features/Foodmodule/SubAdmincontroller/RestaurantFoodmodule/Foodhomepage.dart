// // ignore_for_file: avoid_print, file_names

// import 'dart:async';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:testing/Features/Authscreen/AuthController/Registercontroller.dart';
// import 'package:testing/Features/Authscreen/AuthController/controllerForFavAdd.dart';
// import 'package:testing/Features/Authscreen/Loginscreen.dart';
// import 'package:testing/Features/Bottomsheets/Adduserbottomsheet.dart';
// import 'package:testing/Features/Foodmodule/Data/cartprovider.dart';
// import 'package:testing/Features/Foodmodule/Domain/favouritemodel.dart';
// import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Addfoodcontroller.dart';
// import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Bannercontroller.dart';
// import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Categorylistcontroller.dart';
// import 'package:testing/Features/Foodmodule/SubAdmincontroller/Inactiverescontroller.dart';
// import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/BottomBanner.dart';
// import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodsearch.dart';

// import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/ProductCategorylist.dart';
// import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/TopBanner.dart';
// import 'package:testing/Features/Foodmodule/SubAdmincontroller/Getnearbyrescontroller.dart';

// import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Restaurantcard.dart';
// import 'package:testing/Features/Foodmodule/getFoodCartProvider.dart';
// import 'package:testing/Features/Homepage/AddressController/Addresscontroller.dart';
// import 'package:testing/Features/Homepage/Profile_Orders/CartFloatingbutton.dart';

// import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Chatbotcontroller.dart';
// import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Redirectcontroller.dart';
// import 'package:testing/Features/Homepage/profile.dart';

// import 'package:testing/Features/OrderScreen/OrderScreenController/Favrestaurantcotroller.dart';
// import 'package:testing/inlinebannerad.dart';

// import 'package:testing/utils/Buttons/CustomAlertDialoug.dart';
// import 'package:testing/utils/Buttons/CustomLogoutdialog.dart';
// import 'package:testing/utils/Buttons/CustomTextstyle.dart';
// import 'package:testing/utils/Buttons/Customspace.dart';
// import 'package:testing/utils/Const/ApiConstvariables.dart';
// import 'package:testing/utils/Const/constValue.dart';
// import 'package:testing/utils/Const/localvaluesmanagement.dart';
// import 'package:testing/utils/CustomColors/Customcolors.dart';
// import 'package:testing/utils/Custom_Widgets/addressbottomsheet.dart';
// import 'package:testing/utils/Custom_Widgets/customCartBox.dart';
// import 'package:testing/utils/Shimmers/Nearestrestaurantshimmer.dart';
// import 'package:testing/utils/Shimmers/viewrestaurantloader.dart';
// import 'package:testing/utils/Toast/customtoastmessage.dart';

// import 'package:testing/utils/exitapp.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:loader_overlay/loader_overlay.dart';
// import 'package:provider/provider.dart';
// import 'Foodviewfirstscreen.dart';
// import 'foodcartscreen.dart';

// class Foodscreen extends StatefulWidget {
//   final String categoryFilter;
//   final bool isValue;
//   final bool fromPickupscreen;
//   final bool isfrommanualsearchaddress;
//   const Foodscreen(
//       {super.key,
//       this.isValue = false,
//       this.fromPickupscreen = false,
//       this.isfrommanualsearchaddress = false,
//       this.categoryFilter = ""});

//   @override
//   State<Foodscreen> createState() => _FoodscreenState();
// }

// int activePage = 1;

// class _FoodscreenState extends State<Foodscreen> {
//   Categorylistcontroller categorycontroller = Get.put(Categorylistcontroller());
//   RedirectController redirect = Get.put(RedirectController());
//   AddressController addresscontroller = Get.put(AddressController());
//   Nearbyrescontroller nearbyreget = Get.put(Nearbyrescontroller());
//   Inactiverescontroller inactiverestt = Get.put(Inactiverescontroller());
//   Foodcartcontroller foodcart = Get.put(Foodcartcontroller());
//   FavresGetcontroller favrestget = Get.put(FavresGetcontroller());
//   Chatbotcontroller chatttbot = Get.put(Chatbotcontroller());
//   RegisterscreenController regi = Get.put(RegisterscreenController());

//   List<Map<String, dynamic>> explore_items = [
//     {
//       "name": "Restaurant",
//       "description": "Because Every Parcel \nMatters",
//       "content": "Delivery in 15mins",
//       "img": "assets/images/20251021_105251.png"
//     },
//     {
//       "name": "Shop",
//       "description": "Groceries Made Easy,\nDelivered With Love",
//       "content": "Up to 60% OFF",
//       "img":
//           "assets/images/Storefont_shop_icon_store_building_vector_illustration___Premium_Vector.jpeg-removebg-preview.png"
//     }
//   ];

//   // location postel code variables 4

//   List addressdata = [];
//   String? selectedPostalCode;
//   double? selectedLatitude;
//   double? selectedLongitude;
//   String? addressType;
//   String? selectvalue;
//   int resPage = 0;
//   int nearbyrespage = 0;
//   late Timer nearbyrestimer;

//   final ScrollController _scrollController = ScrollController();

//   final PageController nearbyrespagecontroller = PageController(initialPage: 0);
//   final PageController respagecontroller = PageController(initialPage: 0);

//   bool haveCart = false;

//   dynamic bottombannerList;
//   bool hasBottomBannerList = false;

//   @override
//   void initState() {
//     Provider.of<FavoritesProvider>(context, listen: false).removeAllFavorites();

//     if (widget.fromPickupscreen) {
//       fromPickupscreen();
//     } else if (widget.isfrommanualsearchaddress) {
//       isfrommanualsearchaddress();
//     }
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       var foodcartprovider =
//           Provider.of<FoodCartProvider>(context, listen: false);
//       loge.i(
//           'km from homepage${foodcartprovider.totalDis}  ${foodcartprovider.totalDist}');
//       // double  totalDistance = double.parse(foodcartprovider.totalDis.split(' ').first.toString());
//       // Provider.of<HomepageProvider>(context, listen: false).getHomepagedatas();

//       Provider.of<HomepageProvider>(context, listen: false).getBanner(
//           categoryFilter:
//               nearbyreget.selectedIndex.value == 0 ? "restaurant" : "shop");
//       Provider.of<HomepageProvider>(context, listen: false).getHomepagedatas(
//           categoryFilter:
//               nearbyreget.selectedIndex.value == 0 ? "restaurant" : "shop");
//       nearbyreget.fetchResPage(0);
//       redirect.getredirectDetails(); //1
//       foodcart.getbillfoodcartfood(km: 0);
//       addresscontroller.getaddressapi(
//           context: context, latitude: "", longitude: "");
//       addresscontroller.getprimaryaddressapi();
//       await foodcart.getfoodcartfood(km: 0);
//       Future.delayed(Duration.zero, () {
//         foodcartprovider.getfoodcartProvider(km: resGlobalKM);
//       });
//     });

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<FavoritesProvider>(context, listen: false)
//           .initializeDatabase();
//     });

//     Provider.of<InitializeFavProvider>(context, listen: false)
//         .favInitiliteProvider(cntxtt: context);
//     //Banner

//     super.initState();
//   }

//   fromPickupscreen() {
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       loge.i(resGlobalKM);
//       Provider.of<HomepageProvider>(context, listen: false).getHomepagedatas(
//           categoryFilter:
//               nearbyreget.selectedIndex.value == 0 ? "restaurant" : "shop");
//       addresscontroller.getaddressapi(
//           context: context, latitude: "", longitude: "");
//       addresscontroller.getprimaryaddressapi();

//       await foodcart.getfoodcartfood(km: resGlobalKM);
//       nearbyreget.nearbyresPagingController.refresh();

//       inactiverestt.inactiveresget();
//     });
//   }

//   isfrommanualsearchaddress() {
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       var foodcartprovider =
//           Provider.of<FoodCartProvider>(context, listen: false);

//       loge.i(resGlobalKM);
//       Provider.of<HomepageProvider>(context, listen: false).getHomepagedatas(
//           categoryFilter:
//               nearbyreget.selectedIndex.value == 0 ? "restaurant" : "shop");
//       addresscontroller.getaddressapi(
//           context: context, latitude: "", longitude: "");
//       addresscontroller.getprimaryaddressapi();
//       getResturantIdFun();
//       await foodcart.getfoodcartfood(km: resGlobalKM);
//       nearbyreget.nearbyresPagingController.refresh();
//       inactiverestt.inactiveresget();
//     });
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

//   forrefresh() {
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       loge.i(resGlobalKM);
//       getResturantIdFun();
//       Provider.of<HomepageProvider>(context, listen: false).getBanner(
//           categoryFilter:
//               nearbyreget.selectedIndex.value == 0 ? "restaurant" : "shop");
//       Provider.of<HomepageProvider>(context, listen: false).getHomepagedatas(
//           categoryFilter:
//               nearbyreget.selectedIndex.value == 0 ? "restaurant" : "shop");
//       addresscontroller.getaddressapi(
//           context: context, latitude: "", longitude: "");
//       addresscontroller.getprimaryaddressapi();

//       await foodcart.getfoodcartfood(km: resGlobalKM);
//       nearbyreget.nearbyresPagingController.refresh();
//       inactiverestt.inactiveresget();
//     });
//   }

//   @override
//   void dispose() {
//     nearbyrespagecontroller.dispose();
//     _scrollController.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<Map<String, dynamic>> categories =
//         List<Map<String, dynamic>>.from(categorycontroller.category["data"]);

//     categories.insert(
//         1, {"status": true, "productName": "SHOP", "productType": "shop"});
//     final num = Get.put(Nearbyrescontroller());

//     final favoritesProvider = Provider.of<FavoritesProvider>(context);
//     final foodcartprovider = Provider.of<FoodCartProvider>(context);
//     final mapData = Provider.of<MapDataProvider>(context);
//     var orderForOthers = Provider.of<InstantUpdateProvider>(context);
//     var hompageprovider = Provider.of<HomepageProvider>(context);

//     return PopScope(
//       canPop: false,
//       onPopInvoked: (didPop) async {
//         if (didPop) return;
//         await ExitApp.handlePop();
//         //  await ExitApp.homepop();
//         // Get.back();
//       },
//       child: RefreshIndicator(
//         //   color: Customcolors.darkpurple,
//         color: Customcolors.darkpurple,
//         onRefresh: () async {
//           await Future.delayed(
//             const Duration(seconds: 2),
//             () {
//               return forrefresh();
//             },
//           );
//         },
//         child: Scaffold(
//             backgroundColor: const Color(0xffFFFFFF),
//             resizeToAvoidBottomInset: false,
//             // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,

//             floatingActionButton: Padding(
//               padding: EdgeInsets.only(bottom: 13.h, right: 10.w),
//               child: FloatingActionButton(
//                 onPressed: () {
//                   print("printing");
//                   Get.to(const Foodsearchscreen(),
//                       transition: Transition.leftToRight);
//                 },
//                 backgroundColor: Colors.transparent,
//                 child: Container(
//                   height: 50.h,
//                   width: 50.w,
//                   decoration: BoxDecoration(
//                       color: Color(0xFF623089),
//                       //           gradient: LinearGradient(
//                       // begin: Alignment.topCenter,
//                       // end: Alignment.bottomCenter,
//                       // colors: [ Color(0xFFAE62E8),

//                       //          Color(0xFF623089),

//                       //         ]),
//                       borderRadius: BorderRadius.circular(15)),
//                   child: Icon(
//                     Icons.search,
//                     color: Colors.white,
//                     size: 35,
//                   ),
//                 ),
//               ),
//             ),
//             appBar: AppBar(
//               title: Row(
//                 children: [
//                   Expanded(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         //   Image.asset(othersicon, scale: 3),
//                         Image.asset(
//                           "assets/images/location_icon.png",
//                         height: 26.sp,
//                           //height: 30,
//                         ),
//                         const SizedBox(width: 5),
//                         Padding(
//                           padding: EdgeInsets.only(top: 9.h),
//                           child: InkWell(
//                               onTap: () {
//                                 addressbottomsheet(context).then((value) async {
//                                   _scrollController.jumpTo(0); // 👈 Jump to top
//                                   await Provider.of<HomepageProvider>(context,
//                                           listen: false)
//                                       .getHomepagedatas();
//                                   nearbyreget.nearbyresPagingController
//                                       .refresh();
//                                   foodcartprovider.getfoodcartProvider(
//                                       km: resGlobalKM);
//                                 });
//                               },
//                               child: Row(
//                                 children: [
//                                   Text(
//                                     '${mapData.postalCode} - ${mapData.addressType}',
//                                     //  style: CustomTextStyle.font12popinBlack,
//                                     style: TextStyle(
//                                         color: Customcolors.POSTALCODE_COLOR,
//                                         fontSize: 14,
//                                         fontFamily: 'Poppins-Regular',
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   SizedBox(
//                                     width: 5,
//                                   ),
//                                   const Icon(Icons.keyboard_arrow_down_outlined)
//                                 ],
//                               )),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//               // toolbarHeight: 50.h,
//               backgroundColor: const Color(0xffFFFFFF),
//               automaticallyImplyLeading: false,
//               scrolledUnderElevation: 0,
//               //  surfaceTintColor: Customcolors.DECORATION_WHITE,
//               surfaceTintColor: const Color(0xffFFFFFF),
//               actions: [
//                 if (UserId == null || UserId.isEmpty)
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 12),
//                     child: Container(
//                       width: 30,
//                       height: 30,
//                       decoration: const BoxDecoration(
//                         gradient: LinearGradient(
//                           begin: Alignment.topCenter,
//                           end: Alignment.bottomCenter,
//                           colors: [
//                             Customcolors.lightpurple,
//                             Customcolors.darkpurple
//                           ],
//                         ),
//                         shape: BoxShape.circle,
//                       ),
//                       child: IconButton(
//                         padding: EdgeInsets.zero,
//                         iconSize: 20,
//                         visualDensity: VisualDensity.compact,
//                         icon: const Icon(Icons.perm_identity_sharp,
//                             color: Colors.white),
//                         onPressed: () {
//                           showDialog(
//                             context: context,
//                             builder: (_) => LoginRequiredDialog(
//                               title: "Login Required",
//                               content:
//                                   "Please login to view your items in your cart.",
//                               cancelText: "Later",
//                               confirmText: "Log In",
//                               onConfirm: () {
//                                 Get.offAll(() => const Loginscreen());
//                               },
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   )

//                 // else IconButton(
//                 //         onPressed: () {
//                 //           Get.off(const OrdersHistory(), transition: Transition.leftToRight);
//                 //         },
//                 //       //  icon: const Icon(Icons.history, color: Customcolors.DECORATION_BLACK),
//                 //         icon: Image.asset("assets/images/menu.png",height: 30,)
//                 //       ),
//                 else
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 12),
//                     child: InkWell(
//                         onTap: () {
//                           regi.fetchProfile(profileImgae);
//                           Get.to(const ProfileScreen(),
//                               transition: Transition.leftToRight,
//                               duration: const Duration(milliseconds: 250),
//                               curve: Curves.easeInOut);
//                         },
//                         child: Image.asset(
//                           "assets/images/dddd.png",
//                           height: 22.h,
//                         )
//                         // child: Image.asset("assets/images/dddd.png",height: 30,)

//                         //  Container(
//                         //   width: MediaQuery.of(context).size.width * 0.13,
//                         //   height: MediaQuery.of(context).size.width * 0.13,
//                         //   decoration: BoxDecoration(
//                         //     shape: BoxShape.circle,
//                         //     color: const Color.fromRGBO(254, 236, 227, 8),
//                         //     boxShadow: [
//                         //       BoxShadow(
//                         //         color: Colors.black.withOpacity(0.2),
//                         //         spreadRadius: 2,
//                         //         blurRadius: 5,
//                         //         offset: const Offset(0, 1),
//                         //       ),
//                         //     ],
//                         //   ),
//                         //   child: GetBuilder<RegisterscreenController>(
//                         //     builder: (controller) {
//                         //       final hasProfileImage =
//                         //           controller.profileImageUrl.isNotEmpty;

//                         //       return Center(
//                         //         child: CircleAvatar(
//                         //           radius: 40.r,
//                         //           backgroundColor: Colors.blue.shade100,
//                         //           child: ClipOval(
//                         //             child: SizedBox(
//                         //               height: 115.h,
//                         //               width: 115.w,
//                         //               child: hasProfileImage && UserId != null
//                         //                   ? Image.network(
//                         //                       controller.profileImageUrl,
//                         //                       key: ValueKey(controller
//                         //                           .profileImageUrl), // Helps force rebuild
//                         //                       fit: BoxFit.cover,
//                         //                       errorBuilder:
//                         //                           (context, error, stackTrace) {
//                         //                         return Image.asset(
//                         //                           "assets/images/Profile.png",
//                         //                           fit: BoxFit.cover,
//                         //                         );
//                         //                       },
//                         //                     )
//                         //                   : Image.asset(
//                         //                       "assets/images/Profile.png",
//                         //                       key: const ValueKey(
//                         //                           'default'), // Force rebuild when profileImageUrl is empty
//                         //                       fit: BoxFit.cover,
//                         //                     ),
//                         //             ),
//                         //           ),
//                         //         ),
//                         //       );
//                         //     },
//                         //   ),
//                         // ),
//                         ),
//                   ),
//                 SizedBox(
//                   width: 8.h,
//                 )
//               ],
//             ),
//             body: GlobalLoaderOverlay(
//               useDefaultLoading: false,
//               overlayColor: Colors.white,
//               overlayWidgetBuilder: (_) => const LoadingWithRandomText(),
//               child: Stack(
//                 children: [
//                   SingleChildScrollView(
//                     controller: _scrollController,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           //    Container(height: 50,color: Colors.blueGrey,),

//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children:
//                                 //  List.generate(categories.length,
//                                 List.generate(
//                               explore_items.length,
//                               (index) {
//                                 //  var productname = categories[index]["productName"];
//                                 var productname = explore_items[index]["name"];
//                                 var productdescription =
//                                     explore_items[index]["description"];
//                                 var productcontent =
//                                     explore_items[index]["content"];
//                                 var productimg = explore_items[index]["img"];

//                                 if (categories[index]["status"] == false) {
//                                   return const SizedBox(); // Skips rendering this item
//                                 }
//                                 return InkWell(
//                                     onTap: () {
//                                       num.updateIndex(index);
//                                       // Get.to(
//                                       //     Foodscreen(
//                                       //         categoryFilter: nearbyreget.selectedIndex.value ==
//                                       //                 0
//                                       //             ? "restaurant"
//                                       //             : "shop"),
//                                       //     transition:
//                                       //         Transition
//                                       //             .rightToLeft);

//                                       Navigator.push(
//                                         context,
//                                         PageRouteBuilder(
//                                           pageBuilder: (context, animation,
//                                                   secondaryAnimation) =>
//                                               Foodscreen(
//                                                   categoryFilter: nearbyreget
//                                                               .selectedIndex
//                                                               .value ==
//                                                           0
//                                                       ? "restaurant"
//                                                       : "shop"), // <-- Your class here
//                                           transitionsBuilder: (context,
//                                               animation,
//                                               secondaryAnimation,
//                                               child) {
//                                             const begin = Offset(
//                                                 1.0, 0.0); // start from right
//                                             const end = Offset
//                                                 .zero; // end at original position
//                                             const curve = Curves.ease;

//                                             var tween = Tween(
//                                                     begin: begin, end: end)
//                                                 .chain(
//                                                     CurveTween(curve: curve));

//                                             return SlideTransition(
//                                               position: animation.drive(tween),
//                                               child: child,
//                                             );
//                                           },
//                                         ),
//                                       );
//                                     },
//                                     child: Container(
//                                       margin:
//                                           EdgeInsets.only(right: 20, left: 20),
//                                       child: Column(children: [
//                                         Container(
//                                           padding: EdgeInsets.all(5),
//                                           width: MediaQuery.of(context)
//                                                   .size
//                                                   .width *
//                                               0.20,
//                                           height: MediaQuery.of(context)
//                                                   .size
//                                                   .height *
//                                               0.07,
//                                           decoration: BoxDecoration(
//                                             color: nearbyreget
//                                                         .selectedIndex.value ==
//                                                     index
//                                                 // ? Color.fromARGB(255, 189, 164, 209)
//                                                 // : Color.fromARGB(31, 206, 198, 198),
//                                                 ? Color.fromARGB(
//                                                     255, 184, 132, 226)
//                                                 : Color.fromARGB(
//                                                     31, 206, 198, 198),
//                                             shape: BoxShape.circle,
//                                           ),
//                                           child: Center(
//                                             child: Image.asset(
//                                               productimg,
//                                               //height: 120,
//                                               fit: BoxFit.cover,
//                                               //color: Colors.amber,
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           height: 5,
//                                         ),
//                                         Text(
//                                           productname,
//                                           style: TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold,
//                                               color: nearbyreget.selectedIndex
//                                                           .value ==
//                                                       index
//                                                   ? Color(0xFF623089)
//                                                   : Colors.grey),
//                                         ),
//                                       ]),
//                                     ));
//                               },
//                             ),
//                           ),

//                           //                         SizedBox(height: 20.h),
//                           //                                 SizedBox(
//                           //                           width: MediaQuery.of(context).size.width,
//                           //                           child: SearchForBarWidget(
//                           //                             onTap: () {
//                           //                               Get.to(const Foodsearchscreen(),
//                           //                                   transition: Transition.leftToRight);
//                           //                             },
//                           //                             rotationTexts: foodrotationTexts,
//                           //                           ),
//                           //                         ),
//                           SizedBox(height: 20.h),

//                           Consumer<HomepageProvider>(
//                             builder: (context, value, child) {
//                               WidgetsBinding.instance.addPostFrameCallback((_) {
//                                 if (value.isLoading) {
//                                   context.loaderOverlay.show();
//                                 } else {
//                                   context.loaderOverlay.hide();
//                                 }
//                               });

//                               if (value.isLoading) {
//                                 return const SizedBox();
//                               } else if (value.orderModel == null ||
//                                   value.orderModel.isEmpty) {
//                                 return const SizedBox();
//                               } else {
//                                 final data = value.orderModel;
//                                 final topbanner = value.topBanners;
//                                 final bottombanner = value.bottomBanners;
//                                 //  final bannerList = data["banner"];
//                                 final bannerList = topbanner;
//                                 final foodCategories =
//                                     data["foodCategoryNameList"];
//                                 final reccomendedreslist = data["recomResList"]
//                                         ?["data"]?["data"] ??
//                                     [];
//                                 bottombannerList = bottombanner;
//                                 // bottombannerList = data["bottomBanner"];
//                                 final bool hasBanner =
//                                     bannerList != null && bannerList.isNotEmpty;
//                                 final bool hasCategories =
//                                     foodCategories != null &&
//                                         foodCategories.isNotEmpty;
//                                 final bool hasrecommendedlist =
//                                     reccomendedreslist.isNotEmpty;
//                                 hasBottomBannerList =
//                                     bottombannerList != null &&
//                                         bottombannerList.isNotEmpty;

//                                 return ListView(
//                                   shrinkWrap: true,
//                                   physics: const NeverScrollableScrollPhysics(),
//                                   children: [
//                                     // if (hasCategories)
//                                     //   Productcategorylist(
//                                     //       homepagedetails: foodCategories)
//                                     // else
//                                     //   Container(
//                                     //     height: 100,
//                                     //     alignment: Alignment.center,
//                                     //     child: const Text(
//                                     //         "No food categories found!",
//                                     //         style: CustomTextStyle.chipgrey),
//                                     //   ),
//                                     CustomSizedBox(height: 5.h),
//                                     if (hasBanner)
//                                       TopBannerclass(bannerlist: bannerList)
//                                     else
//                                       Container(
//                                         height: 150,
//                                         alignment: Alignment.center,
//                                         child: const Text(
//                                             "No banners available",
//                                             style: CustomTextStyle.chipgrey),
//                                       ),
//                                     CustomSizedBox(height: 10.h),

//                                     if (hasCategories)
//                                       Productcategorylist(
//                                           homepagedetails: foodCategories)
//                                     else
//                                       Container(
//                                         height: 100,
//                                         alignment: Alignment.center,
//                                         child: const Text(
//                                             "No food categories found!",
//                                             style: CustomTextStyle.chipgrey),
//                                       ),

//                                     // CustomSizedBox(height: 5.h),

//                                     //  SizedBox(height: 20.h),
//                                     //         SizedBox(
//                                     //   width: MediaQuery.of(context).size.width,
//                                     //   child: SearchForBarWidget(
//                                     //     onTap: () {
//                                     //       Get.to(const Foodsearchscreen(),
//                                     //           transition: Transition.leftToRight);
//                                     //     },
//                                     //     rotationTexts: foodrotationTexts,
//                                     //   ),
//                                     // ),

//                                     // CustomSizedBox(height: 25.h),

//                                     // if (hasrecommendedlist) ...[
//                                     //   const Padding(
//                                     //     padding:
//                                     //         EdgeInsets.symmetric(horizontal: 8),
//                                     //     child: Text(
//                                     //       "Popular Dining Chains Around You",
//                                     //       style:
//                                     //           CustomTextStyle.googlebuttontext,
//                                     //     ),
//                                     //   ),
//                                     //   CustomSizedBox(height: 10.h),
//                                     //   SizedBox(
//                                     //     height:
//                                     //         MediaQuery.of(context).size.height *
//                                     //             0.13,
//                                     //     child: ListView.builder(
//                                     //       shrinkWrap: true,
//                                     //       scrollDirection: Axis.horizontal,
//                                     //       itemCount: reccomendedreslist.length,
//                                     //       itemBuilder: (context, index) {
//                                     //         return RestaurantItem(
//                                     //             resget:
//                                     //                 reccomendedreslist[index]);
//                                     //       },
//                                     //     ),
//                                     //   ),
//                                     //   CustomSizedBox(height: 10.h),
//                                     // ] else ...[
//                                     //   const SizedBox.shrink()
//                                     // ]
//                                   ],
//                                 );
//                               }
//                             },
//                           ),
//                           // GetBuilder<Nearbyrescontroller>(
//                           //   builder: (nearbyreget) {
//                           //     if (nearbyreget
//                           //                 .nearbyresPagingController.itemList !=
//                           //             null &&
//                           //         nearbyreget.nearbyresPagingController
//                           //             .itemList!.isNotEmpty) {
//                           //       return Padding(
//                           //         padding:
//                           //             const EdgeInsets.symmetric(horizontal: 8),
//                           //         child: InkWell(
//                           //           onTap: () {
//                           //             print(UserId);
//                           //             print(Usertoken);
//                           //           },
//                           //           child: const Text(
//                           //             "Tasty Spots Near You",
//                           //             style: CustomTextStyle.googlebuttontext,
//                           //           ),
//                           //         ),
//                           //       );
//                           //     } else {
//                           //       return const SizedBox.shrink();
//                           //     }
//                           //   },
//                           // ),
//                       nearbyreget
//                                    .selectedIndex
//                                                               .value ==
//                                                           0
//                                                       ? 
//                                                        Text(
//                                       "Restaurants Near You",
//                                       style: TextStyle(
//       fontSize: 15.sp,
//       fontWeight: FontWeight.w800,
//       color: Customcolors.DECORATION_BLACK,
//       fontFamily: 'Poppins-Medium'),
//                                      ):  Text(
//                                       "Shops Near You",
//                                        style: TextStyle(
//       fontSize: 15.sp,
//       fontWeight: FontWeight.w800,
//       color: Customcolors.DECORATION_BLACK,
//       fontFamily: 'Poppins-Medium'),
//                                      ),
//                                      SizedBox(height: 10,),
//                           Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 8.0),
//                             child: PagedListView<int, dynamic>(
//                               physics: const NeverScrollableScrollPhysics(),
//                               shrinkWrap: true,
//                               addAutomaticKeepAlives: false,
//                               addRepaintBoundaries: false,
//                               addSemanticIndexes: false,
//                               pagingController:
//                                   nearbyreget.nearbyresPagingController,
//                               builderDelegate:
//                                   PagedChildBuilderDelegate<dynamic>(
//                                 animateTransitions: true,
//                                 itemBuilder: (context, nearbyresget, index) {
//                                   // Your restaurant setup
//                                   final restaurant = FavoriteRestaurant(
//                                     id: nearbyresget["document"]["_id"],
//                                     name: nearbyresget["document"]["name"]
//                                         .toString(),
//                                     city: nearbyresget["document"]["address"]
//                                             ["city"]
//                                         .toString(),
//                                     region: nearbyresget["document"]["address"]
//                                             ["region"]
//                                         .toString(),
//                                     imageUrl:
//                                         "$globalImageUrlLink${nearbyresget["document"]["imgUrl"]}",
//                                     rating: nearbyresget["document"]["rating"]
//                                         .toString(),
//                                   );

//                                   double endlat = double.tryParse(
//                                           nearbyresget["document"]["address"]
//                                                       ["latitude"]
//                                                   ?.toString() ??
//                                               "") ??
//                                       0.0;
//                                   double endlong = double.tryParse(
//                                           nearbyresget["document"]["address"]
//                                                       ["longitude"]
//                                                   ?.toString() ??
//                                               "") ??
//                                       0.0;

//                                   // The restaurant card
//                                   final restaurantCard = ResturantsCard(
//                                     favoritesProvider: favoritesProvider,
//                                     restaurant: restaurant,
//                                     nearbyresget: nearbyresget,
//                                     langitude: endlong,
//                                     latitude: endlat,
//                                     offervalue: hompageprovider.orderModel ==
//                                                 null ||
//                                             hompageprovider.orderModel.isEmpty
//                                         ? ""
//                                         : hompageprovider
//                                                 .orderModel["appConfigValue"]
//                                             ["value"],
//                                   );

//                                   // 👇 Insert Ad after every 2 items
//                                   if ((index + 1) % 2 == 0) {
//                                     return Column(
//                                       children: [
//                                         restaurantCard,
//                                         const SizedBox(height: 20),
//                                         const InlineBannerAdWidget(), // our ad widget
//                                         const SizedBox(height: 20),
//                                       ],
//                                     );
//                                   }

//                                   return restaurantCard;
//                                 },
//                                 noItemsFoundIndicatorBuilder: (context) {
//                                   return Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 8),
//                                     child: Column(
//                                       children: [
//                                         Image.asset(
//                                           nearbyreget.selectedIndex.value == 0
//                                               ? "assets/images/No Food.png"
//                                               : "assets/images/No orders.png",
//                                           height:
//                                               nearbyreget.selectedIndex.value ==
//                                                       0
//                                                   ? 350
//                                                   : 250,
//                                           fit: BoxFit.cover,
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Text(
//                                             nearbyreget.selectedIndex.value == 0
//                                                 ? "No Restaurants Available right Now"
//                                                 : "No Shops Available right Now",
//                                             style: CustomTextStyle.chipgrey,
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   );
//                                 },
//                                 firstPageProgressIndicatorBuilder: (context) =>
//                                     const Nearestresshimmer(),
//                               ),
//                             ),
//                             // child: PagedListView<int, dynamic>(
//                             //   physics: const NeverScrollableScrollPhysics(),
//                             //   shrinkWrap: true,
//                             //   addAutomaticKeepAlives: false,
//                             //   addRepaintBoundaries: false,
//                             //   addSemanticIndexes: false,
//                             //   pagingController:
//                             //       nearbyreget.nearbyresPagingController,
//                             //   builderDelegate:
//                             //       PagedChildBuilderDelegate<dynamic>(
//                             //     animateTransitions: true,
//                             //     itemBuilder: (context, nearbyresget, index) {
//                             //       final restaurant = FavoriteRestaurant(
//                             //         id: nearbyresget["document"]["_id"],
//                             //         name: nearbyresget["document"]["name"]
//                             //             .toString(),
//                             //         city: nearbyresget["document"]["address"]
//                             //                 ["city"]
//                             //             .toString(),
//                             //         region: nearbyresget["document"]["address"]
//                             //                 ["region"]
//                             //             .toString(),
//                             //         imageUrl:
//                             //             "$globalImageUrlLink${nearbyresget["document"]["imgUrl"]}",
//                             //         rating: nearbyresget["document"]["rating"]
//                             //             .toString(),
//                             //       );

//                             //       double endlat = double.tryParse(
//                             //               nearbyresget["document"]["address"]
//                             //                           ["latitude"]
//                             //                       ?.toString() ??
//                             //                   "") ??
//                             //           0.0;
//                             //       double endlong = double.tryParse(
//                             //               nearbyresget["document"]["address"]
//                             //                           ["longitude"]
//                             //                       ?.toString() ??
//                             //                   "") ??
//                             //           0.0;

//                             //       return ResturantsCard(
//                             //           favoritesProvider: favoritesProvider,
//                             //           restaurant: restaurant,
//                             //           nearbyresget: nearbyresget,
//                             //           langitude: endlong,
//                             //           latitude: endlat,
//                             //           offervalue: hompageprovider.orderModel ==
//                             //                       null ||
//                             //                   hompageprovider.orderModel.isEmpty
//                             //               ? ""
//                             //               : hompageprovider
//                             //                       .orderModel["appConfigValue"]
//                             //                   ["value"]
//                             //           // hompageprovider.orderModel["appConfigValue"]["value"] ?? "",
//                             //           );
//                             //     },
//                             //     noItemsFoundIndicatorBuilder: (context) {
//                             //       return Padding(
//                             //         padding: const EdgeInsets.symmetric(
//                             //             horizontal: 8),
//                             //         child: Column(
//                             //           children: [
//                             //             Image.asset(
//                             //               nearbyreget.selectedIndex.value == 0
//                             //                   ? "assets/images/No Food.png"
//                             //                   : "assets/images/No orders.png",
//                             //               height:
//                             //                   nearbyreget.selectedIndex.value ==
//                             //                           0
//                             //                       ? 350
//                             //                       : 250,
//                             //               //  height: 350,
//                             //               // width: double.infinity,
//                             //               fit: BoxFit.cover,
//                             //             ),
//                             //             Padding(
//                             //               padding: EdgeInsets.all(8.0),
//                             //               child: Text(
//                             //                 nearbyreget.selectedIndex.value == 0
//                             //                     ? "No Restaurants Available right Now"
//                             //                     : "No Shops Available right Now",
//                             //                 style: CustomTextStyle.chipgrey,
//                             //               ),
//                             //             )
//                             //           ],
//                             //         ),
//                             //       ); //
//                             //     },

//                             //     firstPageProgressIndicatorBuilder: (context) =>
//                             //         const Nearestresshimmer(),
//                             //     // firstPageErrorIndicatorBuilder: (context) {
//                             //     //   return hasBottomBannerList
//                             //     //       ? Column(
//                             //     //           children: [
//                             //     //             Inactiverestaurantcard(
//                             //     //               favoritesProvider:
//                             //     //                   favoritesProvider,
//                             //     //               hasBottomBannerList:
//                             //     //                   hasBottomBannerList,
//                             //     //               offervalue: hompageprovider
//                             //     //                               .orderModel ==
//                             //     //                           null ||
//                             //     //                       hompageprovider
//                             //     //                           .orderModel.isEmpty
//                             //     //                   ? ""
//                             //     //                   : hompageprovider.orderModel[
//                             //     //                           "appConfigValue"]
//                             //     //                       ["value"],
//                             //     //               isRecomResEmpty: true,
//                             //     //             ),
//                             //     //             if (nearbyreget
//                             //     //                     .nearbyresPagingController
//                             //     //                     .itemList
//                             //     //                     ?.length ==
//                             //     //                 1)
//                             //     //               SizedBox(height: 40.h),
//                             //     //             BottomBanner(
//                             //     //                 bottomBannerList:
//                             //     //                     bottombannerList),
//                             //     //           ],
//                             //     //         )
//                             //     //       : _buildNoDataScreen(context);
//                             //     // },
//                             //     // newPageErrorIndicatorBuilder: (context) {
//                             //     //   return Column(
//                             //     //     children: [
//                             //     //       Inactiverestaurantcard(
//                             //     //         favoritesProvider: favoritesProvider,
//                             //     //         offervalue:
//                             //     //             hompageprovider.orderModel ==
//                             //     //                         null ||
//                             //     //                     hompageprovider
//                             //     //                         .orderModel.isEmpty
//                             //     //                 ? ""
//                             //     //                 : hompageprovider.orderModel[
//                             //     //                     "appConfigValue"]["value"],
//                             //     //         isRecomResEmpty: false,
//                             //     //         hasBottomBannerList:
//                             //     //             hasBottomBannerList,
//                             //     //       ),
//                             //     //       if (nearbyreget.nearbyresPagingController
//                             //     //               .itemList?.length ==
//                             //     //           1)
//                             //     //         SizedBox(height: 40.h),
//                             //     //       BottomBanner(
//                             //     //           bottomBannerList: bottombannerList),
//                             //     //     ],
//                             //     //   );
//                             //     // },
//                             //     // noMoreItemsIndicatorBuilder: (context) {
//                             //     //   return Column(
//                             //     //     children: [
//                             //     // Inactiverestaurantcard(
//                             //     //   favoritesProvider: favoritesProvider,
//                             //     //   offervalue:
//                             //     //       hompageprovider.orderModel ==
//                             //     //                   null ||
//                             //     //               hompageprovider
//                             //     //                   .orderModel.isEmpty
//                             //     //           ? ""
//                             //     //           : hompageprovider.orderModel[
//                             //     //               "appConfigValue"]["value"],
//                             //     //   isRecomResEmpty: false,
//                             //     //   hasBottomBannerList:
//                             //     //       hasBottomBannerList,
//                             //     // ),
//                             //     //       if (nearbyreget.nearbyresPagingController
//                             //     //               .itemList?.length ==
//                             //     //           1)
//                             //     //         SizedBox(height: 40.h),
//                             //     //       BottomBanner(
//                             //     //           bottomBannerList: bottombannerList),
//                             //     //     ],
//                             //     //   );
//                             //     // },
//                             //     // newPageProgressIndicatorBuilder: (context) =>
//                             //     //     const Nearestresshimmer(),
//                             //     // noItemsFoundIndicatorBuilder: (context) {
//                             //     //   return Column(
//                             //     //     children: [
//                             //     //       Inactiverestaurantcard(
//                             //     //         favoritesProvider: favoritesProvider,
//                             //     //         offervalue:
//                             //     //             hompageprovider.orderModel ==
//                             //     //                         null ||
//                             //     //                     hompageprovider
//                             //     //                         .orderModel.isEmpty
//                             //     //                 ? ""
//                             //     //                 : hompageprovider.orderModel[
//                             //     //                     "appConfigValue"]["value"],
//                             //     //         isRecomResEmpty: true,
//                             //     //         hasBottomBannerList:
//                             //     //             hasBottomBannerList,
//                             //     //       ),
//                             //     //       if (nearbyreget.nearbyresPagingController
//                             //     //               .itemList?.length ==
//                             //     //           1)
//                             //     //         SizedBox(height: 40.h),
//                             //     //       BottomBanner(
//                             //     //           bottomBannerList: bottombannerList),
//                             //     //     ],
//                             //     //   );
//                             //     // },
//                             //   ),
//                             // ),
//                           ),
//                           if (nearbyreget
//                                   .nearbyresPagingController.itemList?.length ==
//                               1)
//                             SizedBox(height: 40.h),
//                           BottomBanner(bottomBannerList: bottombannerList),
//                         ],
//                       ),
//                     ),
//                   ),

//                   /// 🔹 Cart & Floating Button Stack
//                   foodscreenButtons(foodcartprovider, context, orderForOthers),
//                 ],
//               ),
//             )),
//       ),
//     );
//   }

//   Stack foodscreenButtons(FoodCartProvider foodcartprovider,
//       BuildContext context, InstantUpdateProvider orderForOthers) {
//     return Stack(
//       children: [
//         if (foodcartprovider.isHaveFood)
//           Positioned(
//             bottom: 10,
//             left: 15,
//             right: 15,
//             child: CustomCartBox(
//               itemCount: foodcartprovider.foodCartDetails['totalQuantity']
//                       .toString() ??
//                   "",
//               price: (foodcartprovider.foodCartDetails['totalFoodAmount'] ?? 0)
//                   .toDouble()
//                   .toStringAsFixed(2),
//               restName: foodcartprovider.foodCartDetails?['restaurantDetails']
//                       ?['name'] ??
//                   '',
//               resImage:
//                   "$globalImageUrlLink${foodcartprovider.foodCartDetails?['restaurantDetails']?['logoUrl'] ?? ''}",
//               checkOut: () {
//                 List<dynamic> cartRes = foodcartprovider.searchResModel;
//                 if (cartRes.isNotEmpty) {
//                   if (cartRes[0]['status'] == true &&
//                       cartRes[0]['activeStatus'] == "online") {
//                     final restaurant = FavoriteRestaurant(
//                       id: cartRes[0]["_id"],
//                       name: cartRes[0]["name"].toString(),
//                       city: cartRes[0]["address"]["city"].toString(),
//                       region: cartRes[0]["address"]["region"].toString(),
//                       imageUrl: "$globalImageUrlLink${cartRes[0]["imgUrl"]}",
//                       rating: cartRes[0]["ratingAverage"].toString(),
//                     );

//                     double totalDistance = double.tryParse(
//                             foodcartprovider.totalDis.split(' ').first) ??
//                         0.0;

//                     Get.to(
//                       AddToCartScreen(
//                         //   vendorId:foodcartprovider.vendorid,
//                         totalDis: totalDistance,
//                         favourListDetails:
//                             cartRes[0]["favourListDetails"] ?? [],
//                         menu: cartRes[0]['categoryDetails']?.length ?? 0,
//                         restaurant: restaurant,
//                         restaurantId: restaurant.id,
//                         restaurantcity: restaurant.city,
//                         restaurantfoodtitle: cartRes[0]['cusineList'],
//                         restaurantimg: restaurant.imageUrl,
//                         restaurantname: restaurant.name,
//                         restaurantregion: restaurant.region,
//                         restaurantreview:
//                             cartRes[0]['ratingAverage']?.toString() ?? '0',
//                         reviews: cartRes[0]['ratings']?.length ?? 0,
//                         fulladdress:
//                             cartRes[0]["address"]?['fullAddress']?.toString() ??
//                                 '',
//                       ),
//                       transition: Transition.rightToLeft,
//                     )!
//                         .then((value) {
//                       addresscontroller.getaddressapi(
//                           context: context, latitude: "", longitude: "");
//                     });
//                   } else if (cartRes[0]['status'] == false &&
//                       cartRes[0]['activeStatus'] == "offline") {
//                     AppUtils.showToast(
//                         'The restaurant is currently closed. Please select another restaurant.');
//                   } else {
//                     AppUtils.showToast(
//                         'The restaurant is currently closed. Please select another restaurant.');
//                   }
//                 } else {
//                   AppUtils.showToast(
//                       'The address you selected is outside the restaurant\'s \ndelivery area.');
//                 }
//               },
//               clearCart: () {
//                 List<dynamic> cartRes = foodcartprovider.searchResModel;
//                 if (foodcartprovider.searchResModel.isNotEmpty ||
//                     cartRes.isNotEmpty) {
//                   CustomLogoutDialog.show(
//                     context: context,
//                     title: 'Clear cart?',
//                     content:
//                         "Are you sure you want to clear your cart from ${cartRes[0]["name"].toString()} Restaurant?",
//                     onConfirm: () async {
//                       foodcart.clearCartItem(context: context).then((value) {
//                         foodcartprovider.getfoodcartProvider(km: resGlobalKM);
//                         setState(() {
//                           orderForSomeOneName = '';
//                           orderForSomeOnePhone = '';
//                         });
//                         orderForOthers.upDateInstruction(instruction: '');
//                         orderForOthers.updateSomeOneDetaile(
//                             someOneName: '', someOneNumber: '');
//                       });
//                       Get.back();
//                     },
//                     buttonname: 'Yes',
//                     oncancel: () => Navigator.pop(context),
//                   );
//                 } else {
//                   CustomLogoutDialog.show(
//                     context: context,
//                     title: 'Clear cart?',
//                     content:
//                         "Are you sure you want to clear your cart from this Restaurant?",
//                     onConfirm: () async {
//                       foodcart.clearCartItem(context: context).then((value) {
//                         foodcartprovider.getfoodcartProvider(km: resGlobalKM);
//                         setState(() {
//                           orderForSomeOneName = '';
//                           orderForSomeOnePhone = '';
//                         });
//                         orderForOthers.upDateInstruction(instruction: '');
//                         orderForOthers.updateSomeOneDetaile(
//                             someOneName: '', someOneNumber: '');
//                       });
//                       Get.back();
//                     },
//                     buttonname: 'Yes',
//                     oncancel: () => Navigator.pop(context),
//                   );
//                 }
//               },
//               viewResturant: () {
//                 List<dynamic> cartRes = foodcartprovider.searchResModel;
//                 double totalDistance =
//                     double.parse(foodcartprovider.totalDis.split(' ').first);
//                 if (cartRes.isNotEmpty) {
//                   final restaurant = FavoriteRestaurant(
//                     id: cartRes[0]["_id"],
//                     name: cartRes[0]["name"].toString(),
//                     city: cartRes[0]["address"]["city"].toString(),
//                     region: cartRes[0]["address"]["region"].toString(),
//                     imageUrl: "$globalImageUrlLink${cartRes[0]["imgUrl"]}",
//                     rating: cartRes[0]["ratingAverage"].toString(),
//                   );

//                   Get.to(
//                     Foodviewscreen(
//                       totalDis: totalDistance,
//                       restaurantId: restaurant.id,
//                     ),
//                     transition: Transition.rightToLeft,
//                     curve: Curves.easeIn,
//                   );
//                 } else {
//                   AppUtils.showToast(
//                       'The address you selected is outside the restaurant\'s delivery area.');
//                 }
//               },
//             ),
//           ),
//         Positioned(
//           right: 20,
//           bottom: 140.h,
//           child: const TrackorderFloatingButton(),
//         ),
//         UserId != null
//             ? Obx(() {
//                 if (chatttbot.ischatLoading.isTrue) return const SizedBox();
//                 final data = chatttbot.chathealthcheckDetails;
//                 if (data != null && data["data"]["mobile"] == true) {
//                   // return const Chatbot();
//                   return const SizedBox();
//                 } else {
//                   return const SizedBox();
//                 }
//               })
//             : const SizedBox.shrink(),
//       ],
//     );
//   }

//   Widget _buildNoDataScreen(BuildContext context) => const SizedBox(
//         height: 400,
//         child: Padding(
//             padding: EdgeInsets.all(20.0),
//             child: Center(
//                 child: Text("No Data Available!",
//                     style: CustomTextStyle.chipgrey))),
//       );
// }



































// ignore_for_file: avoid_print, file_names

import 'dart:async';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:testing/Features/Authscreen/AuthController/Registercontroller.dart';
import 'package:testing/Features/Authscreen/AuthController/controllerForFavAdd.dart';
import 'package:testing/Features/Authscreen/Loginscreen.dart';
import 'package:testing/Features/Bottomsheets/Adduserbottomsheet.dart';
import 'package:testing/Features/Foodmodule/Data/cartprovider.dart';
import 'package:testing/Features/Foodmodule/Domain/favouritemodel.dart';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Addfoodcontroller.dart';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Bannercontroller.dart';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Categorylistcontroller.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/Inactiverescontroller.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/BottomBanner.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodsearch.dart';

import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/ProductCategorylist.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/TopBanner.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/Getnearbyrescontroller.dart';

import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Restaurantcard.dart';
import 'package:testing/Features/Foodmodule/getFoodCartProvider.dart';
import 'package:testing/Features/Homepage/AddressController/Addresscontroller.dart';
import 'package:testing/Features/Homepage/Profile_Orders/CartFloatingbutton.dart';

import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Chatbotcontroller.dart';
import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Redirectcontroller.dart';
import 'package:testing/Features/Homepage/profile.dart';

import 'package:testing/Features/OrderScreen/OrderScreenController/Favrestaurantcotroller.dart';
import 'package:testing/common/drawer.dart';
import 'package:testing/inlinebannerad.dart';

import 'package:testing/utils/Buttons/CustomAlertDialoug.dart';
import 'package:testing/utils/Buttons/CustomLogoutdialog.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Const/localvaluesmanagement.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Custom_Widgets/addressbottomsheet.dart';
import 'package:testing/utils/Custom_Widgets/customCartBox.dart';
import 'package:testing/utils/Shimmers/Nearestrestaurantshimmer.dart';
import 'package:testing/utils/Shimmers/viewrestaurantloader.dart';
import 'package:testing/utils/Toast/customtoastmessage.dart';

import 'package:testing/utils/exitapp.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'Foodviewfirstscreen.dart';
import 'foodcartscreen.dart';

class Foodscreen extends StatefulWidget {
  final String categoryFilter;
  final bool isValue;
  final bool fromPickupscreen;
  final bool isfrommanualsearchaddress;
  const Foodscreen(
      {super.key,
      this.isValue = false,
      this.fromPickupscreen = false,
      this.isfrommanualsearchaddress = false,
      this.categoryFilter = ""});

  @override
  State<Foodscreen> createState() => _FoodscreenState();
}

int activePage = 1;

class _FoodscreenState extends State<Foodscreen> {
  Categorylistcontroller categorycontroller = Get.put(Categorylistcontroller());
  RedirectController redirect = Get.put(RedirectController());
  AddressController addresscontroller = Get.put(AddressController());
  Nearbyrescontroller nearbyreget = Get.put(Nearbyrescontroller());
  Inactiverescontroller inactiverestt = Get.put(Inactiverescontroller());
  Foodcartcontroller foodcart = Get.put(Foodcartcontroller());
  FavresGetcontroller favrestget = Get.put(FavresGetcontroller());
  Chatbotcontroller chatttbot = Get.put(Chatbotcontroller());
  RegisterscreenController regi = Get.put(RegisterscreenController());

  List<Map<String, dynamic>> explore_items = [
    {
      "name": "Food",
      "description": "Because Every Parcel \nMatters",
      "content": "Delivery in 15mins",
      "img": "assets/images/food_icon.png"
    //  "img": "assets/images/20251021_105251.png"
    },
    {
      "name": "Shop",
      "description": "Groceries Made Easy,\nDelivered With Love",
      "content": "Up to 60% OFF",
      "img":
          "assets/images/Storefont_shop_icon_store_building_vector_illustration___Premium_Vector.jpeg-removebg-preview.png"
    },
     {
      "name": "Ride",
      "description": "Because Every Parcel \nMatters",
      "content": "Delivery in 15mins",
      "img": "assets/images/food_icon.png"
    
    },
  ];

  // location postel code variables 4

  List addressdata = [];
  String? selectedPostalCode;
  double? selectedLatitude;
  double? selectedLongitude;
  String? addressType;
  String? selectvalue;
  int resPage = 0;
  int nearbyrespage = 0;
  late Timer nearbyrestimer;

  final ScrollController _scrollController = ScrollController();

  final PageController nearbyrespagecontroller = PageController(initialPage: 0);
  final PageController respagecontroller = PageController(initialPage: 0);

  bool haveCart = false;

  dynamic bottombannerList;
  bool hasBottomBannerList = false;

  @override
  void initState() {
    Provider.of<FavoritesProvider>(context, listen: false).removeAllFavorites();

    if (widget.fromPickupscreen) {
      fromPickupscreen();
    } else if (widget.isfrommanualsearchaddress) {
      isfrommanualsearchaddress();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var foodcartprovider =
          Provider.of<FoodCartProvider>(context, listen: false);
      loge.i(
          'km from homepage${foodcartprovider.totalDis}  ${foodcartprovider.totalDist}');
      // double  totalDistance = double.parse(foodcartprovider.totalDis.split(' ').first.toString());
      // Provider.of<HomepageProvider>(context, listen: false).getHomepagedatas();

      Provider.of<HomepageProvider>(context, listen: false).getBanner(
          categoryFilter:
              nearbyreget.selectedIndex.value == 0 ? "restaurant" : "shop");
      Provider.of<HomepageProvider>(context, listen: false).getHomepagedatas(
          categoryFilter:
              nearbyreget.selectedIndex.value == 0 ? "restaurant" : "shop");
      nearbyreget.fetchResPage(0);
      redirect.getredirectDetails(); //1
      foodcart.getbillfoodcartfood(km: 0);
      addresscontroller.getaddressapi(
          context: context, latitude: "", longitude: "");
      addresscontroller.getprimaryaddressapi();
      await foodcart.getfoodcartfood(km: 0);
      Future.delayed(Duration.zero, () {
        foodcartprovider.getfoodcartProvider(km: resGlobalKM);
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FavoritesProvider>(context, listen: false)
          .initializeDatabase();
    });

    Provider.of<InitializeFavProvider>(context, listen: false)
        .favInitiliteProvider(cntxtt: context);
    //Banner

    super.initState();
  }

  fromPickupscreen() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loge.i(resGlobalKM);
      Provider.of<HomepageProvider>(context, listen: false).getHomepagedatas(
          categoryFilter:
              nearbyreget.selectedIndex.value == 0 ? "restaurant" : "shop");
      addresscontroller.getaddressapi(
          context: context, latitude: "", longitude: "");
      addresscontroller.getprimaryaddressapi();

      await foodcart.getfoodcartfood(km: resGlobalKM);
      nearbyreget.nearbyresPagingController.refresh();

      inactiverestt.inactiveresget();
    });
  }

  isfrommanualsearchaddress() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var foodcartprovider =
          Provider.of<FoodCartProvider>(context, listen: false);

      loge.i(resGlobalKM);
      Provider.of<HomepageProvider>(context, listen: false).getHomepagedatas(
          categoryFilter:
              nearbyreget.selectedIndex.value == 0 ? "restaurant" : "shop");
      addresscontroller.getaddressapi(
          context: context, latitude: "", longitude: "");
      addresscontroller.getprimaryaddressapi();
      getResturantIdFun();
      await foodcart.getfoodcartfood(km: resGlobalKM);
      nearbyreget.nearbyresPagingController.refresh();
      inactiverestt.inactiveresget();
    });
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

  forrefresh() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loge.i(resGlobalKM);
      getResturantIdFun();
      Provider.of<HomepageProvider>(context, listen: false).getBanner(
          categoryFilter:
              nearbyreget.selectedIndex.value == 0 ? "restaurant" : "shop");
      Provider.of<HomepageProvider>(context, listen: false).getHomepagedatas(
          categoryFilter:
              nearbyreget.selectedIndex.value == 0 ? "restaurant" : "shop");
      addresscontroller.getaddressapi(
          context: context, latitude: "", longitude: "");
      addresscontroller.getprimaryaddressapi();

      await foodcart.getfoodcartfood(km: resGlobalKM);
      nearbyreget.nearbyresPagingController.refresh();
      inactiverestt.inactiveresget();
    });
  }

  @override
  void dispose() {
    nearbyrespagecontroller.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // List<Map<String, dynamic>> categories =
    //     List<Map<String, dynamic>>.from(categorycontroller.category["data"]);

    // categories.insert(
    //     1, {"status": true, "productName": "SHOP", "productType": "shop"});
    
    final num = Get.put(Nearbyrescontroller());

    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final foodcartprovider = Provider.of<FoodCartProvider>(context);
    final mapData = Provider.of<MapDataProvider>(context);
    var orderForOthers = Provider.of<InstantUpdateProvider>(context);
    var hompageprovider = Provider.of<HomepageProvider>(context);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        await ExitApp.handlePop();
        //  await ExitApp.homepop();
        // Get.back();
      },
      child: RefreshIndicator(
        //   color: Customcolors.darkpurple,
        color: Customcolors.darkpurple,
        onRefresh: () async {
          await Future.delayed(
            const Duration(seconds: 2),
            () {
              return forrefresh();
            },
          );
        },
        child: Scaffold(
            backgroundColor: const Color(0xffFFFFFF),
            resizeToAvoidBottomInset: false,
            // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,

            floatingActionButton: Padding(
              padding: EdgeInsets.only(bottom: 13.h, right: 10.w),
              child: FloatingActionButton(
                onPressed: () {
                  print("printing");
                  Get.to(const Foodsearchscreen(),
                      transition: Transition.leftToRight);
                },
                backgroundColor: Colors.transparent,
                child: Container(
                  height: 50.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                      color: Color(0xFF623089),
                      //           gradient: LinearGradient(
                      // begin: Alignment.topCenter,
                      // end: Alignment.bottomCenter,
                      // colors: [ Color(0xFFAE62E8),

                      //          Color(0xFF623089),

                      //         ]),
                      borderRadius: BorderRadius.circular(15)),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
              ),
            ),
           endDrawer:CustomDrawer(),
            appBar: AppBar(
              title: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //   Image.asset(othersicon, scale: 3),
                        Image.asset(
                          "assets/images/location_icon.png",
                        height: 26.sp,
                          //height: 30,
                        ),
                         SizedBox(width: 10.w),
                        Padding(
                          padding: EdgeInsets.only(top: 9.h),
                          child: InkWell(
                              onTap: () {
                                addressbottomsheet(context).then((value) async {
                                  _scrollController.jumpTo(0); // 👈 Jump to top
                                  await Provider.of<HomepageProvider>(context,
                                          listen: false)
                                      .getHomepagedatas();
                                  nearbyreget.nearbyresPagingController
                                      .refresh();
                                  foodcartprovider.getfoodcartProvider(
                                      km: resGlobalKM);
                                });
                              },
                              child: Row(
                                children: [
                                  Text(
                                    '${mapData.postalCode} - ${mapData.addressType}',
                                    //  style: CustomTextStyle.font12popinBlack,
                                    style: TextStyle(
                                      //  color: Customcolors.POSTALCODE_COLOR,
                                        color: Customcolors.addressColor,
                                        fontSize: 14.sp,
                                        fontFamily: 'Poppins-Regular',
                                        fontWeight: FontWeight.w600),
                                  ),
                                  // SizedBox(
                                  //   width: 5,
                                  // ),
                                  // const Icon(Icons.keyboard_arrow_down_outlined)
                                ],
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              // toolbarHeight: 50.h,
              backgroundColor: const Color(0xffFFFFFF),
              automaticallyImplyLeading: false,
              scrolledUnderElevation: 0,
              //  surfaceTintColor: Customcolors.DECORATION_WHITE,
              surfaceTintColor: const Color(0xffFFFFFF),
              actions: [
                if (UserId == null || UserId.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Customcolors.lightpurple,
                            Customcolors.darkpurple
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 20,
                        visualDensity: VisualDensity.compact,
                        icon: const Icon(Icons.perm_identity_sharp,
                            color: Colors.white),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => LoginRequiredDialog(
                              title: "Login Required",
                              content:
                                  "Please login to view your items in your cart.",
                              cancelText: "Later",
                              confirmText: "Log In",
                              onConfirm: () {
                                Get.offAll(() => const Loginscreen());
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  )

               
                else
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Builder(
                     builder: (context) {
                  return InkWell(
                          onTap: () {

                            regi.fetchProfile(profileImgae);
                             Scaffold.of(context).openEndDrawer(); 
                            // Get.to(const ProfileScreen(),
                            //     transition: Transition.leftToRight,
                            //     duration: const Duration(milliseconds: 250),
                            //     curve: Curves.easeInOut);
                          },
                          child: Image.asset(
                            "assets/images/menu_icon.png",
                            height: 19.h,
                          )
                        
                          );}
                    ),
                  ),
                SizedBox(
                  width: 8.h,
                )
              ],
            ),
            body: GlobalLoaderOverlay(
              useDefaultLoading: false,
              overlayColor: Colors.white,
              overlayWidgetBuilder: (_) => const LoadingWithRandomText(),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    controller: _scrollController,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //    Container(height: 50,color: Colors.blueGrey,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children:
                                //  List.generate(categories.length,
                                List.generate(
                              explore_items.length,
                              (index) {
                                //  var productname = categories[index]["productName"];
                                var productname = explore_items[index]["name"];
                                var productdescription =
                                    explore_items[index]["description"];
                                var productcontent =
                                    explore_items[index]["content"];
                                var productimg = explore_items[index]["img"];

                                // if (categories[index]["status"] == false) {
                                //   return const SizedBox(); // Skips rendering this item
                                // }
                                return InkWell(
                                    onTap: () {
                                      num.updateIndex(index);
                                     

                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              Foodscreen(
                                                  categoryFilter: nearbyreget
                                                              .selectedIndex
                                                              .value ==
                                                          0
                                                      ? "restaurant"
                                                      : "shop"), // <-- Your class here
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            const begin = Offset(
                                                1.0, 0.0); // start from right
                                            const end = Offset
                                                .zero; // end at original position
                                            const curve = Curves.ease;

                                            var tween = Tween(
                                                    begin: begin, end: end)
                                                .chain(
                                                    CurveTween(curve: curve));

                                            return SlideTransition(
                                              position: animation.drive(tween),
                                              child: child,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(right: 20, left: 20),
                                      child: Column(children: [
                                        Container(
                                          padding: EdgeInsets.all(5),
                                          width:55.w,
                                          height:55.h,
                                          decoration: BoxDecoration(
                                            color: nearbyreget
                                                        .selectedIndex.value ==
                                                    index
                                                // ? Color.fromARGB(255, 189, 164, 209)
                                                // : Color.fromARGB(31, 206, 198, 198),
                                                ? Color(0xFFD8BFD8)
                                                : Color.fromARGB(
                                                    31, 206, 198, 198),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              productimg,
                                              height: 44,
                                              fit: BoxFit.cover,
                                              //color: Colors.amber,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3.h,
                                        ),
                                        Text(
                                          productname,
                                          style: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.bold,
                                              color: nearbyreget.selectedIndex
                                                          .value ==
                                                      index
                                                  ? Customcolors.darkpinkColor
                                                  : Customcolors.addressColor,),
                                        ),
                                      ]),
                                    ));
                              },
                            ),
                          ),

                         
                          SizedBox(height: 20.h),

                          Consumer<HomepageProvider>(
                            builder: (context, value, child) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (value.isLoading) {
                                  context.loaderOverlay.show();
                                } else {
                                  context.loaderOverlay.hide();
                                }
                              });

                              if (value.isLoading) {
                                return const SizedBox();
                              } else if (value.orderModel == null ||
                                  value.orderModel.isEmpty) {
                                return const SizedBox();
                              } else {
                                final data = value.orderModel;
                                final topbanner = value.topBanners;
                                final bottombanner = value.bottomBanners;
                                //  final bannerList = data["banner"];
                                final bannerList = topbanner;
                                final foodCategories =
                                    data["foodCategoryNameList"];
                                final reccomendedreslist = data["recomResList"]
                                        ?["data"]?["data"] ??
                                    [];
                                bottombannerList = bottombanner;
                                // bottombannerList = data["bottomBanner"];
                                final bool hasBanner =
                                    bannerList != null && bannerList.isNotEmpty;
                                final bool hasCategories =
                                    foodCategories != null &&
                                        foodCategories.isNotEmpty;
                                final bool hasrecommendedlist =
                                    reccomendedreslist.isNotEmpty;
                                hasBottomBannerList =
                                    bottombannerList != null &&
                                        bottombannerList.isNotEmpty;

                                return ListView(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                   
                                   // CustomSizedBox(height: 5.h),
                                    if (hasBanner)
                                      TopBannerclass(bannerlist: bannerList)
                                    else
                                      Container(
                                        height: 150,
                                        alignment: Alignment.center,
                                        child: const Text(
                                            "No banners available",
                                            style: CustomTextStyle.chipgrey),
                                      ),
                                    CustomSizedBox(height: 10.h),

                                    if (hasCategories)
                                      Productcategorylist(
                                          homepagedetails: foodCategories)
                                    else
                                      Container(
                                        height: 100,
                                        alignment: Alignment.center,
                                        child: const Text(
                                            "No food categories found!",
                                            style: CustomTextStyle.chipgrey),
                                      ),

                                    
                                  ],
                                );
                              }
                            },
                          ),
                         
                      nearbyreget
                                   .selectedIndex
                                                              .value ==
                                                          0
                                                      ? 
                                                       Text(
                                      "Restaurants Near You",
                                      style: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w700,
      color: Colors.black,
      fontFamily: 'Poppins-Medium'
      ),
                                     ):  Text(
                                      "Shops Near You",
                                       style: TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.w800,
      color: Customcolors.DECORATION_BLACK,
      fontFamily: 'Poppins-Medium'),
                                     ),
                                     SizedBox(height: 10,),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: PagedListView<int, dynamic>(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              addAutomaticKeepAlives: false,
                              addRepaintBoundaries: false,
                              addSemanticIndexes: false,
                              pagingController:
                                  nearbyreget.nearbyresPagingController,
                              builderDelegate:
                                  PagedChildBuilderDelegate<dynamic>(
                                animateTransitions: true,
                                itemBuilder: (context, nearbyresget, index) {
                                  // Your restaurant setup
                                  final restaurant = FavoriteRestaurant(
                                    id: nearbyresget["document"]["_id"],
                                    name: nearbyresget["document"]["name"]
                                        .toString(),
                                    city: nearbyresget["document"]["address"]
                                            ["city"]
                                        .toString(),
                                    region: nearbyresget["document"]["address"]
                                            ["region"]
                                        .toString(),
                                    imageUrl:
                                        "$globalImageUrlLink${nearbyresget["document"]["imgUrl"]}",
                                    rating: nearbyresget["document"]["rating"]
                                        .toString(),
                                  );

                                  double endlat = double.tryParse(
                                          nearbyresget["document"]["address"]
                                                      ["latitude"]
                                                  ?.toString() ??
                                              "") ??
                                      0.0;
                                  double endlong = double.tryParse(
                                          nearbyresget["document"]["address"]
                                                      ["longitude"]
                                                  ?.toString() ??
                                              "") ??
                                      0.0;

                                  // The restaurant card
                                  final restaurantCard = ResturantsCard(
                                    favoritesProvider: favoritesProvider,
                                    restaurant: restaurant,
                                    nearbyresget: nearbyresget,
                                    langitude: endlong,
                                    latitude: endlat,
                                    offervalue: hompageprovider.orderModel ==
                                                null ||
                                            hompageprovider.orderModel.isEmpty
                                        ? ""
                                        : hompageprovider
                                                .orderModel["appConfigValue"]
                                            ["value"],
                                  );

                                  // 👇 Insert Ad after every 2 items
                                  if ((index + 1) % 2 == 0) {
                                    return Column(
                                      children: [
                                        restaurantCard,
                                        const SizedBox(height: 20),
                                        const InlineBannerAdWidget(), // our ad widget
                                        const SizedBox(height: 20),
                                      ],
                                    );
                                  }

                                  return restaurantCard;
                                },
                                noItemsFoundIndicatorBuilder: (context) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          nearbyreget.selectedIndex.value == 0
                                              ? "assets/images/No Food.png"
                                              : "assets/images/No orders.png",
                                          height:
                                              nearbyreget.selectedIndex.value ==
                                                      0
                                                  ? 350
                                                  : 250,
                                          fit: BoxFit.cover,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            nearbyreget.selectedIndex.value == 0
                                                ? "No Restaurants Available right Now"
                                                : "No Shops Available right Now",
                                            style: CustomTextStyle.chipgrey,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                firstPageProgressIndicatorBuilder: (context) =>
                                    const Nearestresshimmer(),
                              ),
                            ),
                            // child: PagedListView<int, dynamic>(
                            //   physics: const NeverScrollableScrollPhysics(),
                            //   shrinkWrap: true,
                            //   addAutomaticKeepAlives: false,
                            //   addRepaintBoundaries: false,
                            //   addSemanticIndexes: false,
                            //   pagingController:
                            //       nearbyreget.nearbyresPagingController,
                            //   builderDelegate:
                            //       PagedChildBuilderDelegate<dynamic>(
                            //     animateTransitions: true,
                            //     itemBuilder: (context, nearbyresget, index) {
                            //       final restaurant = FavoriteRestaurant(
                            //         id: nearbyresget["document"]["_id"],
                            //         name: nearbyresget["document"]["name"]
                            //             .toString(),
                            //         city: nearbyresget["document"]["address"]
                            //                 ["city"]
                            //             .toString(),
                            //         region: nearbyresget["document"]["address"]
                            //                 ["region"]
                            //             .toString(),
                            //         imageUrl:
                            //             "$globalImageUrlLink${nearbyresget["document"]["imgUrl"]}",
                            //         rating: nearbyresget["document"]["rating"]
                            //             .toString(),
                            //       );

                            //       double endlat = double.tryParse(
                            //               nearbyresget["document"]["address"]
                            //                           ["latitude"]
                            //                       ?.toString() ??
                            //                   "") ??
                            //           0.0;
                            //       double endlong = double.tryParse(
                            //               nearbyresget["document"]["address"]
                            //                           ["longitude"]
                            //                       ?.toString() ??
                            //                   "") ??
                            //           0.0;

                            //       return ResturantsCard(
                            //           favoritesProvider: favoritesProvider,
                            //           restaurant: restaurant,
                            //           nearbyresget: nearbyresget,
                            //           langitude: endlong,
                            //           latitude: endlat,
                            //           offervalue: hompageprovider.orderModel ==
                            //                       null ||
                            //                   hompageprovider.orderModel.isEmpty
                            //               ? ""
                            //               : hompageprovider
                            //                       .orderModel["appConfigValue"]
                            //                   ["value"]
                            //           // hompageprovider.orderModel["appConfigValue"]["value"] ?? "",
                            //           );
                            //     },
                            //     noItemsFoundIndicatorBuilder: (context) {
                            //       return Padding(
                            //         padding: const EdgeInsets.symmetric(
                            //             horizontal: 8),
                            //         child: Column(
                            //           children: [
                            //             Image.asset(
                            //               nearbyreget.selectedIndex.value == 0
                            //                   ? "assets/images/No Food.png"
                            //                   : "assets/images/No orders.png",
                            //               height:
                            //                   nearbyreget.selectedIndex.value ==
                            //                           0
                            //                       ? 350
                            //                       : 250,
                            //               //  height: 350,
                            //               // width: double.infinity,
                            //               fit: BoxFit.cover,
                            //             ),
                            //             Padding(
                            //               padding: EdgeInsets.all(8.0),
                            //               child: Text(
                            //                 nearbyreget.selectedIndex.value == 0
                            //                     ? "No Restaurants Available right Now"
                            //                     : "No Shops Available right Now",
                            //                 style: CustomTextStyle.chipgrey,
                            //               ),
                            //             )
                            //           ],
                            //         ),
                            //       ); //
                            //     },

                            //     firstPageProgressIndicatorBuilder: (context) =>
                            //         const Nearestresshimmer(),
                            //     // firstPageErrorIndicatorBuilder: (context) {
                            //     //   return hasBottomBannerList
                            //     //       ? Column(
                            //     //           children: [
                            //     //             Inactiverestaurantcard(
                            //     //               favoritesProvider:
                            //     //                   favoritesProvider,
                            //     //               hasBottomBannerList:
                            //     //                   hasBottomBannerList,
                            //     //               offervalue: hompageprovider
                            //     //                               .orderModel ==
                            //     //                           null ||
                            //     //                       hompageprovider
                            //     //                           .orderModel.isEmpty
                            //     //                   ? ""
                            //     //                   : hompageprovider.orderModel[
                            //     //                           "appConfigValue"]
                            //     //                       ["value"],
                            //     //               isRecomResEmpty: true,
                            //     //             ),
                            //     //             if (nearbyreget
                            //     //                     .nearbyresPagingController
                            //     //                     .itemList
                            //     //                     ?.length ==
                            //     //                 1)
                            //     //               SizedBox(height: 40.h),
                            //     //             BottomBanner(
                            //     //                 bottomBannerList:
                            //     //                     bottombannerList),
                            //     //           ],
                            //     //         )
                            //     //       : _buildNoDataScreen(context);
                            //     // },
                            //     // newPageErrorIndicatorBuilder: (context) {
                            //     //   return Column(
                            //     //     children: [
                            //     //       Inactiverestaurantcard(
                            //     //         favoritesProvider: favoritesProvider,
                            //     //         offervalue:
                            //     //             hompageprovider.orderModel ==
                            //     //                         null ||
                            //     //                     hompageprovider
                            //     //                         .orderModel.isEmpty
                            //     //                 ? ""
                            //     //                 : hompageprovider.orderModel[
                            //     //                     "appConfigValue"]["value"],
                            //     //         isRecomResEmpty: false,
                            //     //         hasBottomBannerList:
                            //     //             hasBottomBannerList,
                            //     //       ),
                            //     //       if (nearbyreget.nearbyresPagingController
                            //     //               .itemList?.length ==
                            //     //           1)
                            //     //         SizedBox(height: 40.h),
                            //     //       BottomBanner(
                            //     //           bottomBannerList: bottombannerList),
                            //     //     ],
                            //     //   );
                            //     // },
                            //     // noMoreItemsIndicatorBuilder: (context) {
                            //     //   return Column(
                            //     //     children: [
                            //     // Inactiverestaurantcard(
                            //     //   favoritesProvider: favoritesProvider,
                            //     //   offervalue:
                            //     //       hompageprovider.orderModel ==
                            //     //                   null ||
                            //     //               hompageprovider
                            //     //                   .orderModel.isEmpty
                            //     //           ? ""
                            //     //           : hompageprovider.orderModel[
                            //     //               "appConfigValue"]["value"],
                            //     //   isRecomResEmpty: false,
                            //     //   hasBottomBannerList:
                            //     //       hasBottomBannerList,
                            //     // ),
                            //     //       if (nearbyreget.nearbyresPagingController
                            //     //               .itemList?.length ==
                            //     //           1)
                            //     //         SizedBox(height: 40.h),
                            //     //       BottomBanner(
                            //     //           bottomBannerList: bottombannerList),
                            //     //     ],
                            //     //   );
                            //     // },
                            //     // newPageProgressIndicatorBuilder: (context) =>
                            //     //     const Nearestresshimmer(),
                            //     // noItemsFoundIndicatorBuilder: (context) {
                            //     //   return Column(
                            //     //     children: [
                            //     //       Inactiverestaurantcard(
                            //     //         favoritesProvider: favoritesProvider,
                            //     //         offervalue:
                            //     //             hompageprovider.orderModel ==
                            //     //                         null ||
                            //     //                     hompageprovider
                            //     //                         .orderModel.isEmpty
                            //     //                 ? ""
                            //     //                 : hompageprovider.orderModel[
                            //     //                     "appConfigValue"]["value"],
                            //     //         isRecomResEmpty: true,
                            //     //         hasBottomBannerList:
                            //     //             hasBottomBannerList,
                            //     //       ),
                            //     //       if (nearbyreget.nearbyresPagingController
                            //     //               .itemList?.length ==
                            //     //           1)
                            //     //         SizedBox(height: 40.h),
                            //     //       BottomBanner(
                            //     //           bottomBannerList: bottombannerList),
                            //     //     ],
                            //     //   );
                            //     // },
                            //   ),
                            // ),
                          ),
                          if (nearbyreget
                                  .nearbyresPagingController.itemList?.length ==
                              1)
                            SizedBox(height: 40.h),
                          BottomBanner(bottomBannerList: bottombannerList),
                        ],
                      ),
                    ),
                  ),

                  /// 🔹 Cart & Floating Button Stack
                  foodscreenButtons(foodcartprovider, context, orderForOthers),
                ],
              ),
            )),
      ),
    );
  }

  Stack foodscreenButtons(FoodCartProvider foodcartprovider,
      BuildContext context, InstantUpdateProvider orderForOthers) {
    return Stack(
      children: [
        if (foodcartprovider.isHaveFood)
          Positioned(
            bottom: 10,
            left: 15,
            right: 15,
            child: CustomCartBox(
              itemCount: foodcartprovider.foodCartDetails['totalQuantity']
                      .toString() ??
                  "",
              price: (foodcartprovider.foodCartDetails['totalFoodAmount'] ?? 0)
                  .toDouble()
                  .toStringAsFixed(2),
              restName: foodcartprovider.foodCartDetails?['restaurantDetails']
                      ?['name'] ??
                  '',
              resImage:
                  "$globalImageUrlLink${foodcartprovider.foodCartDetails?['restaurantDetails']?['logoUrl'] ?? ''}",
              checkOut: () {
                List<dynamic> cartRes = foodcartprovider.searchResModel;
                if (cartRes.isNotEmpty) {
                  if (cartRes[0]['status'] == true &&
                      cartRes[0]['activeStatus'] == "online") {
                    final restaurant = FavoriteRestaurant(
                      id: cartRes[0]["_id"],
                      name: cartRes[0]["name"].toString(),
                      city: cartRes[0]["address"]["city"].toString(),
                      region: cartRes[0]["address"]["region"].toString(),
                      imageUrl: "$globalImageUrlLink${cartRes[0]["imgUrl"]}",
                      rating: cartRes[0]["ratingAverage"].toString(),
                    );

                    double totalDistance = double.tryParse(
                            foodcartprovider.totalDis.split(' ').first) ??
                        0.0;

                    Get.to(
                      AddToCartScreen(
                        //   vendorId:foodcartprovider.vendorid,
                        totalDis: totalDistance,
                        favourListDetails:
                            cartRes[0]["favourListDetails"] ?? [],
                        menu: cartRes[0]['categoryDetails']?.length ?? 0,
                        restaurant: restaurant,
                        restaurantId: restaurant.id,
                        restaurantcity: restaurant.city,
                        restaurantfoodtitle: cartRes[0]['cusineList'],
                        restaurantimg: restaurant.imageUrl,
                        restaurantname: restaurant.name,
                        restaurantregion: restaurant.region,
                        restaurantreview:
                            cartRes[0]['ratingAverage']?.toString() ?? '0',
                        reviews: cartRes[0]['ratings']?.length ?? 0,
                        fulladdress:
                            cartRes[0]["address"]?['fullAddress']?.toString() ??
                                '',
                      ),
                      transition: Transition.rightToLeft,
                    )!
                        .then((value) {
                      addresscontroller.getaddressapi(
                          context: context, latitude: "", longitude: "");
                    });
                  } else if (cartRes[0]['status'] == false &&
                      cartRes[0]['activeStatus'] == "offline") {
                    AppUtils.showToast(
                        'The restaurant is currently closed. Please select another restaurant.');
                  } else {
                    AppUtils.showToast(
                        'The restaurant is currently closed. Please select another restaurant.');
                  }
                } else {
                  AppUtils.showToast(
                      'The address you selected is outside the restaurant\'s \ndelivery area.');
                }
              },
              clearCart: () {
                List<dynamic> cartRes = foodcartprovider.searchResModel;
                if (foodcartprovider.searchResModel.isNotEmpty ||
                    cartRes.isNotEmpty) {
                  CustomLogoutDialog.show(
                    context: context,
                    title: 'Clear cart?',
                    content:
                        "Are you sure you want to clear your cart from ${cartRes[0]["name"].toString()} Restaurant?",
                    onConfirm: () async {
                      foodcart.clearCartItem(context: context).then((value) {
                        foodcartprovider.getfoodcartProvider(km: resGlobalKM);
                        setState(() {
                          orderForSomeOneName = '';
                          orderForSomeOnePhone = '';
                        });
                        orderForOthers.upDateInstruction(instruction: '');
                        orderForOthers.updateSomeOneDetaile(
                            someOneName: '', someOneNumber: '');
                      });
                      Get.back();
                    },
                    buttonname: 'Yes',
                    oncancel: () => Navigator.pop(context),
                  );
                } else {
                  CustomLogoutDialog.show(
                    context: context,
                    title: 'Clear cart?',
                    content:
                        "Are you sure you want to clear your cart from this Restaurant?",
                    onConfirm: () async {
                      foodcart.clearCartItem(context: context).then((value) {
                        foodcartprovider.getfoodcartProvider(km: resGlobalKM);
                        setState(() {
                          orderForSomeOneName = '';
                          orderForSomeOnePhone = '';
                        });
                        orderForOthers.upDateInstruction(instruction: '');
                        orderForOthers.updateSomeOneDetaile(
                            someOneName: '', someOneNumber: '');
                      });
                      Get.back();
                    },
                    buttonname: 'Yes',
                    oncancel: () => Navigator.pop(context),
                  );
                }
              },
              viewResturant: () {
                List<dynamic> cartRes = foodcartprovider.searchResModel;
                double totalDistance =
                    double.parse(foodcartprovider.totalDis.split(' ').first);
                if (cartRes.isNotEmpty) {
                  final restaurant = FavoriteRestaurant(
                    id: cartRes[0]["_id"],
                    name: cartRes[0]["name"].toString(),
                    city: cartRes[0]["address"]["city"].toString(),
                    region: cartRes[0]["address"]["region"].toString(),
                    imageUrl: "$globalImageUrlLink${cartRes[0]["imgUrl"]}",
                    rating: cartRes[0]["ratingAverage"].toString(),
                  );

                  Get.to(
                    Foodviewscreen(
                      totalDis: totalDistance,
                      restaurantId: restaurant.id,
                    ),
                    transition: Transition.rightToLeft,
                    curve: Curves.easeIn,
                  );
                } else {
                  AppUtils.showToast(
                      'The address you selected is outside the restaurant\'s delivery area.');
                }
              },
            ),
          ),
        Positioned(
          right: 20,
          bottom: 140.h,
          child: const TrackorderFloatingButton(),
        ),
        UserId != null
            ? Obx(() {
                if (chatttbot.ischatLoading.isTrue) return const SizedBox();
                final data = chatttbot.chathealthcheckDetails;
                if (data != null && data["data"]["mobile"] == true) {
                  // return const Chatbot();
                  return const SizedBox();
                } else {
                  return const SizedBox();
                }
              })
            : const SizedBox.shrink(),
      ],
    );
  }

  Widget _buildNoDataScreen(BuildContext context) => const SizedBox(
        height: 400,
        child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(
                child: Text("No Data Available!",
                    style: CustomTextStyle.chipgrey))),
      );
}
