// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:card_swiper/card_swiper.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
// Import your custom colors and placeholder image path

class BottomBanner extends StatefulWidget {
  final dynamic bottomBannerList;

  const BottomBanner({super.key, required this.bottomBannerList});

  @override
  State<BottomBanner> createState() => _BottomBannerState();
}

class _BottomBannerState extends State<BottomBanner> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          SizedBox(
            height: 90.h,
            child: Swiper(
              autoplay: true,
              itemCount: widget.bottomBannerList.length,
              onTap: (index) {
                // Handle tap if needed
              },
              itemBuilder: (BuildContext context, int index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl:"${globalImageUrlLink}${ widget.bottomBannerList[index]["imageUrl"]}",
                    placeholder: (context, url) =>
                        Image.asset(fastxdummyImg, fit: BoxFit.contain),
                    errorWidget: (context, url, error) =>
                        Image.asset(fastxdummyImg, fit: BoxFit.contain),
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                );
              },
              viewportFraction:
                  widget.bottomBannerList.length > 1 ? 0.9 : 1.0,
              scale: widget.bottomBannerList.length > 1 ? 0.95 : 1.0,
              loop: widget.bottomBannerList.length > 1,
              pagination: widget.bottomBannerList.length > 1
                  ? const SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      builder: DotSwiperPaginationBuilder(
                        color: Customcolors.DECORATION_GREY,
                        activeColor: Customcolors.DECORATION_WHITE,
                        size: 5.0,
                        activeSize: 6.0,
                      ),
                    )
                  : null,
            ),
          ),
          CustomSizedBox(height: 15.h),
        ],
      ),
    );
  }
}
