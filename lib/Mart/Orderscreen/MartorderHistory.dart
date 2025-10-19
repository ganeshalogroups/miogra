
// ignore_for_file: file_names

import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/CustomDottedline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class MartOrderHistory extends StatefulWidget {
  const MartOrderHistory({super.key});

  @override
  State<MartOrderHistory> createState() => _MartOrderHistoryState();
}

class _MartOrderHistoryState extends State<MartOrderHistory> {

  @override
  void initState() {
    super.initState();
  }



  @override
  void dispose() {
    // ordercntoller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
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
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Text(
                      "Delivered",
                      style:
                      // orders['orderStatus']== "delivered"
                      // ? CustomTextStyle.greenordertext : 
                      CustomTextStyle.redmarktext
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
                        ),
                      ),
                      const Text("17 Apr 2024 at 9.08pm",
                          style: CustomTextStyle.smallgrey)
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomPaint(
                    size: Size(MediaQuery.of(context).size.width / 1,20), // Adjust size here
                    painter: DottedLinePainter(),
                  ),
                  ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return const Row(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                             
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 6),
                            child: SizedBox(
                              width: 260,
                              child: Text(
                                "1 X Chicken Biryani Masala",
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
                    size: Size(MediaQuery.of(context).size.width / 1,20), // Adjust size here
                    painter: DottedLinePainter(),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text("₹ 300.00",
                           style: CustomTextStyle.black14bold,
                           ),
      
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.arrow_forward_ios,
                              color: Customcolors.DECORATION_BLACK,
                              size: 15)
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
          
  }
  Widget _buildNoDataScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         const CustomSizedBox(height: 80,),
          Image.asset("assets/images/empty order.png",height: 200,),
           const CustomSizedBox(height: 40,),
          const Text("No Orders History Available", style: CustomTextStyle.googlebuttontext),
          const Text("No Orders yet Delivered/Cancelled.", style: CustomTextStyle.blacktext)
        ],
      ),
    );
  }
}
String formatDate({required String dateStr}) {
  
  DateTime dateTime = DateTime.parse(dateStr);
  dateTime = dateTime.add(const Duration(hours: 5, minutes: 30));
  String formattedDate =  DateFormat("d MMM yyyy 'at' h:mma").format(dateTime).toLowerCase();
  
  return formattedDate;
}