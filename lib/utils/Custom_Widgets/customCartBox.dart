// ignore_for_file: file_names

import 'package:testing/utils/Buttons/CustomIconBtn.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';

class CustomCartBox extends StatelessWidget {
  final VoidCallback checkOut;
  final VoidCallback clearCart;
  final VoidCallback viewResturant;
  final String itemCount;
  final dynamic price;
  final String restName;
  final String resImage;

  const CustomCartBox({
    super.key,
    required this.checkOut,
    required this.clearCart,
    required this.viewResturant,
    required this.itemCount,
    required this.price,
    required this.resImage,
    required this.restName,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Container(
      height: screenHeight * 0.09, // 10% of screen height for responsive height
      width: screenWidth, // Full width
      padding:EdgeInsets.all(screenWidth * 0.02), // Padding relative to screen size
      decoration: CustomContainerDecoration.boxshadowdecoration(),
      child: Row(
        children: [
          Row(
            children: [
              Container(
                height: screenHeight * 0.08,
                width: screenHeight * 0.08,
                decoration: BoxDecoration(
                  image: DecorationImage( image: NetworkImage(resImage), fit: BoxFit.fitHeight),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),

              SizedBox(width: screenWidth * 0.02), // Responsive spacing
              GestureDetector(
                onTap: viewResturant,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenWidth *0.25, // 25% of screen width for restaurant name
                      child: Text(
                        restName,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyle.cartBoxHeading,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.005), // Small vertical spacing
                    const Text(
                      'View Full Menu',
                      style: CustomTextStyle.cartBoxsubHeading,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              InkWell(
                onTap: checkOut,
                child: IntrinsicHeight(
                  // Ensures the height adjusts based on the content
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth *  0.03, // Padding relative to screen width
                      vertical: screenHeight * 0.008, // Adjusted padding for responsiveness
                    ),
                    decoration: BoxDecoration(
                      color: Customcolors.CatBtnGreen,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment:MainAxisAlignment.center, // Center-align content
                      children: [
                        Text(
                          '$itemCount item | ₹$price',
                          style: CustomTextStyle.font10blackreg,
                          overflow: TextOverflow.ellipsis, // Handle overflow in a responsive way
                          textAlign: TextAlign.center, // Ensure text is centered
                        ),
                        // SizedBox(height: screenHeight * 0.005), // Add a small space between text
                        const Text(
                          'Checkout',
                          style: CustomTextStyle.minwhite11,
                          textAlign: TextAlign.center, // Ensure text is centered
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              10.toWidth,
              InkWell(
                onTap: clearCart,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 3,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xffFDE6E6),
                  ),
                  child: closeIcon(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
