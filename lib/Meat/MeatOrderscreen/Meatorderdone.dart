// ignore_for_file: file_names

import 'package:testing/Meat/Homepage/Meathomepage.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatOrderHistoryTabbar/MeatOrdersTab.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/exitapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Meatordercreatedonescreen extends StatefulWidget {
  const Meatordercreatedonescreen({super.key});

  @override
  State<Meatordercreatedonescreen> createState() => _MeatordercreatedonescreenState();
}

class _MeatordercreatedonescreenState extends State<Meatordercreatedonescreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async{
           if (didPop) return;
            // await ExitApp.homepop();
      },
      child: Scaffold(
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  CustomContainer(
                    height: MediaQuery.of(context).size.height / 2,
                    child: const Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomContainer(
                            height: 150,
                            child: Center(
                                child: Image(image: AssetImage("assets/images/order.png"))),
                                   
                          ),
                        ]),
                  ),
                  const CustomSizedBox(),
                  const Text(
                    "Order successful",
                    style: CustomTextStyle.boldblack,
                  ),
                  CustomSizedBox(
                    height: 5.h,
                  ),
                  const Text(
                    "Cool down, your meat will arrive\n in 25 minutes.",
                    style: CustomTextStyle.chipgrey,
                    textAlign: TextAlign.center,
                  ),
                  const CustomSizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: InkWell(
     
                      onTap: () async {
                       
 
                            await Get.off(Meathomepage(meatproductcategoryid: meatproductCateId,));
 
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

                  CustomSizedBox(
                    height: 12.h,
                  ),

                    InkWell(
                      onTap: () {
                        Get.to(const MeatOrderTab());
                    },

                    child: CustomContainer(
                      width: MediaQuery.of(context).size.width / 2,
                      decoration:
                          CustomContainerDecoration.gradientborderdecoration(),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.location_on_rounded,
                                color: Customcolors.darkpurple,
                              ),
                              Text( "Track Order", style: CustomTextStyle.decorationORANGEtext),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
 
  }
}


