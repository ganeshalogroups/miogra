import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Callsmsbutton extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double height;
  final VoidCallback? onPressed;
  final Widget child;

  const Callsmsbutton({
    super.key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.width,
    this.height = 44.0,
   
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(360, 690),
    );
    final borderRadius = this.borderRadius ?? BorderRadius.circular(0);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Customcolors.DECORATION_ERROR_RED,
          shadowColor: Customcolors.DECORATION_ERROR_RED,
          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
        ),
        child: child,
      ),
    );
  }
}



