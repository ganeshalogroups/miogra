// ignore_for_file: must_be_immutable

import 'package:testing/Features/Foodmodule/SubAdmincontroller/CreateOrdercontroller.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MeatCancelOrderDetails extends StatefulWidget {
dynamic orderid;
dynamic resname;
dynamic ordercode;
dynamic status;

 MeatCancelOrderDetails({super.key,required this.orderid,required this.resname,required this.ordercode,required this.status});

  @override
  State<MeatCancelOrderDetails> createState() => MeatCancelOrderDetailsState();
}

class MeatCancelOrderDetailsState extends State<MeatCancelOrderDetails> {
  Ordercontroller canceloorder = Get.put(Ordercontroller());
  int _selectedValue = 0; // Tracks the selected radio button value
  String _comment = "";   // Stores the typed comment from the TextField

  final List<String> _options = [
    'My order is taking longer than expected',
    'I accidently placed the pre-order',
    'My coupon wasn’t applied to my order',
    'I am not in the location',
    'I changed my mind',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with Back button and Restaurant Name
                    Row(
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
                        const SizedBox(width: 13),
                        Flexible(
                          child: Text(
                            widget.resname.toString().capitalizeFirst.toString(),
                            style: CustomTextStyle.boldblack2,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          widget.status.toString().capitalizeFirst.toString(),
                          style: CustomTextStyle.yellowordertext,
                        ),
                      ],
                    ),
                    // Order ID
                    Padding(
                      padding: const EdgeInsets.only(left: 36, top: 12),
                      child: Text(
                        "Order ID: ${widget.ordercode}",
                        style: CustomTextStyle.mapgrey,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Question about cancellation reason
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Why do you want to cancel your order?",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Customcolors.DECORATION_BLACK,
                          fontFamily: 'Poppins-Regular',
                        ),
                      ),
                    ),
                    // List of radio buttons for reasons
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: List.generate(_options.length, (index) {
                          return Row(
                            children: [
                              Radio<int>(
                                activeColor: Customcolors.darkpurple,
                                value: index,
                                groupValue: _selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedValue = value!;
                                  });
                                },
                              ),
                              Flexible(child: Text(_options[index])),
                            ],
                          );
                        }),
                      ),
                    ),
                    // TextField appears when "Other" is selected
                    if (_selectedValue == _options.length - 1)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Container(
                          height: 120,
                          width: constraints.maxWidth * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color.fromARGB(255, 128, 128, 128),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: TextField(
                              maxLines: 5,
                              onChanged: (val) {
                                setState(() {
                                  _comment = val; // Update comment
                                });
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: ' Comment',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                    // Cancel Order button
                    Center(
                      child: Container(
                        width: constraints.maxWidth * 0.9,
                        decoration: CustomContainerDecoration
                            .gradientbuttondecoration(),
                        child: ElevatedButton(
                          onPressed: () {
                            // Determine whether to use the selected radio button text or the typed comment
                            String instructions = _selectedValue == _options.length - 1
                                ? _comment // Use comment if "Other" is selected
                                : _options[_selectedValue]; // Otherwise, use selected reason

                            // Call the cancel order function with the order ID and instructions
                            canceloorder.caancelorder(
                            isfrommeat: true,
                            orderstatus:  widget.status.toString(),
                              orderid: widget.orderid, 
                              instructions: instructions,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                          child: const Text(
                            'Cancel Order',
                            style: CustomTextStyle.loginbuttontext,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}