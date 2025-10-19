// ignore_for_file: file_names
import 'dart:async';
import 'package:testing/Meat/Homepage/Meathomepage.dart';
import 'package:testing/Meat/MeatController.dart/Meatsearchcontroller.dart';
import 'package:testing/Meat/MeatSearch/Meatlist.dart';
import 'package:testing/Meat/MeatSearch/Meatsearchmodule.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Shimmers/SearchShimmer.dart';
import 'package:testing/utils/Shimmers/Searchlistshimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class MeatTextformfield extends StatefulWidget {
  final dynamic meatproductcategoryid;
  const MeatTextformfield({required this.meatproductcategoryid, super.key});

  @override
  State<MeatTextformfield> createState() => _MeatTextformfieldState();
}

class _MeatTextformfieldState extends State<MeatTextformfield> {
  final Meatsearchcontroller meatlistsearch = Get.put(Meatsearchcontroller());
  final TextEditingController meatsearchcontroller = TextEditingController();
  bool meatisSearching = false;
  Timer? debounce;

  @override
  void initState() {
    meatlistsearch.getrecentmeatsearch(
        meatproductcategoryid: widget.meatproductcategoryid);
    super.initState();
  }

  void onsearchreset() {
    setState(() {
      meatisSearching = false;
    });
    meatsearchcontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        meatsearchcontroller.clear();
        Get.off( Meathomepage(meatproductcategoryid: widget.meatproductcategoryid,),
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
              meatsearchcontroller.clear();
              Get.off(
                  Meathomepage(
                    meatproductcategoryid: widget.meatproductcategoryid,
                  ),
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
                      controller: meatsearchcontroller,
                      decoration: InputDecoration(
                        hintText: 'Search for ‘Fish’',
                        hintStyle: const TextStyle(
                          fontFamily: 'Poppins-Regular',
                          color: Customcolors.DECORATION_GREY,
                        ),
                        border: InputBorder.none,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Customcolors.DECORATION_BLACK,
                        ),
                        suffixIcon: meatisSearching
                            ? InkWell(
                                onTap: () {
                                  meatsearchcontroller.clear();
                                  setState(() {
                                    meatisSearching = false;
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
                        if (value.isNotEmpty) {
                          Timer(const Duration(milliseconds: 500), () {
                            meatlistsearch.createmeatrecentsearch(
                              hashtagName: value,
                              meatproductcategoryid:widget.meatproductcategoryid,
                            );
                            meatlistsearch.getrecentmeatsearch(
                                meatproductcategoryid:widget.meatproductcategoryid);
                          });
                          Get.to(
                              Meatlistscreen(
                                searchvalue: value,
                                meatproductcategoryid:widget.meatproductcategoryid,
                                 onSearchReset: () {
                                  onsearchreset();
                                },
                              ),
                              transition: Transition.rightToLeft,
                              duration: const Duration(milliseconds: 300));
                          setState(() {
                            meatisSearching = false;
                          });
                          meatsearchcontroller.clear();
                          meatsearchcontroller.text = "";
                        } else {
                          setState(() {
                            meatisSearching = false;
                            meatsearchcontroller.text = '';
                          });
                        }
                      },
                      onChanged: (value) {
                        if (debounce?.isActive ?? false) debounce!.cancel();
                        debounce = Timer(const Duration(milliseconds: 500), () {
                          if (value.isNotEmpty) {
                            meatlistsearch.meatsearchlistbyshop(value);
                            setState(() {
                              meatisSearching = true;
                            });
                          } else {
                            setState(() {
                              meatlistsearch.meatlist = {};
                              meatisSearching = false;
                            });
                          }
                        });
                      },
                    )),
              ),
              CustomSizedBox(height: 10.h),
              if (meatisSearching) ...[
                Obx(() {
                  if (meatlistsearch.meatlistloading.isTrue) {
                    return const SearchlistShimmer();
                  }else if(meatlistsearch.meatlist["data"]=="Regular expression is invalid: missing closing parenthesis"
                  ||meatlistsearch.meatlist["data"]=="Regular expression is invalid: quantifier does not follow a repeatable item"){
                    return nomatchfound();
                  }
                   else if (meatlistsearch.meatlist == null ||
                      meatlistsearch.meatlist.isEmpty ||
                      meatlistsearch.meatlist["data"]["AdminUserList"].isEmpty) {
                    return nomatchfound();
                  } else {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: meatlistsearch.meatlist["data"]["AdminUserList"].length,
                        itemBuilder: (context, index1) {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: meatlistsearch.meatlist["data"]["AdminUserList"][index1]["categoryDetails"].length,
                            itemBuilder: (context, index2) {
                              return Meatsearch(
                                index2: index2,
                                uptomeats: meatlistsearch.meatlist["data"]["AdminUserList"][index1]["categoryDetails"][index2]["meats"],
                                onSearchReset: () {
                                  onsearchreset();
                                },
                              );
                            },
                          );
                        },
                      ),
                    );
                  }
                }),
              ] else ...[
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
                    Obx(() {
                      if (meatlistsearch.meatgetrecentsearchloading.isTrue) {
                        return const ShimmerGridList();
                      } else if (meatlistsearch.meatgetrecentsearch == null ||
                          meatlistsearch.meatgetrecentsearch["data"]["searchList"] ==null ||
                          meatlistsearch.meatgetrecentsearch["data"]["searchList"].isEmpty) {
                        return Column(
                          children: [
                            Image.asset("assets/meat_images/search_icon_animation.gif"),
                            const Text(
                              "No Recent searches Available",
                              style: CustomTextStyle.chipgrey,
                            ),
                          ],
                        );
                      } else {
                        return Padding(
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
                              meatlistsearch.meatgetrecentsearch["data"]["searchList"].length,
                              (index) => InkWell(
                                borderRadius: BorderRadius.circular(30),
                                onTap: () {
                                  Get.to(
                                      Meatlistscreen(
                                        searchvalue: meatlistsearch.meatgetrecentsearch["data"]["searchList"][index]["hashtagName"].toString(),
                                        meatproductcategoryid: widget.meatproductcategoryid,  onSearchReset: () {
                                  onsearchreset();
                                },
                                      ),
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
                                          meatlistsearch.meatgetrecentsearch["data"]["searchList"][index]["hashtagName"].toString(),
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
                        );
                      }
                    }),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Center nomatchfound() {
    return Center(
                    child: Padding(
                      padding:const EdgeInsets.symmetric(vertical: 40, horizontal: 8),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Oops!\n',
                              style: CustomTextStyle.redtext,
                            ),
                            TextSpan(
                              text: 'We could not understand what you mean, ',
                              style: CustomTextStyle.chipgrey,
                            ),
                            TextSpan(
                              text: 'try something relevant',
                              style: CustomTextStyle.chipgrey,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
  }
}
