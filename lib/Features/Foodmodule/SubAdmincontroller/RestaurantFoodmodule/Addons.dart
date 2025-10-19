// ignore_for_file: avoid_print, file_names

import 'package:dotted_line/dotted_line.dart';
import 'package:testing/Features/Foodmodule/Domain/Foodnonvegmodel.dart';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Addfoodcontroller.dart';
import 'package:testing/Features/Foodmodule/Foodviewscreen/AddButtonFunctions/Buttonfunctionalities.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';



// ignore: must_be_immutable
class CustomiseAddons extends StatefulWidget {
  final List<AddVariant>? customizedFoodvariants;
  final List<AddOn>? addOns;
  final dynamic foodtype;
  dynamic foodid;
  dynamic  totalDis;
  dynamic price;
  dynamic foodcustomerprice;
  String restaurantname;
    dynamic restaurantid;
    final ValueNotifier<int> itemcountNotifier;
    bool isFromCartScreen;
   CustomiseAddons({
   required this. totalDis,
     this.customizedFoodvariants,
     this.addOns,
     this.foodtype,
     this.foodid,
     this.price,
     this.restaurantid,
     this.foodcustomerprice,
     required this.restaurantname,
     this.isFromCartScreen=false,
    //  this.itemcount,
    super.key, required this.itemcountNotifier,
  });

  @override
  State<CustomiseAddons> createState() => _AddonsState();
}


class _AddonsState extends State<CustomiseAddons> {


  final AddProductController controller = Get.put(AddProductController());
  Foodcartcontroller foodcart = Get.put(Foodcartcontroller());
  ButtonController buttonController = ButtonController();
  FoodCustomizationController foodCustomizationController = Get.put(FoodCustomizationController());
  List<String> selectedCategories = [];
  List<String> selectedaddons = [];
  String? selectedVariantId;
  int selectedValue = 0;
  int localItemCount = 1; 

   bool isProcessing = false;
  @override
  // void initState() {
  

  //  WidgetsBinding.instance.addPostFrameCallback((_) {
  //   buttonController = Provider.of<ButtonController>(context, listen: false);

  //   checkIfItemInCart();
  //   if (widget.customizedFoodvariants != null &&
  //       widget.customizedFoodvariants!.isNotEmpty) {
  //       setState(() {
  //       dynamic firstVariantPrice = widget.customizedFoodvariants![0].variantType![0].customerPrice ?? 0;
  //       selectedVariantId     = widget.customizedFoodvariants![0].variantType![0].id.toString();
  //       foodCustomizationController.updateVariant(selectedVariantId,firstVariantPrice);
  //     });
  //   }
    
  // });  super.initState();}
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      buttonController = Provider.of<ButtonController>(context, listen: false);
      await patchCartToUI();
    });
  }
Future<void> patchCartToUI() async {
  final cartItems = await foodcart.getfoodcartfood(km: widget.totalDis);
  final currentItem = cartItems.firstWhere(
    (item) => item['foodId'] == widget.foodid,
    orElse: () => null,
  );

  if (currentItem != null) {
    String? variantId = currentItem['selectedVariantId'];
    List<String> selectedAddOnsFromCart = List<String>.from(currentItem['selectedAddOns'] ?? []);

    double variantPrice = 0.0;
    double addOnTotal = 0.0;
    Map<String, double> patchAddonPrices = {};

    // Fetch variant price
    for (var variantGroup in widget.customizedFoodvariants ?? []) {
      for (var variant in variantGroup.variantType ?? []) {
        if (variant.id.toString() == variantId) {
          variantPrice = variant.customerPrice?.toDouble() ?? 0.0;
        }
      }
    }

    // Fetch addon prices
    for (var addOnGroup in widget.addOns ?? []) {
      for (var addon in addOnGroup.addOnsType ?? []) {
        if (selectedAddOnsFromCart.contains(addon.id.toString())) {
          double addonPrice = addon.customerPrice?.toDouble() ?? 0.0;
          addOnTotal += addonPrice;
          patchAddonPrices[addon.id.toString()] = addonPrice;
        }
      }
    }

    setState(() {
      foodCustomizationController.selectedVariantId.value = variantId!;
      foodCustomizationController.selectedAddons.clear();
      foodCustomizationController.selectedAddons.addAll(selectedAddOnsFromCart);

      foodCustomizationController.baseVariantPrice.value = variantPrice;
      foodCustomizationController.addonPrices = patchAddonPrices;
      foodCustomizationController.calculateTotalPrice(); // triggers foodCustomerPrice update

      localItemCount = currentItem['quantity'] ?? 1;
      widget.itemcountNotifier.value = localItemCount;
    });
  } else {
    // If first time, set default variant
    if (widget.customizedFoodvariants != null && widget.customizedFoodvariants!.isNotEmpty) {
      var firstVariant = widget.customizedFoodvariants![0].variantType?.first;
      if (firstVariant != null) {
        setState(() {
          foodCustomizationController.selectedVariantId.value = firstVariant.id.toString();
          foodCustomizationController.baseVariantPrice.value = firstVariant.customerPrice?.toDouble() ?? 0.0;
          foodCustomizationController.selectedAddons.clear();
          foodCustomizationController.addonPrices.clear();
          foodCustomizationController.calculateTotalPrice();
        });
      }
    }
  }
}

