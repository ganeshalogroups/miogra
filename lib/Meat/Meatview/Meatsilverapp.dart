// ignore_for_file: file_names, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:testing/Meat/Homepage/Meathomepage.dart';
import 'package:testing/Meat/MeatButtonFunctionalities/TotalitemcountButton.dart';
import 'package:testing/Meat/Common/MeatFavouriteIcon.dart';
import 'package:testing/Meat/MeatController.dart/Meatsearchcontroller.dart';
import 'package:testing/Meat/MeatData/Meatfavprovider.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatOrderController/MeatFavouritecontroller.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Meatsilverappwidget extends StatefulWidget {
  dynamic shopname;
  dynamic rating;
  dynamic city;
  dynamic region;
  dynamic imgurl;
  dynamic shop;
  dynamic shopid;
  bool isFrommeatscreen;
  Meatsilverappwidget(
      {required this.shopname,
      this.isFrommeatscreen = false,
      required this.rating,
      required this.city,
      required this.region,
      required this.imgurl,
      required this.shop,
      required this.shopid,
      super.key});

  @override
  State<Meatsilverappwidget> createState() => _MeatsilverappwidgetState();
}

class _MeatsilverappwidgetState extends State<Meatsilverappwidget> {
 Meatsearchcontroller meatlistsearch = Get.put(Meatsearchcontroller());
  @override
  Widget build(BuildContext context) {
  MeatFavgetcontroller favshop =Get.put(MeatFavgetcontroller());
   final meatfavoritesProvider = Provider.of<MeatFavoritesProvider>(context);

    return SliverAppBar(
      backgroundColor: Customcolors.DECORATION_CONTAINERGREY,
      expandedHeight: MediaQuery.of(context).size.height / 2.5,
      toolbarHeight: 0,
      pinned: false,
      floating: false, // Ensure it doesn't float on scroll
      snap: false, // Ensure it doesn't snap back when scrolling stops
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 2,
        collapseMode: CollapseMode.pin,
        background: Stack(
          children: [
            // Big blue container
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: CachedNetworkImage(
                useOldImageOnUrlChange: true,
                imageUrl: widget.imgurl.toString(),
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                placeholder: (context, url) =>
                    Image.asset(meatdummy),
                errorWidget: (context, url, error) =>
                    Image.asset(meatdummy),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 20.h, // Adjust this value to move the container down
              left: MediaQuery.of(context).size.width * 0.05, // Center the container horizontally
              child: Container(
                decoration: BoxDecoration(
                  color: Customcolors.DECORATION_WHITE,
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 182, 182, 182).withOpacity(0.2),
                      offset: const Offset(0, 4),
                      blurRadius: 6,
                      spreadRadius: 0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 80.0, // Height of the white container
                width: MediaQuery.of(context).size.width * 0.9, // Adjust the width to 90% of the screen
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            " ${widget.shopname.toString().capitalizeFirst}",
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyle.meatshopblacktext,
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
                                style: CustomTextStyle.blackbold14,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const CustomSizedBox(height: 5),
                      Row(crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 15,
                            color: Customcolors.DECORATION_GREY,
                          ),
                          SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              " ${widget.city.toString().capitalizeFirst}, ${widget.region.toString().capitalizeFirst}",
                              overflow: TextOverflow.clip,
                              style: CustomTextStyle.boldgrey,
                            ),
                          ),
                          const CustomSizedBox(height: 10),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
            top: 20,
            right: 10, // Position the heart icon at the right side
            child:MeatFavoriteIcon(
            isFavorite: meatfavoritesProvider.isFavorite(widget.shopid),
            onTap: () {
            if (meatfavoritesProvider.isFavorite(widget.shopid)) {
              meatfavoritesProvider.removeFavorite(widget.shopid);
              favshop.meatupdateFavouriteFun(
              userId: UserId,
              productId: widget.shopid,
              );
              } else {
              meatfavoritesProvider.addFavorite(widget.shop);
              favshop.meataddfavouritesApi(
              userId: UserId,
              productId: widget.shopid,
              );
              }
               },
             ),),
            Positioned(
              top: 20,
              left: 8,
              child: IconButton(
                style: const ButtonStyle(
                  backgroundColor:MaterialStatePropertyAll(Customcolors.pureWhite),
                ),
                onPressed: () {
                 Provider.of<MeatButtonController>(context, listen: false).hidemeatButton();
                 if (widget.isFrommeatscreen) {
                 Get.back();
                 meatlistsearch.meatlistloading.value = true;
                 Future.delayed(const Duration(seconds: 1), () async {
                 meatlistsearch.meatlistloading.value = false;
                 });
                 } else {
                  Navigator.pushReplacement(
                 context,MaterialPageRoute(builder: (context) => Meathomepage(meatproductcategoryid: meatproductCateId,)),);      
                 }

                },
                icon: const Icon(Icons.arrow_back),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
