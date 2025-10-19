// ignore_for_file: must_be_immutable, file_names, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:testing/Features/Foodmodule/Domain/favouritemodel.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodviewfirstscreen.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Toast/customtoastmessage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';



class RestaurantItem extends StatefulWidget {
  dynamic resget;
  RestaurantItem({super.key, this.resget,});

  @override
  State<RestaurantItem> createState() => _RestaurantItemState();
}

class _RestaurantItemState extends State<RestaurantItem> {
  @override
  Widget build(BuildContext context) {
    // If the restaurant's status is false, return an empty widget (or do nothing)
    if (widget.resget['status'] == false) {
      return const SizedBox.shrink(); // or SizedBox.shrink() if you prefer to return a non-visible space
    }

    // Create restaurant object
    final restaurant = FavoriteRestaurant(
      id: widget.resget["document"]["_id"],
      name: widget.resget["document"]["name"].toString(),
      city: widget.resget["document"]["address"]["city"].toString(),
      region: widget.resget["document"]["address"]["region"].toString(),
      imageUrl: "${globalImageUrlLink}${widget.resget["document"]["imgUrl"].toString()}",
      rating: widget.resget["document"]["rating"].toString(),
    );

    List<dynamic> additionalImages = widget.resget["document"]["additionalImage"] ?? [];

    // If the restaurant is online and status is true, show it
    return widget.resget["document"]['status'] == true && widget.resget["document"]['activeStatus'] == "online"
      ? GestureDetector(
          onTap: () {
            // Navigate to Foodviewscreen when the restaurant is tapped
            Get.to(
              Foodviewscreen(
                // additionalImages: additionalImages,
                totalDis: 5,
                // favourListDetails: widget.resget["favourListDetails"] ?? [],
                // restaurant: restaurant,
                restaurantId: widget.resget["document"]["_id"],
                // restaurantcity: widget.resget["document"]["address"]["city"].toString(),
                // restaurantfoodtitle: widget.resget["document"]["cusineList"],
                // restaurantname: widget.resget["document"]["name"].toString(),
                // restaurantreview: widget.resget["document"]["rating"].toString(),
                // restaurantregion: widget.resget["document"]["address"]["region"].toString(),
                // restaurantimg:"${globalImageUrlLink}${widget.resget["document"]["imgUrl"].toString()}",
                // reviews: widget.resget["document"]["totalRatingCount"],
                // fulladdress: widget.resget["document"]["address"]["fullAddress"].toString(),
              ),
              transition: Transition.rightToLeft,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeIn,
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.09,
                child: CachedNetworkImage(
                  fadeInDuration: Duration.zero,
                  fadeOutDuration: Duration.zero,
                  imageUrl: "${globalImageUrlLink}${widget.resget["document"]["logoUrl"].toString()}",
                  memCacheHeight: 100,
                  memCacheWidth: 100,
                  useOldImageOnUrlChange: true,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fitHeight,
                        scale: 0.8,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => const CircleAvatar(
                    backgroundImage: AssetImage(fastxdummyImg),
                    backgroundColor: Colors.transparent,
                  ),
                  errorWidget: (context, url, error) => const CircleAvatar(
                    backgroundImage: const AssetImage(fastxdummyImg),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              SizedBox(
                width: 70.w,
                child: AutoSizeText(
                  textAlign: TextAlign.center,
                  (widget.resget["document"]["name"].toString().capitalizeFirst.toString().split(' ').first.toString()),
                  style: CustomTextStyle.addressfetch,
                  maxLines: 1,
                  wrapWords: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        )
      : GestureDetector(
          onTap: () {
            // Show a toast message when the restaurant is closed
            AppUtils.showToast('The Restaurant is Currently Closed');
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.09,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      Colors.grey,
                      BlendMode.saturation,
                    ),
                    child: CachedNetworkImage(
                      imageUrl:"${globalImageUrlLink}${widget.resget["document"]["logoUrl"].toString()}",
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        backgroundImage: imageProvider,
                        backgroundColor: Colors.white,
                      ),
                      placeholder: (context, url) => const CircleAvatar(
                        backgroundImage: AssetImage(fastxdummyImg),
                        backgroundColor: Colors.white,
                      ),
                      errorWidget: (context, url, error) => const CircleAvatar(
                        backgroundImage: AssetImage(fastxdummyImg),
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              SizedBox(
                width: 70.w,
                child: AutoSizeText(
                  textAlign: TextAlign.center,
                  (widget.resget["document"]["name"].toString().capitalizeFirst.toString().split(' ').first.toString()),
                  style: CustomTextStyle.addressfetch,
                  maxLines: 1,
                  wrapWords: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
  }
}