// void addInitialAddOnsToCart() async {

//   await foodcart.addfood(
//     foodid: widget.foodid,
//     isCustomized: true,
//     selectedVariantId: foodCustomizationController.selectedVariantId.value,
//     selectedAddOns: foodCustomizationController.selectedAddons.toSet().toList(),
//     quantity: localItemCount,
//     restaurantId: widget.restaurantid.toString(),
//   );

//   if (!mounted) return;

//   // ✅ Handle unavailable item
//   if (foodcart.lastAddFoodCode == 402 &&
//       foodcart.lastAddFoodMessage == "This Food Not available at this moment") {
//     setState(() {
//       isProcessing = false;
//     });
//     errorDialog(); // Show the unavailable item dialog
//     return; // ❌ Don't proceed further
//   }

//   // ✅ Only update count if item is actually added
//   widget.itemcountNotifier.value = localItemCount;

//   setState(() {
//     isProcessing = false;
//     foodCustomizationController.selectedAddons.clear();
//     foodCustomizationController.selectedVariantId.value = "";
//     foodCustomizationController.foodCustomerPrice.value = 0.0;
//   });

//   buttonController.showButton();
//   buttonController.incrementItemCount(localItemCount);
//   Navigator.pop(context);
//   await patchCartToUI(); // ✅ update after add
// }
 Future<void> addInitialAddOnsToCart() async {
    widget.itemcountNotifier.value = localItemCount;
    var cartItems = await foodcart.getfoodcartfood(km: widget.totalDis);
    var currentItem = cartItems.firstWhere(
      (item) => item['foodId'] == widget.foodid,
      orElse: () => null,
    );

    final String selectedVariantId = foodCustomizationController.selectedVariantId.value ?? '';
    final List<String> selectedAddOns = foodCustomizationController.selectedAddons.toSet().toList();

    if (currentItem != null) {
      int existingQuantity = currentItem['quantity'];
      if (localItemCount > 0) {
        // int updatedQuantity = existingQuantity + localItemCount;
        int updatedQuantity = localItemCount;
        await foodcart.updateCartItem(
          isCustomized: true,
          foodid: widget.foodid,
          quantity: updatedQuantity,
           selectedVariantId: selectedVariantId,
      selectedAddOns: selectedAddOns,
        ).whenComplete(() async {
          print("${updatedQuantity}");
          
         await patchCartToUI(); // ✅ Immediately reflect changes
          widget.itemcountNotifier.value = updatedQuantity;
          setState(() {
            buttonController.showButton();
            buttonController.incrementItemCount(localItemCount);
            Navigator.pop(context);
          });
          await buttonController.updateTotalItemCount(foodcart, widget.totalDis);
        });
      } else {
        await foodcart.deleteCartItem(foodid: widget.foodid).whenComplete(() async {
          var updatedCartItems = await foodcart.getfoodcartfood(km: widget.totalDis);
          if (updatedCartItems == null || updatedCartItems.isEmpty) {
            buttonController.hideButton();
          }
          await buttonController.updateTotalItemCount(foodcart, widget.totalDis);
          Navigator.pop(context);
        });
      }
    } else {
      await buttonController.updateTotalItemCount(foodcart, widget.totalDis);
      await _addOrUpdateItemInCart(selectedVariantId, selectedAddOns);
    }
  }
  Future<void> _addOrUpdateItemInCart(String selectedVariantId, List<String> selectedAddOns) async {
    await foodcart.addfood(
      foodid: widget.foodid,
      isCustomized: true,
      selectedVariantId: selectedVariantId,
      selectedAddOns: selectedAddOns,
      quantity: localItemCount,
      restaurantId: widget.restaurantid.toString(),
    ).whenComplete(() async {
      setState(() {
        isProcessing = false;
        foodCustomizationController.selectedAddons.clear();
        foodCustomizationController.selectedVariantId.value = "";
        foodCustomizationController.foodCustomerPrice.value = 0.0;
        buttonController.showButton();
        buttonController.incrementItemCount(localItemCount);
        Navigator.pop(context);
      });
      await patchCartToUI(); // ✅ update after add
    });
  }
 
void errorDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Oops!"),
        content: const Text("This dish isn’t available right now."),
        actions: [
          TextButton(
            child: const Text("Continue"),
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close bottom sheet
            },
          ),
        ],
      );
    },
  );
}


  void checkIfItemInCart() async {
    try {


      var cartItems = await foodcart.getfoodcartfood(km: widget.totalDis);
      var currentItem = cartItems.firstWhere(
        (item) => item['foodId'] == widget.foodid,
        orElse: () => null,
      );

      setState(() {
        if (currentItem != null) {
          localItemCount = currentItem['quantity'];
        } else {
          localItemCount = 1; // Default to 1 if item is not in cart
        }

        if (currentItem != null || localItemCount != 1 || currentItem.isNotEmpty) {
          buttonController.showButton();
        } else {
          buttonController.hideButton();
        }
      });
    } catch (e) {
      print("Error checking if item is in cart: $e");
    }
  }

  String? addonid;

  @override
  Widget build(BuildContext context) {

     dynamic finalPrice = foodCustomizationController.foodCustomerPrice.value;

  // Calculate total price
  dynamic totalPrice =  finalPrice * localItemCount;

    var totallength = widget.customizedFoodvariants!.length + widget.addOns!.length;

    return Container(
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
              mainAxisAlignment: widget.isFromCartScreen==true?MainAxisAlignment.center:MainAxisAlignment.spaceEvenly,
              children: [
              widget.isFromCartScreen==true?const SizedBox.shrink():
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
                              }
                                else if (localItemCount == 1) {
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
                  child:widget.isFromCartScreen==true?Center(
                    child: CustomContainer(
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: CustomContainerDecoration.gradientbuttondecoration(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                        child: Obx(() {
                          final double finalPrice = foodCustomizationController.foodCustomerPrice.value;
                          final double totalPrice = finalPrice * localItemCount;
                          return Text(
                            "Update Item | ₹${totalPrice.toStringAsFixed(2)}",
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyle.smallwhitetext,
                          );
                        }),
                      ),
                    ),
                  ): CustomContainer(
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: CustomContainerDecoration.gradientbuttondecoration(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      child: Center(
                        child:Obx(() {
  final double finalPrice = foodCustomizationController.foodCustomerPrice.value;
  final double totalPrice = finalPrice * localItemCount;
  return Text(
    "Add Item | ₹${totalPrice.toStringAsFixed(2)}",
    overflow: TextOverflow.ellipsis,
    style: CustomTextStyle.smallwhitetext,
  );
}),
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




checkdd({totallength,context}){

    if(totallength==1){
      return MediaQuery.of(context).size.height / 2.3;

    }else if(totallength==2){
      return MediaQuery.of(context).size.height / 2.5;

    }else{
      return MediaQuery.of(context).size.height / 1.6;
    }

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
                    widget.customizedFoodvariants![index].variantGroupName.toString().capitalizeFirst.toString(),
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
              itemCount: widget.customizedFoodvariants![index].variantType!.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) {
              String variantId = widget.customizedFoodvariants![index].variantType![i].id.toString();
              dynamic variantPrice = widget.customizedFoodvariants![index].variantType![i].customerPrice; // Keep as int

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  child: Row(
                    children: [
                     Builder(
                       builder: (context) {
                         String foodType = widget.foodtype ??
                             '';
                         String assetPath;
                           
                         switch (foodType) {
                           case 'nonveg':
                             assetPath = "assets/images/Non veg.png";
                             break;
                           case 'veg':
                             assetPath = "assets/images/veg.png";
                             break;
                           case 'egg':
                             assetPath = "assets/images/egg.jpg";
                             break;
                           default:
                             assetPath = ''; // Default path or leave it empty if there's no image
                                 
                         }
                           
                         return assetPath.isNotEmpty ? Image.asset(
                                 assetPath,
                                 height: 15,
                               )
                             : const SizedBox
                                 .shrink(); // Return an empty widget if there's no image
                            
                       },
                     ),

                      // Image(
                      //   image: widget.foodtype == "veg"
                      //       ? AssetImage("assets/images/veg.png")
                      //       : AssetImage("assets/images/Non veg.png"),
                      //   height: 18,
                      // ),


                      5.toWidth,
                      SizedBox(
                        width: MediaQuery.of(context).size.width/1.85,  
                        child: Text(
                          widget.customizedFoodvariants![index].variantType![i].variantName.toString().capitalizeFirst.toString(),
                          overflow: TextOverflow.clip,
                          style: CustomTextStyle.black12,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "+ ₹${widget.customizedFoodvariants![index].variantType![i].customerPrice.toString()}",
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
                            groupValue: foodCustomizationController.selectedVariantId.value,
                            onChanged: (String? newValue) {
                            setState(() {
                               foodCustomizationController.updateVariant(newValue, variantPrice!);
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
                  widget.addOns![index1].addOnsGroupName.toString().capitalizeFirst.toString(),
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
              itemCount: widget.addOns![index1].addOnsType!.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) {
                
                // var addOn = widget.addOns![index1].addOnsList![index];
    
                 String addOnId = widget.addOns![index1].addOnsType![i].id.toString();
                 dynamic addOnPrice = widget.addOns![index1].addOnsType![i].customerPrice; // Keep as int
             
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  child: Row(
                    children: [
                      
                        Builder(
                                        builder: (context) {
                                          String foodType = widget.addOns![index1].addOnsType![i].type ??  '';
                                          String assetPath;

                                          switch (foodType) {
                                            case 'nonveg':
                                              assetPath = "assets/images/Non veg.png";
                                              break;
                                            case 'veg':
                                              assetPath = "assets/images/veg.png";
                                              break;
                                            case 'egg':
                                              assetPath = "assets/images/egg.jpg";
                                              break;
                                            default:
                                              assetPath = ''; 
                                          }

                                          return assetPath.isNotEmpty  ? Image.asset( assetPath, height: 15) : const SizedBox.shrink();
                                                    
                                      },
                                    ),
                                   5.toWidth,


                      Expanded(
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width/1.85,  
                            
                            child: Text(
                              widget.addOns![index1].addOnsType![i].variantName.toString().capitalizeFirst.toString(),
                              overflow: TextOverflow.clip,
                              maxLines: 3,
                              style: CustomTextStyle.black12,
                            ),
                          ),
                      ),
    
                      // Spacer(),
      
                        Text(
                          "+ ₹${widget.addOns![index1].addOnsType![i].customerPrice.toString()}",
                          overflow: TextOverflow.ellipsis,
                          style: CustomTextStyle.black12,
                        ),
        
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Transform.scale(
                            scale: 1,
                            child: Checkbox(
                              activeColor: Customcolors.darkpurple,
                              value: foodCustomizationController.selectedAddons.contains(addOnId),
                              onChanged: (bool? newValue) {
                              setState(() {
                                foodCustomizationController.toggleAddon(addOnId, addOnPrice!);
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




class CheckboxRadio extends StatefulWidget {
 final bool value;
  final ValueChanged<bool> onChanged;
  const CheckboxRadio({super.key, required this.value, required this.onChanged});

  @override
  State<CheckboxRadio> createState() => _CheckboxRadioState();
}

class _CheckboxRadioState extends State<CheckboxRadio> {
  @override
  Widget build(BuildContext context) {
       return GestureDetector(
      onTap: () => widget. onChanged(!widget.value),
      child: Container(
        width: 18.0.w,
        height: 17.0.h,
        decoration: BoxDecoration(
          color:widget. value ? Customcolors.darkpurple: Colors.transparent,
          border: Border.all(color:widget. value ? Customcolors.darkpurple: Customcolors.DECORATION_DARKGREY,width: 2),
        ),

        child:widget. value  ? const Icon(Icons.check_outlined, size: 16.0, color: Colors.white,weight: 8)  :  null,

      ),
    );
  }
}

