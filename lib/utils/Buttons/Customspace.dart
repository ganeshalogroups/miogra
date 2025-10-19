// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomSizedBox extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget? child;

  const CustomSizedBox({super.key, this.height, this.child, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: child,
    );
  }
}
