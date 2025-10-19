// ignore_for_file: must_be_immutable, file_names

import 'package:testing/Features/OrderScreen/Orderstatus.dart';
import 'package:testing/map_provider/Map%20Screens/markervaluse.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/CustomDottedline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailsview extends StatefulWidget {
  dynamic orderId;
  dynamic delivaryAddresstype;
  dynamic delivaryAddress;
  dynamic orderDate;
  dynamic km;
  dynamic paymentMethod;
  dynamic itemTotal;
  dynamic gst;
  dynamic delivaryFee;
  dynamic couponDiscount;
  dynamic grandtotal;
  List<dynamic>? orderdetails;
  dynamic couponType;
  dynamic packagingCharge;
  OrderDetailsview({super.key,
  this.couponDiscount,
    required this.packagingCharge,
    this.delivaryAddress,
    this.delivaryAddresstype,
    this.delivaryFee,
    this.grandtotal,
    this.km,
    this.gst,
    this.itemTotal,
    this.orderDate,
    this.orderId,
    this.paymentMethod,
    this.orderdetails,
    this.couponType,});

  @override
  State<OrderDetailsview> createState() => _OrderDetailsviewState();
}

class _OrderDetailsviewState extends State<OrderDetailsview> {
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Text(
                              "Deliver to",
                              style: CustomTextStyle.smallblacktext,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              widget.delivaryAddresstype == 'Home'
                                  ? addressicon(image: homeicon)
                                  : widget.delivaryAddresstype == 'Other' ||
                                          widget.delivaryAddresstype ==
                                              'Current' ||
                                          widget.delivaryAddresstype ==
                                              'Selected'
                                      ? addressicon(image: othersicon)
                                      : addressicon(image: workicon),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.delivaryAddresstype,
                                      style: CustomTextStyle.boldblack2,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${widget.delivaryAddress}",
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
                    )),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Customcolors
                        .DECORATION_WHITE, // Set your desired background color

                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Order Details',
                        style: CustomTextStyle.minblacktext,
                      ),
                      const CustomSizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Order ID',
                            style: CustomTextStyle.carttblack,
                          ),
                          // Spacer(),
                          Text(
                            "${widget.orderId}",
                            style: CustomTextStyle.carttblack,
                          )
                        ],
                      ),
                      const CustomSizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                                right:
                                    16), // Adjust the right padding as needed
                            child: Text(
                              'Order Date',
                              style: CustomTextStyle.carttblack,
                            ),
                          ),
                          Text(
                            "${widget.orderDate}",
                            style: CustomTextStyle.carttblack,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Payment Method',
                            style: CustomTextStyle.carttblack,
                          ),
                          Text(
                            "${widget.paymentMethod.toString().capitalizeFirst}",
                            style: CustomTextStyle.carttblack,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const CustomSizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Customcolors
                        .DECORATION_WHITE, // Set your desired background color
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Bill Summary',
                        style: CustomTextStyle.minblacktext,
                      ),
                      const SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.orderdetails!.length,
                        itemBuilder: (context, index) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 6),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  child: Text(
                                    "${widget.orderdetails![index]['quantity']} X ${widget.orderdetails![index]['foodName']}",
                                    style: CustomTextStyle.noboldblack,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                          CustomPaint(
                                size: Size(MediaQuery.of(context).size.width / 1,
                                    20), // Adjust size here
                                painter: DottedLinePainter(),
                              ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const InkWell(
                            child: Text(
                              'Item Total',
                              style: CustomTextStyle.carttblack,
                            ),
                          ),
                          Text(
                            "₹ ${widget.itemTotal.toStringAsFixed(2)}",
                            style: CustomTextStyle.carttblack,
                          )
                        ],
                      ),
                      const CustomSizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                                right:
                                    16), // Adjust the right padding as needed
                            child: Text(
                              'GST',
                              style: CustomTextStyle.carttblack,
                            ),
                          ),
                          Text(
                            "₹ ${widget.gst.toStringAsFixed(2)}",
                            style: CustomTextStyle.carttblack,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Delivery partner fee(up to ${widget.km} km)',
                            style: CustomTextStyle.carttblack,
                          ),
                          Text(
                            "₹ ${widget.delivaryFee.toStringAsFixed(2)}",
                            style: CustomTextStyle.carttblack,
                          ),
                        ],
                      ),
                     const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Packaging Charge',
                            style: CustomTextStyle.carttblack,
                          ),
                          Text(
                            "₹ ${widget.packagingCharge.toStringAsFixed(2)}",
                            style: CustomTextStyle.carttblack,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Coupon Discount',
                            style: CustomTextStyle.carttblack,
                          ),
                          Text(
                            "${widget.couponType == 'percentage' ? '%' : '₹'} ${widget.couponDiscount}",
                            style: const TextStyle(
                                fontSize: 13,
                                color: Customcolors.darkpurple,
                                fontFamily: 'Poppins-Regular'),
                          )
                        ],
                      ),
                      20.toHeight,
                      CustomPaint(
                            size: Size(MediaQuery.of(context).size.width / 1,20), // Adjust size here
                            painter: DottedLinePainter(),
                          ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Grand Total',
                            style: CustomTextStyle.carttblack,
                          ),
                          Text(
                            "₹ ${widget.grandtotal.toStringAsFixed(2)}",

                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Customcolors.DECORATION_BLACK,
                                fontFamily: 'Poppins-Regular'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const CustomSizedBox(
                  height: 10,
                ),
    ],);
  }
}