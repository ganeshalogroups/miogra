// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:testing/Mart/Homepage/MartHomepageController/MartBannercontroller.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Shimmers/Restaurantshimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MiddleBanner extends StatefulWidget {
  const MiddleBanner({super.key});

  @override
  State<MiddleBanner> createState() => _MiddleBannerState();
}

class _MiddleBannerState extends State<MiddleBanner> {
  final MartBannerlistcontroller bannerlist = Get.put(MartBannerlistcontroller());

  @override
  void initState() {
    bannerlist.middlemartbannerget();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     return Obx(() {
      if (bannerlist.ismiddlebannerloading.isTrue) {
        return const Center(child: BannerShimmer());
      } else if (bannerlist.middlebanner == null || bannerlist.middlebanner["data"]["data"].isEmpty) {
        return const SizedBox();
       } else {
        int bannerCount = bannerlist.middlebanner["data"]["data"].length;

        return SizedBox(
          height: 105.h,
          child: Swiper(
            autoplay: true,
            itemCount: bannerCount,
            onTap: (index) {
              // bannerlist.getResturantsById(
              //   resturantId: bannerlist.banner["data"]["banner"]["data"][index]['navigateUserId'],
              // );
            },
            itemBuilder: (BuildContext context, int index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  placeholder: (context, url) => Image.asset(meatdummy),
                  errorWidget: (context, url, error) =>
                      Image.asset('assets/mart_images/MartBanner.png', fit: BoxFit.contain),
                  width: MediaQuery.of(context).size.width,
                  imageUrl: bannerlist.middlebanner["data"]["data"][index]["imageUrl"],
                  fit: BoxFit.fill,
                ),
              );
            },
            viewportFraction: bannerCount > 1 ? 0.9 : 1.0, // Full width for single banner
            scale: bannerCount > 1 ? 0.95 : 1.0,          // No scale for single banner
            loop: bannerCount > 1,                        // Disable looping if only one banner
            pagination: bannerCount > 1
                ? const SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: DotSwiperPaginationBuilder(
                      color: Customcolors.DECORATION_GREY,
                      activeColor: Customcolors.DECORATION_WHITE,
                      size: 5.0,
                      activeSize: 6.0,
                    ),
                  )
                : null, // Hide pagination if only one banner is present
          ),
        );
      }
    });
  }
}