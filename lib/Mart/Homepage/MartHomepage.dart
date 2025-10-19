// ignore_for_file: file_names

import 'package:testing/Mart/Homepage/BestDeals.dart';
import 'package:testing/Mart/Homepage/Fruits.dart';
import 'package:testing/Mart/Homepage/MartBanner.dart';
import 'package:testing/Mart/Homepage/MartCategories.dart';
import 'package:testing/Mart/Homepage/MiddleBanner.dart';
import 'package:testing/Mart/Homepage/Search/Martsearchscreen.dart';
import 'package:testing/Mart/Homepage/ShopbyCategory.dart';
import 'package:testing/Mart/Homepage/Snacks.dart';
import 'package:testing/Mart/Homepage/TrendingNow.dart';
import 'package:testing/Mart/Homepage/ViewallCategories.dart';
import 'package:testing/Mart/MartProductsview/Martproductsidebar.dart';
import 'package:testing/Mart/Orderscreen/MartOrdersTab.dart';
import 'package:testing/common/commonRotationalTextWidget.dart';
import 'package:testing/map_provider/Map%20Screens/markervaluse.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/exitapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MartHomepage extends StatefulWidget {
  const MartHomepage({super.key});

  @override
  State<MartHomepage> createState() => _MartHomepageState();
}

class _MartHomepageState extends State<MartHomepage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
     canPop: false,
        onPopInvoked: (didPop) async {

          if (didPop) return;
           // await ExitApp.homepop();
          
        },
      child: Scaffold(
       backgroundColor: Customcolors.pureWhite,
        appBar: AppBar(
          backgroundColor: Customcolors.pureWhite,
          automaticallyImplyLeading: true,
          scrolledUnderElevation: 0,
          surfaceTintColor: Customcolors.pureWhite,
          actions: [
            IconButton(
              onPressed: () {Get.to(const MartorderTab());},
              icon: const Icon(
                Icons.history,
                color: Customcolors.DECORATION_BLACK,
              ),
            ),
          ],
          title: InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(othersicon, scale: 3),
                const SizedBox(width: 5),
                const Text(
                  '692001 - Home',
                  style: CustomTextStyle.font12popinBlack,
                ),
                const Icon(Icons.keyboard_arrow_down_outlined),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Center(
                  child: SearchForBarWidget(
                    onTap: () {
                    Get.to(const MartSearchscreen(),transition: Transition.rightToLeft );
                    },
                    rotationTexts: rotationTextsMartFlow,
                  ),
                ),
                 19.toHeight,
                 const MartBanner(),
                 19.toHeight,
                 Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:  [
                                  const Text("Categories",
                                      style: CustomTextStyle.googlebuttontext),
                                      InkWell(
                                      onTap: () {
                                        Get.to(const Viewallcategories(),transition: Transition.rightToLeft );
                                      },
                                        child: const Text("View All",
                                        style: CustomTextStyle.viewall),
                                      ),
                                ],
                              ),
                            ),
                            10.toHeight,
                            Martproductcategory(isFromhomepage: true,),
                            15.toHeight,
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:  [
                                  Text("Best Deals",
                                      style: CustomTextStyle.googlebuttontext),
                                      Text("View All",
                                      style: CustomTextStyle.viewall),
                                ],
                              ),
                            ),10.toHeight,
                            const BestDeals(),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:  [
                                  const Text("Trending Near You",
                                      style: CustomTextStyle.googlebuttontext),
                                      InkWell(
                                      onTap: () {
                                         Get.to(Productsidebar(),transition: Transition.rightToLeft );
                                      },
                                        child: const Text("View All",
                                        style: CustomTextStyle.viewall),
                                      ),
                                ],
                              ),
                            ),10.toHeight,
                            const TrendingNow(),
                            10.toHeight,
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:  [
                                  const Text("Shop by Category",
                                      style: CustomTextStyle.googlebuttontext),
                                      InkWell(
                                      onTap: () {
                                          Get.to(const Viewallcategories(),transition: Transition.rightToLeft );
                                      },
                                        child: const Text("View All",
                                        style: CustomTextStyle.viewall),
                                      ),
                                ],
                              ),
                            ),
                            10.toHeight,
                            Shopbycategory(isFromhomepage: true,),
                            15.toHeight,
                            const MiddleBanner(),
                            10.toHeight,
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:  [
                                  const Text("Fruits",
                                      style: CustomTextStyle.googlebuttontext),
                                      InkWell(
                                      onTap: () {
                                         Get.to(Productsidebar(),transition: Transition.rightToLeft );
                                      },
                                        child: const Text("View All",
                                        style: CustomTextStyle.viewall),
                                      ),
                                ],
                              ),
                            ),10.toHeight,
                            const Fruits(),
                            10.toHeight,
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:  [
                                  const Text("Snacks",
                                      style: CustomTextStyle.googlebuttontext),
                                      InkWell(
                                      onTap: () {
                                         Get.to(Productsidebar(),transition: Transition.rightToLeft );
                                      },
                                        child: const Text("View All",
                                        style: CustomTextStyle.viewall),
                                      ),
                                ],
                              ),
                            ),10.toHeight,
                            const Snacks()
                          ],
                        ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
