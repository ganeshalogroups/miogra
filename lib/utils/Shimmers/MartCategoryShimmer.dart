// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:shimmer/shimmer.dart';

class MartCategoriesShimmer extends StatelessWidget {
  const MartCategoriesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ResponsiveGridList(
        minItemWidth: 80,
        maxItemsPerRow: 4,
        minItemsPerRow: 4,
        horizontalGridSpacing: 10,
        verticalGridSpacing: 10,
        listViewBuilderOptions: ListViewBuilderOptions(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
        ),
        children: List.generate(8, (index) {
          return Column(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 60,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );}
}
