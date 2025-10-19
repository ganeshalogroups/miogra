// ignore_for_file: file_names

import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBoxDecoration {
  isBoxCheckedDecoration({isSelected}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: isSelected? const Color.fromRGBO(248, 221, 208, 0.973) :  Customcolors.DECORATION_WHITE ,
        gradient: isSelected? const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
          Customcolors.lightpurple,
        Customcolors.darkpurple
          ],
        ):const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 255, 255, 255), // Color code for #F98322
            Color.fromARGB(255, 255, 255, 255), // End color
          ],
        ),
      border: Border.all(
          color: isSelected
           ?Customcolors.darkpurple
              // ? Customcolors.DECORATION_WHITE
              : Customcolors.DECORATION_GREY),
    );
  }
}




   BoxDecoration blueboxdecoration =  BoxDecoration(
   borderRadius : BorderRadius.circular(6),
   color        : const Color.fromARGB(255, 230, 245, 254),
   border       : Border.all( color: const Color.fromARGB(255, 1, 151, 244)));

                       
