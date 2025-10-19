// ignore_for_file: file_names

import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';

class FoodDecorations {


  Decoration stepperBoxDecoraion = const BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(15)),
    color: Customcolors.DECORATION_WHITE,
    boxShadow: [
      BoxShadow(
        color: Customcolors.DECORATION_LIGHTGREY, //color of shadow
        spreadRadius: 5, //spread radius
        blurRadius: 7, // blur radius
        offset: Offset(0, 2),
      ),
    ],
  );

//delivary Man Container decoration

  Decoration delivarymanDecoraion = const BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(15)),
    color: Customcolors.DECORATION_WHITE,
    boxShadow: [
      BoxShadow(
        color: Customcolors.DECORATION_LIGHTGREY, //color of shadow
        spreadRadius: 5, //spread radius
        blurRadius: 7, // blur radius
        offset: Offset(0, 2),
      ),
    ],
  );




  Decoration stepperDecParcel = const BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(15)),
    color: Colors.white,

  );





}
