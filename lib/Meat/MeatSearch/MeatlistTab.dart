// ignore_for_file: must_be_immutable, file_names

import 'package:testing/Meat/MeatController.dart/Meatsearchcontroller.dart';
import 'package:testing/Meat/MeatSearch/InactiveMeatlistTab.dart';
import 'package:testing/Meat/MeatSearch/MeatTabsubclass.dart';
import 'package:testing/Meat/Meatview/Meatproductview.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Shimmers/Nearestrestaurantshimmer.dart';
import 'package:testing/utils/Shimmers/Searchlistloader.dart';
import 'package:testing/utils/Toast/customtoastmessage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class MeatlistTab extends StatefulWidget {
  String searchvalue;
  MeatlistTab({required this.searchvalue, super.key});

  @override
  State<MeatlistTab> createState() => _MeatlistTabState();
}

class _MeatlistTabState extends State<MeatlistTab> {
  final Meatsearchcontroller meatlistsearch = Get.put(Meatsearchcontroller());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Start loading state
      meatlistsearch.meatlistloading.value = true;
      Future.delayed(const Duration(seconds: 1), () async {
        meatlistsearch.meatlistloading.value = false;
      });
    });
    super.initState();
  }

  int current = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomSizedBox(
              height: 10,
            ),
            Text(
                "Search results for ${widget.searchvalue.toString() == 'null' ? 'Fish' : widget.searchvalue.toString().capitalizeFirst.toString()}",
                overflow: TextOverflow.ellipsis,
                style: CustomTextStyle.darkgrey),
            const CustomSizedBox(
              height: 10,
            ),
            Obx(() {
              if (meatlistsearch.meatlistloading.isTrue) {
                return const Center(
                  child: Nearestresshimmer(),
                );
              } else if (meatlistsearch.meatlist == null) {
                return const Nearestresshimmer();
              } else if (meatlistsearch
                  .meatlist!["data"]["AdminUserList"].isEmpty) {
                return Column(
                  children: [
                    const SizedBox(height: 20,),
                    const MeatSerchlistloading(),
                    const SizedBox(height: 20,),
                    Text(
                      "Out of ${widget.searchvalue.toString().capitalizeFirst.toString()}!No shops are serving ${widget.searchvalue.toString().capitalizeFirst.toString()} right now!",
                      style: CustomTextStyle.darkgrey,
                    )
                  ],
                );
              } else {
                return AnimationLimiter(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: meatlistsearch.meatlist!["data"]["AdminUserList"].length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      double rating = meatlistsearch.meatlist!["data"]["AdminUserList"][index]["ratingAverage"].toString() ==
                           'null'
                          ? 0
                          : double.tryParse(meatlistsearch.meatlist!["data"]
                                          ["AdminUserList"][index]
                                          ["ratingAverage"]
                                      .toString())
                                  ?.roundToDouble() ??
                              0;
                       final List meatfavourListDetails = meatlistsearch.meatlist!["data"]["AdminUserList"]
                                [index]["favourListDetails"] ??
                            [];
                      return meatlistsearch.meatlist!["data"]["AdminUserList"][index]["status"]==true && meatlistsearch.meatlist!["data"]["AdminUserList"][index]["activeStatus"]=="online"? 
                      AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 750),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: Container(
                              margin:const EdgeInsets.only(top: 10, bottom: 10),
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                borderRadius:BorderRadius.all(Radius.circular(15)),
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
                                    const CustomSizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width / 1.3.w,
                                                child: Text(
                                                  meatlistsearch.meatlist!["data"]["AdminUserList"][index]["name"]
                                                      .toString()
                                                      .capitalizeFirst
                                                      .toString(),
                                                  overflow: TextOverflow.clip,
                                                  style: CustomTextStyle
                                                      .googlebuttontext,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Get.to(Meatproductviewscreen(
                                                  meatfavourListDetails: meatfavourListDetails,
                                                    shopname:  meatlistsearch.meatlist!["data"]["AdminUserList"][index]["name"].toString(),
                                                    shopid: meatlistsearch.meatlist!["data"]["AdminUserList"][index]["_id"],
                                                    imgurl: meatlistsearch.meatlist!["data"]["AdminUserList"][index]["imgUrl"],
                                                    rating: rating,
                                                    city:  meatlistsearch.meatlist!["data"]["AdminUserList"][index]["address"]["city"],
                                                    region:  meatlistsearch.meatlist!["data"]["AdminUserList"][index]["address"]["region"],
                                                    fulladdress:  meatlistsearch.meatlist!["data"]["AdminUserList"][index]["address"]["fullAddress"],
                                                    isFrommeatscreen: true, totalDis: 5,
                                                  ));
                                                },
                                                child: const Icon(
                                                  Icons.arrow_forward_ios_outlined,
                                                  size: 20,
                                                  color: Customcolors
                                                      .DECORATION_BLACK,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const CustomSizedBox(height: 10),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.location_on_outlined,
                                                size: 20,
                                                color: Customcolors
                                                    .DECORATION_BLACK,
                                              ),
                                              Text(
                                                " ${meatlistsearch.meatlist!["data"]["AdminUserList"][index]["address"]["city"].toString().capitalizeFirst.toString()},  ${meatlistsearch.meatlist!["data"]["AdminUserList"][index]["address"]["region"].toString().capitalizeFirst.toString()}",
                                                overflow: TextOverflow.ellipsis,
                                                style: CustomTextStyle.boldgrey,
                                              )
                                            ],
                                          ),
                                          const CustomSizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.star,
                                                size: 20,
                                                color: Colors.amber,
                                              ),
                                              Text(" ${rating.toString()}", style: CustomTextStyle.blacktext),
                                              meatlistsearch.meatlist!["data"]["AdminUserList"] [index]["ratings"]
                                              .isEmpty ||meatlistsearch.meatlist!["data"]["AdminUserList"][index]["ratings"] == null
                                                  ? const Text(" (0 reviews)",
                                                      style: CustomTextStyle.boldgrey)
                                                  : Text(
                                                      " (${meatlistsearch.meatlist!["data"]["AdminUserList"][index]["ratings"].length} reviews)",
                                                      style: CustomTextStyle.boldgrey)
                                            ],
                                          ),
                                          const CustomSizedBox(height: 5),
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Image(
                                                    image: AssetImage( "assets/images/discount.png"),
                                                    height: 15,
                                                    width: 20,
                                                  ),
                                                  Center(
                                                      child: Text(
                                                          'No deals right now, but stay tuned!',
                                                          style: CustomTextStyle.darkgrey))
                                                ],
                                              ),
                                            ],
                                          ),
                                          const Divider()
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 150,
                                      child: GridView.builder(
                                        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1,
                                          crossAxisSpacing: 5,
                                          mainAxisSpacing: 10,
                                          childAspectRatio: 0.48,
                                        ),
                                        itemCount: meatlistsearch.meatlist!["data"]["AdminUserList"][index]["categoryDetails"][0]["meats"].length, // Adjusted to categoryDetails length
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemBuilder: (context, catIndex) {
                                          return Meattabsub(
                                            meats: meatlistsearch.meatlist!["data"]["AdminUserList"][index]["categoryDetails"][0]["meats"],
                                            index: index,
                                            current: current,
                                            index2: catIndex,
                                            isTabScreen: true, shopid:  meatlistsearch
                                            .meatlist!["data"]["AdminUserList"][index]["_id"],
                                             status: meatlistsearch.meatlist!["data"]["AdminUserList"][index]["status"],
                                             activeStatus:meatlistsearch.meatlist!["data"]["AdminUserList"][index]["activeStatus"],
                    
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ):GestureDetector(
                      onTap: () {
                         AppUtils.showToast('The Shop is Currently Closed');
                      },
                      child: InactiveMeatlistTab(index: index, rating: rating, current: current, meatlistsearchlist:  meatlistsearch.meatlist!,));
                    },
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
