// ignore_for_file: file_names, deprecated_member_use

import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:shimmer/shimmer.dart';



class ShopListWithShimmer extends StatelessWidget {
  const ShopListWithShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Container(
                  height: 70.h,
                  width: MediaQuery.of(context).size.width / 0.5,
                  margin:
                      const EdgeInsets.symmetric( vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                ),
                const CustomSizedBox(height: 10),
                MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ResponsiveGridList(
                    shrinkWrap: true,
                    horizontalGridSpacing: 10,
                    verticalGridSpacing: 10,
                    minItemWidth: 150,
                    minItemsPerRow: 2,
                    maxItemsPerRow: 2,
                    listViewBuilderOptions: ListViewBuilderOptions(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    ),
                    children: List.generate(2, (index) {
                      return Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: Customcolors.DECORATION_CONTAINERGREY,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
