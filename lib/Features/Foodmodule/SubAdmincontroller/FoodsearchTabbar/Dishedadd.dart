// ignore_for_file: use_build_context_synchronously, file_names, avoid_print

import 'dart:async';

import 'package:testing/Features/Authscreen/Loginscreen.dart';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Addfoodcontroller.dart';
import 'package:testing/Features/Foodmodule/Foodviewscreen/AddButtonFunctions/Buttonfunctionalities.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Addons.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodviewfirstscreen.dart';
import 'package:testing/Features/coupon/couponController.dart';
import 'package:testing/utils/Buttons/CustomAlertDialoug.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomLogoutdialog.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class FoodItemWidget extends StatefulWidget {
  // final int index;
  // final int index2;
  dynamic addOnList;
  dynamic variantList;
  final dynamic foodItemData;
  // final dynamic additionalImages;
  final ValueNotifier<int> itemCountNotifier;
  bool isFromTab;

  FoodItemWidget({
    super.key,
    // required this.index,
    required this.variantList,
    required this.addOnList,
    // required this.index2,
    this.isFromTab = false,
    required this.foodItemData,
    // required this.additionalImages,
    required this.itemCountNotifier,
  });

  @override
  FoodItemWidgetState createState() => FoodItemWidgetState();
}

class FoodItemWidgetState extends State<FoodItemWidget> {
  CouponController coupon = CouponController();
  final Foodcartcontroller foodcart = Get.find<Foodcartcontroller>();
  ButtonController buttonController = ButtonController();
  bool isProcessing = false;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      foodcart.getfoodcartfood(km: "5");

      buttonController = Provider.of<ButtonController>(context, listen: false);

