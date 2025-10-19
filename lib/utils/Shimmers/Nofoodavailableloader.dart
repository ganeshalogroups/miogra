// ignore_for_file: file_names

import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Nofoodavailable extends StatelessWidget {
  const Nofoodavailable({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "assets/images/nofoodavailable.gif",
          height: 100.h,
          filterQuality: FilterQuality.high,
        ),
        const Text("No Food Available !",style: CustomTextStyle.blacktext,)
      ],
    );
  }
}
