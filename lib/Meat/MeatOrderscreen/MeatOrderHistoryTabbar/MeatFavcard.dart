// ignore_for_file: unnecessary_string_interpolations, must_be_immutable, file_names

import 'dart:async';

import 'package:dotted_line/dotted_line.dart';
import 'package:testing/Meat/Common/MeatFavouriteIcon.dart';
import 'package:testing/Meat/MeatData/Meatfavprovider.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatOrderController/MeatFavouritecontroller.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatOrderHistoryTabbar/InactiveMeatFavcard.dart';
import 'package:testing/Meat/Meatview/Meatproductview.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Toast/customtoastmessage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Meatfavcard extends StatefulWidget {
MeatFavoritesProvider meatfavoritesProvider;
dynamic data;
 Meatfavcard({
 required this.meatfavoritesProvider,
  required this.data,
  super.key});

  @override
  State<Meatfavcard> createState() => _MeatfavcardState();
}

class _MeatfavcardState extends State<Meatfavcard> {
 MeatFavgetcontroller favshop =Get.put(MeatFavgetcontroller());
  void _loadData() {
    Provider.of<MeatFavouritegetPagination>(context, listen: false).clearData()
        .then((_) {
      Provider.of<MeatFavouritegetPagination>(context, listen: false)
          .meatfavget();
    });
  }
  @override
  Widget build(BuildContext context) {
   double rating = widget.data["shopDetails"]["ratingAverage"].toString() == 'null' ? 0   : double.tryParse(widget.data["shopDetails"]["ratingAverage"].toString())?.roundToDouble() ?? 0;
    
    
  return widget.data["shopDetails"]["status"]==true&&widget.data["shopDetails"]["activeStatus"]=="online"? GestureDetector(
  onTap: () {
   Get.to( Meatproductviewscreen(shopname: widget.data["shopDetails"]["name"].toString(), shopid: widget.data["shopDetails"]["_id"], imgurl:widget.data["shopDetails"]["imgUrl"], rating: rating, totalDis: 5, city: widget.data["shopDetails"]["address"]["city"], region: widget.data["shopDetails"]["address"]["region"], fulladdress: widget.data["shopDetails"]["address"]["fullAddress"]));
  },
    child: Container(
    margin: const EdgeInsets.only(top: 10, bottom: 10,right: 5,left: 5),
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
                      width: MediaQuery.of(context).size.width / 1.9,
                      child: Text(
                        "${widget.data["shopDetails"]["name"].toString().capitalizeFirst.toString()}",
                        style: CustomTextStyle.googlebuttontext,
                      ),
                    ),
                    MeatFavoriteIcon(
                                isFavorite: widget.meatfavoritesProvider.isFavorite(widget.data["shopDetails"]["_id"]),
                                onTap: () {
                                  Timer(const Duration(milliseconds: 500), () { 
        widget.meatfavoritesProvider.removeFavorite(widget.data["shopDetails"]["_id"]);
        favshop.meatupdateFavouriteFun(
          userId: UserId,
          productId: widget.data["shopDetails"]["_id"],
        );
      _loadData();
    });
    
    }
                              ),
                  ],
                ),
                const CustomSizedBox(height: 10),
                Row(
                  children:  [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 20,
                      color: Customcolors.DECORATION_BLACK,
                    ),
                    Text(
                      "${widget.data["shopDetails"]["address"]["city"].toString().capitalizeFirst.toString()}, ${widget.data["shopDetails"]["address"]["region"].toString().capitalizeFirst.toString()}",
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyle.boldgrey,
                    ),
                  ],
                ),
                const CustomSizedBox(height: 5),
                Row(
                  children:  [
                    const Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.amber,
                    ),
                    Text(rating.toString(), style: CustomTextStyle.blacktext),
                    Text(
                      " (${widget.data["shopDetails"]['ratings'].length} reviews)",
                      style: CustomTextStyle.boldgrey,
                    ),
                  ],
                ),
                const CustomSizedBox(height: 5),
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
                      dashGapColor: Colors.white,
                      dashGapRadius: 5,
                    ),
                  ),
                ),
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
  ):GestureDetector(
  onTap: () {
     AppUtils.showToast('The Shop is Currently Closed');
  },
  child: InactivemeatFavcard(meatfavoritesProvider: widget.meatfavoritesProvider, data: widget.data));

  }
}