// ignore_for_file: file_names, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:testing/Features/Authscreen/Loginscreen.dart';
import 'package:testing/Features/Foodmodule/Data/cartprovider.dart';
import 'package:testing/Features/Foodmodule/Domain/favouritemodel.dart';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Foodsearchlistgetcontroller.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodviewfirstscreen.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/Getnearbyrescontroller.dart';
import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Redirectcontroller.dart';
import 'package:testing/utils/Buttons/CustomFavourite.dart';
import 'package:testing/utils/Buttons/CustomLogoutdialog.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Shimmers/Nearestrestaurantshimmer.dart';
import 'package:testing/utils/Shimmers/Searchlistloader.dart';
import 'package:testing/utils/Toast/customtoastmessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Restaurantfoodlist extends StatelessWidget {
  final String? searchvalue;
  Restaurantfoodlist({this.searchvalue, super.key});

  final Foodsearchcontroller createrecentsearch = Get.put(Foodsearchcontroller());
  final Nearbyrescontroller nearbyreget = Get.find<Nearbyrescontroller>();

  @override
  Widget build(BuildContext context) {
    final searchTerm = (searchvalue == null || searchvalue!.isEmpty)
        ? 'Biryani'
        : searchvalue!.capitalizeFirst!;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomSizedBox(height: 10),
            Text("Search results for $searchTerm", style: CustomTextStyle.darkgrey),
            const CustomSizedBox(height: 10),
            Obx(() {
              if (createrecentsearch.dishessearchlistloading.value) {
                return const Center(child: Nearestresshimmer());
              } else if (createrecentsearch.dishessearchlist == null) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Serchlistloading(),
                      Text(
                        "No more restaurants Available!",
                        style: CustomTextStyle.darkgrey,
                      ),
                    ],
                  ),
                );
              } else if (createrecentsearch.dishessearchlist!["data"]["restaurantDetails"].isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Serchlistloading(),
                      Text(
                        "No more restaurants serving ${searchTerm.capitalizeFirst.toString()}!",
                        style: CustomTextStyle.darkgrey,
                      ),
                    ],
                  ),
                );
              } else {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: createrecentsearch.dishessearchlist!["data"]["restaurantDetails"].length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final item = createrecentsearch.dishessearchlist!["data"]["restaurantDetails"][index]["document"];
                    final dynamic rating = item["rating"];
                    // final List favourListDetails = item["favourListDetails"] ?? [];
                    // final List<dynamic>? restaurantFoodTitle = item["cusineList"] ;
                    final bool status = item["status"] ;
                    final dynamic activeStatus = item["activeStatus"];
                    // final dynamic fullAddress = item["address"]["fullAddress"];
                    // final dynamic latitude = item["address"]['latitude'];
                    // final dynamic longitude = item["address"]['longitude'];

                    // final dynamic ratingString = item["totalRatingCount"]?.toString() ?? '0';
                    final dynamic reviews = item["totalRatingCount"] ;

                    // final List<dynamic> additionalImages = (item["additionalImage"] ?? [])
                    //     .map<String>((img) => "$globalImageUrlLink$img")
                    //     .toList();

                    return DishResCard(
                      searchvalue: searchvalue,
                      item: item,
                      // additionalImages: additionalImages,
                      // destlat: latitude,
                      // destlong: longitude,
                      // favourListDetails: favourListDetails,
                      rating: rating,
                      // favrestaurant: restaurant,
                      // restaurantfoodtitle: restaurantFoodTitle,
                      status: status,
                      reviews: reviews,
                      // ratinglength: totalRating,
                      activestatus: activeStatus,
                      // fulladdress: fullAddress,
                    );
                  },
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}


class DishResCard extends StatelessWidget {
  dynamic activestatus;
  dynamic destlat;
  dynamic item;
  // dynamic destlong;
  dynamic rating;
  bool status;
  dynamic searchvalue;
  // String fulladdress;
  dynamic menulength;
  // FavoriteRestaurant favrestaurant;
  // final List favourListDetails;
  // final List<dynamic>? restaurantfoodtitle;
  dynamic reviews;
  // final List<dynamic>? additionalImages;
  
