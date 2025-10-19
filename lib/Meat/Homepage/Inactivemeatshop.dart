// ignore_for_file: must_be_immutable, file_names

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:testing/Meat/Common/MeatFavouriteIcon.dart';
import 'package:testing/Meat/MeatData/Meatfavprovider.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatOrderController/MeatFavouritecontroller.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Inactivemeatlist extends StatefulWidget {
  dynamic shopget;
  dynamic rating;
  dynamic shop;
  MeatFavoritesProvider meatfavoritesProvider;
  Inactivemeatlist({
    required this.shop,
    required this.meatfavoritesProvider,
    required this.shopget,
    required this.rating,
    super.key,
  });

  @override
  State<Inactivemeatlist> createState() => InactivemeatlistState();
}

int _current = 0;

class InactivemeatlistState extends State<Inactivemeatlist> {
MeatFavgetcontroller favshop =Get.put(MeatFavgetcontroller());
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black87, Colors.grey, Colors.white],
        ),
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
                        child: ColorFiltered(
                          colorFilter: const ColorFilter.mode(
                            Colors.grey,
                            BlendMode.saturation,
                          ),
                          child: CachedNetworkImage(
                            useOldImageOnUrlChange: true,
                            imageUrl: widget.shopget["imgUrl"].toString(),
                            placeholder: (context, url) =>
                                Image.asset(meatdummy),
                            errorWidget: (context, url, error) =>
                                Image.asset(meatdummy),
                            fit: BoxFit.fitWidth,
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          CarouselSlider(
                            items: widget.shopget["additionalImage"]
                                .map((imageUrl) => ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: ColorFiltered(
                                        colorFilter: const ColorFilter.mode(
                                          Colors.grey,
                                          BlendMode.saturation,
                                        ),
                                        child: CachedNetworkImage(
                                          useOldImageOnUrlChange: true,
                                          imageUrl: imageUrl.toString(),
                                          placeholder: (context, url) =>
                                              Image.asset(meatdummy),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(meatdummy),
                                          fit: BoxFit.fitWidth,
                                          height: 150,
                                          width: MediaQuery.of(context)
                                              .size
                                              .width,
                                        ),
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
                if (widget.shopget["subAdminInfo"] == "halal")
                  Positioned(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 8,
                      ),
                      decoration: CustomContainerDecoration.halaldecoration(),
                      child: Image.asset(
                        "assets/images/100% HALAL.png",
                        width: 50.w,
                      ),
                    ),
                  ),
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
                      filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 2,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    " ${widget.shopget["name"].toString().capitalizeFirst}",
                                    overflow: TextOverflow.ellipsis,
                                    style: CustomTextStyle.meatshoptext,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.amber,
                                      ),
                                      Text(
                                        " ${widget.rating}",
                                        overflow: TextOverflow.ellipsis,
                                        style:
                                            CustomTextStyle.meatlocationtext,
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
                                    color: Customcolors.DECORATION_WHITE,
                                  ),
                                  Text(
                                    " ${widget.shopget["address"]["city"].toString().capitalizeFirst}, ${widget.shopget["address"]["region"].toString().capitalizeFirst}",
                                    overflow: TextOverflow.ellipsis,
                                    style: CustomTextStyle.meatlocationtext,
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
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Row(
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
          ),
        ],
      ),
    );
  }
}
