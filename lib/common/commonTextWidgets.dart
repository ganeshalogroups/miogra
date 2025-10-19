// ignore_for_file: must_be_immutable, file_names

import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';



class ViewMoreTextArrow extends StatelessWidget {
  String content;
  ViewMoreTextArrow({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          content,
          style: CustomTextStyle.boldgrey,
        ),
        const Icon(
          Icons.keyboard_arrow_right,
          color: Customcolors.DECORATION_GREY,
        ),
      ],
    );
  }
}
