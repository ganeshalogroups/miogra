// // ignore_for_file: file_names, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

// import 'dart:convert';
// import 'package:testing/Features/Authscreen/Loginscreen.dart';
// import 'package:testing/Features/Foodmodule/Data/cartprovider.dart';
// import 'package:testing/Features/Foodmodule/Domain/favouritemodel.dart';
// import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Addfoodcontroller.dart';
// import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Bannercontroller.dart';
// import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodsearch.dart';
// import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodviewfirstscreen.dart';
// import 'package:testing/Features/Foodmodule/SubAdmincontroller/Getnearbyrescontroller.dart';
// import 'package:testing/map_provider/Map%20Screens/MapSearch.dart/apiKey.dart';
// import 'package:testing/utils/Buttons/CustomFavourite.dart';
// import 'package:testing/utils/Buttons/CustomLogoutdialog.dart';
// import 'package:testing/utils/Buttons/CustomTextstyle.dart';
// import 'package:testing/utils/Buttons/Customspace.dart';
// import 'package:testing/utils/Const/ApiConstvariables.dart';
// import 'package:testing/utils/Const/constImages.dart';
// import 'package:testing/utils/Const/constValue.dart';
// import 'package:testing/utils/CustomColors/Customcolors.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';

// // ignore: must_be_immutable
// class ResturantsCard extends StatefulWidget {
//   FavoriteRestaurant restaurant;
//   dynamic nearbyresget;
//   FavoritesProvider favoritesProvider;
//   double latitude;
//   double langitude;
//   dynamic offervalue;
//   // bool isfavtr;

//   ResturantsCard(
//       {super.key,
//       required this.favoritesProvider,
//       required this.restaurant,
//       required this.nearbyresget,
//       required this.latitude,
//       required this.offervalue,
//       // required this.isfavtr,
//       required this.langitude});

//   @override
//   State<ResturantsCard> createState() => _ResturantsCardState();
// }

// class _ResturantsCardState extends State<ResturantsCard> {
//   Foodcartcontroller foodcart = Get.put(Foodcartcontroller());
//   @override
//   void initState() {
//     getDistance(
//       destLat: widget.latitude,
//       destLng: widget.langitude,
//     );

//     super.initState();
//   }

//   String offerValue = "";
//   int _current = 0;
//   Nearbyrescontroller nearbyreget = Get.put(Nearbyrescontroller());

//   String totalDis = '';
//   String totalDur = '';

//   Future<void> getDistance(
//       {required double destLat, required double destLng}) async {
//     final url = Uri.parse(
//         'https://maps.googleapis.com/maps/api/directions/json?origin=$initiallat,$initiallong&destination=$destLat,$destLng&mode=driving&key=$kGoogleApiKey');
//     final response = await http.get(url);
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);

//       processDirectionsResponse(data);
//     } else {
//       throw Exception('Failed to load directions');
//     }
//   }

//   void processDirectionsResponse(Map<String, dynamic> data) {
//     final routes = data['routes'] as List;
//     if (routes.isNotEmpty) {
//       final route = routes[0];
//       final legs = route['legs'] as List;
//       if (legs.isNotEmpty) {
//         final leg = legs[0];
//         totalDis = leg['distance']['text'];
//         totalDur = leg['duration']['text'];
//       }
//     } else {
//       debugPrint('check....Api Routs in getDistance Are Empty');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Extracted values for better readability
//     final restaurant = widget.nearbyresget["document"];
//     final status = restaurant['status'];
//    //  final isActive = restaurant['activeStatus'] == "online";

//      if (status == false) {
//     //   // If the restaurant is inactive, return an empty container or nothing
//        return const SizedBox.shrink(); // This hides the widget completely
//      }

//     return GestureDetector(
//       onTap: () {
//         // if (isActive) {

