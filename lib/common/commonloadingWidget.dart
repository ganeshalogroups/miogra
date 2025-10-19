// ignore_for_file: file_names

import 'package:testing/utils/Containerdecoration.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// ignore: must_be_immutable
class ReusableLoadingDummyButton extends StatelessWidget {

  double heighht;
   ReusableLoadingDummyButton({super.key, this.heighht = 45.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heighht,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: CustomContainerDecoration.gradientbuttondecoration(),
      child: Center(
        child: LoadingAnimationWidget.newtonCradle(
          color: Colors.white,
          size: 70,
        ),
      ),
    );
  }
}
