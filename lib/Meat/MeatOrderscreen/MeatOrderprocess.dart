// ignore_for_file: file_names
import 'package:testing/Meat/MeatOrderscreen/Meatorderdone.dart';
import 'package:testing/Meat/MeatOrderscreen/meatadditionalinfo.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MeatOrderprocess extends StatefulWidget {
  const MeatOrderprocess({super.key});

  @override
  State<MeatOrderprocess> createState() => _MeatOrderprocessState();
}

class _MeatOrderprocessState extends State<MeatOrderprocess> {
  @override
  void initState() {
    super.initState();


    // Set a timer for 1 minute (60 seconds)
    Future.delayed(const Duration(milliseconds: 5200), () {
      // Navigate to the next screen

      var clearall = Provider.of<MeatInstantUpdateProvider>(context,listen: false);

        meatorderForSomeOneName  = '';
        meatorderForSomeOnePhone = '';
        clearall.meatupDateInstruction(instruction: '');
        clearall.meatupdateSomeOneDetaile(someOneName: '',someOneNumber: '');
        
        Future.delayed(Duration.zero,() => getStorage.write(gRestaurantId,''));
        Get.off(const Meatordercreatedonescreen(),transition: Transition.upToDown);
        
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
                    child: Image.asset("assets/meat_images/meatloading.gif"),
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