//         Get.to(
//           Foodviewscreen(
//             totalDis: 5,
//             restaurantId: restaurant["_id"],
//           ),
//           transition: Transition.rightToLeft,
//           duration: const Duration(milliseconds: 200),
//           curve: Curves.easeIn,
//         );
//       },
//       child: Container(
//         margin: const EdgeInsets.only(top: 10, bottom: 10),
//         width: MediaQuery.of(context).size.width,
//         decoration: const BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(15)),
//           color: Customcolors.DECORATION_WHITE,
//           boxShadow: [
//             BoxShadow(
//               color: Customcolors.DECORATION_LIGHTGREY, //color of shadow
//               spreadRadius: 5, //spread radius
//               blurRadius: 7, // blur radius
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         // child: _buildRestaurantDetails(context, isClosed: !isActive),
//         child: _buildRestaurantDetails(context),
//       ),
//     );
//   }

//   Widget _buildRestaurantDetails(
//     BuildContext context,
//   ) {
//     final restaurant = widget.nearbyresget["document"];
//     // final rating = restaurant["rating"].toString() ?? 0;

//     dynamic offerPercentage = restaurant.containsKey('servicesType')
//         ? restaurant["servicesType"]["offerPercentage"]
//         : "";

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
       
//         ClipRRect(
//           borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(15), topRight: Radius.circular(15),bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
//           child: CachedNetworkImage(
//             placeholder: (context, url) => Image.asset(fastxdummyImg),
//             errorWidget: (context, url, error) => Image.asset(fastxdummyImg),
//             height: 160.h,
//             width: MediaQuery.of(context).size.width,
//             imageUrl: "${globalImageUrlLink}${restaurant["imgUrl"].toString()}",
//             fit: BoxFit.fill,
//           ),
//         ),
        
//         //  Align(alignment: Alignment.topRight,
//         // child: Container(height: 40.h,width: 40.h,decoration: BoxDecoration(
//         //   gradient: LinearGradient(
//         //     begin: Alignment.topCenter,
//         //     end: Alignment.bottomCenter,
//         //     colors: [ Color(0xFFAE62E8),
        
//         //  Color(0xFF623089),
         
         
//         // ]),borderRadius: BorderRadius.circular(15)
//         // ),child: InkWell(
//         //   onTap: () {
//         //       Get.to(const Foodsearchscreen(),
//         //                           transition: Transition.leftToRight);
//         //   },
//         //   child: Icon(Icons.search,color: Colors.white,)),)),
//         // CustomSizedBox(height: 5),
//         Padding(
//           padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width / 1.3.w,
//                     child: Text(
//                       " ${restaurant["name"].toString().capitalizeFirst}",
//                       overflow: TextOverflow.clip,
//                       style: CustomTextStyle.googlebuttontext,
//                     ),
//                   ),
//                   // UserId != null
//                   //     ?
//                   FavoriteIcon(
//                     isFavorite: widget.favoritesProvider
//                         .isFavorite(widget.restaurant.id),
//                     onTap: () {
//                       if (UserId == null) {
//                       showDialog(
//   context: context,
//   builder: (_) => LoginRequiredDialog(
//     title: "Login Required",
//     content: "Please login to add this item to your favorites.",
//     cancelText: "Later",
//     confirmText: "Log In",
//     onConfirm: () {
//       // Navigate or perform any action
//       Get.offAll(() => const Loginscreen());
//     },
//   ),
// );
//                         return;
//                       }

