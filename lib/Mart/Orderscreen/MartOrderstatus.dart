// ignore_for_file: file_names

import 'package:testing/Mart/Orderscreen/MartOrderdetailsview.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MartOrderstatus extends StatefulWidget {
  const MartOrderstatus({super.key});

  @override
  State<MartOrderstatus> createState() => _MartOrderstatusState();
}

class _MartOrderstatusState extends State<MartOrderstatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Customcolors.DECORATION_CONTAINERGREY,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start (left) of the column
                  
              children: [

                Row(

                  mainAxisAlignment: MainAxisAlignment.start, // Align children to the start (left) of the row
                      
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Customcolors.DECORATION_BLACK,
                      ),
                    ), 
                    const SizedBox(width: 13), // Add some space between the icon and text
                       
                    SizedBox(
                      width: MediaQuery.of(context).size.width/1.8,
                      child: const Text(
                        "Time Pass Restaurant",
                        style: CustomTextStyle.boldblack2,
                        overflow: TextOverflow.clip,
                      ),
                    ),


                    const Spacer(),
                    const Text(
                      "delivered",
                      style: 
                      // widget.status == "delivered"
                          // ? CustomTextStyle.greenordertext
                          // : widget.status == "cancelled"
                          //     ? CustomTextStyle.redmarktext  : 
                              CustomTextStyle.yellowordertext,
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 36, top: 10),
                  child: Text(
                    "82b/2 , Grown street, Vetturnimadam, \nKrishnan Kovil, Nagercoil.",
                    style: CustomTextStyle.mapgrey,
                  ),
                ),
               const MartOrderDetailsview(
               ),
    //             if (widget.status == "cancelled" &&  widget.paymentMethod == "online payment" &&   widget.paymentStatus != "refund")
                  
    //               refund.isrefundLoading.isTrue
    //                   ? CustomContainer(
    //                       width: MediaQuery.of(context).size.width / 3,
    //                       height: 40,
    //                       decoration: CustomContainerDecoration
    //                           .gradientbuttondecoration(),
    //                       child: const Padding(
    //                         padding: EdgeInsets.symmetric(
    //                             vertical: 3, horizontal: 20),
    //                         child: Center(
    //                           child: Text(
    //                             "Loading..",
    //                             style: CustomTextStyle.smallwhitetext,
    //                           ),
    //                         ),
    //                       ),
    //                     )
    //                   : InkWell(
    //                       onTap: () {
    //                         refund.sendrefund(
    //                             amount: 100, paymentId: widget.razorpaymentId);
    //                       },
    //                       child: CustomContainer(
    //                         width: MediaQuery.of(context).size.width / 3,
    //                         height: 40,
    //                         decoration: CustomContainerDecoration
    //                             .gradientbuttondecoration(),
    //                         child: const Padding(
    //                           padding: EdgeInsets.symmetric(
    //                               vertical: 3, horizontal: 20),
    //                           child: Center(
    //                             child: Text(
    //                               "Refund",
    //                               style: CustomTextStyle.smallwhitetext,
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                     )
             
    //            else if (widget.paymentStatus == "refund" &&  widget.status == "cancelled" && widget.paymentMethod == "online payment"||widget.paymentStatus == "refund" && widget.status == "rejected" && widget.paymentMethod == "online payment")
                  
    //               Column(
    //                 children: [
    //                   Padding(
    //                     padding: const EdgeInsets.symmetric(horizontal: 16),
    //                     child: AnotherStepper(
    //                       stepperList: _buildStepperData(),
    //                       stepperDirection: Axis.vertical,
    //                       iconWidth: 20,
    //                       iconHeight: 20,
    //                       activeBarColor: _activeIndex == 3
    //                           ? Colors.green
    //                           : Customcolors.darkpurple,
    //                       inActiveBarColor: Customcolors.DECORATION_GREY,
    //                       inverted: false,
    //                       verticalGap: 12,
    //                       activeIndex: _activeIndex,
    //                       barThickness: 1,
    //                     ),
    //                   ),
    //                    Container(
    //                               width:
    //                                   MediaQuery.of(context).size.width * 0.9,
    //                               padding: const EdgeInsets.all(8.0),
    //                               decoration: BoxDecoration(
    //                                 color: Colors
    //                                     .red[100], // Optional: background color
    //                                 borderRadius: BorderRadius.circular(
    //                                     8), // Rounded corners
    //                               ),
    //                               child: Text(
    //                                 "Refunds are processed within 7 to 10 business days after approval.",
    //                                 style: CustomTextStyle.rederrortext,
    //                                 textAlign: TextAlign
    //                                     .center, // Centers the text horizontally
    //                               ),
    //                             ),
                   
    //                 ],
    //               ),
                              
    //               widget.status == "delivered"

    // ? 
    Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Aligns items in the center
              children: [
                const Text(
                  "Rate Order",
                  style: CustomTextStyle.oRANGEtext,
                ),
                const SizedBox(width: 20), 
                  InkWell(
                    onTap: () {
                    },
                    child: CustomContainer(
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: CustomContainerDecoration.gradientbuttondecoration(),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Download Invoice",
                              style: CustomTextStyle.smallwhitetext,
                            ),
                            Icon(
                              Icons.download,
                              color: Customcolors.DECORATION_WHITE,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const CustomSizedBox(height: 5),
            // You can add any additional widgets here
          ],
        ),
      )
    // : const SizedBox()

              ],
            ),
          ),
        ),
      ),
    );
 
  
  }
}