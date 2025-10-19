// ignore_for_file: must_be_immutable, avoid_print, file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:testing/Meat/MeatButtonFunctionalities/MeatAddproductController.dart/AddmeatController.dart';
import 'package:testing/Meat/MeatButtonFunctionalities/TotalitemcountButton.dart';
import 'package:testing/Meat/MeatController.dart/Meatsearchcontroller.dart';
import 'package:testing/Meat/MeatSearch/MeatItemwidget.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Meattabsub extends StatefulWidget {
  dynamic meats;
  dynamic index;
  dynamic index2;
  dynamic shopid;
  bool isTabScreen;
  dynamic status;
  dynamic activeStatus;
  int current;
  Meattabsub(
      {this.meats,
      this.index,
      required this.current,
       required this.status,
       required this.activeStatus,
      required this.shopid,
      this.isTabScreen = false,
      required this.index2,
      super.key});

  @override
  State<Meattabsub> createState() => MeattabsubState();
}

class MeattabsubState extends State<Meattabsub> {
  Meatsearchcontroller meatlistsearch = Get.put(Meatsearchcontroller());
  MeatAddcontroller meatcart = Get.put(MeatAddcontroller());
  MeatButtonController meatbuttonController = MeatButtonController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      meatcart.getmeatcartmeat(km: 0);
      meatbuttonController =Provider.of<MeatButtonController>(context, listen: false);
    });
  }

  Future<void> checkIfItemInCart() async {
    try {
      var cartItems = await meatcart.getmeatcartmeat(km: 0);

      var currentItem = cartItems.firstWhere(
        (item) => item['subAdminId'] == widget.shopid,
        orElse: () => null,
      );

      if (currentItem != null && currentItem['subAdminId'] == widget.shopid) {
        setState(() {
          currentItem['quantity'];
        });
      } else if (currentItem != null) {
        setState(() {
          Provider.of<MeatButtonController>(context, listen: false)
              .showmeatButton();
        });

        // setState(() {});
      } else {
        setState(() {
          Provider.of<MeatButtonController>(context, listen: false)
              .hidemeatButton();
        });
      }
    } catch (e) {
      print("Error checking if item is in cart: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> itemCountNotifier = ValueNotifier<int>(0);
    List<Map<String, dynamic>> addOnList = [];
    List<Map<String, dynamic>> variantList = [];

// Check if the food item is customizable
    if (widget.meats[widget.index2]
            ["iscustomizable"] ==
        true) {
      // Dynamically parse addOns if present
      final addOns =
          widget.meats[widget.index2]["customizedFood"]["addOns"];
      if (addOns is List) {
        addOnList = addOns.cast<Map<String, dynamic>>();
      }

      // Dynamically parse addVariants if present
      final addVariants = widget.meats[widget.index2]
          ["customizedFood"]["addVariants"];
      if (addVariants is List) {
        variantList = addVariants.cast<Map<String, dynamic>>();
      }
    } else {
      // Handle the non-customizable case
      const SizedBox();
    }

    double rating = meatlistsearch.meatlist!["data"]["AdminUserList"]
                    [widget.index]["ratingAverage"]
                .toString() ==
            'null'
        ? 0
        : double.tryParse(meatlistsearch.meatlist!["data"]["AdminUserList"]
                        [widget.index]["ratingAverage"]
                    .toString())
                ?.roundToDouble() ??
            0;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: const Color.fromARGB(255, 240, 240, 240),
         gradient: widget.status == true && widget.activeStatus == "online"
        ? null
        : const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(154, 255, 255, 255),
              Color.fromARGB(184, 219, 219, 219),
              Color.fromARGB(102, 255, 255, 255)
            ],
          ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child:widget.status==true&&widget.activeStatus=="online"&& meatlistsearch.meatlist!["data"]
                                  ["AdminUserList"][widget.index]
                                  ["categoryDetails"][0]["meats"][widget.index2]["availableStatus"]==true &&meatlistsearch.meatlist!["data"]
                                  ["AdminUserList"][widget.index]
                                  ["categoryDetails"][0]["meats"][widget.index2]["status"]==true? ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        child: CachedNetworkImage(
                          placeholder: (context, url) => Image.asset(
                            meatdummy,
                            fit: BoxFit.fill,
                            height: 10,
                            width: 10,
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                           meatdummy,
                            fit: BoxFit.fill,
                            height: 10,
                            width: 10,
                          ),
                          height: 110,
                          width: 100,
                          imageUrl: meatlistsearch.meatlist!["data"]
                                  ["AdminUserList"][widget.index]
                                  ["categoryDetails"][0]["meats"][widget.index2]
                                  ["meatImgUrl"]
                              .toString(),
                          fit: BoxFit.fill,
                          // You can specify height and width if needed, or omit them.
                        ),
                      ):ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        child: ColorFiltered(
                        colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.saturation,),
                          child: CachedNetworkImage(
                            placeholder: (context, url) => Image.asset(
                              meatdummy,
                              fit: BoxFit.fill,
                              height: 10,
                              width: 10,
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              meatdummy,
                              fit: BoxFit.fill,
                              height: 10,
                              width: 10,
                            ),
                            height: 110,
                            width: 100,
                            imageUrl: meatlistsearch.meatlist!["data"]
                                    ["AdminUserList"][widget.index]
                                    ["categoryDetails"][0]["meats"][widget.index2]
                                    ["meatImgUrl"]
                                .toString(),
                            fit: BoxFit.fill,
                            // You can specify height and width if needed, or omit them.
                          ),
                        ),
                      )),
                  meatlistsearch.meatlist!["data"]["AdminUserList"]
                              [widget.index]["categoryDetails"][0]["meats"]
                          [widget.index2]["iscustomizable"]
                      ? const SizedBox(
                          height: 5,
                        )
                      : const SizedBox(
                          height: 0,
                        ),
                  meatlistsearch.meatlist!["data"]["AdminUserList"]
                              [widget.index]["categoryDetails"][0]["meats"]
                          [widget.index2]["iscustomizable"]
                      ? const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text("Customisable",
                              style: CustomTextStyle.addressfetch),
                        )
                      : const SizedBox()
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 150,
                              child: Text(
                                meatlistsearch.meatlist!["data"]
                                        ["AdminUserList"][widget.index]
                                        ["categoryDetails"][0]["meats"]
                                        [widget.index2]["meatName"]
                                    .toString()
                                    .capitalizeFirst
                                    .toString(),
                                style: CustomTextStyle.googlebuttontext,
                                maxLines: 2,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        meatlistsearch.meatlist!["data"]["AdminUserList"][widget.index]
                                            ["categoryDetails"][0]["meats"]
                                        [widget.index2]["meatDiscription"] ==
                                    null ||
                                meatlistsearch.meatlist!["data"]["AdminUserList"]
                                            [widget.index]["categoryDetails"][0]["meats"]
                                        [widget.index2]["meatDiscription"] ==
                                    "" ||
                                meatlistsearch
                                    .meatlist!["data"]["AdminUserList"][widget.index]["categoryDetails"][0]
                                        ["meats"][widget.index2]["meatDiscription"]
                                    .isEmpty
                            ? const SizedBox.shrink()
                            : Text(
                                " ${meatlistsearch.meatlist!["data"]["AdminUserList"][widget.index]["categoryDetails"][0]["meats"][widget.index2]["meatDiscription"].toString().capitalizeFirst.toString()}",
                                style: CustomTextStyle.boldgrey,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 20,
                              color: Colors.amber,
                            ),
                            Text(" ${rating.toString()}",
                                style: CustomTextStyle.blacktext),
                            meatlistsearch
                                        .meatlist!["data"]["AdminUserList"]
                                            [widget.index]["ratings"]
                                        .isEmpty ||
                                    meatlistsearch.meatlist!["data"]
                                                ["AdminUserList"][widget.index]
                                            ["ratings"] ==
                                        null
                                ? const Text(" (0 reviews)",
                                    style: CustomTextStyle.boldgrey)
                                : Text(
                                    " (${meatlistsearch.meatlist!["data"]["AdminUserList"][widget.index]["ratings"].length} reviews)",
                                    style: CustomTextStyle.boldgrey)
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            meatlistsearch.meatlist!["data"]["AdminUserList"]
                                                [widget.index]
                                            ["categoryDetails"][0]["meats"]
                                        [widget.index2]["iscustomizable"] ==
                                    true
                                ? Text(
                                    "₹ ${meatlistsearch.meatlist!["data"]["AdminUserList"][widget.index]["categoryDetails"][0]["meats"][widget.index2]["customizedFood"]["addVariants"][0]["variantType"][0]["customerPrice"]}",
                                    style: CustomTextStyle.foodpricetext,
                                  )
                                : Text(
                                    "₹ ${meatlistsearch.meatlist!["data"]["AdminUserList"][widget.index]["categoryDetails"][0]["meats"][widget.index2]["meat"]["customerPrice"]}",
                                    style: CustomTextStyle.foodpricetext,
                                  ),
                            const SizedBox(
                              width: 2,
                            ),
                            meatlistsearch.meatlist!["data"]["AdminUserList"]
                                                [widget.index]
                                            ["categoryDetails"][0]["meats"]
                                        [widget.index2]["iscustomizable"] ==
                                    true
                                ? Text(
                                    "₹ ${meatlistsearch.meatlist!["data"]["AdminUserList"][widget.index]["categoryDetails"][0]["meats"][widget.index2]["customizedFood"]["addVariants"][0]["variantType"][0]["customerPrice"]}",
                                    style: CustomTextStyle.strikered,
                                  )
                                : Text(
                                    "₹ ${meatlistsearch.meatlist!["data"]["AdminUserList"][widget.index]["categoryDetails"][0]["meats"][widget.index2]["meat"]["customerPrice"]}",
                                    style: CustomTextStyle.strikered,
                                  ),
                          ],
                        ),
                        widget.status==true &&widget.activeStatus=="online"&& meatlistsearch.meatlist!["data"]
                                  ["AdminUserList"][widget.index]
                                  ["categoryDetails"][0]["meats"][widget.index2]["availableStatus"]==true &&meatlistsearch.meatlist!["data"]
                                  ["AdminUserList"][widget.index]
                                  ["categoryDetails"][0]["meats"][widget.index2]["status"]==true?
                        MeatsearchItem(
                          meatItemData: meatlistsearch.meatlist!["data"],
                          index: widget.index,
                          index2: widget.index2,
                          variantList: variantList,addOnList: addOnList,
                          itemCountNotifier: itemCountNotifier,
                          isFromTab: widget.isTabScreen,
                        ):const SizedBox()
                      ],
                    ),
                    const CustomSizedBox(height: 5,),
                  ],
                ),
              ),
            ],
          ),
        
        ],
      ),
    );
  }
}