    // You may want to pass these as params or keep them inside if you want singleton controllers
  final Foodsearchcontroller createrecentsearch = Get.find<Foodsearchcontroller>();
  final Nearbyrescontroller nearbyreget = Get.find<Nearbyrescontroller>();
  final RedirectController redirect = Get.find<RedirectController>();
  DishResCard({
    super.key,
    required this.status,
    required this.activestatus,
    this.item,
    required this.rating,
    required this.reviews,
    // required this.favrestaurant,
    // required this.destlat,
    required this.searchvalue,
    // required this.destlong,
    // required this.additionalImages,
    // required this.fulladdress, 
    // required this.restaurantfoodtitle, 
    // required this.favourListDetails,
  });

  @override
  Widget build(BuildContext context) {
  

        final favrestaurant = FavoriteRestaurant(
                      id: item["_id"].toString(),
                      name: item["name"].toString(),
                      city: item["address"]["city"].toString(),
                      region: item["address"]["region"].toString(),
                      imageUrl: "$globalImageUrlLink${item["imgUrl"]}",
                      rating: item["rating"].toString(),
                    );
    // if (status == false) {
    //   return const SizedBox.shrink();
    // }

    double parsedRating = rating.toString() == 'null'
        ? 0
        : double.tryParse(rating.toString())?.roundToDouble() ?? 0;

    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    if (activestatus != "online") {
      return GestureDetector(
        onTap: () {
          AppUtils.showToast('The Restaurant is Currently Closed');
        },
        child: _buildRestaurantCard(
          context,
          parsedRating,
          favrestaurant,
          favoritesProvider,
          isGreyedOut: true,
        ),
      );
    }

    return InkWell(
      onTap: () {
        Get.to(
          Foodviewscreen(
            searchvalue: searchvalue,
            isFromDishScreeen: true,
            // additionalImages: additionalImages,
            totalDis: 5,
            restaurantId: item["_id"],
            // restaurantcity: favrestaurant.city,
            // restaurantname: favrestaurant.name,
            // restaurantimg: favrestaurant.imageUrl,
            // restaurantregion: favrestaurant.region,
            // restaurantfoodtitle: restaurantfoodtitle,
            // restaurantreview: favrestaurant.rating,
            // restaurant: favrestaurant,
            // reviews: ratinglength.length,
            // fulladdress: fulladdress,
          ),
          transition: Transition.zoom,
          curve: Curves.easeIn,
        );
      },
      child: _buildRestaurantCard(
        context,
        parsedRating,
        favrestaurant,
        favoritesProvider,
        isGreyedOut: false,
      ),
    );
  }

