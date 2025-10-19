// ignore_for_file: must_be_immutable, file_names, avoid_print

import 'dart:async';

import 'package:dotted_line/dotted_line.dart';
import 'package:testing/Meat/MeatButtonFunctionalities/MeatAddproductController.dart/AddmeatController.dart';
import 'package:testing/Meat/MeatButtonFunctionalities/TotalitemcountButton.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatOrderController/MeatCouponcontroller.dart';
import 'package:testing/Meat/MeatOrderscreen/meatadditionalinfo.dart';
import 'package:testing/Meat/Meatview/CommonProductdetail.dart';
import 'package:testing/utils/Buttons/CustomAlertDialoug.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CustomiseBottomsheet extends StatefulWidget {
dynamic meatItem;
dynamic shopId;
dynamic totalDis;
final ValueNotifier<int> itemcountNotifier;
final List<dynamic>? customizedFoodvariants;
final List<dynamic>? addOns;
dynamic shopstatus;
dynamic availableStatus;
dynamic meatstatus;
 CustomiseBottomsheet({required this.meatItem, required this.itemcountNotifier,required this.shopId,  this.customizedFoodvariants,required this.totalDis,
 required this.availableStatus,required this.shopstatus,required this.meatstatus,this.addOns,super.key});

  @override
  State<CustomiseBottomsheet> createState() => _CustomiseBottomsheetState();
}

class _CustomiseBottomsheetState extends State<CustomiseBottomsheet> {
  MeatAddcontroller meatcart = Get.put(MeatAddcontroller());
  MeatButtonController meatbuttonController = MeatButtonController();
  MeatCustomizationController meatcustomizationController = Get.put(MeatCustomizationController());
  MeatCouponController coupon = MeatCouponController();
  List<String> selectedCategories = [];
  List<String> selectedaddons = [];
  String? selectedVariantId;
  int selectedValue = 0;
  int localItemCount = 1; 
  bool isProcessing = false;
  @override
    void initState() {
  

   WidgetsBinding.instance.addPostFrameCallback((_) {
    meatbuttonController = Provider.of<MeatButtonController>(context, listen: false);

    checkIfItemInCart();
    if (widget.customizedFoodvariants != null &&
        widget.customizedFoodvariants!.isNotEmpty) {
        setState(() {
        int firstVariantPrice = widget.customizedFoodvariants![0]["variantType"]![0]["customerPrice"] ?? 0;
        selectedVariantId     = widget.customizedFoodvariants![0]["variantType"]![0]["_id"].toString();
        meatcustomizationController.updateVariant(selectedVariantId,firstVariantPrice);
      });
    }
    
  });  super.initState();}



  void addInitialAddOnsToCart() async {
    widget.itemcountNotifier.value = localItemCount; 
    var orderForOthers  = Provider.of<MeatInstantUpdateProvider>(context,listen: false);
    var cartItems = await meatcart.getmeatcartmeat(km: widget.totalDis);
    var currentItem = cartItems.firstWhere(
      (item) => item['meatId'] == widget.meatItem["_id"],
      orElse: () => null,
    );
    String selectedVariantId = meatcustomizationController.selectedVariantId.value ?? '';
    List<String> selectedAddOns = meatcustomizationController.selectedAddons.toSet().toList();
 if (currentItem != null) {
      bool variantMatches =
          currentItem['selectedVariantId'] == selectedVariantId;

      // Check if the selected add-ons match the current item's add-ons
      List<String> currentAddOns =currentItem['selectedAddOns']?.cast<String>() ?? [];
      bool addonsMatch =Set<String>.from(currentAddOns).containsAll(selectedAddOns) &&Set<String>.from(selectedAddOns).containsAll(currentAddOns);

      if (variantMatches && addonsMatch) {
        // If matches, update quantity
        int existingQuantity = currentItem['quantity'];
        if (localItemCount > 0) {
          int updatedQuantity = existingQuantity + localItemCount;

          await meatcart
              .updatemeatItem(
            meatid: widget.meatItem["_id"],
            quantity: updatedQuantity,
          )
              .whenComplete(() {
            widget.itemcountNotifier.value = updatedQuantity;
            setState(() {
              meatbuttonController.showmeatButton();
              meatbuttonController.incrementmeatItemCount(localItemCount);
              Navigator.pop(context);
            });
          });


          await meatbuttonController.updatemeatTotalItemCount(meatcart,);
        } else {
          await meatcart.deleteCartItem(meatid: widget.meatItem["_id"])
              .whenComplete(() async {

                
            var updatedCartItems = await meatcart.getmeatcartmeat(km: widget.totalDis);
                
            if (updatedCartItems == null || updatedCartItems.isEmpty) {
              meatbuttonController.hidemeatButton();
            }

            await meatbuttonController.updatemeatTotalItemCount(meatcart,);
            Navigator.pop(context);
          });
        }
      } else if (!variantMatches || !addonsMatch) {
  showDialog(
    context: context,
    builder: (context) {
      return 
       CustomLogoutDialog(
            title: 'Replace Cart Item?',
            content:
                "Are you sure you want to change your previously added customization",
            onConfirm: () async {
              await meatcart.deleteCartItem(meatid: widget.meatItem["_id"]);

              await meatbuttonController.updatemeatTotalItemCount(meatcart,);
              // Add the new item with updated variant and add-ons
              await _addOrUpdateItemInCart(selectedVariantId, selectedAddOns);
               Navigator.pop(context);
               setState(() {
                   meatorderForSomeOneName = '';
                   meatorderForSomeOnePhone ='';
                 });
                 orderForOthers.meatupDateInstruction(instruction: '');
                 orderForOthers.meatupdateSomeOneDetaile(someOneName:'', someOneNumber: '');

             
            },
            buttonname: 'Replace', oncancel: () {
             setState(() {
             isProcessing = false;
            });
            Navigator.pop(context);
             });
    },
  ).whenComplete(() {
    // Ensure isProcessing is reset when dialog is closed by any method
    setState(() {
      isProcessing = false;
    });
  });
      }
    } else {

      await meatbuttonController.updatemeatTotalItemCount(meatcart);
      // Item is not in the cart; add it
      await _addOrUpdateItemInCart(selectedVariantId, selectedAddOns);
    }
  }

