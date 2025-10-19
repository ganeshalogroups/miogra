import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Bannercontroller.dart';
import 'package:testing/Features/Foodmodule/getFoodCartProvider.dart';
import 'package:testing/Features/Homepage/Profile_Orders/Chatbot.dart';

import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Chatbotcontroller.dart';
import 'package:testing/Features/Homepage/Profile_Orders/parcelChatbot.dart';
import 'package:testing/Features/coupon/couponController.dart';
import 'package:testing/parcel/p_parcel_orders/orders_tabs.dart';
import 'package:testing/parcel/p_services_provider/p_Round_Trip_Validation.dart';
import 'package:testing/parcel/p_services_provider/p_address_provider.dart';

import 'package:testing/parcel/singelTrip.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Shimmers/Restaurantshimmer.dart';
import 'package:testing/utils/exitapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';

class ParcelHomeScreen extends StatefulWidget {
  const ParcelHomeScreen({super.key});

  @override
  State<ParcelHomeScreen> createState() => _ParcelHomeScreenState();
}

class _ParcelHomeScreenState extends State<ParcelHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  Chatbotcontroller chatttbot = Get.put(Chatbotcontroller());
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final foodcartprovider = Provider.of<FoodCartProvider>(context);

    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (didPop) return;

          final couponController =
              Provider.of<CouponController>(context, listen: false);
          final roundtripcontroller =
              Provider.of<RoundTripLOcatDataProvider>(context, listen: false);
          final picdropProvider =
              Provider.of<ParcelAddressProvider>(context, listen: false);

          roundtripcontroller.clearAddressMapData();
          picdropProvider.clearAddressMapData();

          // Safely handle coupon-related operations
          couponController.removeCoupon();
          couponController.parcelremoveCoupon();
          couponController.rTripparcelremoveCoupon();
         // await ExitApp.homepop();
        },
        child: Scaffold(
            resizeToAvoidBottomInset: false, // keep AppBar fixed
            body: Scaffold(
              resizeToAvoidBottomInset:
                  false, // keep top fixed even when keyboard opens
                  appBar: AppBar(
                    title: Text('Send Package',
                                   style: CustomTextStyle.profile,textAlign: TextAlign.center,),
                              
                    actions: [ IconButton(
                              onPressed: () {
                                Get.to(const ParcelOrdersHistory(),
                                    transition: Transition.zoom);
                              },
                              icon: const Icon(Icons.history),
                            ),],),
              body: SafeArea(
                  child: Stack(
                children: [
                  Column(
                    children: [
                      // The top section that was in AppBar
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //        Center(
                      //          child: Text('Send Package',
                      //             style: CustomTextStyle.profile,textAlign: TextAlign.center,),
                      //        ),
                      //       IconButton(
                      //         onPressed: () {
                      //           Get.to(const ParcelOrdersHistory(),
                      //               transition: Transition.zoom);
                      //         },
                      //         icon: const Icon(Icons.history),
                      //       ),
                      //     ],
                      //   ),
                     // ),
                      10.toHeight,
                      const CardSwiper(),
                      10.toHeight,
                      TabBar(
                        indicatorColor: Customcolors.darkpurple,
                        indicatorSize: TabBarIndicatorSize.tab,
                        controller: tabController,
                        tabs: const [
                          Tab(
                              child: Text('Single Trip',
                                  style: CustomTextStyle.profile)),
                          Tab(
                              child: Text('Round Trip',
                                  style: CustomTextStyle.profile)),
                        ],
                      ),

                      // Expanded main content
                      Expanded(
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: tabController,
                          children: [
                            SingleTripScreen(single: true, round: false),
                            SingleTripScreen(single: false, round: true),
                          ],
                        ),

                      
                      ),
                    ],
                  ),
                    foodscreenButtons(foodcartprovider, context),
                 
                ],
              )),
            )));
  }

  Stack foodscreenButtons(
      FoodCartProvider foodcartprovider, BuildContext context) {
    return Stack(
      children: [
        UserId != null
            ? Obx(() {
                if (chatttbot.ischatLoading.isTrue) return const SizedBox();
                final data = chatttbot.chathealthcheckDetails;
                if (data != null && data["data"]["mobile"] == true) {
                //  return const Chatbot();
                  return SizedBox();
                } else {
                  return const SizedBox();
                }
              })
            : const SizedBox.shrink(),
      ],
    );
  }
}

class CardSwiper extends StatefulWidget {
  const CardSwiper({super.key});

  @override
  State<CardSwiper> createState() => _CardSwiperState();
}

class _CardSwiperState extends State<CardSwiper> {
  Bannerlistcontroller bannerlist = Get.put(Bannerlistcontroller());

  @override
  void initState() {
    bannerlist.bannerget(productType: 'services');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (bannerlist.isbannerloading.isTrue) {
        return const Center(child: BannerShimmer());
      } else if (bannerlist.banner == null ||
          bannerlist.banner["data"]["data"].isEmpty) {
        return const SizedBox();

        // return Center(child: Text("No banner Available!"));
      } else {
        int bannerCount = bannerlist.banner["data"]["data"].length;

        return SizedBox(
          height: 105.h,
          child: Swiper(
            autoplay: true,
            itemCount: bannerCount,
            onTap: (index) {
              bannerlist.getResturantsById(
                  resturantId: bannerlist.banner["data"]["data"][index]
                      ['navigateUserId']);
            },

            itemBuilder: (BuildContext context, int index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  placeholder: (context, url) => Image.asset(fastxdummyImg),
                  errorWidget: (context, url, error) => Image.asset(
                      "assets/images/parcel.png",
                      fit: BoxFit.contain),
                  width: MediaQuery.of(context).size.width,
                  imageUrl:
                      "$globalImageUrlLink${bannerlist.banner["data"]["data"][index]["imageUrl"]}",
                  fit: BoxFit.fill,
                ),
              );
            },
            viewportFraction:
                bannerCount > 1 ? 0.9 : 1.0, // Full width for single banner
            scale: bannerCount > 1 ? 0.95 : 1.0, // No scale for single banner
            loop: bannerCount > 1, // Disable looping if only one banner

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
