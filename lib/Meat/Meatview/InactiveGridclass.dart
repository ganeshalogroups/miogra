// ignore_for_file: must_be_immutable, file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InactiveGridclass extends StatefulWidget {
dynamic meatItem;
InactiveGridclass({super.key,required this.meatItem});

  @override
  State<InactiveGridclass> createState() => InactiveGridclassState();
}

class InactiveGridclassState extends State<InactiveGridclass> {
  @override
  Widget build(BuildContext context) {
    return Container(
              decoration: BoxDecoration(
                color: Customcolors.DECORATION_CONTAINERGREY,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Colors.grey,
                        BlendMode.saturation,
                        ),
                        child: CachedNetworkImage(
                          useOldImageOnUrlChange: true,
                          imageUrl:widget.meatItem["meatImgUrl"],
                          placeholder: (context, url) =>Image.asset(meatdummy),
                          errorWidget: (context, url, error) =>Image.asset(meatdummy),
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                   widget.meatItem["iscustomizable"] == true
                     ? const Padding(
                     padding: EdgeInsets.symmetric(horizontal: 8),
                     child: Text("Customisable",style: CustomTextStyle.addressfetch)  
                   ): const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.meatItem["meatName"].toString().capitalizeFirst.toString(),
                          overflow: TextOverflow.clip,
                          maxLines: 3,
                           style: CustomTextStyle.meatbold,
                        ),
                        const SizedBox(height: 5),
                        widget.meatItem["meatDiscription"].isEmpty||widget.meatItem["meatDiscription"]==null?
                        const SizedBox():
                        Text(
                          widget.meatItem["meatDiscription"].toString().capitalizeFirst.toString(),
                          style: CustomTextStyle.foodDescription,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "₹${widget.meatItem["meat"]["customerPrice"]} / ${widget.meatItem["meat"]["unitValue"]}${widget.meatItem["meat"]["unit"].toString()}",
                          style: CustomTextStyle.meatpricetext,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                ],
              ),
            );
          
  }
}