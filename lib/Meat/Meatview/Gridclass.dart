// ignore_for_file: must_be_immutable, deprecated_member_use, file_names
import 'package:testing/Meat/Meatview/CustomiseBottomsheet.dart';
import 'package:testing/Meat/Meatview/InactiveGridclass.dart';
import 'package:testing/Meat/Meatview/MeatAddButton.dart';
import 'package:testing/Meat/Meatview/ProductBottomsheet.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
class MeatGrid extends StatefulWidget {
  final dynamic meats;
  final dynamic shopId;
  final dynamic shopstatus;
  dynamic shopname;
  dynamic totalDis;
  MeatGrid({required this.meats, required this.shopId,required this.shopname,required this.shopstatus,required this.totalDis, super.key});

  @override
  State<MeatGrid> createState() => MeatGridState();
}

class MeatGridState extends State<MeatGrid> {


  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ResponsiveGridList(
        shrinkWrap: true,
        horizontalGridSpacing: 10,
        verticalGridSpacing: 10,
        minItemWidth: 150,
        minItemsPerRow: 2,
        maxItemsPerRow: 2,
        listViewBuilderOptions: ListViewBuilderOptions(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
        ),
        children: List.generate(widget.meats.length, (index) {
          final meatItem = widget.meats[index];
            ValueNotifier<int> itemCountNotifier = ValueNotifier<int>(0);
          return GestureDetector(
          onTap: () {
            if(meatItem["iscustomizable"] == true){
            showModalBottomSheet(
                  backgroundColor: Customcolors.DECORATION_WHITE,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CustomiseBottomsheet(meatItem: meatItem, itemcountNotifier:itemCountNotifier ,
                      shopId: widget.shopId,customizedFoodvariants: meatItem["customizedFood"]["addVariants"],
                      addOns: meatItem["customizedFood"]["addOns"], availableStatus: meatItem["availableStatus"],
                         meatstatus: meatItem["status"],
                         shopstatus: widget.shopstatus, totalDis: widget.totalDis,),
                      Positioned(
                        top: -60,
                        right: 0,
                        left: 0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }else{
            showModalBottomSheet(
               backgroundColor: Customcolors.DECORATION_WHITE,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SingleChildScrollView(
                        child: ProductviewBottomsheet(meatItem: meatItem,
                         itemcountNotifier:itemCountNotifier ,
                         shopId: widget.shopId,
                         availableStatus: meatItem["availableStatus"],
                         meatstatus: meatItem["status"],
                         shopstatus: widget.shopstatus, totalDis: widget.totalDis,
                         ), // Replace with your widget
                      ),
                      Positioned(
                        top: -60,
                        right: 0,
                        left: 0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            
            }
          },
            child: meatItem["availableStatus"]==true &&meatItem["status"]==true&&widget.shopstatus==true?
            Container(
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
                      child: CachedNetworkImage(
                        useOldImageOnUrlChange: true,
                        imageUrl: meatItem["meatImgUrl"],
                        placeholder: (context, url) =>Image.asset(meatdummy),
                        errorWidget: (context, url, error) =>Image.asset(meatdummy),
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                   meatItem["iscustomizable"] == true
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
                          meatItem["meatName"].toString().capitalizeFirst.toString(),
                          overflow: TextOverflow.clip,
                          maxLines: 3,
                           style: CustomTextStyle.meatbold,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          meatItem["meatDiscription"].toString().capitalizeFirst.toString(),
                          style: CustomTextStyle.foodDescription,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "₹${meatItem["meat"]["customerPrice"]} / ${meatItem["meat"]["unitValue"]}${meatItem["meat"]["unit"].toString()}",
                          style: CustomTextStyle.meatpricetext,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 5),
                        MeatbuttonNew(
                           meatindex: meatItem,
                          meatcustomerprice:meatItem["meat"]["customerPrice"] ,
                          shopname: widget.shopname,
                          meatid: meatItem["_id"],
                          itemcountNotifier: itemCountNotifier,
                          shopId: widget.shopId, totalDis: widget.totalDis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ):InactiveGridclass(meatItem: meatItem,),
          );
        }),
      ),
    );
  }
}
