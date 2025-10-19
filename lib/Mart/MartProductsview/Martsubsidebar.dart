
// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:testing/Mart/MartProductsview/Productscontroller/ProductgetpaginationController.dart';
import 'package:testing/Mart/MartProductsview/Productscontroller/Subcategorycontroller.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Subsidebar extends StatefulWidget {
dynamic categoryId;
dynamic categorydata;
dynamic offset;
PageController pagecontroller;
Subsidebar({super.key,required this.categoryId,required this.offset,required this.pagecontroller,required this.categorydata});

  @override
  State<Subsidebar> createState() => _SubsidebarState();
}

// class _SubsidebarState extends State<Subsidebar> {

//   MartsubCategoriescontroller martsubcat =  Get.put(MartsubCategoriescontroller());

//   int selectedindex = 0;

//   void loadbyid({subcateid}) {
//     Timer(Duration(milliseconds: 500), () {
//       martsubcat.setSelectedSubcateid(subcateid);
//     });
//     Provider.of<MartProductGetPaginations>(context, listen: false)
//         .clearData()
//         .then((value) {
//       Provider.of<MartProductGetPaginations>(context, listen: false)
//           .fetchallproducts(
//         offset: widget.offset,
//         cateid: widget.categoryId,
//         subcateid: subcateid,
//         searchvalue: martsubcat.searchproductnamesearch.value,
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       if (martsubcat.issubcategoryloading.isTrue) {
//         return Center(child: CircularProgressIndicator());
//       } else if (martsubcat.subcategory == null ||
//           martsubcat.subcategory["data"].isEmpty) {
//         return SizedBox();
//       } else {
//         return SizedBox(
//           width: 77,
//           child: ListView.separated(
//             shrinkWrap: true,
//             separatorBuilder: (BuildContext context, int index) {
//               return SizedBox(height: 5);
//             },
//             itemCount: martsubcat.subcategory["data"].length,
//             itemBuilder: (BuildContext context, int index) {
//               return GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     selectedindex = index;
//                     widget.pagecontroller.jumpToPage(index);
//                     loadbyid(
//                       subcateid: martsubcat.subcategory["data"][index]["_id"],
//                     );
//                   });
//                 },
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: AnimatedContainer(
//                         color: Customcolors.pureWhite,
//                         duration: Duration(milliseconds: 500),
//                         child: Padding(
//                           padding:
//                               const EdgeInsets.symmetric(vertical: 7),
//                           child: Column(
//                             children: [
//                               Container(
//                                 margin:EdgeInsets.symmetric(horizontal: 5),
//                                 padding: EdgeInsets.symmetric(vertical: 7),
//                                 decoration: BoxDecoration(
//                                   color: Customcolors.DECORATION_CONTAINERGREY,
//                                   borderRadius: BorderRadius.circular(10.r),
//                                 ),
//                                 child: CachedNetworkImage(
//                                   imageUrl: martsubcat.subcategory["data"]
//                                       [index]["subCateImage"],
//                                   width: 65,
//                                   height: 55,
//                                   fit: BoxFit.contain,
//                                   placeholder: (context, url) => Image.asset(
//                                     meatdummy,
//                                     width: 65,
//                                     height: 55,
//                                   ),
//                                   errorWidget: (context, url, error) =>
//                                       Image.asset(
//                                     meatdummy,
//                                     width: 65,
//                                     height: 55,
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(height: 10),
//                               AutoSizeText(
//                                 "${martsubcat.subcategory["data"][index]["subCateName"].toString().capitalizeFirst}",
//                                 textAlign: TextAlign.center,
//                                 maxLines: 3,
//                                 wrapWords: true,
//                                 style: CustomTextStyle.addressfetch,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     AnimatedContainer(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: Customcolors.darkpurple,
//                       ),
//                       alignment: Alignment.center,
//                       width: 4,
//                       duration: Duration(milliseconds: 500),
//                       height: (selectedindex == index) ? 65 : 0,
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         );
//       }
//     });
//   }
// }



class _SubsidebarState extends State<Subsidebar> {
  final MartsubCategoriescontroller martsubcat = Get.put(MartsubCategoriescontroller());
  final RxInt selectedindex = 0.obs;

  void loadbyid({String? subcateid}) {
    martsubcat.setSelectedSubcateid(subcateid ?? "All");

    Provider.of<MartProductGetPaginations>(context, listen: false)
        .clearData()
        .then((_) {
      Provider.of<MartProductGetPaginations>(context, listen: false)
          .fetchallproducts(
        offset: widget.offset,
        cateid: widget.categoryId,
        subcateid: subcateid, // If null, it means "All" is selected
        searchvalue: martsubcat.searchproductnamesearch.value,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (martsubcat.issubcategoryloading.isTrue) {
        return const Center(child: CircularProgressIndicator());
      } else if (martsubcat.subcategory?["data"] == null || martsubcat.subcategory!["data"].isEmpty) {
        return const SizedBox();
      } else {
        // Add 1 to include the "All" option
        return SizedBox(
          width: 77,
          child: ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (_, __) => const SizedBox(height: 5),
            itemCount: martsubcat.subcategory!["data"].length + 1, // "All" + categories
            itemBuilder: (_, index) {
              final bool isSelected = selectedindex.value == index;

              // **Handle "All" option at index 0**
              if (index == 0) {
                return GestureDetector(
                  onTap: () {
                    selectedindex.value = index;
                    widget.pagecontroller.jumpToPage(0);
                    loadbyid(subcateid: ""); // Null means "All"
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          color: Customcolors.pureWhite,
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 5),
                                padding: const EdgeInsets.symmetric(vertical: 7),
                                decoration: BoxDecoration(
                                  color: Customcolors.DECORATION_CONTAINERGREY,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: CachedNetworkImage(
                                imageUrl: widget.categorydata["meatCateImage"],
                                width: 65,
                                height: 55,
                                fit: BoxFit.contain,
                                fadeInDuration: const Duration(milliseconds: 300),
                                placeholder: (_, __) => Image.asset(
                                  meatdummy,
                                  width: 65,
                                  height: 55,
                                ),
                                errorWidget: (_, __, ___) => Image.asset(
                                  meatdummy,
                                  width: 65,
                                  height: 55,
                                ),
                              ), // Icon for "All"
                              ),
                              const SizedBox(height: 10),
                              const AutoSizeText(
                                "All",
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                wrapWords: true,
                                style: CustomTextStyle.addressfetch,
                              ),
                            ],
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        width: 4,
                        height: isSelected ? 65 : 0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Customcolors.darkpurple,
                        ),
                      ),
                    ],
                  ),
                );
              }

              // **Handle dynamic subcategories**
              final subcategory = martsubcat.subcategory!["data"][index - 1];

              return GestureDetector(
                onTap: () {
                  selectedindex.value = index;
                  widget.pagecontroller.jumpToPage(index);
                  loadbyid(subcateid: subcategory["_id"]);
                  print("subbbbcategoryy:${subcategory["_id"]}");
                   print("offset:${widget.offset}");
                },
                child: Row(
                  children: [
                    Expanded(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        color: Customcolors.pureWhite,
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              padding: const EdgeInsets.symmetric(vertical: 7),
                              decoration: BoxDecoration(
                                color: Customcolors.DECORATION_CONTAINERGREY,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: subcategory["subCateImage"],
                                width: 65,
                                height: 55,
                                fit: BoxFit.contain,
                                fadeInDuration: const Duration(milliseconds: 300),
                                placeholder: (_, __) => Image.asset(
                                  meatdummy,
                                  width: 65,
                                  height: 55,
                                ),
                                errorWidget: (_, __, ___) => Image.asset(
                                  meatdummy,
                                  width: 65,
                                  height: 55,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            AutoSizeText(
                              subcategory["subCateName"].toString().capitalizeFirst ?? '',
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              wrapWords: true,
                              style: CustomTextStyle.addressfetch,
                            ),
                          ],
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: 4,
                      height: isSelected ? 65 : 0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Customcolors.darkpurple,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }
    });
  }
}
