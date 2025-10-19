// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Foodcategoryshimmer extends StatelessWidget {
  const Foodcategoryshimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
                    "assets/images/menugif.gif",
                    height: 120.0,
                    filterQuality: FilterQuality.high,
                  ),
    );
  }
}
