// ignore_for_file: file_names, must_be_immutable, avoid_print, use_build_context_synchronously, unnecessary_brace_in_string_interps

import 'package:testing/Meat/MeatButtonFunctionalities/MeatAddproductController.dart/AddmeatController.dart';
import 'package:testing/Meat/MeatButtonFunctionalities/TotalitemcountButton.dart';
import 'package:testing/Meat/MeatOrderscreen/meatadditionalinfo.dart';
import 'package:testing/Meat/Meatview/CommonProductdetail.dart';
import 'package:testing/utils/Buttons/CustomAlertDialoug.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProductviewBottomsheet extends StatefulWidget {
dynamic meatItem;
dynamic shopId;
dynamic shopstatus;
dynamic availableStatus;
dynamic meatstatus;
dynamic totalDis;
  final ValueNotifier<int> itemcountNotifier;
 ProductviewBottomsheet({super.key,required this.meatItem, required this.itemcountNotifier,required this.shopId,required this.availableStatus,required this.shopstatus,required this.meatstatus,required this.totalDis});

  @override
  State<ProductviewBottomsheet> createState() => _ProductviewBottomsheetState();
}

class _ProductviewBottomsheetState extends State<ProductviewBottomsheet> {
  MeatAddcontroller meatcart = Get.put(MeatAddcontroller());
  MeatButtonController meatbuttonController = MeatButtonController();
 bool isProcessing = false;
   @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      meatcart.getmeatcartmeat(km: widget.totalDis);
      meatbuttonController =Provider.of<MeatButtonController>(context, listen: false);
      checkIfItemInCart();
    });
  }

 Future<void> checkIfItemInCart() async {
    try {
      var cartItems = await meatcart.getmeatcartmeat(km: widget.totalDis);
      var currentItem = cartItems.firstWhere(
        (item) => item['meatId'] == widget.meatItem["_id"],
        orElse: () => null,
      );

      setState(() {
        if (currentItem != null) {
          widget.itemcountNotifier.value = currentItem['quantity'];
        } else {
          widget.itemcountNotifier.value = 0;
        }

        if (currentItem != null ||
            widget.itemcountNotifier.value != 0 ||
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

 
  @override
  Widget build(BuildContext context) {
  var orderForOthers  = Provider.of<MeatInstantUpdateProvider>(context);
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Customcolors.DECORATION_WHITE,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
         Commonproductdetailclass(meatItem: widget.meatItem,meatstatus: widget.meatstatus,shopstatus: widget.shopstatus,availableStatus: widget.availableStatus,),
          // Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            ValueListenableBuilder<int>(
            valueListenable: widget.itemcountNotifier,
            builder: (context, itemCount, child) {
            dynamic basePrice = widget.meatItem["meat"]["customerPrice"];
            dynamic unitValue = itemCount > 0 ? widget.meatItem["meat"]["unitValue"]*itemCount:widget.meatItem["meat"]["unitValue"];
            dynamic totalPrice = itemCount > 0 ? basePrice * itemCount : basePrice;

            return Text(
            '₹${totalPrice.toStringAsFixed(2)} / ${unitValue}${widget.meatItem["meat"]["unit"]}',
            style: CustomTextStyle.boldblack,
          );
        },
       ),
              const SizedBox(width: 16),
             widget.availableStatus==true &&widget.meatstatus==true&&widget.shopstatus==true?
              // ADD button
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CustomContainer(
                  height: 30.h,
                  width: 90.w,
                  decoration: CustomContainerDecoration.gradientborderdecoration(
                    radious: 8.0,
                    borderwidth: 0.6,
                  ),
                  child:ValueListenableBuilder<int>(
                  valueListenable: widget.itemcountNotifier,
                  builder: (context, itemCount, child) {
                  return itemCount == 0
                  ? InkWell(
            onTap: () async {
              if (isProcessing) return; // Prevent further clicks during processing

              setState(() {
                isProcessing = true; // Set processing flag to true
              });

              await checkIfItemInCart();

              var cartItems = await meatcart.getmeatcartmeat(km: widget.totalDis);

              var isDifferentshop = cartItems.any(
                (item) => item['subAdminId'] != widget.shopId,
              );

              if (cartItems != null && isDifferentshop) {
                Future.delayed(Duration.zero, () {
                  CustomLogoutDialog.show(
                    context: context,
                    title: 'Replace Cart Item?',
                    content:
                        "You can only add products from one restaurant at a time. Do you want to clear the cart?",
                    onConfirm: () async {
                        await meatcart.clearmeatCartItem(context: context);
                        meatcart.getmeatcartmeat(km: widget.totalDis);

                        meatbuttonController.totalItemCountNotifier.value = 0;
                        widget.itemcountNotifier.value = 1;

                        meatcart.addmeat(
                          meatid: widget.meatItem["_id"],
                          isCustomized: false,
                          quantity: widget.itemcountNotifier.value,
                          shopId: widget.shopId,
                        );

                        meatbuttonController.showmeatButton();
                        meatbuttonController.incrementmeatItemCount(1);

                        setState(() {
                          isProcessing = false; // Reset processing flag
                        });

                        Navigator.pop(context);
                      

                      setState(() {
                        meatorderForSomeOneName = '';
                        meatorderForSomeOnePhone = '';
                      });

                      orderForOthers.meatupDateInstruction(instruction: '');
                      orderForOthers.meatupdateSomeOneDetaile(
                        someOneName: '',
                        someOneNumber: '',
                      );
                    },
                    buttonname: 'Replace',
                    oncancel: () {
                      Navigator.pop(context);
                    },
                  );
                });
              }else {
                widget.itemcountNotifier.value = 1;

                meatcart.addmeat(
                  meatid:  widget.meatItem["_id"],
                  isCustomized: false,
                  quantity: widget.itemcountNotifier.value,
                  shopId: widget.shopId,
                );

                meatbuttonController.showmeatButton();
                meatbuttonController.incrementmeatItemCount(1);
              }

              setState(() {
                isProcessing = false; // Reset processing flag after bottom sheet is done
              });
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
                      widget.itemcountNotifier.value--;

                      if (widget.itemcountNotifier.value <= 0) {
                        widget.itemcountNotifier.value = 0;
                      }

                      meatbuttonController.decrementmeatItemCount(1);
                      updateItemCount(widget.itemcountNotifier.value);
                    },
                    child: const Icon(
                      Icons.remove,
                      color: Customcolors.darkpurple,
                      size: 15,
                      weight: 20,
                    ),
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
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 1,
                  child: InkWell(
                    onTap: () {
                      widget.itemcountNotifier.value++;
                      updateItemCount(widget.itemcountNotifier.value);
                      meatbuttonController.incrementmeatItemCount(1);
                      meatbuttonController.showmeatButton();
                    },
                    child: const Icon(
                      Icons.add,
                      color: Customcolors.darkpurple,
                      size: 15,
                      weight: 20,
                    ),
                  ),
                ),
              ),
            ],
          );
  },
)
),
              ):CustomContainer(
                                width:  MediaQuery.of(context).size.width * 0.5,
                                decoration: CustomContainerDecoration.greybuttondecoration(),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                                  child: Center(
                                    child: Text(
                                      "Meat Unavailable",
                                      overflow: TextOverflow.ellipsis,
                                      style: CustomTextStyle.smallwhitetext,
                                    ),
                                  ),
                                ),
                              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> updateItemCount(int itemCount) async {
    if (itemCount > 0) {
      await meatcart.updatemeatItem(meatid: widget.meatItem["_id"], quantity: itemCount);
    } else {
      await meatcart
          .deleteCartItem(meatid: widget.meatItem["_id"],)
          .whenComplete(() async {
        var cartItems = await meatcart.getmeatcartmeat(km: widget.totalDis);
        if (cartItems == null || cartItems.isEmpty) {
          meatbuttonController.hidemeatButton();
        }
        await meatbuttonController.updatemeatTotalItemCount(meatcart);
      });
    }
  }
}
