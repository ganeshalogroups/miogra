// ignore_for_file: must_be_immutable, file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:testing/Meat/Common/MeatFavouriteIcon.dart';
import 'package:testing/Meat/MeatData/Meatfavprovider.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatOrderController/MeatFavouritecontroller.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Toast/customtoastmessage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class Inactiveshopmeatlistcard extends StatefulWidget {
dynamic shopname;
  dynamic shopid;
  dynamic shopcity;
  dynamic shopregion;
  dynamic activestatus;
  dynamic imageUrl;
  dynamic latitude;
  dynamic longitude;
  double rating;
  bool status;
  dynamic searchvalue;
  String fulladdress;
  final List meatfavourListDetails;
  dynamic shop;
  MeatFavoritesProvider meatfavoritesProvider;
  dynamic ratinglength;
  Inactiveshopmeatlistcard({super.key,
   required this.shopname,
    required this.shopid,
    required this.shop,
    required this.meatfavoritesProvider,
    required this.fulladdress,
    required this.imageUrl,
    required this.activestatus,
    required this.meatfavourListDetails,
    required this.rating,
    required this.status,
    required this.shopregion,
    required this.latitude,
    required this.searchvalue,
    required this.longitude,
    required this.ratinglength,
    required this.shopcity});

  @override
  State<Inactiveshopmeatlistcard> createState() => _InactiveshopmeatlistcardState();
}

class _InactiveshopmeatlistcardState extends State<Inactiveshopmeatlistcard> {
MeatFavgetcontroller favshop =Get.put(MeatFavgetcontroller());
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      AppUtils.showToast('The Shop is Currently Closed');
           },
  child: AnimationConfiguration.staggeredList(
    position: 0,
    duration: const Duration(milliseconds: 750),
    child: SlideAnimation(
      verticalOffset: 50.0,
      child: FadeInAnimation(
        child: Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Customcolors.DECORATION_WHITE,
             gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black87,
                      Colors.grey,
                      Colors.white,
                    ]),
            boxShadow: [
              BoxShadow(
                color: Customcolors.DECORATION_LIGHTGREY, //color of shadow
                spreadRadius: 5, //spread radius
                blurRadius: 7, // blur radius
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: ColorFiltered(
                colorFilter: const ColorFilter.mode(
                 Colors.grey,
                  BlendMode.saturation,
                  ),
                  child: CachedNetworkImage(
                    placeholder: (context, url) => Image.asset(
                      meatdummy,
                    ),
                    errorWidget: (context, url, error) =>
                        Image.asset(meatdummy),
                    height: 100.h,
                    width: MediaQuery.of(context).size.width,
                    imageUrl: widget.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const CustomSizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.3.w,
                          child: Text(
                            " ${widget.shopname.toString().capitalizeFirst}",
                            overflow: TextOverflow.clip,
                            style: CustomTextStyle.googlebuttontext,
                          ),
                        ),
                        MeatFavoriteIcon(
                              isFavorite: widget.meatfavoritesProvider.isFavorite(widget.shopid),
                              onTap: () {
                                if (widget.meatfavoritesProvider.isFavorite(widget.shopid)) {
                                  widget.meatfavoritesProvider.removeFavorite(widget.shopid);
                                  favshop.meatupdateFavouriteFun(
                                    userId: UserId,
                                    productId: widget.shopid,
                                  );
                                } else {
                                  widget.meatfavoritesProvider.addFavorite(widget.shop);
                                  favshop.meataddfavouritesApi(
                                    userId: UserId,
                                    productId: widget.shopid,
                                  );
                                }
                              },
                            ),
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
                          " ${widget.shopcity.toString().capitalizeFirst.toString()},  ${widget.shopregion.toString().capitalizeFirst.toString()}",
                          overflow: TextOverflow.ellipsis,
                          style: CustomTextStyle.boldgrey,
                        ),
                      ],
                    ),
                    const CustomSizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 20,
                          color: Colors.amber,
                        ),
                        Text(
                          " ${widget.rating.toString()}",
                          overflow: TextOverflow.ellipsis,
                          style: CustomTextStyle.blacktext,
                        ),
                        widget.ratinglength.isEmpty
                            ? const Text(
                                " (0 reviews)",
                                style: CustomTextStyle.boldgrey,
                                overflow: TextOverflow.ellipsis,
                              )
                            : Text(
                                "( ${widget.ratinglength.length} reviews)",
                                overflow: TextOverflow.ellipsis,
                                style: CustomTextStyle.boldgrey,
                              ),
                      ],
                    ),
                    const Divider(),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [],
                        ),
                        Row(
                          children: [
                            Image(
                              image: AssetImage("assets/images/discount.png"),
                              height: 15,
                              width: 20,
                            ),
                            Center(
                              child: Text(
                                'No deals right now, but stay tuned!',
                                style: CustomTextStyle.darkgrey,
                              ),
                            ),
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
    ),
  ),
);

  }
}