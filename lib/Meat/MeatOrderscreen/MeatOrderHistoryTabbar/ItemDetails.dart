// ignore_for_file: file_names, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Itemdetails extends StatefulWidget {
dynamic meatImgurl;
dynamic meatunitValue;
dynamic meatunit;
dynamic calculatePrice;
dynamic meatName;
 Itemdetails({
  required this.meatImgurl,
  required this.meatunit,
  required this.meatunitValue,
  required this.calculatePrice,
  required this.meatName,
  super.key});

  @override
  State<Itemdetails> createState() => ItemdetailsState();
}

class ItemdetailsState extends State<Itemdetails> {
  @override
  Widget build(BuildContext context) {
    return Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(148, 255, 255, 255),
                                            borderRadius: BorderRadius.circular(15),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.2),
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                useOldImageOnUrlChange: true,
                                                imageUrl: widget.meatImgurl,
                                                placeholder: (context, url) =>
                                                    Image.asset(meatdummy),
                                                errorWidget: (context, url, error) =>
                                                    Image.asset(meatdummy),
                                                height: 60,
                                                width: 70,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 140,
                                              child: Text(
                                               widget.meatName.toString().capitalizeFirst.toString(),
                                                style: CustomTextStyle.carttblack,
                                                overflow: TextOverflow.clip,
                                              ),
                                            ),
                                            Text(
                                              "₹${widget.calculatePrice} / ${widget.meatunitValue}${widget.meatunit}",
                                              style: CustomTextStyle.foodDescription,
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
  }
}