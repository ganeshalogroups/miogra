import 'dart:math';

import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

class Viewrestaurantloader extends StatelessWidget {
  const Viewrestaurantloader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(
        height: 180.0.h,
       child: Lottie.asset("assets/animations/Loading animation.json"),
        // child: Lottie.asset("assets/animations/Loading animation blue.json"),
      ),
      const SizedBox(height: 16),
      Text(
        "Fetching delicious dishes for you",
        style: CustomTextStyle.addbtn,
        textAlign: TextAlign.center,
      ),
    ],
  ),
);

  }
}

class Notdeliverable extends StatelessWidget {
  const Notdeliverable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
  padding: const EdgeInsets.all(12),
  decoration: BoxDecoration(
    color: Colors.orange.shade100, // light orange background
    borderRadius: BorderRadius.circular(12),
  ),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Left side: Column with red badge and message
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Red badge with white text
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Customcolors.DECORATION_ERROR_RED,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Not deliverable',
                style: CustomTextStyle.font10blackreg,
              ),
            ),
            const SizedBox(height: 8),
            // Message text below badge
            const Text(
              'We cannot deliver to your location as it’s beyond the restaurant’s delivery zone.',
              style: CustomTextStyle.midbold
            ),
          ],
        ),
      ),

      const SizedBox(width: 12),

      // Right side: Image
      SizedBox(
        width: 60,
        // height: 65,
        child: Image.asset(
          'assets/images/no-route.png', // replace with your image path
          fit: BoxFit.contain,
        ),
      ),
    ],
  ),
);

  }
}



class LoadingWithRandomText extends StatefulWidget {
  const LoadingWithRandomText({super.key});

  @override
  State<LoadingWithRandomText> createState() => _LoadingWithRandomTextState();
}

class _LoadingWithRandomTextState extends State<LoadingWithRandomText> {
  late final String message;

final List<String> loadingMessages = [
  'Just a moment while we plate your perfect meal',
  'Bringing together flavors you’re going to love',
  'We’re preparing something truly delicious for you',
  'Hold tight while we find your next favorite dish',
  'Great food takes time and yours is almost ready',
  'Searching nearby kitchens for the best bites',
  'Whipping up your order with extra care and taste',
  'Your cravings are being crafted into reality',
  'Curating a menu full of mouth-watering choices',
  'Getting everything ready for a flavorful experience',
];


  @override
  void initState() {
    super.initState();
    message = loadingMessages[Random().nextInt(loadingMessages.length)];
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LoadingAnimationWidget.inkDrop(
          color:Customcolors.darkpurple,
          size: 40,
        ),
        const SizedBox(height: 25),
        SizedBox(
        width: MediaQuery.of(context).size.width/1.2,
          child: Text(
            message,
            style: CustomTextStyle.black13B,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}