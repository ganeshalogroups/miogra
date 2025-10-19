
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerGridList extends StatelessWidget {
  const ShimmerGridList({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SizedBox(
      height: 100,
        child: ResponsiveGridList(
          minItemWidth: 40,
          maxItemsPerRow: 3,
          minItemsPerRow: 3,
          horizontalGridSpacing: 5,
          horizontalGridMargin: 1,
          listViewBuilderOptions: ListViewBuilderOptions(physics: const NeverScrollableScrollPhysics()),
          children: List.generate(
            9, // Number of shimmer items you want to show
            (index) =>
          Column(
          children: [
            Container(
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 22,
                          color: Colors.grey[300]!,
                        ),
                        const SizedBox(width: 6),
                        Container(
                          width: 50,
                          height: 10,
                          color: Colors.grey[300]!,
                        ),
                      ],
                    ),
                  ),
          ],
        )
       ),
        ),
      ),
    );
  }
}
