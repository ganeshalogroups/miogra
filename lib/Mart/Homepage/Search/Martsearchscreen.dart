// ignore_for_file: file_names

import 'package:testing/Mart/Homepage/MartHomepage.dart';
import 'package:testing/Mart/MartProductsview/Martproductsidebar.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class MartSearchscreen extends StatefulWidget {
  const MartSearchscreen({super.key});

  @override
  State<MartSearchscreen> createState() => _MartSearchscreenState();
}

class _MartSearchscreenState extends State<MartSearchscreen> {
final TextEditingController martsearchcontroller = TextEditingController();
 bool martissearching = false;
  List<Map<String, dynamic>> bestDeals = [
    {"name": "Fogg"},
    {"name": "Tomato"},
    {"name": "Lays"},
    {"name": "Potato"},
  ];
  @override
  Widget build(BuildContext context) {
    return  PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        Get.off( const MartHomepage(),
         transition: Transition.rightToLeft,preventDuplicates: true);
      },
      child: Scaffold(
      resizeToAvoidBottomInset: false,
        backgroundColor: Customcolors.DECORATION_CONTAINERGREY,
        appBar: AppBar(
          backgroundColor: Customcolors.DECORATION_CONTAINERGREY,
          title: const Text(
            'Search for shop  & meats',
            style: CustomTextStyle.darkgrey,
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () {
              Get.off(
                  const MartHomepage(),
                  transition: Transition.rightToLeft,
                  preventDuplicates: true);
            },
            child: const Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Customcolors.DECORATION_WHITE,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          offset: const Offset(0, 4),
                          blurRadius: 1,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: TextFormField(
                      cursorColor: Customcolors.DECORATION_GREY,
                      cursorWidth: 2.0,
                      cursorRadius: const Radius.circular(5.0),
                      controller: martsearchcontroller,
                      decoration: InputDecoration(
                        hintText: 'Search for ‘Tomato’',
                        hintStyle: const TextStyle(
                          fontFamily: 'Poppins-Regular',
                          color: Customcolors.DECORATION_GREY,
                        ),
                        border: InputBorder.none,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Customcolors.DECORATION_BLACK,
                        ),
                        suffixIcon: martissearching
                            ? InkWell(
                                onTap: () {
                                  martsearchcontroller.clear();
                                  setState(() {
                                    martissearching = false;
                                  });
                                },
                                child: Icon(
                                  MdiIcons.close,
                                  color: Customcolors.DECORATION_DARKGREY,
                                  size: 20,
                                ),
                              )
                            : const SizedBox(),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 15.0),
                      ),
                      onFieldSubmitted: (value) {
                        
                      },
                      onChanged: (value) {
                        
                      },
                    )),
              ),
              CustomSizedBox(height: 10.h),
              // if (martissearching) ...[
              //   Obx(() {
              //     if (meatlistsearch.meatlistloading.isTrue) {
              //       return const SearchlistShimmer();
              //     }else if(meatlistsearch.meatlist["data"]=="Regular expression is invalid: missing closing parenthesis"
              //     ||meatlistsearch.meatlist["data"]=="Regular expression is invalid: quantifier does not follow a repeatable item"){
              //       return nomatchfound();
              //     }
              //      else if (meatlistsearch.meatlist == null ||
              //         meatlistsearch.meatlist.isEmpty ||
              //         meatlistsearch.meatlist["data"]["AdminUserList"].isEmpty) {
              //       return nomatchfound();
              //     } else {
              //       return SizedBox(
              //         height: MediaQuery.of(context).size.height * 0.8,
              //         child: ListView.builder(
              //           physics: const AlwaysScrollableScrollPhysics(),
              //           shrinkWrap: true,
              //           itemCount: meatlistsearch.meatlist["data"]["AdminUserList"].length,
              //           itemBuilder: (context, index1) {
              //             return ListView.builder(
              //               physics: const NeverScrollableScrollPhysics(),
              //               shrinkWrap: true,
              //               itemCount: meatlistsearch.meatlist["data"]["AdminUserList"][index1]["categoryDetails"].length,
              //               itemBuilder: (context, index2) {
              //                 return Meatsearch(
              //                   index2: index2,
              //                   uptomeats: meatlistsearch.meatlist["data"]["AdminUserList"][index1]["categoryDetails"][index2]["meats"],
              //                   onSearchReset: () {
              //                     onsearchreset();
              //                   },
              //                 );
              //               },
              //             );
              //           },
              //         ),
              //       );
              //     }
              //   }),
              // ] else ...[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Text(
                    "Recent Searches",
                    style: CustomTextStyle.boldblack,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomSizedBox(height: 10),
                 Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ResponsiveGridList(
                            minItemWidth: 40,
                            maxItemsPerRow: 3,
                            horizontalGridSpacing: 5,
                            horizontalGridMargin: 1,
                            listViewBuilderOptions: ListViewBuilderOptions(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                            ),
                            children: List.generate(
                              bestDeals.length,
                              (index) => InkWell(
                                borderRadius: BorderRadius.circular(30),
                                onTap: () {
                                  Get.to(
                                  Productsidebar(),
                                      transition: Transition.rightToLeft);
                                },
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                        color: Customcolors.DECORATION_GREY),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.access_time_rounded,
                                        size: 22,
                                        color: Customcolors.DECORATION_GREY,
                                      ),
                                      const SizedBox(width: 6),
                                      Flexible(
                                        child: Text(
                                          bestDeals[index]["name"].toString(),
                                          softWrap: true,
                                          style: CustomTextStyle.chipgrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                ),
              // ],
            ],
          ),
        ),
      ),
    );
  }
}