// ignore_for_file: file_names, must_be_immutable
import 'dart:convert';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:testing/Meat/Homepage/Inactivemeatshop.dart';
import 'package:testing/Meat/Common/MeatFavouriteIcon.dart';
import 'package:testing/Meat/MeatData/Meatfavprovider.dart';
import 'package:testing/Meat/MeatDomain/Meatfavmodel.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatOrderController/MeatFavouritecontroller.dart';
import 'package:testing/Meat/Meatview/Meatproductview.dart';
import 'package:testing/map_provider/Map%20Screens/MapSearch.dart/apiKey.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Toast/customtoastmessage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Meatshops extends StatefulWidget {
  MeatFavoriteShop shop;
  final dynamic shopget;
  final double latitude;
  final double langitude;
  MeatFavoritesProvider meatfavoritesProvider;

   Meatshops({
    required this.shopget,
    required this.shop,
    required this.meatfavoritesProvider,
    required this.latitude,
    required this.langitude,
    super.key,
  });

  @override
  State<Meatshops> createState() => MeatshopsState();
}

class MeatshopsState extends State<Meatshops> {
MeatFavgetcontroller favshop =Get.put(MeatFavgetcontroller());
  String totalDis = '';
  String totalDur = '';
  int _current = 0;

  @override
  void initState() {
    getDistance(
      destLat: widget.latitude,
      destLng: widget.langitude,
    );
    super.initState();
  }

  Future<void> getDistance({
    required double destLat,
    required double destLng,
  }) async {
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
      debugPrint('check....Api Routs Are Empty');
    }
  }

  @override
  Widget build(BuildContext context) {
    double rating = widget.shopget["ratingAverage"].toString() == 'null'
        ? 0
        : double.tryParse(widget.shopget["ratingAverage"].toString())
                ?.roundToDouble() ??
            0;
            

    return widget.shopget['status'] == true &&
            widget.shopget['activeStatus'] == "online"
        ? InkWell(
            onTap: () {
            List<dynamic> meatfavourListDetails = widget.shopget["favourListDetails"] ?? [];
              Get.to(Meatproductviewscreen(
                shopid: widget.shopget["_id"],
                shopname: widget.shopget["name"],
                rating: rating,
                region: widget.shopget["address"]["region"],
                city: widget.shopget["address"]["city"],
                imgurl: widget.shopget["imgUrl"], fulladdress: widget.shopget["address"]["fullAddress"],
                meatfavourListDetails: meatfavourListDetails,
                shop: widget.shop, totalDis: 5,
              ));
            },
            child: Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Customcolors.DECORATION_WHITE,
                boxShadow: [
                  BoxShadow(
                    color: Customcolors.DECORATION_LIGHTGREY,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 2),
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        widget.shopget["additionalImage"].isEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  useOldImageOnUrlChange: true,
                                  imageUrl: widget.shopget["imgUrl"].toString(),
                                  placeholder: (context, url) => Image.asset(meatdummy),
                                  errorWidget: (context, url, error) =>Image.asset(meatdummy),
                                  fit: BoxFit.fitWidth,
                                  height: 150,
                                  width: MediaQuery.of(context).size.width,
                                ),
                              )
                            : Column(
                                children: [
                                  CarouselSlider(
                                    items: widget.shopget["additionalImage"]
                                        .map((imageUrl) => ClipRRect(
                                              borderRadius: BorderRadius.circular(15),
                                              child: CachedNetworkImage(
                                                useOldImageOnUrlChange: true,
                                                imageUrl: imageUrl.toString(),
                                                placeholder: (context, url) =>
                                                    Image.asset(meatdummy),
                                                errorWidget: (context, url,error) =>
                                                    Image.asset(meatdummy),
                                                fit: BoxFit.fitWidth,
                                                height: 150,
                                                width: MediaQuery.of(context).size.width,
                                              ),
                                            ))
                                        .toList(),
                                    options: CarouselOptions(
                                      height: 150,
                                      viewportFraction: 1.0,
                                      enableInfiniteScroll: true,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          _current = index;
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  AnimatedSmoothIndicator(
                                    activeIndex: _current,
                                    count: widget.shopget["additionalImage"].length,
                                    effect: const ScrollingDotsEffect(
                                      activeDotColor: Colors.black,
                                      dotColor: Colors.grey,
                                      dotHeight: 8,
                                      dotWidth: 8,
                                    ),
                                  ),
                                ],
                              ),
                        widget.shopget["subAdminInfo"] == "halal"
                            ? Positioned(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 8),
                                  decoration: CustomContainerDecoration
                                      .halaldecoration(),
                                  child: Image.asset(
                                    "assets/images/100% HALAL.png",
                                    width: 50.w,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                          Positioned(
                          top: 8,
                          right: 8,
                          child: MeatFavoriteIcon(
                              isFavorite: widget.meatfavoritesProvider.isFavorite(widget.shopget["_id"]),
                              onTap: () {
                                if (widget.meatfavoritesProvider.isFavorite(widget.shopget["_id"])) {
                                  widget.meatfavoritesProvider.removeFavorite(widget.shopget["_id"]);
                                  favshop.meatupdateFavouriteFun(
                                    userId: UserId,
                                    productId: widget.shopget["_id"],
                                  );
                                } else {
                                  widget.meatfavoritesProvider.addFavorite(widget.shop);
                                  favshop.meataddfavouritesApi(
                                    userId: UserId,
                                    productId: widget.shopget["_id"],
                                  );
                                }
                              },
                            ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(15),
                              bottom: Radius.circular(15),
                            ),
                            child: BackdropFilter(
                              filter:ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 2),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            " ${widget.shopget["name"].toString().capitalizeFirst}",
                                            overflow: TextOverflow.ellipsis,
                                            style:CustomTextStyle.meatshoptext,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.star,
                                                size: 15,
                                                color: Colors.amber,
                                              ),
                                              Text(
                                                " $rating",
                                                overflow: TextOverflow.ellipsis,
                                                style: CustomTextStyle.meatlocationtext,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const CustomSizedBox(height: 5),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on_outlined,
                                            size: 15,
                                            color:
                                                Customcolors.DECORATION_WHITE,
                                          ),
                                          Text(
                                            " ${widget.shopget["address"]["city"].toString().capitalizeFirst.toString()}, ${widget.shopget["address"]["region"].toString().capitalizeFirst.toString()}",
                                            overflow: TextOverflow.ellipsis,
                                            style: CustomTextStyle
                                                .meatlocationtext,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Image(
                              image: AssetImage("assets/images/discount.png"),
                              height: 15,
                              width: 20,
                            ),
                            Text(
                              " 60% off up to ₹120.00",
                              style: CustomTextStyle.darkgrey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : GestureDetector(
            onTap: () {
              AppUtils.showToast('The Shop is Currently Closed');
            },
            child: Inactivemeatlist(
              shop:widget.shop,
              meatfavoritesProvider: widget.meatfavoritesProvider,
              shopget: widget.shopget,
              rating: rating,
            ),
          );
  }
}
