
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SearchlistShimmer extends StatelessWidget {
  const SearchlistShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            leading: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),   color: Colors.white,),
              width: 70,
            ),
            title: Container(
             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),   color: Colors.white,),
              height: 14,
            ),
            subtitle: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),   color: Colors.white,),
              height: 10,
            ),
          ),
       ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            leading: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),   color: Colors.white,),
              width: 70,
            ),
            title: Container(
             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),   color: Colors.white,),
              height: 14,
            ),
            subtitle: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),   color: Colors.white,),
              height: 10,
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            leading: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),   color: Colors.white,),
              width: 70,
            ),
            title: Container(
             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),   color: Colors.white,),
              height: 14,
            ),
            subtitle: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),   color: Colors.white,),
              height: 10,
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            leading: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),   color: Colors.white,),
              width: 70,
            ),
            title: Container(
             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),   color: Colors.white,),
              height: 14,
            ),
            subtitle: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),   color: Colors.white,),
              height: 10,
            ),
          ),
        ],
      ),
        ),
    );
  }
}