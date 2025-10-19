// ignore_for_file: file_names

import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:flutter/material.dart';

class Nodataavailablescreen extends StatefulWidget {
  const Nodataavailablescreen({super.key});

  @override
  State<Nodataavailablescreen> createState() => _NodataavailablescreenState();
}

class _NodataavailablescreenState extends State<Nodataavailablescreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
    body: Column(mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(image: AssetImage("assets/images/Coming Soon.gif")),
        Text("Stay Tuned!",   style: CustomTextStyle.boldblack,)
      ],
    ),
    );
  }
}