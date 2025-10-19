
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:flutter/material.dart';

class Cancelorderprogressingscreen extends StatefulWidget {
  const Cancelorderprogressingscreen({super.key});

  @override
  State<Cancelorderprogressingscreen> createState() =>
      _CancelorderprogressingscreenState();
}

class _CancelorderprogressingscreenState
    extends State<Cancelorderprogressingscreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image: const AssetImage("assets/images/Progressing.gif"),
                  height: MediaQuery.of(context).size.height /
                      2.1, // Adjust the height as needed
                ),
                const CustomSizedBox(),
                const Center( // Wrap the Text widget with Center
                    child: Text(
                      "Note: A slight delay may occur if your order is accepted by the restaurant before we get your cancellation!",
                      textAlign: TextAlign.center, // Optional: center-aligns the text
                      style: CustomTextStyle.notetext,
                    ),
                  ),
                const Center( // Wrap the Text widget with Center
                    child: Text(
                      "Almost there! We're tracking your order status right now!",
                      textAlign: TextAlign.center, // Optional: center-aligns the text
                      style: CustomTextStyle.blackB12,
                    ),
                  ),
                const CustomSizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
