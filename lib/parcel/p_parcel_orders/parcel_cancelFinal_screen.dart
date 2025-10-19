// ignore_for_file: file_names

import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/exitapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ParcelCancelFinalScreen extends StatefulWidget {
  const ParcelCancelFinalScreen({super.key});

  @override
  State<ParcelCancelFinalScreen> createState() => _ParcelCancelFinalScreenState();
}

class _ParcelCancelFinalScreenState extends State<ParcelCancelFinalScreen> {
  @override
   @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async{
           if (didPop) return;
           //  await ExitApp.homepop();
      },
      child: Scaffold(
        body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column( 
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      const Image(
                  image:  AssetImage("assets/images/Cancelorder.gif"),
                  height: 100
                ),
                    const CustomSizedBox(height: 25,),
                    const Text(
                      "your order has been cancelled",
                      style: CustomTextStyle.boldblack,
                    ),
                    CustomSizedBox(
                      height: 10.h,
                    ),
                      Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: InkWell(
                   
                        onTap: () async {
                         
                             
                              await ExitApp.parcelHome();
                             
                        },
                        child: CustomContainer(
                          width: MediaQuery.of(context).size.width / 2,
                          decoration:
                              CustomContainerDecoration.gradientbuttondecoration(),
                          child: const Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.home,
                                    color: Customcolors.DECORATION_WHITE,
                                  ),
                                  Text(
                                    "Back to home",
                                    style: CustomTextStyle.smallwhitetext,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                            
                    const CustomSizedBox(
                      height: 20,
                    ),],
                ),
              ),
            )),
      ),
    );
  }

}