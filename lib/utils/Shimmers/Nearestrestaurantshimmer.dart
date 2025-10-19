// // ignore_for_file: file_names

// ignore_for_file: file_names

import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Nearestresshimmer extends StatelessWidget {
  const Nearestresshimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: Customcolors.DECORATION_WHITE,
              boxShadow: const [
                BoxShadow(
                  color: Customcolors.DECORATION_LIGHTGREY,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Container(
                    height: 100.h,
                    width: double.infinity,
                    color: Colors.grey[300],
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 15.h,
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[300],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, size: 20, color: Colors.grey),
                          const SizedBox(width: 5),
                          Container(
                            height: 15.h,
                            width: 180.w,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 20, color: Colors.amber),
                          const SizedBox(width: 5),
                          Container(
                            height: 15.h,
                            width: 60.w,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            height: 15.h,
                            width: 90.w,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(), // Empty left side (you had an empty Row here)
                          Row(
                            children: [
                              Container(
                                height: 15,
                                width: 20,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Container(
                                height: 15,
                                width: 180,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
