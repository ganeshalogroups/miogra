
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ParcelCancelorderprogressingscreen extends StatefulWidget {
  const ParcelCancelorderprogressingscreen({super.key});

  @override
  State<ParcelCancelorderprogressingscreen> createState() =>
      _ParcelCancelorderprogressingscreenState();
}

class _ParcelCancelorderprogressingscreenState
    extends State<ParcelCancelorderprogressingscreen> {
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
              LottieBuilder.asset(
                    'assets/animations/cancel order animation.json',
                    height: MediaQuery.of(context).size.height / 4,
                  ),
                


                30.toHeight,
                const CustomSizedBox(),
                const Center( 
                    child: Text(
                      "Note: A slight delay may occur in processing your cancellation if the parcel has already been picked up or is in transit!",
                      textAlign: TextAlign.center, // Optional: center-aligns the text
                      style: CustomTextStyle.notetext,
                    ),
                  ),
                  10.toHeight,
                const Center( 
                    child:  Text(
                      "Almost there! We're tracking your order status right now!",
                      textAlign: TextAlign.center, // Optional: center-aligns the text
                      style: CustomTextStyle.blackB12,
                    ),
                  ),

                  20.toHeight,
              
              ],
            ),
          ),
        )),
      ),
    );
  }
}
