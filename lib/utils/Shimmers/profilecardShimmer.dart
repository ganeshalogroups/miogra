

// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProfileCardShimmer extends StatelessWidget {
  const ProfileCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 100.h,
            padding: const EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width / 1,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.grey[400],
                ),
                const SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: 20,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 15,
                      color: Colors.grey[400],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
  }
}