//                       // ✅ Proceed with favorite toggle if user is logged in
//                       if (widget.favoritesProvider
//                           .isFavorite(widget.restaurant.id)) {
//                         widget.favoritesProvider
//                             .removeFavorite(widget.restaurant.id);
//                         nearbyreget.updateFavouriteFun(
//                           productCategoryId: productCateId,
//                           userId: UserId,
//                           productId: widget.restaurant.id,
//                         );
//                       } else {
//                         widget.favoritesProvider.addFavorite(widget.restaurant);
//                         nearbyreget.addfavouritesApi(
//                           productCategoryId: productCateId,
//                           userId: UserId,
//                           productId: widget.restaurant.id,
//                         );
//                       }
//                     },
//                   ),
//                   //  FavoriteIcon(
//                   //     isFavorite: widget.favoritesProvider
//                   //         .isFavorite(widget.restaurant.id),
//                   //     onTap: () {
//                   //       if (widget.favoritesProvider
//                   //           .isFavorite(widget.restaurant.id)) {
//                   //         widget.favoritesProvider
//                   //             .removeFavorite(widget.restaurant.id);
//                   //         nearbyreget.updateFavouriteFun(
//                   //           productCategoryId: productCateId,
//                   //           userId: UserId,
//                   //           productId: widget.restaurant.id,
//                   //         );
//                   //       } else {
//                   //         widget.favoritesProvider
//                   //             .addFavorite(widget.restaurant);
//                   //         nearbyreget.addfavouritesApi(
//                   //           productCategoryId: productCateId,
//                   //           userId: UserId,
//                   //           productId: widget.restaurant.id,
//                   //         );
//                   //       }
//                   //     },
//                   //   )

//                   // : SizedBox.shrink(),
//                 ],
//               ),
//               const CustomSizedBox(height: 5),
//               Row(
//                 children: [
//                   const Icon(
//                     Icons.location_on_outlined,
//                     size: 20,
//                     color: Customcolors.DECORATION_BLACK,
//                   ),
//                   Text(
//                     " ${restaurant["address"]["city"].toString().capitalizeFirst}, ${restaurant["address"]["region"].toString().capitalizeFirst}",
//                     overflow: TextOverflow.ellipsis,
//                     style: CustomTextStyle.boldgrey,
//                   ),
//                 ],
//               ),
//               const CustomSizedBox(height: 5),
//               Row(
//                 children: [
//                   restaurant["rating"] != null && restaurant["rating"] != 0
//                       ? const Icon(
//                           Icons.star,
//                           size: 20,
//                           color: Colors.amber,
//                         )
//                       : const SizedBox.shrink(),
//                   // Text(" ${restaurant["rating"].toString() ?? 0}",
//                   //     overflow: TextOverflow.ellipsis,
//                   //     style: CustomTextStyle.blacktext),
//                   restaurant["rating"] != null && restaurant["rating"] != 0
//                       ? Text(
//                           restaurant["rating"].toString(),
//                           overflow: TextOverflow.ellipsis,
//                           style: CustomTextStyle.blacktext,
//                         )
//                       : const SizedBox.shrink(),

//                   restaurant["totalRatingCount"] == "null" ||
//                           restaurant["totalRatingCount"] == 0
//                       ? const SizedBox.shrink()
//                       : Text("( ${restaurant["totalRatingCount"]} reviews)",
//                           style: CustomTextStyle.boldgrey),
//                 ],
//               ),
//               const Divider(),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Row(
//                     children: [],
//                   ),
//                   Row(
//                     children: [
//                       const Image(
//                         image: AssetImage("assets/images/discount.png"),
//                         height: 15,
//                         width: 20,
//                       ),
//                       (offerPercentage != null &&
//                               offerPercentage.toString().isNotEmpty &&
//                               offerPercentage != 0)
//                           ? Text(
//                               "Enjoy up to $offerPercentage% off your meal",
//                               style: CustomTextStyle.darkgrey,
//                             )
//                           : Consumer<HomepageProvider>(
//                               builder: (context, value, child) {
//                               if (value.isLoading) {
//                                 return const CupertinoActivityIndicator();
//                               } else if (value.orderModel == null ||
//                                   value.orderModel.isEmpty) {
//                                 return const Center(
//                                     child: Text(
//                                         "No deals right now, but stay tuned!",
//                                         style: CustomTextStyle.darkgrey));
//                               } else {
//                                 return Text(
//                                   "Enjoy up to ${value.orderModel["appConfigValue"]["value"]}% off your meal",
//                                   style: CustomTextStyle.darkgrey,
//                                 );
//                               }
//                             }),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// dynamic restaurant;
// dynamic restaurantId;
// dynamic restaurantCity;
// dynamic restaurantFoodTitle;
// dynamic restaurantName;
// dynamic restaurantReview;
// dynamic restaurantRegion;
// int? reviews;
// dynamic restaurantImg;
// int? menu;
// List<dynamic>? favourListDetails;

