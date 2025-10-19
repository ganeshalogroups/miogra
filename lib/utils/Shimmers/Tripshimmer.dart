// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class TipShimmerLoader extends StatelessWidget {
  const TipShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
       width: MediaQuery.of(context).size.width / 1,
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Shimmer title bar
            Container(
              height: 20,
              width: 150,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
        
            // Shimmer tip buttons (Wrap inside Column)
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: List.generate(4, (index) {
                return Container(
                  width: 80,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              }),
            ),
        
            // const SizedBox(height: 20),
        
            // // Shimmer "Other" text field
            // Container(
            //   height: 45,
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
