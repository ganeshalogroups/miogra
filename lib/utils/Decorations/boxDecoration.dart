

// ignore_for_file: file_names

import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';

class BoxDecorationsFun {
  static BoxDecoration whiteCircelRadiusDecoration({double radious = 10.0}) {
    return BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(radious));
  }

  static BoxDecoration greyBoderDecoraton({double radus = 10.0}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radus),
      border: Border.all(color: Colors.grey),
    );
  }

  static BoxDecoration bottomCurvedBoxBorder() {
    return const BoxDecoration(
      color: Colors.transparent,
      border: Border(bottom: BorderSide(color: Customcolors.DECORATION_GREY)),
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
    );
  }
}
