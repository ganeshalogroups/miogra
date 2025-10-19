// ignore_for_file: file_names

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:get/get.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/Getnearbyrescontroller.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';

class RotatingTextWidget extends StatelessWidget {
  final List<String> textList;
  final Duration pauseDuration;
  final VoidCallback? onTap;

  const RotatingTextWidget({
    super.key,
    required this.textList,
    this.pauseDuration = const Duration(milliseconds: 300),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      isRepeatingAnimation : true,
      repeatForever        : true,
      pause                : pauseDuration,
      animatedTexts        : textList.map((text) => RotateAnimatedText(
                 text,
                 textStyle: CustomTextStyle.regulargrey,
              )).toList(),
      onTap: onTap,
    );
  }
}








class SearchForBarWidget extends StatelessWidget {
  final List<String> rotationTexts;
  final VoidCallback? texttap;
  final VoidCallback onTap;

  const SearchForBarWidget({
    super.key,
    required this.rotationTexts,
     this.texttap,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
     Nearbyrescontroller nearbyreget = Get.put(Nearbyrescontroller());
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: rotationBarShadwow(),
          width: MediaQuery.of(context).size.width * 0.9,
        child: AbsorbPointer(
          absorbing: true,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: null,
              hintStyle: CustomTextStyle.formfieldtext,
              border: InputBorder.none,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.search,
                      color: Customcolors.DECORATION_BLACK,
                    ),
                    const SizedBox(width: 8), // Space between the icon and the text
                    const Text(
                      'Search for ',
                      style: CustomTextStyle.regulargrey,
                    ),
                    RotatingTextWidget(
                      textList:  nearbyreget.selectedIndex.value==0?   rotationTexts:rotationTextsMartFlow,
                    ),
                  ],
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
            ),
          ),
        ),
      ),
    );
  }
}
