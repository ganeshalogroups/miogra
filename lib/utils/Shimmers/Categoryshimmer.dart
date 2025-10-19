// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:shimmer/shimmer.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
      // baseColor: Colors.grey[300]!,
      // highlightColor: Colors.grey[100]!,
      child: ResponsiveGridList(
      // ignore: deprecated_member_use
      shrinkWrap: true,
        minItemWidth: 40,
        maxItemsPerRow: 4,
        minItemsPerRow: 4,
        // horizontalGridSpacing: 2,
        // horizontalGridMargin: 1,
        listViewBuilderOptions: ListViewBuilderOptions(physics: const NeverScrollableScrollPhysics(), shrinkWrap: true,),
        children: List.generate(
          4, // Number of shimmer items you want to show
          (index) =>
        Column(
        children: [
          Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey[300]!),
                    color: Colors.grey[300]!
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                ),
        ],
      )
             ),
      ),
    );
 
  }


// circleboxes(){
// return        Container(
//                   height: 40,
//                   width: 100,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(30),
//                     border: Border.all(color: Colors.grey[300]!),
//                     color: Colors.grey[300]!
//                   ),
//                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                 )

// }


}






class HomeButtonShimmer extends StatelessWidget {
  const HomeButtonShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const SizedBox(height: 40),
          Container(
            width: 150,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 25),

          Container(
            width: 75,
            height: 15,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          const SizedBox(height: 30),

          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          const SizedBox(height: 20),

          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Container(
                width: 100,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
