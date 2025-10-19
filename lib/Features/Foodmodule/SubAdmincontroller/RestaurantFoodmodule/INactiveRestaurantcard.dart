// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:testing/Features/Foodmodule/Data/cartprovider.dart';
import 'package:testing/Features/Foodmodule/Domain/favouritemodel.dart';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Bannercontroller.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/Getnearbyrescontroller.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/Inactiverescontroller.dart';
import 'package:testing/utils/Buttons/CustomFavourite.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Toast/customtoastmessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Inactiverestaurantcard extends StatefulWidget {
 FavoritesProvider favoritesProvider;
  final bool isRecomResEmpty;
  final bool hasBottomBannerList;
  dynamic offervalue;
  Inactiverestaurantcard({
    super.key,
    required this.favoritesProvider,
    this.hasBottomBannerList = false,
    required this.offervalue,
    required this.isRecomResEmpty,
  });

  @override
  State<Inactiverestaurantcard> createState() => _InactiverestaurantcardState();
}

class _InactiverestaurantcardState extends State<Inactiverestaurantcard> {
  Inactiverescontroller inactiverestt = Get.put(Inactiverescontroller());
  Nearbyrescontroller nearbyreget = Get.put(Nearbyrescontroller());
   //Nearbyrescontroller nearbyreget = Get.put(Nearbyrescontroller());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (inactiverestt.inactiveresloading.isTrue) {
        return const Center(
            child: CupertinoActivityIndicator(
          color: Customcolors.DECORATION_WHITE,
        ));
      } 
       else if (inactiverestt.inactiveresModel == null) {
        //return CircularProgressIndicator(color: Customcolors.darkpurple,);
         return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Image.asset(
               nearbyreget.selectedIndex.value ==
                                                                              0
                                                                          ? 
                "assets/images/No Food.png":  "assets/images/No orders.png",
                height: nearbyreget.selectedIndex.value ==
                                                                              0? 350:250,
              //  height: 350,
               // width: double.infinity,
                fit: BoxFit.cover,
              ),
             Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                   nearbyreget.selectedIndex.value ==
                                                                              0
                                                                          ? 
                                                                         "No Restaurants Available right Now":"No Shops Available right Now",
                  style: CustomTextStyle.chipgrey,
                ),
              )
            ],
          ),
        ); //
       
      } else if (widget.isRecomResEmpty &&
          !widget.hasBottomBannerList &&
          inactiverestt.inactiveresModel["data"]["data"].isEmpty) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Image.asset(
               nearbyreget.selectedIndex.value ==
                                                                              0
                                                                          ? 
                "assets/images/No Food.png":  "assets/images/No orders.png",
                height: nearbyreget.selectedIndex.value ==
                                                                              0? 350:250,
              //  height: 350,
               // width: double.infinity,
                fit: BoxFit.cover,
              ),
             Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                   nearbyreget.selectedIndex.value ==
                                                                              0
                                                                          ? 
                                                                         "No Restaurants Available right Now":"No Shops Available right Now",
                  style: CustomTextStyle.chipgrey,
                ),
              )
            ],
          ),
        ); // <-- Extracted helper
      } else if (widget.isRecomResEmpty &&
          inactiverestt.inactiveresModel["data"]["data"].isEmpty) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Image.asset(
              nearbyreget.selectedIndex.value ==
                                                                              0
                                                                          ? 
                "assets/images/No Food.png":  "assets/images/No orders.png",
                height: nearbyreget.selectedIndex.value ==
                                                                              0? 350:250,
               // height: 350,
              //  width: double.infinity,
                fit: BoxFit.cover,
              ),
               Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  nearbyreget.selectedIndex.value ==
                                                                              0
                                                                          ? 
                                                                         "No Restaurants Available right Now":"No Shops Available right Now",
                  style: CustomTextStyle.chipgrey,
                ),
              )
            ],
          ),
        );
      } 
      else if (inactiverestt.inactiveresModel["data"]["data"].isEmpty) {
        return const SizedBox.shrink();
      } else {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Image.asset(  nearbyreget.selectedIndex.value ==
                                                                              0
                                                                          ? 
                "assets/images/No Food.png":  "assets/images/No orders.png",
                height: nearbyreget.selectedIndex.value ==
                                                                              0? 350:250,
              //  width: double.infinity,
                fit: BoxFit.cover,
              ),
               Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
              nearbyreget.selectedIndex.value ==
                                                                              0
                                                                          ? 
                                                                         "No Restaurants Available right Now":"No Shops Available right Now",
                  style: CustomTextStyle.chipgrey,
                ),
              )
            ],
          ),
        );
        // return Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     const Padding(
        //       padding: EdgeInsets.symmetric(horizontal: 8),
        //       child: Text(
        //         "We’re Offline Right Now",
        //         style: CustomTextStyle.googlebuttontext,
        //       ),
        //     ),
        //     ListView.builder(
        //       shrinkWrap: true,
        //       physics: const NeverScrollableScrollPhysics(),
        //       itemCount: inactiverestt.inactiveresModel["data"]["data"].length,
        //       itemBuilder: (context, index) {
        //         final restaurant = inactiverestt.inactiveresModel["data"]
        //             ["data"][index]["document"];
        //         final inactiverestaurant = FavoriteRestaurant(
        //           id: restaurant["_id"],
        //           name: restaurant["name"].toString(),
        //           city: restaurant["address"]["city"].toString(),
        //           region: restaurant["address"]["region"].toString(),
        //           imageUrl:"$globalImageUrlLink${restaurant["imgUrl"].toString()}",
        //           rating: restaurant["rating"].toString(),
        //         );
        //         return GestureDetector(
        //           onTap: () {
        //             AppUtils.showToast('The Restaurant is Currently Closed');
        //           },
        //           child: Container(
        //             margin: const EdgeInsets.only(top: 10, bottom: 10),
        //             width: MediaQuery.of(context).size.width,
        //             decoration: const BoxDecoration(
        //               borderRadius: BorderRadius.all(Radius.circular(15)),
        //               gradient: LinearGradient(
        //                 begin: Alignment.topCenter,
        //                 end: Alignment.bottomCenter,
        //                 colors: [Colors.black87, Colors.grey, Colors.white],
        //               ),
        //               color: Customcolors.DECORATION_WHITE,
        //               boxShadow: [
        //                 BoxShadow(
        //                   color: Customcolors
        //                       .DECORATION_LIGHTGREY, //color of shadow
        //                   spreadRadius: 5, //spread radius
        //                   blurRadius: 7, // blur radius
        //                   offset: Offset(0, 2),
        //                 ),
        //               ],
        //             ),
        //             child: Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 ClipRRect(
        //                   borderRadius: const BorderRadius.only(
        //                       topLeft: Radius.circular(15),
        //                       topRight: Radius.circular(15)),
        //                   child: ColorFiltered(
        //                     colorFilter: const ColorFilter.mode(
        //                       Colors.grey,
        //                       BlendMode.saturation,
        //                     ),
        //                     child: CachedNetworkImage(
        //                       placeholder: (context, url) =>
        //                           Image.asset(fastxdummyImg),
        //                       errorWidget: (context, url, error) =>
        //                           Image.asset(fastxdummyImg),
        //                       height: 100.h,
        //                       width: MediaQuery.of(context).size.width,
        //                       imageUrl:
        //                           "$globalImageUrlLink${restaurant["imgUrl"].toString()}",
        //                       fit: BoxFit.fitWidth,
        //                     ),
        //                   ),
        //                 ),
        //                 const CustomSizedBox(height: 5),
        //                 Padding(
        //                   padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
        //                   child: Column(
        //                     children: [
        //                       Row(
        //                         mainAxisAlignment:
        //                             MainAxisAlignment.spaceBetween,
        //                         children: [
        //                           SizedBox(
        //                             width: MediaQuery.of(context).size.width /
        //                                 1.3.w,
        //                             child: Text(
        //                               " ${restaurant["name"].toString().capitalizeFirst}",
        //                               overflow: TextOverflow.clip,
        //                               style: CustomTextStyle.googlebuttontext,
        //                             ),
        //                           ),
        //                           FavoriteIcon(
        //                             isFavorite: widget.favoritesProvider
        //                                 .isFavorite(inactiverestaurant.id),
        //                             onTap: () {
        //                               if (widget.favoritesProvider
        //                                   .isFavorite(inactiverestaurant.id)) {
        //                                 widget.favoritesProvider.removeFavorite(
        //                                     inactiverestaurant.id);
        //                                 nearbyreget.updateFavouriteFun(
        //                                   productCategoryId: productCateId,
        //                                   userId: UserId,
        //                                   productId: inactiverestaurant.id,
        //                                 );
        //                               } else {
        //                                 widget.favoritesProvider
        //                                     .addFavorite(inactiverestaurant);
        //                                 nearbyreget.addfavouritesApi(
        //                                   productCategoryId: productCateId,
        //                                   userId: UserId,
        //                                   productId: inactiverestaurant.id,
        //                                 );
        //                               }
        //                             },
        //                           ),
        //                         ],
        //                       ),
        //                       const CustomSizedBox(height: 5),
        //                       Row(
        //                         children: [
        //                           const Icon(
        //                             Icons.location_on_outlined,
        //                             size: 20,
        //                             color: Customcolors.DECORATION_BLACK,
        //                           ),
        //                           Text(
        //                             " ${restaurant["address"]["city"].toString().capitalizeFirst}, ${restaurant["address"]["region"].toString().capitalizeFirst}",
        //                             overflow: TextOverflow.ellipsis,
        //                             style: CustomTextStyle.boldgrey,
        //                           ),
        //                         ],
        //                       ),
        //                       const CustomSizedBox(height: 5),
        //                       Row(
        //                         children: [
        //                           restaurant["rating"] != null &&
        //                                   restaurant["rating"] != 0
        //                               ? const Icon(
        //                                   Icons.star,
        //                                   size: 20,
        //                                   color: Colors.amber,
        //                                 )
        //                               : const SizedBox.shrink(),
        //                           // Text(" ${restaurant["rating"].toString() ?? 0}",
        //                           //     overflow: TextOverflow.ellipsis,
        //                           //     style: CustomTextStyle.blacktext),
        //                           restaurant["rating"] != null &&
        //                                   restaurant["rating"] != 0
        //                               ? Text(
        //                                   restaurant["rating"].toString(),
        //                                   overflow: TextOverflow.ellipsis,
        //                                   style: CustomTextStyle.blacktext,
        //                                 )
        //                               : const SizedBox.shrink(),

        //                           restaurant["totalRatingCount"] == "null" ||
        //                                   restaurant["totalRatingCount"] == 0
        //                               ? const SizedBox.shrink()
        //                               : Text(
        //                                   "( ${restaurant["totalRatingCount"]} reviews)",
        //                                   style: CustomTextStyle.boldgrey),
        //                         ],
        //                       ),
        //                       const Divider(),
        //                       Row(
        //                         mainAxisAlignment:
        //                             MainAxisAlignment.spaceBetween,
        //                         children: [
        //                           const Row(
        //                             children: [],
        //                           ),
        //                           Row(
        //                             children: [
        //                               const Image(
        //                                 image: AssetImage(
        //                                     "assets/images/discount.png"),
        //                                 height: 15,
        //                                 width: 20,
        //                               ),
        //                               Consumer<HomepageProvider>(
        //                                   builder: (context, value, child) {
        //                                 if (value.isLoading) {
        //                                   return const CupertinoActivityIndicator();
        //                                 } else if (value.orderModel == null ||
        //                                     value.orderModel.isEmpty) {
        //                                   return const Center(
        //                                       child: Text(
        //                                           "No deals right now, but stay tuned!",
        //                                           style: CustomTextStyle
        //                                               .darkgrey));
        //                                 } else {
        //                                   return Text(
        //                                     "Enjoy up to ${value.orderModel["appConfigValue"]["value"]}% off your meal",
        //                                     style: CustomTextStyle.darkgrey,
        //                                   );
        //                                 }
        //                               }),
        //                             ],
        //                           ),
        //                         ],
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         );
        //       },
        //     ),
        //   ],
        // );
      }
    });
  }
}