  Widget _buildRestaurantCard(
    BuildContext context,
    double rating,
    dynamic favrestaurant,
    FavoritesProvider favoritesProvider,
     {
    required bool isGreyedOut,
  }) {
  
        dynamic offerPercentage = item.containsKey('servicesType')? item["servicesType"]["offerPercentage"]  : "";
       return  Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: Customcolors.DECORATION_WHITE,
          gradient: isGreyedOut
              ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black87, Colors.grey, Colors.white],
                )
              : null,
          boxShadow: const [
            BoxShadow(
              color: Customcolors.DECORATION_LIGHTGREY,
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              child: isGreyedOut
                  ? ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Colors.grey,
                        BlendMode.saturation,
                      ),
                      child: CachedNetworkImage(
                        placeholder: (context, url) =>
                            Image.asset(fastxdummyImg),
                        errorWidget: (context, url, error) =>
                            Image.asset(fastxdummyImg),
                        height: 100.h,
                        width: MediaQuery.of(context).size.width,
                        imageUrl: "$globalImageUrlLink${item["imgUrl"]}",
                        fit: BoxFit.cover,
                      ),
                    )
                  : CachedNetworkImage(
                      placeholder: (context, url) =>
                          Image.asset(fastxdummyImg),
                      errorWidget: (context, url, error) =>
                          Image.asset(fastxdummyImg),
                      height: 100.h,
                      width: MediaQuery.of(context).size.width,
                      imageUrl: "$globalImageUrlLink${item["imgUrl"]}",
                      fit: BoxFit.cover,
                    ),
            ),
            const CustomSizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  // Title + Favorite
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.3.w,
                        child: Text(
                          " ${item["name"].toString().capitalizeFirst}",
                          overflow: TextOverflow.clip,
                          style: CustomTextStyle.googlebuttontext,
                        ),
                      ),

                      
                     FavoriteIcon(
  isFavorite: favoritesProvider.isFavorite(item["_id"]),
  onTap: () {
    if (UserId == null) {
     showDialog(
  context: context,
  builder: (_) => LoginRequiredDialog(
    title: "Login Required",
    content: "Please login to add or remove this favorite item.",
    cancelText: "Later",
    confirmText: "Log In",
    onConfirm: () {
      // Navigate or perform any action
      Get.offAll(() => const Loginscreen());
    },
  ),
);
      return; // 🛑 Prevent further execution
    }

    // ✅ If UserId is not null, proceed with favorite logic
    if (favoritesProvider.isFavorite(item["_id"])) {
      favoritesProvider.removeFavorite(item["_id"]);
      nearbyreget.updateFavouriteFun(
        productCategoryId: productCateId,
        userId: UserId,
        productId: item["_id"],
      );
    } else {
      favoritesProvider.addFavorite(favrestaurant);
      nearbyreget.addfavouritesApi(
        productCategoryId: productCateId,
        userId: UserId,
        productId: item["_id"],
      );
    }
  },
)
                      
                    ],
                  ),
                  const CustomSizedBox(height: 5),
                  // Location
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 20,
                        color: Customcolors.DECORATION_BLACK,
                      ),
                      Text(
                        " ${favrestaurant.city.toString().capitalizeFirst},  ${favrestaurant.region.toString().capitalizeFirst}",
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyle.boldgrey,
                      ),
                    ],
                  ),
                  const CustomSizedBox(height: 5),
                  // Rating
                  Row(
                    children: [
                      rating != 0
                          ? const Icon(Icons.star, size: 20, color: Colors.amber)
                          : const SizedBox.shrink(),
                      rating != 0
                          ? Text(" $rating",
                              overflow: TextOverflow.ellipsis,
                              style: CustomTextStyle.blacktext)
                          : const SizedBox.shrink(),
                      reviews==0||reviews==null
                          ? const SizedBox.shrink()
                          : Text(
                              " (${reviews} reviews)",
                              overflow: TextOverflow.ellipsis,
                              style: CustomTextStyle.boldgrey,
                            ),
                    ],
                  ),
                  const Divider(),
                  // Offers
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      Row(
                        children: [
                          const Image(
                            image: AssetImage("assets/images/discount.png"),
                            height: 15,
                            width: 20,
                          ),
                          (offerPercentage != null && offerPercentage.toString().isNotEmpty&& offerPercentage != 0)? 
                           Text("Enjoy up to ${offerPercentage}% off your meal",
                                style: CustomTextStyle.darkgrey,
                              ):
                          Obx(() {
                            if (redirect.isredirectLoading.isTrue) {
                              return const Center(
                                  child: CupertinoActivityIndicator());
                            } else if (redirect.redirectLoadingDetails == null ||
                                redirect.redirectLoadingDetails["data"] == null) {
                              return const Text(
                                'No deals right now, but stay tuned!',
                                style: CustomTextStyle.darkgrey,
                              );
                            } else {
                              for (var item in redirect
                                  .redirectLoadingDetails["data"]) {
                                if (item["key"] == "offerValue") {
                                  return Text(
                                    "Enjoy up to ${item["value"]}% off your meal",
                                    style: CustomTextStyle.darkgrey,
                                  );
                                }
                              }
                              return const Text(
                                'No deals right now, but stay tuned!',
                                style: CustomTextStyle.darkgrey,
                              );
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
      );
    } 
  }
// }
