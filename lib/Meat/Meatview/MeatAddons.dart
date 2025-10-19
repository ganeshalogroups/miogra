// ignore_for_file: must_be_immutable, avoid_print, file_names

import 'package:dotted_line/dotted_line.dart';
import 'package:testing/Meat/MeatButtonFunctionalities/MeatAddproductController.dart/AddmeatController.dart';
import 'package:testing/Meat/MeatButtonFunctionalities/TotalitemcountButton.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Meataddons extends StatefulWidget {
   final List<dynamic>? customizedFoodvariants;
  final List<dynamic>? addOns;
  dynamic meatid;
  dynamic price;
  String shopname;
    dynamic shopid;
    final ValueNotifier<int> itemcountNotifier;
   Meataddons({
     this.customizedFoodvariants,
     this.addOns,
     this.meatid,
     this.price,
     this.shopid,
     required this.shopname,
     required this.itemcountNotifier,
    super.key});

  @override
  State<Meataddons> createState() => _MeataddonsState();
}

class _MeataddonsState extends State<Meataddons> {
  MeatAddcontroller meatcart = Get.put(MeatAddcontroller());
  MeatButtonController meatbuttonController = MeatButtonController();
  MeatCustomizationController meatcustomizationController = MeatCustomizationController();
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

       widget.itemcountNotifier.value = localItemCount; // Update value only when adding item to cart
    



    await meatcart.addmeat(
      meatid             : widget.meatid,
      isCustomized       : true,
      selectedVariantId  : meatcustomizationController.selectedVariantId.value,
      selectedAddOns     : meatcustomizationController.selectedAddons.toSet().toList(),
      // selectedVariantId: selectedVariantId,
      // selectedAddOns  : selectedaddons.toSet().toList(),
      quantity           : localItemCount,
      shopId       : widget.shopid.toString(),
    ).whenComplete(() => setState(() {
     isProcessing = false;
     meatcustomizationController.selectedAddons.clear();
     meatcustomizationController.selectedVariantId.value = "";
     meatcustomizationController.meatCustomerPrice.value = 0.0;
      meatbuttonController.showmeatButton();
       meatbuttonController.incrementmeatItemCount(localItemCount);
      Navigator.pop(context);
    }));
  }

  void checkIfItemInCart() async {
    try {


      var cartItems = await meatcart.getmeatcartmeat(km: 0);
      var currentItem = cartItems.firstWhere(
        (item) => item['meatId'] == widget.meatid,
        orElse: () => null,
      );

      setState(() {
        if (currentItem != null) {
          localItemCount = currentItem['quantity'];
        } else {
          localItemCount = 1; // Default to 1 if item is not in cart
        }

        if (currentItem != null || localItemCount != 1 || currentItem.isNotEmpty) {
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
  Widget build(BuildContext context) {
       double finalPrice = meatcustomizationController.meatCustomerPrice.value;
  // double initialPrice = widget.foodcustomerprice.toDouble();

  // Calculate total price
  double totalPrice =  finalPrice * localItemCount;

    loge.i('${widget.customizedFoodvariants!.length} = + = ${widget.addOns!.length} ');


    var totallength = widget.customizedFoodvariants!.length + widget.addOns!.length;

      return Container(

      // height: checkdd(context: context,totallength: totallength),
    
      height:  totallength== 1 ? totallength==2?  MediaQuery.of(context).size.height / 2.3     : MediaQuery.of(context).size.height / 3  : MediaQuery.of(context).size.height / 1.6,
     
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Customcolors.DECORATION_WHITE,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
                
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 160, vertical: 10),
                  child: Divider(
                    color: Customcolors.DECORATION_GREY,
                    thickness: 4,
                  ),
                ),

            Expanded(
              child: ListView(
                // physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  buildVariantList(),
                  const Divider(
                    color: Customcolors.DECORATION_LIGHTGREY,
                    endIndent: 10,
                    indent: 10,
                  ),
                  CustomSizedBox(height: 5.h),
                  buildAddOnsList(),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
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
    
                                  //  buttonController.decrementItemCount(localItemCount);
                                  // buttonController.updateItemCount(widget.foodid, _localItemCount);
                              }
                                else if (localItemCount == 1) {
                                // If the count is 1, remove the item and pop the screen
                                 Navigator.pop(context);}
                            },
                            child: const Icon(Icons.remove, color: Customcolors.darkpurple),
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
                              // buttonController.showButton();
                              //  buttonController.incrementItemCount(localItemCount);
                            },
                            child: const Icon(Icons.add, color: Customcolors.darkpurple),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                InkWell(
                  onTap: () {
                   if (isProcessing) return; // Prevent further clicks during processing

                      setState(() {
                        isProcessing = true; // Set processing flag to true
                      });
                       addInitialAddOnsToCart();
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

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    widget.customizedFoodvariants![index]["variantGroupName"].toString().capitalizeFirst.toString(),
                    // overflow: TextOverflow.ellipsis,
                    style: CustomTextStyle.blackB14,
                  ),
                ),
              CustomSizedBox(height: 3.h),
              if (index == 0) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Select any 1 option",
                      style: CustomTextStyle.addressfetch,
                    ),
                  ),
              ],
            CustomSizedBox(height: 3.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
               child: DottedLine(
                direction     : Axis.horizontal,
                alignment     : WrapAlignment.center,
                lineLength    : double.infinity,
                lineThickness : 1.0,
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
              String variantId = widget.customizedFoodvariants![index]["variantType"]![i]["_id"].toString();
              int? variantPrice = widget.customizedFoodvariants![index]["variantType"]![i]["customerPrice"]; // Keep as int

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width/1.85,  
                        child: Text(
                          widget.customizedFoodvariants![index]["variantType"]![i]["variantName"].toString().capitalizeFirst.toString(),
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
                            activeColor: Customcolors.darkpurple,
                            value: variantId,
                            groupValue: meatcustomizationController.selectedVariantId.value,
                            onChanged: (String? newValue) {
                            setState(() {
                               meatcustomizationController.updateVariant(newValue, variantPrice!);
                            });
                            },
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

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  widget.addOns![index1]["addOnsGroupName"].toString().capitalizeFirst.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyle.blackB14,
                ),
              ),

            CustomSizedBox(height: 3.h),

            if (index1 == 0) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child:  Text(
                    "Choose Add-Ons",
                    style: CustomTextStyle.addressfetch,
                    ),
                  ),
            ],

            CustomSizedBox(height: 3.h),


                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
                
                // var addOn = widget.addOns![index1].addOnsList![index];
    
                 String addOnId = widget.addOns![index1]["addOnsType"]![i]["_id"].toString();
                 int? addOnPrice = widget.addOns![index1]["addOnsType"]![i]["customerPrice"]; // Keep as int
             
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width/1.85,  
                            
                            child: Text(
                              widget.addOns![index1]["addOnsType"]![i]["variantName"].toString().capitalizeFirst.toString(),
                              overflow: TextOverflow.clip,
                              maxLines: 3,
                              style: CustomTextStyle.black12,
                            ),
                          ),
                      ),
    
                      // Spacer(),
      
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
                              activeColor: Customcolors.darkpurple,
                              value: meatcustomizationController.selectedAddons.contains(addOnId),
                              onChanged: (bool? newValue) {
                              setState(() {
                                meatcustomizationController.toggleAddon(addOnId, addOnPrice!);
                              });
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
            // CustomSizedBox(height: 5.h),
          ],
        );
      },
    );
  }

}