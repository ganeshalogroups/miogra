// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Foodlistshimmer extends StatelessWidget {
  const Foodlistshimmer({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) {
        return Skeletonizer(
          enabled: true,
          child: Container(
            height: size.height * 0.2,
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(height: 15, width: 100, color: Colors.grey[300]),
                    Container(height: 15, width: 30, color: Colors.grey[300]),
                  ],
                ),
                const SizedBox(height: 8),
                // Location
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 20, color: Colors.grey),
                    const SizedBox(width: 5),
                    Container(height: 15, width: 150, color: Colors.grey[300]),
                  ],
                ),
                const SizedBox(height: 8),
                // Rating
                Row(
                  children: [
                    const Icon(Icons.star, size: 20, color: Colors.amber),
                    const SizedBox(width: 5),
                    Container(height: 15, width: 50, color: Colors.grey[300]),
                  ],
                ),
                const Divider(),
                // Bottom Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(height: 15, width: 60, color: Colors.grey[300]),
                    Row(
                      children: [
                        Container(height: 15, width: 20, color: Colors.grey[300]),
                        const SizedBox(width: 5),
                        Container(height: 15, width: 100, color: Colors.grey[300]),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}