// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvgAsset {

  
  static Widget customSvgAsset({svgImage, height = 30.0, width = 30.0}) {
    return SvgPicture.asset(
      svgImage,
      height: height,
      width: width,
    );
  }
}
