
// ignore_for_file: must_be_immutable, duplicate_ignore, file_names

import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:flutter/material.dart';



class ReusableRedButton extends StatelessWidget {

final VoidCallback ontap;
String buttonName;
double height ;

   ReusableRedButton({super.key,required this.buttonName,this.height = 45,required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: height,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: CustomContainerDecoration.gradientbuttondecoration(),
        child: Center(
          child: Text(
            buttonName,
            style: CustomTextStyle.smallwhitetext,
          ),
        ),
      ),
    );
  }
}


class ReusablegreyButton extends StatelessWidget {

final VoidCallback ontap;
String buttonName;
double height ;

   ReusablegreyButton({super.key,required this.buttonName,this.height = 45,required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: height,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: CustomContainerDecoration.greybuttondecoration(),
        child: Center(
          child: Text(
            buttonName,
            style: CustomTextStyle.smallwhitetext,
          ),
        ),
      ),
    );
  }
}