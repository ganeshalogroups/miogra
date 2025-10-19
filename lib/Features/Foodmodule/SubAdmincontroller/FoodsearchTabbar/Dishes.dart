// ignore_for_file: avoid_print, file_names, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, must_be_immutable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Addfoodcontroller.dart';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Foodsearchlistgetcontroller.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/FoodsearchTabbar/DishesSub.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodviewfirstscreen.dart';
import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Redirectcontroller.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Shimmers/Nearestrestaurantshimmer.dart';
import 'package:testing/utils/Shimmers/Searchlistloader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Dishes extends StatelessWidget {
  String? searchvalue;
  Dishes({this.searchvalue, super.key});
  Foodsearchcontroller createrecentsearch = Get.find<Foodsearchcontroller>();
  RedirectController redirect = Get.find<RedirectController>();
  final Foodcartcontroller foodcart = Get.find<Foodcartcontroller>();
//  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomSizedBox(
              height: 10,
            ),
            Text(
                "Search results for ${searchvalue.toString() == 'null' ? 'Biryani' : searchvalue.toString().capitalizeFirst.toString()}",
                overflow: TextOverflow.ellipsis,
                style: CustomTextStyle.darkgrey),
            const CustomSizedBox(
              height: 10,
            ),
            Obx(() {
              if (createrecentsearch.dishessearchlistloading.isTrue) {
                return const Center(
                  child: Nearestresshimmer(),
                );
              } else if (createrecentsearch.dishessearchlist == null) {
                return const Column(
                  //  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Serchlistloading(),
                    Text(
                      "No more dishes Available!",
                      style: CustomTextStyle.darkgrey,
                    )
                  ],
                );
              } else if (createrecentsearch
                  .dishessearchlist!["data"]["dishDetails"].isEmpty) {
                return Column(
                  //  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Serchlistloading(),
                    Text(
                      "No more dishes in ${searchvalue.toString().capitalizeFirst.toString()}!",
                      style: CustomTextStyle.darkgrey,
                    )
                  ],
                );
              } else {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: createrecentsearch
                        .dishessearchlist!["data"]["dishDetails"].length,
                    itemBuilder: (context, index) {
                      var restaurant =
                          createrecentsearch.dishessearchlist!["data"]
                              ["dishDetails"][index]["document"];
                      // bool isActive = restaurant["status"] == true;
                      String activeStatus =
                          restaurant["restaurantActiveStatus"] ?? "";

                      // if (!isActive) {
                      //   // status is false: skip showing this restaurant completely
                      //   return SizedBox.shrink();
                      // }
                      if (activeStatus == "offline") {
                        // Show greyed out restaurant
                        return _buildGreyedOutRestaurantItem(
                            restaurant, index, context);
                      } else if (activeStatus == "online") {
                        // Show normal restaurant UI
                        return _buildNormalRestaurantItem(
                            restaurant, index, context);
                      } else {
                        // If activeStatus is something else, skip or handle here
                        return const SizedBox.shrink();
                      }
                    });
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildGreyedOutRestaurantItem(dynamic restaurant, int index, context) {
    // double rating = restaurant["ratingAverage"].toString() == 'null'
    //     ? 0
    //     : double.tryParse(restaurant["ratingAverage"].toString())?.roundToDouble() ?? 0;

    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Customcolors.DECORATION_CONTAINERGREY,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.grey,
            Color.fromARGB(66, 0, 0, 0),
          ],
        ),
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
            const CustomSizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.3.w,
                        child: Text(
                          restaurant["foodRestaurantName"]
                              .toString()
                              .capitalizeFirst
                              .toString(),
                          overflow: TextOverflow.clip,
                          style: CustomTextStyle.googlebuttontext,
                        ),
                      ),
                    ],
                  ),
                  const CustomSizedBox(height: 10),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Color.fromARGB(255, 240, 240, 240),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Color.fromARGB(199, 212, 211, 211),
                    Color.fromARGB(79, 255, 255, 255),
                  ],
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                          Colors.grey,
                          BlendMode.saturation,
                        ),
                        child: CachedNetworkImage(
                          placeholder: (context, url) => Image.asset(
                            "$fastxdummyImg",
                            fit: BoxFit.fill,
                            height: 10,
                            width: 10,
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            "$fastxdummyImg",
                            fit: BoxFit.fill,
                            height: 10,
                            width: 10,
                          ),
                          height: 110,
                          width: 100,
                          imageUrl:
                              "$globalImageUrlLink${restaurant["foodImgUrl"].toString()}",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(height: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    restaurant["foodName"]
                                        .toString()
                                        .capitalizeFirst
                                        .toString(),
                                    style: CustomTextStyle.googlebuttontext,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Image(
                                  image: restaurant["foodType"] == "nonveg"
                                      ? const AssetImage(
                                          "assets/images/Non veg.png")
                                      : const AssetImage(
                                          "assets/images/veg.png"),
                                  height: 18,
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                            const SizedBox(height: 5),
                            (restaurant["foodDiscription"] == null ||
                                    restaurant["foodDiscription"]
                                        .toString()
                                        .trim()
                                        .isEmpty)
                                ? const SizedBox.shrink()
                                : Text(
                                    "${restaurant["foodDiscription"].toString().capitalizeFirst.toString()}",
                                    style: CustomTextStyle.boldgrey,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "₹ ${restaurant["food"]["customerPrice"]}.00",
                              style: CustomTextStyle.googlebuttontext,
                            ),
                          ],
                        ),
                        const CustomSizedBox(height: 5),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildNormalRestaurantItem(dynamic restaurant, int index, context) {
    // double rating = restaurant["ratingAverage"].toString() == 'null'
    //     ? 0
    //     : double.tryParse(restaurant["ratingAverage"].toString())?.roundToDouble() ?? 0;

    // List<dynamic> additionalImages = restaurant["additionalImage"] ?? [];
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
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
            const CustomSizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.3.w,
                        child: Text(
                          restaurant["foodRestaurantName"]
                              .toString()
                              .capitalizeFirst
                              .toString(),
                          overflow: TextOverflow.clip,
                          style: CustomTextStyle.googlebuttontext,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // final restaurantfav = FavoriteRestaurant(
                          //   id: restaurant["_id"],
                          //   name: restaurant["name"].toString(),
                          //   city: restaurant["address"]["city"].toString(),
                          //   region: restaurant["address"]["region"].toString(),
                          //   imageUrl: "$globalImageUrlLink${restaurant["imgUrl"]}",
                          //   rating: restaurant["ratingAverage"].toString(),
                          // );

                          Get.to(
                            Foodviewscreen(
                              isFromDishScreeen: true,
                              // additionalImages: additionalImages,
                              totalDis: '5',
                              // reviews: restaurant["ratings"].length,
                              restaurantId: restaurant["restaurantId"],
                              // restaurantcity: restaurant["address"]["city"],
                              // restaurantname: restaurant["name"],
                              // restaurantimg: "$globalImageUrlLink${restaurant["imgUrl"]}",
                              // restaurantregion: restaurant["address"]["region"],
                              // restaurantfoodtitle: restaurant["cusineList"],
                              // restaurantreview: restaurant["ratingAverage"],
                              // restaurant: restaurantfav,
                              // fulladdress: restaurant["address"]["fullAddress"],
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 20,
                          color: Customcolors.DECORATION_BLACK,
                        ),
                      ),
                    ],
                  ),
                  const CustomSizedBox(height: 10),
                  const Divider(),
                ],
              ),
            ),
            Dishessubclass(
              availablenow: createrecentsearch.dishessearchlist!["data"]
                  ["dishDetails"][index],
              foods: restaurant,
              index: index,
              // current: _current,
              // additionalImages: additionalImages,
              // index2: catIndex,
              isTabScreen: true,
            )
          ],
        ),
      ),
    );
  }
}
