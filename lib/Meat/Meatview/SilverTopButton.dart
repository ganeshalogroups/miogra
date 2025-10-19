// ignore_for_file: must_be_immutable, deprecated_member_use, file_names

import 'package:testing/Meat/Common/Customselectablecontainer.dart';
import 'package:testing/Meat/MeatController.dart/MeatProductviewcontroller.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class SilverTopbuttons extends StatefulWidget {
  dynamic shopid;
   SilverTopbuttons({
    required this.shopid,
    super.key});

  @override
  State<SilverTopbuttons> createState() => _SilverTopbuttonsState();
}

class _SilverTopbuttonsState extends State<SilverTopbuttons> {
  MeatProductviewController productview = Get.put(MeatProductviewController());
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              if (productview.categorybuttongetloading.isTrue) {
                return const Center(child: SizedBox());
              } else if (productview.categorybuttonget == null ||
                  productview.categorybuttonget["data"].isEmpty) {
                return const Center(
                  child: CupertinoActivityIndicator(
                    color: Customcolors.darkpurple,
                  ),
                );
              } else {
                return MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: SizedBox(
                    height: 35,
                    child: ResponsiveGridList(
                      shrinkWrap: true,
                      minItemWidth: 30,
                      maxItemsPerRow: 3,
                      horizontalGridSpacing: 5,
                      horizontalGridMargin: 1,
                      listViewBuilderOptions: ListViewBuilderOptions(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                      ),
                      children: List.generate(
                          productview.categorybuttonget['data']['categoryList'].length, (index) {
                        final foodCusineName = productview.categorybuttonget["data"]['categoryList'][index]["meatCateName"];
                        final foodCusineId = productview.categorybuttonget["data"]['categoryList'][index]["_id"]; // Assuming 'meatCateId' exists

                        return CustomSelectableContainer(
                          text: "${productview.categorybuttonget["data"]['categoryList'][index]["meatCateName"].toString().capitalizeFirst}", // The text to display
                          isSelected: productview.selectedFoodCusineName == foodCusineName, // Whether it is selected or not
                          textStyle: CustomTextStyle.chipgrey,
                          onTap: () {
                           productview.setSelectedFoodCusineName(foodCusineName, foodCusineId);
                            context.read<MeatProductviewPaginations>().clearData(); // Clear previous data
                            context.read<MeatProductviewPaginations>().fetchEarningData(
                                    meatCategoryId: foodCusineId,
                                    searchvalue:productview.searchmeatnamesearch.value,
                                    shopid: widget.shopid);
                          },
                          onCancelTap: () {
                            productview.clearSelectedFoodCusineName();
                            context.read<MeatProductviewPaginations>().clearData(); // Clear previous data
                            context.read<MeatProductviewPaginations>().fetchEarningData(
                                    meatCategoryId: "",
                                    searchvalue:productview.searchmeatnamesearch.value,
                                    shopid: widget.shopid);
                          }, // Your custom text style
                        );
                      }),
                    ),
                  ),
                );
              }
            }),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }
}
