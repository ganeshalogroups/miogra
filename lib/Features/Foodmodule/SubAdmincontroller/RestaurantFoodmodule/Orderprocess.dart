// ignore_for_file: file_names

import 'package:lottie/lottie.dart';
import 'package:testing/Features/Bottomsheets/Adduserbottomsheet.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Ordersucess.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Orderprocess extends StatefulWidget {
  const Orderprocess({super.key});

  @override
  State<Orderprocess> createState() => _OrderprocessState();
}

class _OrderprocessState extends State<Orderprocess> {
  @override
  void initState() {
    super.initState();


    // Set a timer for 1 minute (60 seconds)
    Future.delayed(const Duration(milliseconds: 5200), () {
      // Navigate to the next screen

      var clearall = Provider.of<InstantUpdateProvider>(context,listen: false);

        orderForSomeOneName  = '';
        orderForSomeOnePhone = '';
        clearall.upDateInstruction(instruction: '');
        clearall.updateSomeOneDetaile(someOneName: '',someOneNumber: '');
        
        Future.delayed(Duration.zero,() => getStorage.write(gRestaurantId,''));
        Get.off(const OrderCreatedDoneScreen(),transition: Transition.upToDown);
        
    });
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200.0.h, // specify the desired height
                     child: Image.asset("assets/images/Foodorderprocess.gif",//color: Color(0xFF623089)
 ),
//child: Lottie.asset("assets/animations/Animation - 1750337762812 1.json"),
                  ),
                  const Text(
                    "Order process..",
                    style: CustomTextStyle.boldblack,
                  ),
                  const SizedBox(height: 5.0), // space between texts
                  const Text(
                    "Wait a moment, Your order is",
                    style: CustomTextStyle.chipgrey,
                  ),
                   const Text(
                    "being processed!",
                  style: CustomTextStyle.chipgrey,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}