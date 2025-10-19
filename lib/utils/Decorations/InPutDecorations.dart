// ignore_for_file: file_names

import 'package:testing/common/custom_richText.dart';
import 'package:testing/map_provider/Map%20Screens/map_property_Decorations/LocAdd_bottomSheet_decorations.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';



class ReusableInputDecoration {
  static InputDecoration getDecoration({ required String fieldName, String prefixText = "" }) {
    return InputDecoration(
      label: CustomRichText(fieldName: fieldName),
      focusedBorder: AddressAddDecoration().inputBorder(),
      enabledBorder: AddressAddDecoration().inputBorder(),
      errorBorder: AddressAddDecoration().inputBorder(),
      focusedErrorBorder: AddressAddDecoration().inputBorder(),
      contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
      errorStyle:CustomTextStyle.notetext,
      isDense: false,
      isCollapsed: false,
      prefixText: prefixText,
      counterText: "",
      errorMaxLines: 2,
      fillColor: Colors.transparent,
      filled: true,
      hintStyle: CustomTextStyle.addressfeildtext,
      prefixStyle: const TextStyle(color: Customcolors.DECORATION_BLACK),
      prefixIconColor: Customcolors.DECORATION_BLACK,
      prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
    );
  }
}