      checkIfItemInCart();
    });
  }

  Future<void> checkIfItemInCart() async {
    // final foodDetails = widget.foodItemData["AdminUserList"][widget.index]
    //     ["categoryDetails"][0]["foods"][widget.index2];

    try {
      var cartItems = await foodcart.getfoodcartfood(km: "5");

      var currentItem = cartItems.firstWhere(
        (item) => item['foodId'] == widget.foodItemData["_id"],
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
          buttonController.showButton();
        } else {
          buttonController.hideButton();
        }
      });

      await buttonController.updateTotalItemCount(foodcart, "5");
    } catch (e) {
      print("Error checking if item is in cart: $e");
    }
  }

  Future<void> _addFoodToCart() async {
    if (isProcessing) return; // Prevent further clicks during processing

    setState(() {
      isProcessing = true; // Set processing flag to true
    });
    await checkIfItemInCart();
    // Replace with your actual food cart and recent search instances
    var cartItems = await foodcart.getfoodcartfood(km: "5");

    var isDifferentRestaurant = cartItems.any(
      (item) => item['restaurantId'] != widget.foodItemData["restaurantId"],
    );

    if (isDifferentRestaurant) {
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
              content:
                  "You can only add products from one restaurant at a time. Do you want to clear the cart?",
              onConfirm: () async {
                await foodcart.clearCartItem(context: context);
                coupon.removeCoupon();
                foodcart.getfoodcartfood(km: "5");
                buttonController.totalItemCountNotifier.value = 0;
                resetItemCount();
                await foodcart.getfoodcartfood(km: "5");
                Navigator.pop(context);
                _addOrNavigateToCustomize();
              },
              buttonname: 'Replace',
              oncancel: () {
                Navigator.pop(context);
              },
            );
          }).whenComplete(() {
        if (!mounted) return;
        setState(() {
          isProcessing = false;
        });
      });
    });
  }

  Future<void> errorDialog() async {
    Future.delayed(Duration.zero, () {
      showDialog(
          context: context,
          builder: (context) {
            return CustomcartLogoutDialog(
              title: 'Oops!',
              content: "This dish isn’t available right now",
              onConfirm: () async {
                Navigator.pop(context);
              },
              buttonname: 'Continue',
            );
          });
//           .whenComplete(() {
//   if (!mounted) return;
//   setState(() {
//     isProcessing = false;
//   });
// });
    });
  }

  Future<void> _addOrNavigateToCustomize() async {
    if (widget.foodItemData["iscustomizable"] == true) {
      addonsBottomSheet(
        context: context,
        customizedFoodvariants: widget.variantList,
        addOns: widget.addOnList,
        foodtype: widget.foodItemData["foodType"],
        restaurantname: widget.foodItemData["foodRestaurantName"],
        itemcountNotifier: widget.itemCountNotifier,
        foodcustomerprice: widget.foodItemData["food"]["customerPrice"],
        resid: widget.foodItemData["restaurantId"],
        foodid: widget.foodItemData["_id"],
      ).whenComplete(() {
        buttonController.showButton();
        if (!mounted) return;
        setState(() {
          isProcessing = false; // Reset processing flag
        });
        // widget.itemCountNotifier.value = 1;
        // Navigate to Foodviewscreen to show add-ons and customizations
        Get.to(
          Foodviewscreen(
            isFromDishScreeen: widget.isFromTab,
            totalDis: '5',
            restaurantId: widget.foodItemData["restaurantId"],
            addOnsL: widget.addOnList,
            customizeFoodVarients: widget.variantList,
            foodCustomerPrice: widget.foodItemData["food"]["customerPrice"],
            foodId: widget.foodItemData["_id"],
            foodType: widget.foodItemData["foodType"].toString(),
            iscustomizable: true,
            itemcountNotifier: widget.itemCountNotifier,
          ),
        );
      });
    } else {
      await foodcart.addfood(
        foodid: widget.foodItemData["_id"],
        isCustomized: false,
        quantity: 1,
        restaurantId: widget.foodItemData["restaurantId"],
      );

// ✅ Handle unavailable item
      if (foodcart.lastAddFoodCode == 402 &&
              foodcart.lastAddFoodMessage ==
                  "This Food Not available at this moment" ||
          widget.foodItemData["availableNow"] == false) {
        if (!mounted) return;
        setState(() {
          isProcessing = false;
        });
        // Get.snackbar("Oops", "This dish isn’t available right now");
        errorDialog();
        return; // ❌ Prevent further execution
      }

// ✅ Proceed only when add is successful
      buttonController.showButton();
      buttonController.incrementItemCount(1);
      setState(() {
        isProcessing = false;
      });
      widget.itemCountNotifier.value = 1;

      Get.to(
        Foodviewscreen(
          isFromDishScreeen: widget.isFromTab,
          totalDis: '5',
          restaurantId: widget.foodItemData["restaurantId"],
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
                      if (UserId == null || UserId.isEmpty) {
                        // Show alert dialog if user is not logged in
                         showDialog(
  context: context,
  builder: (_) => LoginRequiredDialog(
    title: "Login Required",
    content: "Please login to add this item to your cart.",
    cancelText: "Later",
    confirmText: "Log In",
    onConfirm: () {
      // Navigate or perform any action
      Get.offAll(() => const Loginscreen());
    },
  ),
);
                      } else {
                        _addFoodToCart(); // Proceed if user is logged in
                      }
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
                          // color: Colors.amber,
                          height: MediaQuery.of(context).size.height / 1,
                          child: InkWell(
                            onTap: () async {
                              widget.itemCountNotifier.value--;

                              if (widget.itemCountNotifier.value <= 0) {
                                widget.itemCountNotifier.value = 0;
                                // Future.delayed(Duration.zero,() => getStorage.write(gRestaurantId,''));
                              }
                              buttonController.decrementItemCount(1);
                              //  Provider.of<FoodCartProvider>(context,listen: false).getfoodcartProvider(km: 5);
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
                              // print('yeah its Clicked...');

                              widget.itemCountNotifier.value++;
                              updateItemCount(widget.itemCountNotifier.value);
                              buttonController.incrementItemCount(1);
                              buttonController.showButton();
                              // Provider.of<FoodCartProvider>(context,listen: false).getfoodcartProvider(km: 5);
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

  Future<dynamic> addonsBottomSheet(
      {required BuildContext context,
      required customizedFoodvariants,
      required addOns,
      required String foodtype,
      required restaurantname,
      required itemcountNotifier,
      required foodcustomerprice,
      required resid,
      required foodid}) {
    return showModalBottomSheet(
      backgroundColor: Customcolors.DECORATION_WHITE,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return CustomiseAddons(
          totalDis: "5",
          restaurantname: restaurantname,
          foodcustomerprice: foodcustomerprice,
          foodtype: foodtype,
          customizedFoodvariants: customizedFoodvariants,
          addOns: addOns,
          restaurantid: resid,
          foodid: foodid,
          itemcountNotifier: itemcountNotifier,
        );
      },
    );
  }

  void resetItemCount() {
    if (widget.itemCountNotifier.value == 0) {
      widget.itemCountNotifier.value = -1; // force rebuild
    }
    widget.itemCountNotifier.value = 0;
    print("Item count reset to: ${widget.itemCountNotifier.value}");
  }

//   Future<void> updateItemCount(int itemCount) async {
//     if (itemCount > 0) {
//       await foodcart.updateCartItem(
//       isCustomized: false,
//           foodid: widget.foodItemData["_id"], quantity: itemCount);
//     } else {
//       await foodcart
//           .deleteCartItem(
//         foodid: widget.foodItemData["_id"],
//       )
//           .whenComplete(() async {
//         var cartItems = await foodcart.getfoodcartfood(km: "5");
//         if (cartItems == null || cartItems.isEmpty) {
//           buttonController.hideButton();
//         }
//         await buttonController.updateTotalItemCount(foodcart, "5");
//       });
//     }
//   }
// }

  Future<void> updateItemCount(int itemCount) async {
    final isCustomized = widget.foodItemData["iscustomizable"] ?? false;
    String selectedVariantId = '';
    List<dynamic> selectedAddOns = [];

    if (isCustomized) {
      // Step 1: Get cart items
      var cartItems = await foodcart.getfoodcartfood(km: "5");

      // Step 2: Find current cart item by foodId
      var currentItem = cartItems.firstWhere(
        (item) => item['foodId'] == widget.foodItemData["_id"],
        orElse: () => null,
      );

      if (currentItem != null) {
        // Step 3: Extract variant and add-ons
        selectedVariantId = currentItem['selectedVariantId'] ?? '';
        selectedAddOns = List<String>.from(currentItem['selectedAddOns'] ?? []);
      }
    }

    // Handle quantity update or delete
    if (itemCount > 0) {
      await foodcart.updateCartItem(
        foodid: widget.foodItemData["_id"],
        quantity: itemCount,
        isCustomized: isCustomized,
        selectedVariantId: selectedVariantId,
        selectedAddOns: selectedAddOns,
      );
    } else {
      await foodcart
          .deleteCartItem(foodid: widget.foodItemData["_id"])
          .whenComplete(() async {
        var cartItems = await foodcart.getfoodcartfood(km: "5");
        if (cartItems == null || cartItems.isEmpty) {
          buttonController.hideButton();
        }
        await buttonController.updateTotalItemCount(foodcart, "5");
      });
    }
  }
}
