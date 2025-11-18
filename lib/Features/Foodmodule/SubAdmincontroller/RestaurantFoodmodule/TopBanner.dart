// ignore_for_file: file_names, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


// class TopBannerclass extends StatefulWidget {
// dynamic bannerlist;
//    TopBannerclass({super.key,required this.bannerlist});

//   @override
//   State<TopBannerclass> createState() => _TopBannerclassState();
// }

// class _TopBannerclassState extends State<TopBannerclass> {
//   @override
//   Widget build(BuildContext context) {
//     return  SizedBox(
//           height: 90.h,
//           // height: MediaQuery.of(context).size.height * 0.15,
//           child: Swiper(
//             autoplay: true,
//             itemCount: widget.bannerlist.length,
//             onTap: (index) {
//               // bannerlist.getResturantsById(
//               //     resturantId: bannerlist.banner["data"]["banner"]["data"]
//               //         [index]['navigateUserId']);
//             },

//             itemBuilder: (BuildContext context, int index) {
//               return ClipRRect(
//   borderRadius: BorderRadius.circular(10),
//   child: Container(
//     decoration: BoxDecoration(
//      color: const Color.fromARGB(255, 238, 237, 237),
//       image: DecorationImage(
//         image: CachedNetworkImageProvider(
//        "$globalImageUrlLink${widget.bannerlist[index]["imageUrl"]}"   ,
//         ),
//         fit: BoxFit.cover,
//       ),
//     ),
//   ),
// );
//             },

//             viewportFraction:
//                 widget.bannerlist.length > 1 ? 0.9 : 1.0, // Full width for single banner
//             scale: widget.bannerlist.length > 1 ? 0.95 : 1.0, // No scale for single banner
//             loop: widget.bannerlist.length > 1, // Disable looping if only one banner

//             pagination: widget.bannerlist.length > 1
//                 ? const SwiperPagination(
//                     alignment: Alignment.bottomCenter,
//                     builder: DotSwiperPaginationBuilder(
//                       color: Customcolors.DECORATION_GREY,
//                       activeColor: Customcolors.DECORATION_WHITE,
//                       size: 5.0,
//                       activeSize: 6.0,
//                     ),
//                   )
//                 : null, // Hide pagination if only one banner is present
//           ),
//         );
      
//   }
// }


















class TopBannerclass extends StatefulWidget {
  final dynamic bannerlist;
  const TopBannerclass({super.key, required this.bannerlist});

  @override
  State<TopBannerclass> createState() => _TopBannerclassState();
}

class _TopBannerclassState extends State<TopBannerclass> {
  int _currentIndex = 0;
  final SwiperController _controller = SwiperController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Banner Swiper
        SizedBox(
          height: 90.h,
          width: 330.w,
          child: Swiper(
            controller: _controller,
            autoplay: true,
            itemCount: widget.bannerlist.length,
            onIndexChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 238, 237, 237),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                       // "$globalImageUrlLink${widget.bannerlist[index]["imageUrl"]}",
                        "$globalImageUrlLink${widget.bannerlist[index]["document"]["imageUrl"]}",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
            viewportFraction:  1.0,
            scale:  1.0,
            // viewportFraction: widget.bannerlist.length > 1 ? 0.9 : 1.0,
            // scale: widget.bannerlist.length > 1 ? 0.95 : 1.0,
            loop: widget.bannerlist.length > 1,
          ),
        ),

       SizedBox(height: 15.h), // space between banner & dots

        // Dots (outside the banner)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.bannerlist.length, (index) {
            bool isActive = _currentIndex == index;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: 8.h,
              height:8.h,
              // width: isActive ? 10 : 6,
              // height: isActive ? 10 : 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive
                    ?  Customcolors.darkpinkColor
                    : Color.fromARGB(255, 208, 166, 216)
              ),
            );
          }),
        ),
      ],
    );
  }
}
