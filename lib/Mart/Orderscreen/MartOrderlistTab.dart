
// ignore_for_file: must_be_immutable, file_names

import 'dart:async';
import 'package:testing/Mart/Orderscreen/MartOrderstatus.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/CustomDottedline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MartorderlistTab extends StatefulWidget {
bool isFromHome;
MartorderlistTab({super.key,this.isFromHome =false});

  @override
  State<MartorderlistTab> createState() => _MartorderlistTabState();
}

class _MartorderlistTabState extends State<MartorderlistTab> {
Timer? timer; // Timer for countdown

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel(); 
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return ListView.separated(
            itemCount: 3,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
    
    
    
              return Column(
                children: [
                  InkWell(
                  onTap: () {
                   Get.to(const MartOrderstatus());
                  },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Customcolors.DECORATION_LIGHTGREY, //color of shadow
                            spreadRadius: 5, //spread radius
                            blurRadius: 7, // blur radius
                            offset: Offset(0, 2),
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 15),
                              child: Text(
                                "Processing",
                                style: CustomTextStyle.yellowtext,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width/2.2.w,
                                  child: const Text(
                                    "Time Pass Restaurant",
                                    style: CustomTextStyle.boldblack2,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                              
                               const Text("17 Apr 2024 at 9.08pm", style: CustomTextStyle.smallgrey)
                             
                              ],
                            ),
                            const SizedBox(height: 20),
                            CustomPaint(
                              size: Size(MediaQuery.of(context).size.width / 1,20), // Adjust size here
                              painter: DottedLinePainter(),
                            ),
                            ListView.builder(
                              itemCount: 2,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, ind) {
                                return const Row(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 6),
                                      child: SizedBox(
                                      width: 260,
                                        child: Text(
                                          "1 X Indian Tomato",
                                          style: CustomTextStyle.noboldblack,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                            CustomPaint(
                              size: Size(MediaQuery.of(context).size.width / 1, 20), // Adjust size here
                              painter: DottedLinePainter(),
                            ),
    
    
                          
    
    
    
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                    
                    
                                const Row(
                                  children: [
                                    Text("₹300.00",
                                    style: CustomTextStyle.black14bold,),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(Icons.arrow_forward_ios,
                                        color: Customcolors.DECORATION_BLACK,
                                        size: 15)
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                    
                                  },
                                  child: CustomContainer(
                                    decoration: CustomContainerDecoration.gradientbuttondecoration(),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 20),
                                      child: Center(
                                        child: Text(
                                          "Track Order",
                                          style: CustomTextStyle.smallwhitetext,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10),
          );
  }
}