  Future<void> _addOrUpdateItemInCart( String selectedVariantId, List<String> selectedAddOns) async {
     
    await meatcart.addmeat(
      meatid: widget.meatItem["_id"],
      isCustomized: true,
      selectedVariantId: selectedVariantId,
      selectedAddOns: selectedAddOns,
      quantity: localItemCount,
      shopId: widget.shopId.toString(),
    )
        .whenComplete(() {
      setState(() {
      isProcessing = false;
        meatcustomizationController.selectedAddons.clear();
        meatcustomizationController.selectedVariantId.value = "";
        meatcustomizationController.meatCustomerPrice.value = 0.0;
        meatbuttonController.showmeatButton();
        meatbuttonController.incrementmeatItemCount(localItemCount);
        Navigator.pop(context);
      });
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
           widget.itemcountNotifier.value = 0; // Default to 1 if item is not in cart
        }

        if (currentItem != null ||  widget.itemcountNotifier.value != 0 || currentItem.isNotEmpty) {
          meatbuttonController.showmeatButton();
        } else {
          meatbuttonController.hidemeatButton();
        }
      });
    } catch (e) {
      print("Error checking if item is in cart: $e");
    }
  }

  String? addonid;

@override
@override
Widget build(BuildContext context) {
  double finalPrice = meatcustomizationController.meatCustomerPrice.value;

    double totalPrice = finalPrice * localItemCount;
  var totallength = widget.customizedFoodvariants!.length + widget.addOns!.length;

  double containerHeight;
  if (totallength == 1) {
    containerHeight = MediaQuery.of(context).size.height / 2.3 + 250.h;
  } else if (totallength == 2) {
    containerHeight = MediaQuery.of(context).size.height / 3 + 250.h;
  } else {
    containerHeight = MediaQuery.of(context).size.height / 1.6 + 250.h;
  }

  double minHeight = 400.h; // Adjust this as per your requirements

  return Container(
    height: containerHeight < minHeight ? minHeight : containerHeight, // Set minimum height
    decoration: const BoxDecoration(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      color: Customcolors.DECORATION_WHITE,
    ),
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Wrap the entire content in SingleChildScrollView to make everything scrollable
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Common product details
                Commonproductdetailclass(meatItem: widget.meatItem,meatstatus: widget.meatstatus,shopstatus: widget.shopstatus,availableStatus: widget.availableStatus,),
                
                // Build Variant List
                buildVariantList(),
                
                // Divider
                const Divider(
                  color: Customcolors.DECORATION_LIGHTGREY,
                  endIndent: 10,
                  indent: 10,
                ),
                
                // Add space between sections
                CustomSizedBox(height: 5.h),
                
                // Build Add-Ons List
                buildAddOnsList(),
              ],
            ),
          ),
        ),
        
        // Price and ADD button
        const SizedBox(width: 16),
        // ADD button
                  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        child: widget.availableStatus == true &&
                 widget.shopstatus ==true &&
                 widget.meatstatus == true? Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ValueListenableBuilder<int>(
              valueListenable: widget.itemcountNotifier,
              builder: (context, itemCount, child) {
                return Container(
        padding: const EdgeInsets.symmetric(vertical: 2),
        width: 100,
        decoration: CustomContainerDecoration.customisedbuttondecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                if (localItemCount > 1) {
                  setState(() {
                    localItemCount--;
                  });
                   } else if (localItemCount == 1) {
                  Navigator.pop(context);
                }
              },
              child: const Icon(
                Icons.remove,
                color: Customcolors.darkpurple,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '$localItemCount',
              style: CustomTextStyle.decorationORANGEtext22,
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: () {
                setState(() {
                  localItemCount++;
                });
                meatbuttonController.showmeatButton();
              },
              child: const Icon(
                Icons.add,
                color: Customcolors.darkpurple,
              ),
            ),
          ],
        ),
                );
              },
            ),
            InkWell(
              onTap: () async {
                if (isProcessing) return; // Prevent further clicks during processing
        
                setState(() {
        isProcessing = true; // Set processing flag to true
                });
        
                var cartItems = await meatcart.getmeatcartmeat(km: widget.totalDis);
                var isDifferentshop = cartItems.any((item) => item['subAdminId'] != widget.shopId);
        
                if (isDifferentshop) {
        showReplaceCartDialog();
                } else {
        addInitialAddOnsToCart();
                }
              },
              child: CustomContainer(
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: CustomContainerDecoration.gradientbuttondecoration(),
                child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Center(
          child: Text(
            "Add Item | ₹${totalPrice.toStringAsFixed(2)}",
            overflow: TextOverflow.ellipsis,
            style: CustomTextStyle.smallwhitetext,
          ),
        ),
                ),
              ),
            ),
          ],
        ):Center(
          child: CustomContainer(
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: CustomContainerDecoration.greybuttondecoration(),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                                child: Center(
                                  child: Text(
                                    "No meat available right now",
                                    overflow: TextOverflow.ellipsis,
                                    style: CustomTextStyle.smallwhitetext,
                                  ),
                                ),
                              ),
                            ),
        ),
                  ),
      ],
    ),
  );
}

