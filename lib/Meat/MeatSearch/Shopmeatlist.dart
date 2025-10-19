// ignore_for_file: must_be_immutable, file_names

import 'package:testing/Meat/MeatController.dart/Meatsearchcontroller.dart';
import 'package:testing/Meat/MeatDomain/Meatfavmodel.dart';
import 'package:testing/Meat/MeatSearch/Shopmeatlistcard.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Shimmers/Nearestrestaurantshimmer.dart';
import 'package:testing/utils/Shimmers/Searchlistloader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class Shopmeatlist extends StatefulWidget {
  dynamic searchvalue;
   Shopmeatlist({
    required this.searchvalue,
    super.key});

  @override
  State<Shopmeatlist> createState() => _ShopmeatlistState();
}

class _ShopmeatlistState extends State<Shopmeatlist> {
    Meatsearchcontroller meatlistsearch = Get.put(Meatsearchcontroller());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomSizedBox(height: 10),
            Text(
                "Search results for ${widget.searchvalue.toString() == 'null' ? 'Fish' : widget.searchvalue.toString().capitalizeFirst.toString()}",
                style: CustomTextStyle.darkgrey),
            const CustomSizedBox(height: 10),
            Obx(() {
              if (meatlistsearch.meatlistloading.isTrue) {
                return const Center(
                  child: Nearestresshimmer(),
                );
              }else if (meatlistsearch.meatlist == null ||
                  meatlistsearch.meatlist == "null" ||
                  meatlistsearch.meatlist.isEmpty ||
                  meatlistsearch.meatlist["data"]["AdminUserList"] == null ||
                  meatlistsearch.meatlist["data"]["AdminUserList"].isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20,),
                      const MeatSerchlistloading(),
                      const SizedBox(height: 20,),
                      Text(
                        "Out of ${widget.searchvalue.toString().capitalizeFirst.toString()}!No shops are serving ${widget.searchvalue.toString().capitalizeFirst.toString()} right now!",
                        style: CustomTextStyle.darkgrey,
                      )
                    ],
                  ),
                );
              } else {
                return SizedBox(
                  // height: MediaQuery.of(context).size.height,
                  child: AnimationLimiter(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:meatlistsearch.meatlist["data"]["AdminUserList"].length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        

                        dynamic totalrating =
                           meatlistsearch.meatlist["data"]["AdminUserList"][index]["ratings"];
                        final List meatfavourListDetails = meatlistsearch.meatlist["data"]["AdminUserList"]
                                [index]["favourListDetails"] ??
                            [];

                        bool status = meatlistsearch.meatlist["data"]
                            ["AdminUserList"][index]["status"];
                        dynamic activestatus =meatlistsearch.meatlist["data"]["AdminUserList"][index]["activeStatus"];
                        dynamic fulladdress = meatlistsearch.meatlist["data"]["AdminUserList"][index]
                            ["address"]["fullAddress"];
                        double latitude =meatlistsearch.meatlist["data"]["AdminUserList"][index]["address"]['latitude'];
                        var longitude = meatlistsearch.meatlist["data"]["AdminUserList"][index]
                            ["address"]['longitude'];

                        double rating = meatlistsearch.meatlist["data"]["AdminUserList"]
                                        [index]["ratingAverage"]
                                    .toString() ==
                                'null'
                            ? 0
                            : double.tryParse(meatlistsearch.meatlist["data"]["AdminUserList"][index]
                                            ["ratingAverage"]
                                        .toString())
                                    ?.roundToDouble() ??
                                0;
                        final shop = MeatFavoriteShop(
                                id: meatlistsearch.meatlist["data"]["AdminUserList"][index]["_id"],
                                name:  meatlistsearch.meatlist["data"] ["AdminUserList"][index]["name"].toString(),
                                city: meatlistsearch.meatlist["data"]["AdminUserList"][index]["address"]["city"].toString(),
                                region: meatlistsearch.meatlist["data"] ["AdminUserList"][index]["address"]["region"].toString(),
                                imageUrl:  meatlistsearch.meatlist["data"]["AdminUserList"][index]["imgUrl"].toString(),
                                rating: rating,
                              );
                        return Shoplistcard(
                        shop:shop ,
                          searchvalue: widget.searchvalue,
                          latitude: latitude,
                          longitude: longitude,
                          meatfavourListDetails: meatfavourListDetails,
                          rating: rating,
                          status: status,
                          ratinglength: totalrating,
                          activestatus: activestatus,
                          fulladdress: fulladdress, 
                          imageUrl:  meatlistsearch.meatlist["data"]["AdminUserList"][index]["imgUrl"],
                          shopcity:meatlistsearch.meatlist["data"]["AdminUserList"][index]["address"]["city"], 
                          shopname:   meatlistsearch.meatlist["data"] ["AdminUserList"][index]["name"],
                          shopregion: meatlistsearch.meatlist["data"] ["AdminUserList"][index]["address"]["region"].toString(), shopid: meatlistsearch.meatlist["data"] ["AdminUserList"][index]["_id"],
                        );
                      },
                    ),
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
