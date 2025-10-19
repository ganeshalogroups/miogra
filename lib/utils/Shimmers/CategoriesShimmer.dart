// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CategoriesShimmer extends StatelessWidget {
  const CategoriesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
          height: 75.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5, // Number of shimmer placeholders
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 65.w,
                        height: 55.h,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              );
            },
          ),
        );
  }
}
