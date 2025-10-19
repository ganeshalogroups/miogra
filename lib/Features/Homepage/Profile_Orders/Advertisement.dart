// ignore_for_file: file_names, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'package:cached_network_image/cached_network_image.dart';
import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Advertisementcontroller.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AdvertisementScreen extends StatefulWidget {
  const AdvertisementScreen({super.key});

  @override
  State<AdvertisementScreen> createState() => _AdvertisementScreenState();
}

class _AdvertisementScreenState extends State<AdvertisementScreen> {
  AdvertisementController advertise = Get.put(AdvertisementController());
 AddImageLinkController adImagelink = Get.put(AddImageLinkController());

  @override
  void initState() {
    advertise.getadvertisementDetails();
    adImagelink.getimagelink();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          if (advertise.isLoading.isTrue) {
            return const Center(child:  CupertinoActivityIndicator(
              color: Customcolors.DECORATION_WHITE,
            ));
          } else if (advertise.advertisementDetails == null) {
            return const CircularProgressIndicator(color: Customcolors.darkpurple,
            );
          } else if (advertise.advertisementDetails["data"]["data"].isEmpty) {
            return const SizedBox();
          } else {
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: advertise.advertisementDetails["data"]["data"].length,
              itemBuilder: (context, index) {
                //  final String textToCopy = advertise.advertisementDetails["data"]["data"][index]["offerCode"].toString();
                return Container(
                  margin: const EdgeInsets.only(top: 0, bottom: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    color: Customcolors.DECORATION_WHITE,
                    boxShadow: [
                      BoxShadow(
                        color: Customcolors.DECORATION_LIGHTGREY,
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        child: CachedNetworkImage(
                          placeholder: (context, url) =>Image.asset("${fastxdummyImg}"),
                          errorWidget: (context, url, error) =>Image.asset("${fastxdummyImg}"),
                          height: 150.h,
                          width: MediaQuery.of(context).size.width,
                          imageUrl: adImagelink.imagelink["data"]["value"].toString() + advertise.advertisementDetails["data"]["data"][index]["imageUrl"].toString() ,
                          fit: BoxFit.fill,
                        ),
                      ),
                      // Separate container for the content below the image
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          color: Customcolors.DECORATION_WHITE,
                        ),
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
                      //  margin: EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // if (!_showDetails1)
                            Row(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *0.22, // 30% of screen width
                                      height:MediaQuery.of(context).size.height *0.07, // 10% of screen height

                                      child: CachedNetworkImage(
                                        imageUrl:  adImagelink.imagelink["data"]["value"].toString() + advertise.advertisementDetails["data"]["data"][index]["logoUrl"].toString(),
                                        imageBuilder:(context, imageProvider) =>Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(color: Colors.white, width: 2),
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                // color: Customcolors.DECORATION_LIGHTGREY,
                                                color: Colors.grey.shade300,
                                                spreadRadius: 1,
                                                blurRadius: 3,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: NetworkImage( adImagelink.imagelink["data"]["value"].toString() + advertise.advertisementDetails["data"]["data"][index]["logoUrl"].toString()),
                                                    fit: BoxFit.fitHeight,
                                                    scale: 0.8)),
                                          ),
                                        ),
                                        placeholder: (context, url) =>const CircleAvatar(backgroundImage:AssetImage('${fastxdummyImg}'),backgroundColor: Colors.transparent,
                                        ),
                                        errorWidget: (context, url, error) =>const CircleAvatar(backgroundImage:AssetImage('${fastxdummyImg}'),
                                          backgroundColor: Colors.transparent,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(" ${advertise.advertisementDetails["data"]["data"][index]["name"]}",
                                  overflow: TextOverflow.ellipsis,
                                  style: CustomTextStyle.foodpricetext,
                                ),
                                const Spacer(),
                              ],
                            ),
                       //     //  if (!_showDetails1)
                        //    CustomSizedBox(height: 10.h),
                         //   //  if (!_showDetails1)



                            // Padding(
                            //   padding:const EdgeInsets.symmetric(horizontal: 8),
                            //   child: Text(
                            //     advertise.advertisementDetails["data"]["data"][index]["title"].toString().toUpperCase().toString(),
                            //     softWrap: true,
                            //     style: CustomTextStyle.cartBoxHeading,
                            //   ),
                            // ),
                         //   //  if (!_showDetails1)
                            // Padding(
                            //   padding:const EdgeInsets.symmetric(horizontal: 8),
                            //   child: Text(
                            //     advertise.advertisementDetails["data"]["data"][index]["description"].toString().capitalizeFirst.toString(),
                            //     softWrap: true,
                            //     style: CustomTextStyle.minblacktext,
                            //   ),
                            // ),
                            // SizedBox(height: 10.h),

                            
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     const Text(
                            //       " Details",
                            //       overflow: TextOverflow.ellipsis,
                            //       style: CustomTextStyle.chipgrey,
                            //     ),
                            //     SizedBox(height: 5.h),
                            //     Container(
                            //       width: MediaQuery.of(context).size.width / 1,
                            //       color: Customcolors.DECORATION_WHITE,
                            //       child: Padding(
                            //         padding: const EdgeInsets.symmetric(horizontal: 8),
                            //         child: ListView.builder(
                            //           itemCount: advertise.advertisementDetails["data"]["data"][index]["rewardsDetails"].length,
                            //           shrinkWrap: true,
                            //           itemBuilder: (context, index1) {
                            //             return Row(
                            //               children: [
                            //                 const Icon(Icons.circle,
                            //                     size: 6,
                            //                     color: Customcolors.DECORATION_DARKGREY),
                            //                 const SizedBox(width: 4),
                            //                 Text(
                            //                   advertise.advertisementDetails["data"]["data"][index]["rewardsDetails"][index1].toString(),
                            //                   style: CustomTextStyle.boldgrey,
                            //                   overflow: TextOverflow.ellipsis,
                            //                   maxLines: 1,
                            //                 ),
                            //               ],
                            //             );
                            //           },
                            //         ),
                            //       ),
                            //     ),
                            //   // Divider(),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        }),
      ],
    );
  }
}
