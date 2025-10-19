// ignore_for_file: file_names

import 'package:card_swiper/card_swiper.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class Restaurantshimmer extends StatelessWidget {
  const Restaurantshimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 163.h,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Row(
          children: [
            emptyboxes(context: context),
            emptyboxes(context: context),
            emptyboxes(context: context),
            emptyboxes(context: context),
          ],
        ),
      ),
    );
  }
}

emptyboxes({context}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 0),
    child: Column(
      children: [
        Container(
          decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.white,),
           width : MediaQuery.of(context).size.width  *  0.25, // 30% of screen width
          height: MediaQuery.of(context).size.height  *  0.09, // 10% of screen height
          
        ),
        SizedBox(height: 8.h),

        Container(height: 10,width: 50,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.amber),)
      ],


      
    ),
  );
}

class BannerShimmer extends StatelessWidget {
  const BannerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 90.h,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: bannerShimmer(context: context),
      ),
    );
  }
}

bannerShimmer({context}) {
  int bannerCount = 3;

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Column(
      children: [
        SizedBox(
          height: 85.h,
          // height: MediaQuery.of(context).size.height * 0.15,
          child: Swiper(
            autoplay: false,
            itemCount: bannerCount,
            onTap: (index) {},
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)));
            },

            viewportFraction:
                bannerCount > 1 ? 0.9 : 1.0, // Full width for single banner
            scale: bannerCount > 1 ? 0.95 : 1.0, // No scale for single banner
            loop: bannerCount > 1, // Disable looping if only one banner

            pagination: bannerCount > 1
                ? const SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: DotSwiperPaginationBuilder(
                      color: Customcolors.DECORATION_WHITE,
                      activeColor: Customcolors.DECORATION_WHITE,
                      size: 5.0,
                      activeSize: 6.0,
                    ),
                  )
                : null, // Hide pagination if only one banner is present
          ),
        ),
        10.toHeight
        // ClipRRect(
        //   borderRadius: BorderRadius.all(Radius.circular(8)),
        //   child: Container(
        //     height: 90.h,
        //     width: MediaQuery.of(context).size.width/1.1,
        //     color: Colors.white,
        //   ),
        // ),
        // SizedBox(height: 8.h),
      ],
    ),
  );
}

class HomeScreenShimmer extends StatelessWidget {
  const HomeScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 163.h,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  homeCateBoxes(context: context),
                  homeCateBoxes(context: context),
                  homeCateBoxes(context: context),
                  homeCateBoxes(context: context),
                ],
              ),
              SizedBox(height: 10.h),
              Container(
                width: MediaQuery.of(context).size.width/1.3,
                height: 20,
                color: Colors.white,
              ),
               SizedBox(height: 15.h),

                Container(
                  width: MediaQuery.of(context).size.width/1.1,
                  height: 10,
                  color: Colors.white,
                ),
                5.toHeight,
                  Container(
                    width: MediaQuery.of(context).size.width/1.15,
                    height: 10,
                    color: Colors.black,
                  ),
                5.toHeight,
                  Container(
                    width: MediaQuery.of(context).size.width/1.25,
                    height: 10,
                    color: Colors.white,
                  ),
      
              SizedBox(height:15.h),

                 Container(
                width:  MediaQuery.of(context).size .width * 0.9,
                height: 30.h,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.white),
                
              ),

              SizedBox(height: 32.h),
              Align(
                 alignment: Alignment.center,
                 child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.white),
                  width:  MediaQuery.of(context) .size.width * 0.9,
                  height: 30.h,
                ),
              ),
          
          
          
            ],
          ),
        ),
      ),
    );
  }
}

    homeCateBoxes({context}) {
      return Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(65)),
              child: Container(
                width: 68.w,
                height: 30.h,
                color: Colors.white,
              ),
            ),
        
              SizedBox(height: 8.h),
            //  CustomTextStyle().customIcontext(isSelected:_selectedIndex == index,text: categorycontroller.category["data"][index]["productName"] ?.toString().capitalizeFirst),
              5.toHeight,
              Container(
                width: 50,
                height: 2,
                color: Colors.white,
              ),
        
                SizedBox(height: 15.h),
        
          
        
          ],
        );
    }
