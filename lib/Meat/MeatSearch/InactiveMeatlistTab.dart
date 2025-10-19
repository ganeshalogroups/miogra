// ignore_for_file: must_be_immutable, file_names

import 'package:testing/Meat/MeatSearch/MeatTabsubclass.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class InactiveMeatlistTab extends StatefulWidget {
dynamic index;
dynamic rating;
int current;
dynamic meatlistsearchlist;
 InactiveMeatlistTab({super.key,
 required this.rating,
 required this.current,
  required this.index,
  required this.meatlistsearchlist
  });

  @override
  State<InactiveMeatlistTab> createState() => _InactiveMeatlistTabState();
}

class _InactiveMeatlistTabState extends State<InactiveMeatlistTab> {
  @override
  Widget build(BuildContext context) {
 return AnimationConfiguration.staggeredList(
  position:widget.index,
  duration: const Duration(milliseconds: 750),
  child: SlideAnimation(
    verticalOffset: 50.0,
    child: FadeInAnimation(
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Customcolors.DECORATION_CONTAINERGREY,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
            Colors.white,
            Colors.grey,
            Color.fromARGB(66, 0, 0, 0),
            ]),
          boxShadow: [
            BoxShadow(
              color: Customcolors.DECORATION_LIGHTGREY,
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomSizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.3.w,
                          child: Text(
                            widget.meatlistsearchlist!["data"]["AdminUserList"][widget.index]["name"]
                                .toString()
                                .capitalizeFirst
                                .toString(),
                            overflow: TextOverflow.clip,
                            style: CustomTextStyle.googlebuttontext,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                          },
                          child: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 20,
                            color: Customcolors.DECORATION_BLACK,
                          ),
                        ),
                      ],
                    ),
                    const CustomSizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 20,
                          color: Customcolors.DECORATION_BLACK,
                        ),
                        Text(
                          " ${ widget.meatlistsearchlist["data"]["AdminUserList"][widget.index]["address"]["city"].toString().capitalizeFirst.toString()}, ${widget.meatlistsearchlist!["data"]["AdminUserList"][widget.index]["address"]["region"].toString().capitalizeFirst.toString()}",
                          overflow: TextOverflow.ellipsis,
                          style: CustomTextStyle.boldgrey,
                        ),
                      ],
                    ),
                    const CustomSizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 20, color: Colors.amber),
                        Text(" ${widget.rating.toString()}", style: CustomTextStyle.blacktext),
                         widget.meatlistsearchlist["data"]["AdminUserList"][widget.index]["ratings"].isEmpty ||
                          widget.meatlistsearchlist["data"]["AdminUserList"][widget.index]["ratings"] == null
                            ? const Text(" (0 reviews)", style: CustomTextStyle.boldgrey)
                            : Text(
                                " (${ widget.meatlistsearchlist["data"]["AdminUserList"][widget.index]["ratings"].length} reviews)",
                                style: CustomTextStyle.boldgrey,
                              ),
                      ],
                    ),
                    const CustomSizedBox(height: 5),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image(
                              image: AssetImage("assets/images/discount.png"),
                              height: 15,
                              width: 20,
                            ),
                            Center(
                              child: Text(
                                'No deals right now, but stay tuned!',
                                style: CustomTextStyle.darkgrey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(),
                  ],
                ),
              ),
              SizedBox(
                height: 150,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.48,
                  ),
                  itemCount:  widget.meatlistsearchlist["data"]["AdminUserList"][widget.index]["categoryDetails"][0]["meats"]
                      .length, // Adjusted to categoryDetails length
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, catIndex) {
                    return Meattabsub(
                      meats:  widget.meatlistsearchlist["data"]["AdminUserList"][widget.index]["categoryDetails"][0]["meats"],
                      index: widget.index,
                      current: widget.current,
                      index2: catIndex,
                      isTabScreen: true,
                      shopid:  widget.meatlistsearchlist["data"]["AdminUserList"][widget.index]["_id"],
                      status: widget.meatlistsearchlist["data"]["AdminUserList"][widget.index]["status"],
                      activeStatus: widget.meatlistsearchlist["data"]["AdminUserList"][widget.index]["activeStatus"],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ),
);
}
}