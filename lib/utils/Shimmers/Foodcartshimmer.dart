// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Foodcartshimmer extends StatelessWidget {
  const Foodcartshimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
  baseColor: Colors.grey[300]!,
  highlightColor: Colors.grey[100]!,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
       Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 9),
        child:  Container(
                  height: 20,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[300],
                  ),
                ),
      ),
      ListView.builder(
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (BuildContext context, index) {
  
          return
           Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child:  Container(
                  height: 20,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[300],
                  ),
                ),
                ),const SizedBox(height: 5,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Container(
                  height: 20,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[300],
                  ),
                ),const SizedBox(height: 5,),
                     Container(
                  height: 20,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[300],
                  ),
                ),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child:  Container(
                  height: 35,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[300],
                  ),
                ),)
              ],
            ),
          );
        },
      ),
      // CustomDottedContainer(),
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Container(
      //           height: 20,
      //           width: 70,
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(20),
      //             color: Colors.grey[300],
      //           ),
      //         ),
      //     Icon(
      //       Icons.keyboard_arrow_right,
      //       color: Customcolors.DECORATION_GREY,
      //     ),
      //   ],
      // ),
    ],
  ),
);
  }
}