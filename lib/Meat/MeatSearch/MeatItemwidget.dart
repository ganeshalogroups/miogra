// ignore_for_file: must_be_immutable, avoid_print, use_build_context_synchronously, file_names

import 'package:testing/Meat/MeatButtonFunctionalities/MeatAddproductController.dart/AddmeatController.dart';
import 'package:testing/Meat/MeatButtonFunctionalities/TotalitemcountButton.dart';
import 'package:testing/Meat/Meatview/Meatproductview.dart';
import 'package:testing/utils/Buttons/CustomAlertDialoug.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MeatsearchItem extends StatefulWidget {
  final int index;
  final int index2;
  final dynamic meatItemData;
  dynamic addOnList;
  dynamic variantList;
  final ValueNotifier<int> itemCountNotifier;
  bool isFromTab;
  MeatsearchItem({
    super.key,
    required this.index,
    required this.variantList,
    required this.addOnList,
    required this.index2,
    this.isFromTab = false,
    required this.meatItemData,
    required this.itemCountNotifier,
  });

  @override
  State<MeatsearchItem> createState() => _MeatsearchItemState();
}

class _MeatsearchItemState extends State<MeatsearchItem> {
  MeatAddcontroller meatcart = Get.put(MeatAddcontroller());
  MeatButtonController meatbuttonController = MeatButtonController();
  bool isProcessing = false;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      meatcart.getmeatcartmeat(km: 0);
      meatbuttonController =Provider.of<MeatButtonController>(context, listen: false);
      checkIfItemInCart();
    });
  }

  Future<void> checkIfItemInCart() async {
    final meatDetails = widget.meatItemData["AdminUserList"][widget.index]
        ["categoryDetails"][0]["meats"][widget.index2];

    try {
      var cartItems = await meatcart.getmeatcartmeat(km: 0);

      var currentItem = cartItems.firstWhere(
        (item) => item['meatId'] == meatDetails["_id"],
        orElse: () => null,
      );

      setState(() {
        if (currentItem != null) {
          widget.itemCountNotifier.value = currentItem['quantity'];
        } else {
          widget.itemCountNotifier.value = 0;
        }

        if (currentItem != null ||
            widget.itemCountNotifier.value != 0 ||
            currentItem.isNotEmpty) {
          meatbuttonController.showmeatButton();
        } else {
          meatbuttonController.hidemeatButton();
        }
      });

      await meatbuttonController.updatemeatTotalItemCount(meatcart);
    } catch (e) {
      print("Error checking if item is in cart: $e");
    }
  }

  Future<void> addmeatToCart() async {
    if (isProcessing) return; // Prevent further clicks during processing

    setState(() {
      isProcessing = true; // Set processing flag to true
    });
    await checkIfItemInCart();
     var cartItems = await meatcart.getmeatcartmeat(km: 0);

    var isDifferentshop = cartItems.any(
      (item) => item['restaurantId'] != widget.meatItemData["AdminUserList"][widget.index]["_id"],
    );

    if (isDifferentshop) {
      _showReplaceCartDialog();
    } else {
      _addOrNavigateToCustomize();
    }
  }
  Future<void> _showReplaceCartDialog() async {
    Future.delayed(Duration.zero, () {
      showDialog(
          context: context,
          builder: (context) {
            return CustomLogoutDialog(
              title: 'Replace Cart Item?',
              content:"You can only add products from one Shop at a time. Do you want to clear the cart?",
              onConfirm: () async {
                await meatcart.clearmeatCartItem(context: context);
                meatcart.getmeatcartmeat(km: 0);
                meatbuttonController.totalItemCountNotifier.value = 0;
                Navigator.pop(context);
                _addOrNavigateToCustomize();
              },
              buttonname: 'Replace',
              oncancel: () {
                Navigator.pop(context);
              },
            );
          }).whenComplete(() => setState(() {
            isProcessing = false;
          }));
    });
  }

  Future<void> _addOrNavigateToCustomize() async {
    final meatDetails = widget.meatItemData["AdminUserList"][widget.index]
        ["categoryDetails"][0]["meats"][widget.index2];
     double rating = widget.meatItemData["AdminUserList"][widget.index]["ratingAverage"].toString() =='null'
        ? 0
        : double.tryParse(widget.meatItemData["AdminUserList"][widget.index]["ratingAverage"].toString())?.roundToDouble() 
        ??0;
        final List meatfavourListDetails = widget.meatItemData["AdminUserList"]
                                [widget.index]["favourListDetails"] ??
                            [];
    if (meatDetails["iscustomizable"] == true) {
      Get.to(
        Meatproductviewscreen(
          meatfavourListDetails: meatfavourListDetails,
          isFrommeatscreen: widget.isFromTab,
          shopid: widget.meatItemData["AdminUserList"][widget.index]["_id"],
          city: widget.meatItemData["AdminUserList"][widget.index]["address"]["city"],
          shopname: widget.meatItemData["AdminUserList"][widget.index]["name"],
          imgurl: widget.meatItemData["AdminUserList"][widget.index]["imgUrl"],
          region: widget.meatItemData["AdminUserList"][widget.index]["address"]["region"],
          addOnsL: widget.addOnList,
          customizemeatVariants: widget.variantList,
          meatCustomerPrice: meatDetails["meat"]["customerPrice"],
          meatId: meatDetails["_id"],
          iscustomizable: true,
          itemcountNotifier: widget.itemCountNotifier,
          fulladdress: widget.meatItemData["AdminUserList"][widget.index]["address"]["fullAddress"],
          rating: rating, totalDis: 5,
        ),
      );
    } else {
      // Add item directly to cart
      meatcart.addmeat(
        meatid: meatDetails["_id"],
        isCustomized: false,
        quantity: 1,
        shopId: widget.meatItemData["AdminUserList"][widget.index]["_id"],
      );
      meatbuttonController.showmeatButton();
      meatbuttonController.incrementmeatItemCount(1);
      setState(() {
        isProcessing = false; // Reset processing flag
      });
      widget.itemCountNotifier.value = 1;
      Get.to(
        Meatproductviewscreen(
          meatfavourListDetails: meatfavourListDetails,
          isFrommeatscreen: widget.isFromTab,
          shopid: widget.meatItemData["AdminUserList"][widget.index]["_id"],
          city: widget.meatItemData["AdminUserList"][widget.index]["address"]["city"],
          shopname: widget.meatItemData["AdminUserList"][widget.index]["name"],
          imgurl: widget.meatItemData["AdminUserList"][widget.index]["imgUrl"],
          region: widget.meatItemData["AdminUserList"][widget.index]["address"]["region"],
          meatId: meatDetails["_id"],
          iscustomizable: false,
          itemcountNotifier: widget.itemCountNotifier,
          fulladdress: widget.meatItemData["AdminUserList"][widget.index]["address"]["fullAddress"],
          rating: rating, totalDis: 5,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: CustomContainer(
        // padding: EdgeInsets.symmetric(vertical: 3),
        height: 25.h,
        width: 80.w,
        decoration:
            CustomContainerDecoration.gradientborderdecoration(radious: 10.0),
        child: ValueListenableBuilder<int>(
          valueListenable: widget.itemCountNotifier,
          builder: (context, itemCount, child) {
            return itemCount == 0
                ? InkWell(
                    onTap: () {
                      addmeatToCart();
                    },
                    child: Center(
                      child: Text(
                        'ADD',
                        style: CustomTextStyle.addbtn,
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       Expanded(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 1,
                          child: InkWell(
                            onTap: () async {
                              widget.itemCountNotifier.value--;

                              if (widget.itemCountNotifier.value <= 0) {
                                widget.itemCountNotifier.value = 0;
                                }
                              meatbuttonController.decrementmeatItemCount(1);
                              updateItemCount(widget.itemCountNotifier.value);
                            },
                            child: const Icon(Icons.remove,
                                color: Customcolors.darkpurple,
                                size: 15,
                                weight: 20),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '$itemCount',
                            style: CustomTextStyle.addbtn,
                            // style: CustomTextStyle.decorationORANGEtext22,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                       Expanded(
                        child: SizedBox(
                          // color: Colors.amber,
                          height: MediaQuery.of(context).size.height / 1,
                          child: InkWell(
                            onTap: () {
                              widget.itemCountNotifier.value++;
                              updateItemCount(widget.itemCountNotifier.value);
                              meatbuttonController.incrementmeatItemCount(1);
                              meatbuttonController.showmeatButton();
                              },
                            child: const Icon(Icons.add,
                                color: Customcolors.darkpurple,
                                size: 15,
                                weight: 20),
                          ),
                        ),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
   Future<void> updateItemCount(int itemCount) async {
    final meatDetails = widget.meatItemData["AdminUserList"][widget.index]
        ["categoryDetails"][0]["meats"][widget.index2];
    if (itemCount > 0) {
      await meatcart.updatemeatItem(
          meatid: meatDetails["_id"], quantity: itemCount);
    } else {
      await meatcart
          .deleteCartItem(
        meatid: meatDetails["_id"],
      )
          .whenComplete(() async {
        var cartItems = await meatcart.getmeatcartmeat(km: 0);
        if (cartItems == null || cartItems.isEmpty) {
          meatbuttonController.hidemeatButton();
        }
        await meatbuttonController.updatemeatTotalItemCount(meatcart);
      });
    }
  }

}
