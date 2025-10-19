// ignore_for_file: file_names

import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:flutter/cupertino.dart';

class BlueBoxForBottomSheet extends StatelessWidget {
  const BlueBoxForBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Container(
        width: double.infinity,
        // height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: const Color.fromARGB(255, 230, 245, 254),
            border: Border.all(
              color: const Color.fromARGB(255, 1, 151, 244),
            )),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child:  Text(
            "A detailed address will help our Delivery Partner reach your doorstep easily",
            style: CustomTextStyle.adressblue
            // TextStyle(color: Customcolors.DECORATION_BLUE),
          ),
        ),
      ),
    );
  }
}
