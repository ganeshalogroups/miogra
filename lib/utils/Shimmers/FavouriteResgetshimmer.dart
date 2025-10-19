// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Favouriteresgetshimmer extends StatelessWidget {
  const Favouriteresgetshimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (context, index) => _buildSkeletonItem(),
      ),
    );
  }

  Widget _buildSkeletonItem() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white, // actual content background
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(height: 15, width: 100, color: Colors.grey),
              // const Icon(Icons.favorite, size: 20, color: Colors.red),
            ],
          ),
          const SizedBox(height: 15),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(height: 15, width:70, color: Colors.grey),
            ],
          ),
          // Row(
          //   children: [
          //     const Icon(Icons.location_on_outlined, size: 20),
          //     const SizedBox(width: 8),
          //     Expanded(
          //       child: Container(height: 15, color: Colors.grey),
          //     ),
          //   ],
          // ),
          const SizedBox(height: 10),
          Row(
            children: [
              // const Icon(Icons.star, color: Colors.amber),
              // const SizedBox(width: 5),
              Container(height: 15, width: 150, color: Colors.grey),
              const SizedBox(width: 5),
              // Text(" (57 reviews)", style: TextStyle(color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(thickness: 1),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(height: 15, width: 50, color: Colors.grey),
              Row(
                children: [
                  const Image(
                    image: AssetImage("assets/images/discount.png"),
                    height: 15,
                    width: 20,
                  ),
                  const SizedBox(width: 5),
                  Container(height: 15, width: 70, color: Colors.grey),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
