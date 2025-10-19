

import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';

class AddressAddDecoration {

  InputBorder inputBorder() {
    return const UnderlineInputBorder(
      borderSide   : BorderSide(color: Customcolors.DECORATION_GREY),
      borderRadius : BorderRadius.only(
        bottomLeft : Radius.circular(15),
        bottomRight: Radius.circular(15),
      ),
    );
  }
  
}
