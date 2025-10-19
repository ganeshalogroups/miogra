// ignore_for_file: file_names

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';

class CustomContainerDecoration {
//Login padding style

  static BoxDecoration loginPaddingDecoration({
    Color color = Customcolors.DECORATION_WHITE,
  }) {
    return const BoxDecoration(
      color: Customcolors.DECORATION_WHITE,
      borderRadius: BorderRadius.only(
        topLeft: Radius.zero,
        topRight: Radius.zero,
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
    );
  }

  static BoxDecoration lightgreybuttondecoration() {
    return BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 200, 198, 198), // Color code for #F98322
            Color.fromARGB(255, 179, 175, 175), // End color
          ],
        ),
        borderRadius: BorderRadius.circular(20));
  }

  static BoxDecoration whitecontainer({
    Color color = Customcolors.DECORATION_WHITE,
  }) {
    return const BoxDecoration(
      color: Customcolors.DECORATION_WHITE,
    );
  }
 static BoxDecoration whitebordercontainer({
    Color color = Customcolors.DECORATION_WHITE,
  }) {
    return  BoxDecoration(
    borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r),topRight: Radius.circular(20.r)),
      color: Customcolors.DECORATION_WHITE,
    );
  }
  BoxDecoration productIconDecoration({isSelectedIndex}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      gradient: isSelectedIndex
          ? const LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: [0.2, 1.4],
             // colors: [Color(0xFFF98322), Color(0xFFEE4C46)],
             colors: [   
 Color(0xFF623089),
  Color(0xFFAE62E8),]
            )
          : const LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: [0.2, 1.4],
              colors: [
                Customcolors.DECORATION_WHITE,
                Customcolors.DECORATION_WHITE
              ],
            ),
    );
  }

  static BoxDecoration greyborder({
    Color color = Customcolors.DECORATION_WHITE,
  }) {
    return BoxDecoration(
        border: Border.all(color: Customcolors.DECORATION_GREY),
        borderRadius: const BorderRadius.all(Radius.circular(30)));
  }

  static BoxDecoration foodgreyborder(
      {Color color = Customcolors.DECORATION_WHITE, double radious = 10.0}) {
    return BoxDecoration(
        border: Border.all(color: Customcolors.DECORATION_GREY),
        borderRadius: BorderRadius.all(Radius.circular(radious)));
  }

  static BoxDecoration profileborder({
    Color color = Customcolors.DECORATION_WHITE,
  }) {
    return BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 228, 227, 227), // Color code for #F98322
            Color.fromARGB(255, 224, 221, 221), // End color
          ],
        ),
        borderRadius: BorderRadius.circular(5)
        // borderRadius: BorderRadius.all(Radius.circular(30))
        );
  }

  static BoxDecoration whitecontainerdecoration(
      {Color clr = Customcolors.DECORATION_WHITE}) {
    return BoxDecoration(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      color: clr,
    );
  }

  static BoxDecoration boxshadowdecoration() {
    return BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(17),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 1),
        ),
      ],
    );
  }

  static BoxDecoration textformfieldDecoration() {
    return BoxDecoration(
      color: Customcolors.DECORATION_WHITE,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          offset: const Offset(0, 4),
          blurRadius: 1,
          spreadRadius: 0,
        ),
      ],
    );
  }

  static BoxDecoration menudecoration() {
    return const BoxDecoration(
      color: Color.fromRGBO(245, 92, 36, 0.792),
      shape: BoxShape.circle,
    );
  }

  static BoxDecoration gradientdecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [

            Color(0xFFAE62E8),
 Color(0xFF623089)
          // Color(0xFFF98322), // Color code for #F98322
          // Color(0xFFEE4C46), // End color


        ],
      ),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
    );
  }

  static BoxDecoration voicerecorderdecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
         Color(0xFFAE62E8),
 Color(0xFF623089)
        ],
      ),
      shape: BoxShape.circle,
    );
  }

  static BoxDecoration halaldecoration() {
    return const BoxDecoration(
        color: Customcolors.halalGreen,
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(15), topLeft: Radius.circular(15)));
  }

  static BoxDecoration customisedbuttondecoration() {
    return BoxDecoration(
        // gradient: LinearGradient(
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        //   colors: const [
        //     Color(0xFFF98322), // Color code for #F98322
        //     Color(0xFFEE4C46), // End color
        //   ],
        // ),
        border: Border.all(
          color: Customcolors.darkpurple, // Border color
          width: 1.0, // Border width
        ),
        borderRadius: BorderRadius.circular(8));
  }

  static BoxDecoration gradientbuttondecoration() {
    return BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            // Color(0xFFF98322), // Color code for #F98322
            // Color(0xFFEE4C46), // End color
                Color(0xFFAE62E8),
 Color(0xFF623089)
          ],
        ),
        borderRadius: BorderRadius.circular(5));
  }
  static BoxDecoration gradientchatbotbuttondecoration() {
    return BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
         Customcolors.lightpurple,
           Customcolors.darkpurple
          ],
        ),
        borderRadius: BorderRadius.circular(10));
  }
  
  static BoxDecoration menubuttondecoration() {
    return BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
          Customcolors.lightpurple,
          Customcolors.darkpurple
          ],
        ),
        borderRadius: BorderRadius.circular(15));
  }



    static BoxDecoration lightgradientborderdecoration(
      ) {
    return const BoxDecoration(
       gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 255, 208, 170),
              Color.fromARGB(255, 248, 177, 175),
            ],
          ),
        color: Colors.white);
  }

  static BoxDecoration addButtonDecoration() {
    return const BoxDecoration(
        border: GradientBoxBorder(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
            Customcolors.lightpurple,
           Customcolors.darkpurple,
            ],
          ),
        ),
        color: Colors.white,
        // boxShadow: const [
        //         BoxShadow(
        //           color: Customcolors.DECORATION_LIGHTGREY, //color of shadow
        //           spreadRadius: 2, //spread radius
        //           blurRadius: 2, // blur radius
        //           offset: Offset(0, 1),
        //         ),
        //       ],
        borderRadius: BorderRadius.all(Radius.circular(30)));
  }

  static BoxDecoration gradientborderdecoration(
      {radious = 5.0, borderwidth = 1.0}) {
    return BoxDecoration(
        border: GradientBoxBorder(
          width: borderwidth,
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
            Customcolors.lightpurple,
            Customcolors.darkpurple
            ],
          ),
        ),
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(radious)));
  }
  


   static BoxDecoration redborderdecoration(
      {radious = 30.0, borderwidth = 1.0}) {
    return BoxDecoration(
        border: GradientBoxBorder(
          width: borderwidth,
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 249, 34, 34),
              Color.fromARGB(255, 234, 117, 113),
            ],
          ),
        ),
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(radious)));
  }


   static BoxDecoration reddecoration(
      {radious = 30.0, borderwidth = 1.0}) {
    return BoxDecoration(
        border: GradientBoxBorder(
          width: borderwidth,
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 249, 34, 34),
              Color.fromARGB(255, 234, 117, 113),
            ],
          ),
        ),
        color: Customcolors.DECORATION_ERROR_RED,
        borderRadius: BorderRadius.all(Radius.circular(radious)));
  }


  static BoxDecoration greybuttondecoration() {
    return BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Customcolors.DECORATION_GREY,
            Customcolors.DECORATION_DARKGREY,
          ],
        ),
        borderRadius: BorderRadius.circular(30));
  }
  static BoxDecoration meatcartgreybuttondecoration({radious = 30.0, borderwidth = 1.0}) {
    return BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Customcolors.DECORATION_GREY,
            Customcolors.DECORATION_DARKGREY,
          ],
        ),
        borderRadius: BorderRadius.circular(30));
  }
}




BoxDecoration rotationBarShadwow() {
  return BoxDecoration(
      color: Customcolors.DECORATION_WHITE,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2), // Shadow color
          offset: const Offset(0, 4), // Horizontal offset: 0, Vertical offset: 4
          blurRadius: 5, // Blur radius
          spreadRadius: 2,
        )
      ]);
}






extension SizedBoxExtension on int {
  Widget get toHeight {
    return SizedBox(
      height: toDouble(),
    );
  }
}

extension WidthSzeExtension on int {
  Widget get toWidth {
    return SizedBox(
      width: toDouble(),
    );
  }
}
