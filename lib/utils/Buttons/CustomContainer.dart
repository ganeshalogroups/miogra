// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget? child;
  final double? width;
   final Widget? color;
  final double? height;
  final Decoration? decoration;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
 final  Alignment? alignment;
  const CustomContainer(
      {super.key,
      this.alignment,
      this.width,
      this.color,
      this.height,
      this.decoration,
      this.padding,
      this.margin,
      this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      width: width,
      height: height,
      decoration: decoration,
      padding: padding,
      margin: margin,
      child: child,
    );
  }
}
