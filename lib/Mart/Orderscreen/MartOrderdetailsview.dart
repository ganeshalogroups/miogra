
// ignore_for_file: file_names

import 'package:testing/Features/OrderScreen/Orderstatus.dart';
import 'package:testing/map_provider/Map%20Screens/markervaluse.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/CustomDottedline.dart';
import 'package:flutter/material.dart';

class MartOrderDetailsview extends StatefulWidget {

  const MartOrderDetailsview({super.key});

  @override
  State<MartOrderDetailsview> createState() => _MartOrderDetailsviewState();
}
class _MartOrderDetailsviewState extends State<MartOrderDetailsview> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Customcolors.DECORATION_WHITE,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Text(
                    "Deliver to",
                    style: CustomTextStyle.smallblacktext,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 5),
                    addressicon(image: workicon),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Home",
                            style: CustomTextStyle.boldblack2,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "82b/2, Grown street, Vetturnimadam, \nKrishnan Kovil, Nagercoil.",
                              maxLines: null,
                              style: CustomTextStyle.chipgrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Customcolors.DECORATION_WHITE,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Order Details', style: CustomTextStyle.minblacktext),
              CustomSizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Order ID', style: CustomTextStyle.carttblack),
                  Text("#325481278", style: CustomTextStyle.carttblack),
                ],
              ),
              CustomSizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Order Date', style: CustomTextStyle.carttblack),
                  Text("20.05.2024", style: CustomTextStyle.carttblack),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Payment Method', style: CustomTextStyle.carttblack),
                  Text("Cash on Delivery", style: CustomTextStyle.carttblack),
                ],
              ),
            ],
          ),
        ),
        const CustomSizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Customcolors.DECORATION_WHITE,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Bill Summary', style: CustomTextStyle.minblacktext),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: const Text(
                        "1 X Chicken Biryani Masala",
                        style: CustomTextStyle.noboldblack,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              CustomPaint(
                size: Size(MediaQuery.of(context).size.width, 20),
                painter: DottedLinePainter(),
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Item Total', style: CustomTextStyle.carttblack),
                  Text("₹ 300.00", style: CustomTextStyle.carttblack),
                ],
              ),
              const CustomSizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('GST', style: CustomTextStyle.carttblack),
                  Text("₹ 16.00", style: CustomTextStyle.carttblack),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Delivery partner fee (up to 10 km)', style: CustomTextStyle.carttblack),
                  Text("₹ 10.00", style: CustomTextStyle.carttblack),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Packaging Charge', style: CustomTextStyle.carttblack),
                  Text("₹ 10.00", style: CustomTextStyle.carttblack),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Coupon Discount', style: CustomTextStyle.carttblack),
                  Text(
                    "-₹125.00",
                    style: TextStyle(
                      fontSize: 13,
                      color: Customcolors.darkpurple,
                      fontFamily: 'Poppins-Regular',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomPaint(
                size: Size(MediaQuery.of(context).size.width, 20),
                painter: DottedLinePainter(),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Grand Total', style: CustomTextStyle.carttblack),
                  Text(
                    "₹ 191.00",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Customcolors.DECORATION_BLACK,
                      fontFamily: 'Poppins-Regular',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const CustomSizedBox(height: 10),
      ],
    );
  }
}
