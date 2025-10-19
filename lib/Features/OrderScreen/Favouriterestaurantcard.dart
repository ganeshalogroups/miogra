// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'package:dotted_line/dotted_line.dart';
import 'package:testing/Features/Foodmodule/Data/cartprovider.dart';
import 'package:testing/Features/Foodmodule/Domain/favouritemodel.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/Getnearbyrescontroller.dart';
import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Redirectcontroller.dart';
import 'package:testing/Features/OrderScreen/OrderScreenController/Favrestaurantcotroller.dart';
import 'package:testing/utils/Buttons/CustomFavourite.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Toast/customtoastmessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Favouriterescard extends StatefulWidget {

FavoriteRestaurant restaurant;
FavoritesProvider favoritesProvider;

  dynamic favresget;
  var latitude;
  var langitude;



   Favouriterescard({ 
      required this.favresget,
      required this.favoritesProvider,
      required this.restaurant,
      required this.latitude,
      required this.langitude,
      super.key});


  @override
  State<Favouriterescard> createState() => _FavouriterescardState();
}



class _FavouriterescardState extends State<Favouriterescard> {

FavresGetcontroller favresget=Get.put(FavresGetcontroller());
Nearbyrescontroller nearbyreget = Get.put(Nearbyrescontroller());
 RedirectController redirect = Get.put(RedirectController());
 @override
  void initState() {


        // favresget.favresPagingController.refresh();
        // getDistance(
        // destLat: widget.latitude,
        // destLng: widget.langitude,
        // originLat: initiallat,
        // originLng: initiallong);


    super.initState();
  }
  @override
  Widget build(BuildContext context) {

 double rating = widget.favresget["restaurantDetails"]["ratingAverage"].toString() == 'null' ? 0   : double.tryParse(widget.favresget["restaurantDetails"]["ratingAverage"].toString())?.roundToDouble() ?? 0;
    
    dynamic offerPercentage = widget.favresget["restaurantDetails"].containsKey('servicesType')? widget.favresget["restaurantDetails"]["servicesType"]["offerPercentage"]  : "";
    
       Provider.of<ListProvider>(context);


    return widget.favresget["restaurantDetails"]["status"]==true&&widget.favresget["restaurantDetails"]["activeStatus"]=="online"? Container(
                    // height: MediaQuery.of(context).size.height * 0.21,
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Customcolors.DECORATION_CONTAINERGREY,
                      boxShadow: [
                        BoxShadow(
                          color: Customcolors.DECORATION_LIGHTGREY,
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomSizedBox( height: 5,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:  [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width/1.9.w,
                                      child: Text(
                                        " ${widget.favresget["restaurantDetails"]["name"].toString().toString().capitalizeFirst.toString()}",
                                        style: CustomTextStyle.googlebuttontext,
                                      ),
                                    ),

                         
                                 FavoriteIcon(
                                   isFavorite:  widget.favoritesProvider.isFavorite(widget.restaurant.id) || widget.favresget["restaurantDetails"]["status"]==true ,


                                  onTap: () async {

                                  widget.favoritesProvider.removeFavorite(widget.restaurant.id);

                                // Remove from API favorites
                                // nearbyreget.removefavouritesApi(widget.favresget["_id"]);

                                await nearbyreget.updateFavouriteFun(
                                      productCategoryId: productCateId,
                                      userId: UserId,
                                      productId: widget.restaurant.id,
                                    );

                                  favresget.favresPagingController.refresh();
                                  setState(() {});

                              }
                            ),
                                 


                                  ],
                                ),
                                const CustomSizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children:  [

                                    const Icon(
                                      Icons.location_on_outlined,
                                      size: 20,
                                      color: Customcolors.DECORATION_BLACK,
                                    ),

                                    
                                     Text("${widget.favresget["restaurantDetails"]["address"]["city"].toString().capitalizeFirst.toString()}, ${widget.favresget["restaurantDetails"]["address"]["region"].toString().capitalizeFirst.toString()}",
                                       overflow: TextOverflow.ellipsis,
                                      style: CustomTextStyle.boldgrey,
                                    )


                                  ],
                                ),
                                const CustomSizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children:  [
                                   (rating == 0)?SizedBox.fromSize():  const Icon(
                                      Icons.star,
                                      size: 20,
                                      color: Colors.amber,
                                    ),
                                  (rating == 0)?SizedBox.fromSize():   Text(" $rating", style: CustomTextStyle.blacktext),
                                       widget.favresget['restaurantDetails']["ratings"].isEmpty || widget.favresget['restaurantDetails']["ratings"] == null? const SizedBox.shrink():
                                    Text(" (${widget.favresget['restaurantDetails']['ratings'].length} reviews)", style: CustomTextStyle.boldgrey)
                                       
                                  ],
                                ),
                                const CustomSizedBox(
                                  height: 5,
                                ),
                                Container(
                                  color: Customcolors.DECORATION_CONTAINERGREY,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DottedLine(
                                        direction: Axis.horizontal,
                                        alignment: WrapAlignment.center,
                                        lineLength: double.infinity,
                                        lineThickness: 1.0,
                                        dashLength: 4.0,
                                        dashColor: Colors.black,
                                        dashGradient: const [
                                          Color.fromARGB(255, 169, 169, 169),
                                          Color.fromARGB(255, 185, 187, 188)
                                        ],
                                        dashRadius: 4,
                                        dashGapLength: 6,
                                        dashGapRadius: 5),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:   [
                                    const Row(
                                      children: [
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Image(
                                          image: AssetImage(
                                              "assets/images/discount.png"),
                                          height: 15,
                                          width: 20,
                                        ),
                                          (offerPercentage != null && offerPercentage.toString().isNotEmpty&& offerPercentage != 0)
                   ? Text(
                  "Enjoy up to $offerPercentage% off your meal",
                   style: CustomTextStyle.darkgrey,)
                   :
                                          Obx(() {
  // Check if loading is in progress
  if (redirect.isredirectLoading.isTrue) {
    return const Center(child: CupertinoActivityIndicator());
  } 
  // If data is missing or null, show a default value
  else if (redirect.redirectLoadingDetails == null || redirect.redirectLoadingDetails["data"] == null) {
    return const Center(child: Text('No deals right now, but stay tuned!', style: CustomTextStyle.darkgrey));
  } 
  else {
    // Searching for "offerValue" in the data and using it directly
    for (var item in redirect.redirectLoadingDetails["data"]) {
      if (item["key"] == "offerValue") {
        // Directly access and display the offerValue
        return Text(
          "Enjoy up to ${item["value"]}% off your meal", 
          style: CustomTextStyle.darkgrey,
        );
      }
    }
    // If the "offerValue" is not found, fallback to default value
    return const Center(child: Text('No deals right now, but stay tuned!', style: CustomTextStyle.darkgrey));
  }
}),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ) : GestureDetector(
            onTap: () {
              AppUtils.showToast('The Resturants Currently Closed');
            },
            child:  Container(
                    // height: MediaQuery.of(context).size.height * 0.21,
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Customcolors.DECORATION_CONTAINERGREY,
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(146, 0, 0, 0),
                      Colors.grey,
                      Colors.white,
                    ]),
                      boxShadow: [
                        BoxShadow(
                          color: Customcolors.DECORATION_LIGHTGREY,
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomSizedBox( height: 5,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:  [
                                    SizedBox(
                                    width: MediaQuery.of(context).size.width/1.3,
                                      child: Text(
                                        " ${widget.favresget["restaurantDetails"]["name"].toString().toString().capitalizeFirst.toString()}",
                                        overflow: TextOverflow.clip,
                                        maxLines: 3,
                                        style: CustomTextStyle.googlebuttontext,
                                      ),
                                    ),


                              FavoriteIcon(
                              isFavorite:  widget.favoritesProvider.isFavorite(widget.restaurant.id),
                              onTap: () {

                              //  if (widget.favoritesProvider.isFavorite(widget.restaurant.id)) {
                               widget.favoritesProvider.removeFavorite(widget.restaurant.id);

                              // Remove from API favorites
                               nearbyreget.removefavouritesApi(widget.favresget["_id"]);
                              favresget.favresPagingController.refresh();
                              //  }
                                }
                              ),



                                  ],
                                ),
                                const CustomSizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children:  [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      size: 20,
                                      color: Customcolors.DECORATION_BLACK,
                                    ),
                                    Text(
                                       " ${widget.favresget["restaurantDetails"]["address"]["city"].toString().capitalizeFirst.toString()}, ${widget.favresget["restaurantDetails"]["address"]["region"].toString().capitalizeFirst.toString()}",
                              overflow: TextOverflow.ellipsis,
                                      style: CustomTextStyle.disablegrey,
                                    )
                                  ],
                                ),
                                const CustomSizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children:  [
                                   (rating == 0)?SizedBox.fromSize():  const Icon(
                                      Icons.star,
                                      size: 20,
                                      color: Colors.amber,
                                    ),
                                  (rating == 0)?SizedBox.fromSize():   Text(" $rating", style: CustomTextStyle.blacktext),
                                       widget.favresget['restaurantDetails']["ratings"].isEmpty || widget.favresget['restaurantDetails']["ratings"] == null? const SizedBox.shrink():
                                    Text(" (${widget.favresget['restaurantDetails']['ratings'].length} reviews)", style: CustomTextStyle.boldgrey)
                                       
                                  ],
                                ),
                                // Row(
                                //   children:  [
                                //     Icon(
                                //       Icons.star,
                                //       size: 20,
                                //       color: Colors.amber,
                                //     ),
                                //     Text(" $rating",
                                //         style: CustomTextStyle.blacktext),
                                //     Text(" (57 reviews)",
                                //         style: CustomTextStyle.boldgrey)
                                //   ],
                                // ),
                                const CustomSizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DottedLine(
                                      direction: Axis.horizontal,
                                      alignment: WrapAlignment.center,
                                      lineLength: double.infinity,
                                      lineThickness: 1.0,
                                      dashLength: 4.0,
                                      dashColor: Colors.black,
                                      dashGradient: const [
                                        Color.fromARGB(255, 169, 169, 169),
                                        Color.fromARGB(255, 185, 187, 188)
                                      ],
                                      dashRadius: 4,
                                      dashGapLength: 6,
                                      dashGapRadius: 5),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:   [
                                    const Row(
                                      children: [
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Image(
                                          image: AssetImage(
                                              "assets/images/discount.png"),
                                          height: 15,
                                          width: 20,
                                        ),
                                     (offerPercentage != null && offerPercentage.toString().isNotEmpty&& offerPercentage != 0)
                   ? Text(
                  "Enjoy up to $offerPercentage% off your meal",
                   style: CustomTextStyle.darkgrey,)
                   :          Obx(() {
  // Check if loading is in progress
  if (redirect.isredirectLoading.isTrue) {
    return const Center(child: CupertinoActivityIndicator());
  } 
  // If data is missing or null, show a default value
  else if (redirect.redirectLoadingDetails == null || redirect.redirectLoadingDetails["data"] == null) {
    return const Center(child: Text('No deals right now, but stay tuned!', style: CustomTextStyle.darkgrey));
  } 
  else {
    // Searching for "offerValue" in the data and using it directly
    for (var item in redirect.redirectLoadingDetails["data"]) {
      if (item["key"] == "offerValue") {
        // Directly access and display the offerValue
        return Text(
          "Enjoy up to ${item["value"]}% off your meal", 
          style: CustomTextStyle.darkgrey,
        );
      }
    }
    // If the "offerValue" is not found, fallback to default value
    return const Center(child: Text('No deals right now, but stay tuned!', style: CustomTextStyle.darkgrey));
  }
}),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          );                      
  }
}


// @override
// Widget build(BuildContext context) {
//   final restaurant = widget.favresget["restaurantDetails"];

//   // Case 1: status == false → Do not render anything
//   if (restaurant["status"] == false) {
//     return const SizedBox.shrink(); // empty widget
//   }

//   // Parse rating safely
//   double rating = restaurant["ratingAverage"].toString() == 'null'
//       ? 0
//       : double.tryParse(restaurant["ratingAverage"].toString())?.roundToDouble() ?? 0;

//   Provider.of<ListProvider>(context); // Ensure Provider call is kept

//   // Case 2: status == true && activeStatus == "offline" → Greyed out (disabled)
//   if (restaurant["status"] == true && restaurant["activeStatus"] == "offline") {
//     return GestureDetector(
//       onTap: () {
//         AppUtils.showToast('The Restaurant is Currently Closed');
//       },
//       child: _buildRestaurantCard(
//         context,
//         restaurant,
//         rating,
//         isActive: false,
//       ),
//     );
//   }

//   // Case 3: status == true && activeStatus == "online" → Normal clickable card
//   return _buildRestaurantCard(
//     context,
//     restaurant,
//     rating,
//     isActive: true,
//   );
// }

// Widget _buildRestaurantCard(BuildContext context, dynamic restaurant, double rating, {required bool isActive}) {
//   return Container(
//     margin: const EdgeInsets.symmetric(vertical: 10),
//     width: MediaQuery.of(context).size.width,
//     decoration: BoxDecoration(
//       borderRadius: const BorderRadius.all(Radius.circular(15)),
//       color: Customcolors.DECORATION_CONTAINERGREY,
//       gradient: !isActive
//           ? const LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//                 Color.fromARGB(146, 0, 0, 0),
//                 Colors.grey,
//                 Colors.white,
//               ],
//             )
//           : null,
//       boxShadow: const [
//         BoxShadow(
//           color: Customcolors.DECORATION_LIGHTGREY,
//           spreadRadius: 5,
//           blurRadius: 7,
//           offset: Offset(0, 2),
//         ),
//       ],
//     ),
//     child: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const CustomSizedBox(height: 5),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 // Restaurant Name + Favorite Button Row
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width / (isActive ? 1.9 : 1.3),
//                       child: Text(
//                         " ${restaurant["name"].toString().capitalizeFirst}",
//                         overflow: TextOverflow.ellipsis,
//                         style: CustomTextStyle.googlebuttontext,
//                       ),
//                     ),
//                     FavoriteIcon(
//                       isFavorite: widget.favoritesProvider.isFavorite(widget.restaurant.id),
//                       onTap: () async {
//                         widget.favoritesProvider.removeFavorite(widget.restaurant.id);
//                         if (isActive) {
//                           await nearbyreget.updateFavouriteFun(
//                             productCategoryId: productCateId,
//                             userId: UserId,
//                             productId: widget.restaurant.id,
//                           );
//                         } else {
//                           nearbyreget.removefavouritesApi(widget.favresget["_id"]);
//                         }
//                         favresget.favresPagingController.refresh();
//                         setState(() {});
//                       },
//                     ),
//                   ],
//                 ),
//                 const CustomSizedBox(height: 10),
//                 // Address
//                 Row(
//                   children: [
//                     const Icon(Icons.location_on_outlined, size: 20, color: Customcolors.DECORATION_BLACK),
//                     Text(
//                       " ${restaurant["address"]["city"].toString().capitalizeFirst}, ${restaurant["address"]["region"].toString().capitalizeFirst}",
//                       overflow: TextOverflow.ellipsis,
//                       style: isActive ? CustomTextStyle.boldgrey : CustomTextStyle.disablegrey,
//                     ),
//                   ],
//                 ),
//                 const CustomSizedBox(height: 5),
//                 // Rating
//                 Row(
//                   children: [
//                     const Icon(Icons.star, size: 20, color: Colors.amber),
//                     Text(" $rating", style: CustomTextStyle.blacktext),
//                     Text(" (${restaurant['ratings'].length} reviews)", style: CustomTextStyle.boldgrey),
//                   ],
//                 ),
//                 const CustomSizedBox(height: 5),
//                 // Dotted Divider
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: DottedLine(
//                     direction: Axis.horizontal,
//                     alignment: WrapAlignment.center,
//                     lineLength: double.infinity,
//                     lineThickness: 1.0,
//                     dashLength: 4.0,
//                     dashColor: Colors.black,
//                     dashGradient: const [
//                       Color.fromARGB(255, 169, 169, 169),
//                       Color.fromARGB(255, 185, 187, 188)
//                     ],
//                     dashRadius: 4,
//                     dashGapLength: 6,
//                     dashGapRadius: 5,
//                   ),
//                 ),
//                 // Discount Info
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const SizedBox(), // placeholder
//                     Row(
//                       children: [
//                         const Image(
//                           image: AssetImage("assets/images/discount.png"),
//                           height: 15,
//                           width: 20,
//                         ),
//                         Obx(() {
//                           if (redirect.isredirectLoading.isTrue) {
//                             return const Center(child: CupertinoActivityIndicator());
//                           } else if (redirect.redirectLoadingDetails == null ||
//                               redirect.redirectLoadingDetails["data"] == null) {
//                             return Text('No deals right now, but stay tuned!',
//                                 style: CustomTextStyle.darkgrey);
//                           } else {
//                             for (var item in redirect.redirectLoadingDetails["data"]) {
//                               if (item["key"] == "offerValue") {
//                                 return Text("Enjoy up to ${item["value"]}% off your meal",
//                                     style: CustomTextStyle.darkgrey);
//                               }
//                             }
//                             return Text('No deals right now, but stay tuned!',
//                                 style: CustomTextStyle.darkgrey);
//                           }
//                         }),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

// }