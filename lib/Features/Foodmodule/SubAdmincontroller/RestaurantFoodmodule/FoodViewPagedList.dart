// ignore_for_file: unused_local_variable, must_be_immutable, file_names

import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodlistdesign.dart';
import 'package:testing/inlinebannerad.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodViewPagedList extends StatelessWidget {
  final dynamic rescommission;
  final dynamic resid;
  final dynamic fetchedDatas;
  final String restaurantname;
  final dynamic totalDis;
  final dynamic restaurantDetails;
  final dynamic offerPercentage;
  final dynamic restaurantAvailable;
  final Map<String, GlobalKey> categoryKeys;
  const FoodViewPagedList({
    required this.totalDis,
    required this.restaurantname,
    required this.fetchedDatas,
    required this.resid,
    required this.restaurantDetails,
    super.key,
    required int indexone,
    required this.categoryKeys,
    required this.offerPercentage,
    required this.restaurantAvailable,
    required this.rescommission,
  });

  @override
  Widget build(BuildContext context) {
    final categoryName =
        fetchedDatas.foodCateName?.toString().capitalizeFirst ?? '';
    final categoryKey =
        categoryKeys.putIfAbsent(categoryName, () => GlobalKey());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (fetchedDatas.foods!.isNotEmpty && fetchedDatas.status == true)
          Container(
            key: categoryKey, // <-- Attach here
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Text(categoryName,
                overflow: TextOverflow.ellipsis,
                style: CustomTextStyle.googlebuttontext),
          ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: fetchedDatas.foods!.length,
          itemBuilder: (context, index) {
            return FoodListdesign(
              restaurantAvailable: restaurantAvailable,
              offerPercentage: offerPercentage,
              totalDis: totalDis,
              restaurantname: restaurantname.toString(),
              model: fetchedDatas,
              resid: resid.toString(),
              index: index,
              rescommission: rescommission,
            );
          },
        ),
        InlineBannerAdWidget()
      ],
    );
  }
}