// List<String> newListData = [];





































// ignore_for_file: file_names, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:testing/Features/Authscreen/Loginscreen.dart';
import 'package:testing/Features/Foodmodule/Data/cartprovider.dart';
import 'package:testing/Features/Foodmodule/Domain/favouritemodel.dart';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Addfoodcontroller.dart';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Bannercontroller.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodsearch.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodviewfirstscreen.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/Getnearbyrescontroller.dart';
import 'package:testing/map_provider/Map%20Screens/MapSearch.dart/apiKey.dart';
import 'package:testing/utils/Buttons/CustomFavourite.dart';
import 'package:testing/utils/Buttons/CustomLogoutdialog.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ResturantsCard extends StatefulWidget {
  FavoriteRestaurant restaurant;
  dynamic nearbyresget;
  dynamic resRating;
  FavoritesProvider favoritesProvider;
  double latitude;
  double langitude;
  dynamic offervalue;
  // bool isfavtr;

  ResturantsCard(
      {super.key,
      required this.favoritesProvider,
      required this.restaurant,
      required this.nearbyresget,
      required this.latitude,
      required this.offervalue,
      this.resRating,
      // required this.isfavtr,
      required this.langitude});

  @override
  State<ResturantsCard> createState() => _ResturantsCardState();
}

class _ResturantsCardState extends State<ResturantsCard> {
  Foodcartcontroller foodcart = Get.put(Foodcartcontroller());
  @override
  void initState() {
    getDistance(
      destLat: widget.latitude,
      destLng: widget.langitude,
    );

    super.initState();
  }

  String offerValue = "";
  int _current = 0;
  Nearbyrescontroller nearbyreget = Get.put(Nearbyrescontroller());

  String totalDis = '';
  String totalDur = '';

