// ignore_for_file: must_be_immutable, file_names

import 'package:testing/Features/Foodmodule/SubAdmincontroller/CreateOrdercontroller.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CancelOrderDetails extends StatefulWidget {
  dynamic orderid;
  dynamic resname;
  dynamic ordercode;
  dynamic status;

  CancelOrderDetails(
      {super.key,
      required this.orderid,
      required this.resname,
      required this.ordercode,
      required this.status});

  @override
  State<CancelOrderDetails> createState() => _CancelOrderDetailsState();
}

class _CancelOrderDetailsState extends State<CancelOrderDetails> {
  final Ordercontroller canceloorder = Get.put(Ordercontroller());
  int? _selectedValue; // No default selection
  String _comment = ""; // Comment for 'Other'
  final TextEditingController _commentController = TextEditingController();
  bool _isSubmitting = false;

  final List<String> _options = [
    'My order is taking longer than expected',
    'I accidentally placed the pre-order',
    'My coupon wasn’t applied to my order',
    'I am not in the location',
    'I changed my mind',
    'Other',
  ];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isOtherSelected = _selectedValue == _options.length - 1;
                final isCommentEmpty = _commentController.text.trim().isEmpty;
                final canCancel = _selectedValue != null &&
                    (!isOtherSelected || !isCommentEmpty);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Header with Back button and Restaurant Name
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
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
                            widget.resname
                                .toString()
                                .capitalizeFirst
                                .toString(),
                            style: CustomTextStyle.boldblack2,
                          ),
                        ),
                        const Spacer(),
                        widget.status == "initiated"
                            ? Text(
                                "Order Placed",
                                style: CustomTextStyle.orangeeetext,
                              )
                            : Text(
                                widget.status
                                    .toString()
                                    .capitalizeFirst
                                    .toString(),
                                style: CustomTextStyle.orangeeetext,
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

                    // Cancellation reason question
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

                    // Radio options
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: List.generate(_options.length, (index) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(_options[index],
                                style: CustomTextStyle.blacktext),
                            leading: Radio<int>(
                              activeColor: Customcolors.darkpurple,
                              value: index,
                              groupValue: _selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  _selectedValue = value!;
                                });
                              },
                            ),
                          );
                        }),
                      ),
                    ),

                    // Comment field if "Other" is selected
                    if (isOtherSelected)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Container(
                          height: 120,
                          width: constraints.maxWidth * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: TextField(
                              controller: _commentController,
                              maxLines: 5,
                              onChanged: (val) {
                                setState(() {
                                  _comment = val;
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

                    // Cancel Order Button
                    Center(
                      child: Opacity(
                        opacity: canCancel && !_isSubmitting ? 1.0 : 0.5,
                        child: Container(
                          width: constraints.maxWidth * 0.9,
                          decoration: canCancel && !_isSubmitting
                              ? CustomContainerDecoration
                                  .gradientbuttondecoration()
                              : CustomContainerDecoration
                                  .greybuttondecoration(),
                          child: ElevatedButton(
                            onPressed: canCancel && !_isSubmitting
                                ? () async {
                                    if (isOtherSelected && isCommentEmpty) {
                                      Get.snackbar(
                                        "Comment Required",
                                        "Please enter a comment for cancellation",
                                        backgroundColor: Colors.orange.shade100,
                                        colorText: Colors.black,
                                      );
                                      return;
                                    }

                                    setState(() {
                                      _isSubmitting = true;
                                    });

                                    String instructions = isOtherSelected
                                        ? _commentController.text.trim()
                                        : _options[_selectedValue!];

                                    await canceloorder.caancelorder(
                                      orderstatus: widget.status.toString(),
                                      orderid: widget.orderid,
                                      instructions: instructions,
                                    );

                                    setState(() {
                                      _isSubmitting = false;
                                    });

                                    // Optional: Navigate back or show success message
                                    // Get.back(); or Get.snackbar("Order Cancelled", "Your order has been cancelled");
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                            ),
                            child: _isSubmitting
                                ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: LoadingAnimationWidget.newtonCradle(
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                  )
                                : const Text(
                                    'Cancel Order',
                                    style: CustomTextStyle.loginbuttontext,
                                  ),
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
