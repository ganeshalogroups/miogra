// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class OrdersScreenShimeer extends StatelessWidget {
  const OrdersScreenShimeer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 3,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return Container(
            height: 220.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.green,
            ),
          );
        },
      ),
    );
  }
}