  Future<void> getDistance(
      {required double destLat, required double destLng}) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?origin=$initiallat,$initiallong&destination=$destLat,$destLng&mode=driving&key=$kGoogleApiKey');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      processDirectionsResponse(data);
    } else {
      throw Exception('Failed to load directions');
    }
  }

  void processDirectionsResponse(Map<String, dynamic> data) {
    final routes = data['routes'] as List;
    if (routes.isNotEmpty) {
      final route = routes[0];
      final legs = route['legs'] as List;
      if (legs.isNotEmpty) {
        final leg = legs[0];
        totalDis = leg['distance']['text'];
        totalDur = leg['duration']['text'];
      }
    } else {
      debugPrint('check....Api Routs in getDistance Are Empty');
    }
  }

  @override
  Widget build(BuildContext context) {
   
    final restaurant = widget.nearbyresget["document"];
    final status = restaurant['status'];
  

     if (status == false) {
   
       return const SizedBox.shrink(); // This hides the widget completely
     }

    return GestureDetector(
      onTap: () {
        // if (isActive) {

        Get.to(
          Foodviewscreen(
            resRating: widget.resRating,
            totalDis: 5,
            restaurantId: restaurant["_id"],
          ),
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeIn,
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Customcolors.DECORATION_WHITE,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 190, 190, 192), //color of shadow
              spreadRadius: 3, //spread radius
              blurRadius: 7, // blur radius
              offset: Offset(0, 2),
            ),
          ],
        ),
       
        child: _buildRestaurantDetails(context),
      ),
    );
  }

  Widget _buildRestaurantDetails(
    BuildContext context,
  ) {
    final restaurant = widget.nearbyresget["document"];
   

    dynamic offerPercentage = restaurant.containsKey('servicesType')
        ? restaurant["servicesType"]["offerPercentage"]
        : "";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       
        ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15),bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
          child: CachedNetworkImage(
            placeholder: (context, url) => Image.asset(fastxdummyImg),
            errorWidget: (context, url, error) => Image.asset(fastxdummyImg),
            height: 160.h,
            width: MediaQuery.of(context).size.width,
            imageUrl: "${globalImageUrlLink}${restaurant["imgUrl"].toString()}",
            fit: BoxFit.fill,
          ),
        ),
        
       
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.3.w,
                    child: Text(
                    " ${restaurant["name"].toString().capitalizeFirst}",
                  
                      overflow: TextOverflow.clip,
                     // style: CustomTextStyle.googlebuttontext,
                     style: TextStyle(
      fontSize: 17.sp,
      fontWeight: FontWeight.w800,
      color: Customcolors.DECORATION_GREY,
      fontFamily: 'Poppins-Medium'),
                    ),
                  ),

 restaurant["rating"] != null && restaurant["rating"] != 0
                      ? 
                    Row(
                children: [
                 Image.asset("assets/images/star_icon.png",height: 16.sp,),
                            SizedBox(width: 5,),
                 ShaderMask(
  shaderCallback: (bounds) => const LinearGradient(
    colors: [Color(0xFFAE62E8), Color(0xFF623089)],
     begin: Alignment.topCenter,   // 👈 Start from top
    end: Alignment.bottomCenter,  // 👈 End at bottom
  ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                  child: Text(
                            restaurant["rating"].toString(),
                            overflow: TextOverflow.ellipsis,
                           // style: CustomTextStyle.blacktext,
                           style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      fontFamily: 'Poppins-Regular',
                    )
                          ),
                )
                     
                      ]) :  Row(
                children: [
                  // Icon(
                  //         Icons.star_outline_rounded,
                  //         size: 23.sp,
                  //         color: Color(0xFF623089)
                  //       ),
                     Image.asset("assets/images/star_icon.png",height: 16.sp,),
                            SizedBox(width: 5,),
                ShaderMask(
  shaderCallback: (bounds) => const LinearGradient(
    colors: [Color(0xFFAE62E8), Color(0xFF623089)],
     begin: Alignment.topCenter,   // 👈 Start from top
    end: Alignment.bottomCenter,  // 👈 End at bottom
  ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                  child: Text(
                           "0.0",
                            overflow: TextOverflow.ellipsis,
                           // style: CustomTextStyle.blacktext,
                           style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                     // color: Color(0xFF623089),
                       color: Colors.white,
                      fontFamily: 'Poppins-Regular',
                    )
                          ),
                )
                     
                      ])
                  // UserId != null
                  //     ?

//      Favourites

//                   FavoriteIcon(
//                     isFavorite: widget.favoritesProvider
//                         .isFavorite(widget.restaurant.id),
//                     onTap: () {
//                       if (UserId == null) {
//                       showDialog(
//   context: context,
//   builder: (_) => LoginRequiredDialog(
//     title: "Login Required",
//     content: "Please login to add this item to your favorites.",
//     cancelText: "Later",
//     confirmText: "Log In",
//     onConfirm: () {
//       // Navigate or perform any action
//       Get.offAll(() => const Loginscreen());
//     },
//   ),
// );
//                         return;
//                       }