Widget buildVariantList() {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: widget.customizedFoodvariants!.length,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.customizedFoodvariants![index]["variantGroupName"]
                .toString()
                .capitalizeFirst
                .toString(),
            style: CustomTextStyle.blackB14,
          ),
          CustomSizedBox(height: 3.h),
          if (index == 0) ...[
            const Text(
              "Select any 1 option",
              style: CustomTextStyle.addressfetch,
            ),
          ],
          CustomSizedBox(height: 3.h),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: DottedLine(
              direction: Axis.horizontal,
              alignment: WrapAlignment.center,
              lineLength: double.infinity,
              lineThickness: 1.0,
              dashLength: 4.0,
              dashColor: Colors.black,
              dashGradient: const [
                Color.fromARGB(255, 169, 169, 169),
                Color.fromARGB(255, 185, 187, 188)
              ],
              dashRadius: 4,
              dashGapLength: 6,
              dashGapRadius: 5,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.customizedFoodvariants![index]["variantType"]!.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              String variantId =
                  widget.customizedFoodvariants![index]["variantType"][i]["_id"].toString();
              int? variantPrice =
                  widget.customizedFoodvariants![index]["variantType"]![i]["customerPrice"];

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.85,
                      child: Text(
                        widget.customizedFoodvariants![index]["variantType"]![i]["variantName"]
                            .toString()
                            .capitalizeFirst
                            .toString(),
                        overflow: TextOverflow.clip,
                        style: CustomTextStyle.black12,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "+ ₹${widget.customizedFoodvariants![index]["variantType"]![i]["customerPrice"].toString()}",
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyle.black12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Transform.scale(
                        scale: 1,
                        child: Radio(
                          activeColor:widget.availableStatus == true &&widget.shopstatus ==true &&widget.meatstatus == true? Customcolors.darkpurple:Customcolors.DECORATION_GREY,
                          value: variantId,
                          groupValue: meatcustomizationController.selectedVariantId.value,
                          onChanged:widget.availableStatus == true &&widget.shopstatus ==true &&widget.meatstatus == true? (String? newValue) {
                            setState(() {
                              meatcustomizationController.updateVariant(newValue, variantPrice!);
                            });
                          }:null,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          CustomSizedBox(height: 5.h),
        ],
      );
    },
  );
}

