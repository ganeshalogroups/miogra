// ignore_for_file: file_names

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Bannershimmer extends StatelessWidget {
  const Bannershimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor      : Colors.grey[300]!,
          highlightColor : Colors.grey[100]!,
          child: SizedBox(
            height: 150,
            child: Swiper(
              itemHeight: 150,
              autoplay: true,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image:  AssetImage("assets/images/ListBiriyani.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              itemCount: 5,
              viewportFraction: 0.8,
              transformer: ScaleAndFadeTransformer(fade: 0.3),
              scale: 0.9,
            ),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}