//                       // ✅ Proceed with favorite toggle if user is logged in
//                       if (widget.favoritesProvider
//                           .isFavorite(widget.restaurant.id)) {
//                         widget.favoritesProvider
//                             .removeFavorite(widget.restaurant.id);
//                         nearbyreget.updateFavouriteFun(
//                           productCategoryId: productCateId,
//                           userId: UserId,
//                           productId: widget.restaurant.id,
//                         );
//                       } else {
//                         widget.favoritesProvider.addFavorite(widget.restaurant);
//                         nearbyreget.addfavouritesApi(
//                           productCategoryId: productCateId,
//                           userId: UserId,
//                           productId: widget.restaurant.id,
//                         );
//                       }
//                     },
//                   ),



                  // dont know so dont remove

                  //  FavoriteIcon(
                  //     isFavorite: widget.favoritesProvider
                  //         .isFavorite(widget.restaurant.id),
                  //     onTap: () {
                  //       if (widget.favoritesProvider
                  //           .isFavorite(widget.restaurant.id)) {
                  //         widget.favoritesProvider
                  //             .removeFavorite(widget.restaurant.id);
                  //         nearbyreget.updateFavouriteFun(
                  //           productCategoryId: productCateId,
                  //           userId: UserId,
                  //           productId: widget.restaurant.id,
                  //         );
                  //       } else {
                  //         widget.favoritesProvider
                  //             .addFavorite(widget.restaurant);
                  //         nearbyreget.addfavouritesApi(
                  //           productCategoryId: productCateId,
                  //           userId: UserId,
                  //           productId: widget.restaurant.id,
                  //         );
                  //       }
                  //     },
                  //   )

                  // : SizedBox.shrink(),
                ],
              ),
              const CustomSizedBox(height: 5),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 20,
                    color: Customcolors.DECORATION_BLACK,
                  ),
                  Text(
                  " ${restaurant["address"]["city"].toString().capitalizeFirst}, ${restaurant["address"]["region"].toString().capitalizeFirst}",
                    overflow: TextOverflow.ellipsis,
                  //   style: CustomTextStyle.boldgrey,
                     style: TextStyle(
      fontSize: 11.sp,
      fontWeight: FontWeight.w600,
      color: Customcolors.DECORATION_GREY,
      fontFamily: 'Poppins-Medium'),
                    ),
                  Spacer(),

                   restaurant["totalRatingCount"] == "null" ||
                           restaurant["totalRatingCount"] == 0
                       ?Text("0",
                          // style: CustomTextStyle.boldgrey),
                           style: TextStyle(
      fontSize: 11.sp,
      fontWeight: FontWeight.w600,
      color: Customcolors.DECORATION_GREY,
      fontFamily: 'Poppins-Medium'),
                    )
                       : Text("${restaurant["totalRatingCount"]}",
                          // style: CustomTextStyle.boldgrey),
                           style: TextStyle(
      fontSize: 11.sp,
      fontWeight: FontWeight.w600,
      color: Customcolors.DECORATION_GREY,
      fontFamily: 'Poppins-Medium'),
                    ),
                           SizedBox(width: 10,)
                ],
              ),
              const CustomSizedBox(height: 10),

              Row(children: [
//               RichText(
//   text: TextSpan(
//     children: [
//       TextSpan(
//         text: 'Delivery Within ',
//         style: GoogleFonts.montserrat(
//           fontSize: 10.sp,
//           color: Colors.black,
//          // fontFamily: 'Poppins-Medium',
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//       TextSpan(
//         text: '10 Min',
//         style: TextStyle(
//           fontSize: 11.sp,
//           color: Colors.green,
//           fontWeight: FontWeight.w700,
//         ),
//       ),
//       TextSpan(
//         text: ' To ',
//         style: TextStyle(
//           fontSize: 11.sp,
//           color: Colors.black,
//           fontWeight: FontWeight.w800,
//         ),
//       ),
//       TextSpan(
//         text: '20 Min',
//         style: TextStyle(
//           fontSize: 11.sp,
//           color: Colors.green,
//           fontWeight: FontWeight.w700,
//         ),
//       ),
//     ],
//   ),
// ),
// Text("Your order is on the way!",
//  style: TextStyle(
//           fontSize: 13.sp,
//           color: Customcolors.addressColor,
//           fontFamily: 'Poppins-Medium',
//           fontWeight: FontWeight.w600,
//         ),),


 
                      const Image(
                        image: AssetImage("assets/images/discount.png"),
                        height: 15,
                        width: 20,
                      ),
                      (offerPercentage != null &&
                              offerPercentage.toString().isNotEmpty &&
                              offerPercentage != 0)
                          ? Text(
                              "Enjoy up to $offerPercentage% off your meal",
                              style: CustomTextStyle.darkgrey,
                            )
                          : Consumer<HomepageProvider>(
                              builder: (context, value, child) {
                              if (value.isLoading) {
                                return const CupertinoActivityIndicator();
                              } else if (value.orderModel == null ||
                                  value.orderModel.isEmpty) {
                                return const Center(
                                    child: Text(
                                        "No deals right now, but stay tuned!",
                                        style: CustomTextStyle.darkgrey));
                              } else {
                                return Text(
                                  "Enjoy up to ${value.orderModel["appConfigValue"]["value"]}% off your meal",
                                  style: CustomTextStyle.darkgrey,
                                );
                              }
                            }),
                  
                Spacer(),
                Text("Ratings",
                          // style: CustomTextStyle.boldgrey),
                           style: TextStyle(
      fontSize: 11.sp,
      fontWeight: FontWeight.w600,
      color: Customcolors.DECORATION_GREY,
      fontFamily: 'Poppins-Medium'),
                    ),],),
              // Row(
              //   children: [
              //     restaurant["rating"] != null && restaurant["rating"] == 0
              //         ? const Icon(
              //             Icons.star,
              //             size: 20,
              //             color: Colors.amber,
              //           )
              //         : const SizedBox.shrink(),
                 
              //     restaurant["rating"] != null && restaurant["rating"] == 0
              //         ? Text(
              //             restaurant["rating"].toString(),
              //             overflow: TextOverflow.ellipsis,
              //             style: CustomTextStyle.blacktext,
              //           )
              //         : const SizedBox.shrink(),

              //     restaurant["totalRatingCount"] == "null" ||
              //             restaurant["totalRatingCount"] != 0
              //         ? const SizedBox.shrink()
              //         : Text("( ${restaurant["totalRatingCount"]} reviews)",
              //             style: CustomTextStyle.boldgrey),
              //   ],
              // ),





              // const Divider(),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     const Row(
              //       children: [],
              //     ),
              //     Row(
              //       children: [
              //         const Image(
              //           image: AssetImage("assets/images/discount.png"),
              //           height: 15,
              //           width: 20,
              //         ),
              //         (offerPercentage != null &&
              //                 offerPercentage.toString().isNotEmpty &&
              //                 offerPercentage != 0)
              //             ? Text(
              //                 "Enjoy up to $offerPercentage% off your meal",
              //                 style: CustomTextStyle.darkgrey,
              //               )
              //             : Consumer<HomepageProvider>(
              //                 builder: (context, value, child) {
              //                 if (value.isLoading) {
              //                   return const CupertinoActivityIndicator();
              //                 } else if (value.orderModel == null ||
              //                     value.orderModel.isEmpty) {
              //                   return const Center(
              //                       child: Text(
              //                           "No deals right now, but stay tuned!",
              //                           style: CustomTextStyle.darkgrey));
              //                 } else {
              //                   return Text(
              //                     "Enjoy up to ${value.orderModel["appConfigValue"]["value"]}% off your meal",
              //                     style: CustomTextStyle.darkgrey,
              //                   );
              //                 }
              //               }),
              //       ],
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ],
    );
  }
}

dynamic restaurant;
dynamic restaurantId;
dynamic restaurantCity;
dynamic restaurantFoodTitle;
dynamic restaurantName;
dynamic restaurantReview;
dynamic restaurantRegion;
int? reviews;
dynamic restaurantImg;
int? menu;
List<dynamic>? favourListDetails;

List<String> newListData = [];