Widget buildAddOnsList() {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: widget.addOns!.length,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.addOns![index1]["addOnsGroupName"]
                .toString()
                .capitalizeFirst
                .toString(),
            overflow: TextOverflow.ellipsis,
            style: CustomTextStyle.blackB14,
          ),
          CustomSizedBox(height: 3.h),
          if (index1 == 0) ...[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Choose Add-Ons",
                style: CustomTextStyle.addressfetch,
              ),
            ),
          ],
          CustomSizedBox(height: 3.h),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: DottedLine(
              direction: Axis.horizontal,
              alignment: WrapAlignment.center,
              lineLength: double.infinity,
              lineThickness: 1.0,
              dashLength: 4.0,
              dashColor: Colors.black,
              dashGradient: const [
                Color.fromARGB(255, 169, 169, 169),
                Color.fromARGB(255, 185, 187, 188)
              ],
              dashRadius: 4,
              dashGapLength: 6,
              dashGapRadius: 5,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.addOns![index1]["addOnsType"]!.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              String addOnId =
                  widget.addOns![index1]["addOnsType"]![i]["_id"].toString();
              int? addOnPrice =
                  widget.addOns![index1]["addOnsType"]![i]["customerPrice"];

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.85,
                        child: Text(
                          widget.addOns![index1]["addOnsType"]![i]["variantName"]
                              .toString()
                              .capitalizeFirst
                              .toString(),
                          overflow: TextOverflow.clip,
                          maxLines: 3,
                          style: CustomTextStyle.black12,
                        ),
                      ),
                    ),
                    Text(
                      "+ ₹${widget.addOns![index1]["addOnsType"]![i]["customerPrice"].toString()}",
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyle.black12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Transform.scale(
                        scale: 1,
                        child: Checkbox(
                          activeColor:widget.availableStatus == true &&widget.shopstatus ==true &&widget.meatstatus == true? Customcolors.darkpurple:Customcolors.DECORATION_GREY,
                          value: meatcustomizationController.selectedAddons.contains(addOnId),
                          onChanged: widget.availableStatus == true &&widget.shopstatus ==true &&widget.meatstatus == true? (bool? newValue) {
                            setState(() {
                              meatcustomizationController.toggleAddon(addOnId, addOnPrice!);
                            });
                          }:null,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      );
    },
  );
}
 Future<void> updateItemCount(int itemCount) async {
    if (itemCount > 0) {
      await meatcart.updatemeatItem(meatid: widget.meatItem["_id"], quantity: itemCount);
    } else {
      await meatcart
          .deleteCartItem(meatid: widget.meatItem["_id"])
          .whenComplete(() async {
          setState(() {
         meatcustomizationController.selectedAddons.clear();
         meatcustomizationController.selectedVariantId.value = "";
         meatcustomizationController.meatCustomerPrice.value = 0.0;
          });
        var cartItems = await meatcart.getmeatcartmeat(km: widget.totalDis);
        if (cartItems == null || cartItems.isEmpty) {
          meatbuttonController.hidemeatButton();
        }
        await meatbuttonController.updatemeatTotalItemCount(meatcart);
      });
    }
  }
void showReplaceCartDialog() {
  var orderForOthers = Provider.of<MeatInstantUpdateProvider>(context, listen: false);

  showDialog(
    context: context,
    builder: (context) {
      return CustomLogoutDialog(
        // context: context,
        title: 'Replace Cart Item?',
        content: "You can only add products from one shop at a time. Do you want to clear the cart?",
        onConfirm: () async {
          await meatcart.clearmeatCartItem(context: context);
          coupon.removeCoupon();
          await meatcart.getmeatcartmeat(km: widget.totalDis);
          meatbuttonController.totalItemCountNotifier.value = 0;
          Navigator.pop(context);
          addInitialAddOnsToCart();
          setState(() {
            meatorderForSomeOneName = '';
            meatorderForSomeOnePhone = '';
          });
          // Update order details in the provider
          orderForOthers.meatupDateInstruction(instruction: '');
          orderForOthers.meatupdateSomeOneDetaile(someOneName: '', someOneNumber: '');
        },
        buttonname: 'Replace',
        oncancel: () {
          Navigator.pop(context);
        },
      );
    },
  ).whenComplete(() {
    // Ensure isProcessing is reset when dialog is closed by any method
    setState(() {
      isProcessing = false;
    });
  });
}
}