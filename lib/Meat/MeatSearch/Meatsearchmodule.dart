// ignore_for_file: file_names, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:testing/Meat/MeatController.dart/Meatsearchcontroller.dart';
import 'package:testing/Meat/MeatSearch/Meatlist.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Meatsearch extends StatefulWidget {
  final dynamic index2;
  final dynamic uptomeats;
  final VoidCallback onSearchReset;

  const Meatsearch({
    required this.index2,
    required this.uptomeats,
    super.key,
    required this.onSearchReset,
  });

  @override
  State<Meatsearch> createState() => _MeatsearchState();
}

class _MeatsearchState extends State<Meatsearch> {
  final Meatsearchcontroller meatlistsearch = Get.put(Meatsearchcontroller());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.uptomeats.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Get.to(Meatlistscreen(
                  searchvalue: widget.uptomeats[index]["meatName"].toString(),
                  meatproductcategoryid: meatproductCateId, onSearchReset: () {widget.onSearchReset;  },
                ));
                widget.onSearchReset();
              },
              child: Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: Customcolors.DECORATION_WHITE,
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 182, 182, 182).withOpacity(0.2),
                      offset: const Offset(0, 4),
                      blurRadius: 6,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 90,
                                  height: 100,
                                  child:widget.uptomeats[index]["availableStatus"]==true &&widget.uptomeats[index]["status"]==true? ClipRRect(
                                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                                    child: CachedNetworkImage(
                                      placeholder: (context, url) =>
                                          Image.asset(meatdummy,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(meatdummy,
                                      ),
                                      imageUrl: widget.uptomeats[index]["meatImgUrl"],
                                      fit: BoxFit.fill,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                  ):ClipRRect(
                                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                                    child: ColorFiltered(
                                    colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.saturation,),
                                      child: CachedNetworkImage(
                                        placeholder: (context, url) =>
                                            Image.asset(meatdummy,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(meatdummy,
                                        ),
                                        imageUrl: widget.uptomeats[index]["meatImgUrl"],
                                        fit: BoxFit.fill,
                                        width: MediaQuery.of(context).size.width,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${widget.uptomeats[index]["meatName"].toString().capitalizeFirst}",
                                        overflow: TextOverflow.clip,
                                        style: CustomTextStyle.googlebuttontext,
                                      ),
                                    ),
                                  ],
                                ),
                                const CustomSizedBox(height: 5),
                                Text(
                                  "${widget.uptomeats[index]["meatShopName"].toString().capitalizeFirst}",
                                  overflow: TextOverflow.ellipsis,
                                  style: CustomTextStyle.foodDescription,
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      " ₹${widget.uptomeats[index]["meat"]["customerPrice"].toString()} / ${widget.uptomeats[index]["meat"]["unitValue"].toString()}${widget.uptomeats[index]["meat"]["unit"].toString()}",
                                      style: CustomTextStyle.meatpricetext,
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        CustomSizedBox(
          height: 10.h,
        )
      ],
    );
  }
}
