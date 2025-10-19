
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Serchlistloading extends StatelessWidget {
  const Serchlistloading({super.key});

  @override
  Widget build(BuildContext context) {
     return Image.asset(
                   "assets/images/nofoodsearch.gif",
                   filterQuality: FilterQuality.high,color: Color(0xFF623089) ,
                 );
  }
}


class MeatSerchlistloading extends StatelessWidget {
  const MeatSerchlistloading({super.key});

  @override
  Widget build(BuildContext context) {
     return Image.asset(
                   "assets/meat_images/nosearch.gif",
                   height: 220.h,
                   filterQuality: FilterQuality.high,
                 );
  }
}