// ignore_for_file: file_names, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:testing/Mart/Homepage/MartHomepageController/MartcategoriesController.dart';
import 'package:testing/Mart/MartProductsview/Martproductsidebar.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/Shimmers/MartCategoryShimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class Martproductcategory extends StatefulWidget {
bool isFromhomepage;
 Martproductcategory({super.key,this.isFromhomepage=false});

  @override
  State<Martproductcategory> createState() => _MartproductcategoryState();
}
class _MartproductcategoryState extends State<Martproductcategory> {
  MartCategoriescontroller martcategory = Get.put(MartCategoriescontroller());

  @override
  void initState() {
    martcategory.martcategorygettrue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (martcategory.iscategoryloading.isTrue) {
        return const Center(child:  MartCategoriesShimmer());
      } else if (martcategory.category == null ||
          martcategory.category["data"]["data"].isEmpty) {
        return const SizedBox();
      } else {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ResponsiveGridList(
            minItemWidth: 80,
            maxItemsPerRow: 4,
            minItemsPerRow: 4,
            horizontalGridSpacing: 10,
            verticalGridSpacing: 10, // Added spacing between rows
            listViewBuilderOptions: ListViewBuilderOptions(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
            ),
            children: List.generate(
              martcategory.category["data"]["data"].length,
              (index) {
                return GestureDetector(
                onTap: () {
                   Get.to(Productsidebar(categoryId: martcategory.category["data"]["data"][index]["_id"] ,isFromhomepage: true,categorydata: martcategory.category["data"]["data"][index] ,));
               
                },
                  child: Column(
                    children: [
                      _buildCategoryItem(index),
                      const SizedBox(height: 5), // Space between image and text
                      Text(
                        martcategory.category["data"]["data"][index]["meatCateName"]
                            .toString()
                            .capitalizeFirst
                            .toString(),
                        style: CustomTextStyle.subblack,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      }
    });
  }

  Widget _buildCategoryItem(int index) {
    return Container(
      width: 80,
      height: 80,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(253, 246, 245, 1),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: CachedNetworkImage(
          imageUrl: martcategory.category["data"]["data"][index]["meatCateImage"],
          width: 50,
          height: 50,
          placeholder: (context, url) => Image.asset(
            meatdummy,
            width: 50,
            height: 50,
          ),
          errorWidget: (context, url, error) => Image.asset(
            meatdummy,
            width: 50,
            height: 50,
          ),
        ),
      ),
    );
  }
}
