
// ignore_for_file: file_names

import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomRichText extends StatelessWidget {
  String fieldName;

  CustomRichText({super.key, required this.fieldName});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: fieldName,
        style: CustomTextStyle.addressfeildtext,
        children: const [
          TextSpan(
            text: ' *',
            style: TextStyle(color: Colors.red, fontSize: 16.0),
          )
        ],
      ),
    );
  }
}
