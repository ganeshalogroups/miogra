// ignore_for_file: avoid_print, use_build_context_synchronously, file_names, unnecessary_null_comparison, must_be_immutable

import 'dart:async';
import 'package:testing/Features/Authscreen/Loginscreen.dart';
import 'package:testing/Features/Bottomsheets/Adduserbottomsheet.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Addons.dart';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Addfoodcontroller.dart';
import 'package:testing/Features/Foodmodule/Foodviewscreen/AddButtonFunctions/Buttonfunctionalities.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/AvailableFoodItem.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/UnavailableItem.dart';
import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Redirectcontroller.dart';
import 'package:testing/Features/OrderScreen/NoncustomisedBottomsheet.dart';
import 'package:testing/Features/OrderScreen/product%20details.dart';
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

class FoodListdesign extends StatefulWidget {
   final dynamic rescommission;
  final int index;
  final dynamic resid;
  final dynamic model;
  final dynamic totalDis;
  final String restaurantname;
  final dynamic offerPercentage;
  final dynamic restaurantAvailable;

  const FoodListdesign({
    super.key,
    required this.totalDis,
    required this.offerPercentage,
    required this.resid,
    required this.index,
    required this.model,
    required this.restaurantname,
    required this.restaurantAvailable, 
    required this.rescommission,
  });

  @override
  State<FoodListdesign> createState() => FoodListdesignState();
}

class FoodListdesignState extends State<FoodListdesign> {
  late final Foodcartcontroller foodcart;
  late final RedirectController redirect;
  ValueNotifier<int> itemCountNotifier = ValueNotifier<int>(0);
  dynamic currentCartItem;
  @override
  void initState() {
    super.initState();
    foodcart = Get.find<Foodcartcontroller>();
    redirect = Get.find<RedirectController>();
  }

  @override
  Widget build(BuildContext context) {
    dynamic foodIndexvalue = widget.model.foods![widget.index];
    return GestureDetector(
        onTap: () async {
          // Validate restaurant availability first
          final isRestaurantAvailable =
              widget.restaurantAvailable?['restaurantAvailable'] == true &&
                  widget.restaurantAvailable?['activeStatus'] == 'online' &&
                  widget.restaurantAvailable?['status'] == true;

          if (!isRestaurantAvailable) return;

          final foodIndexvalue = widget.model.foods![widget.index];

          if (foodIndexvalue.iscustomizable == true) {
            await Get.to(
              ProductDetails(
                totalDis: widget.totalDis,
                restaurantname: widget.restaurantname,
                itemcountNotifier: itemCountNotifier,
                foodid: foodIndexvalue.id,
                index: widget.index,
                model: widget.model,
                customizedFoodvariants:
                    foodIndexvalue.customizedFood!.addVariants,
                addOns: foodIndexvalue.customizedFood!.addOns,
                resid: widget.resid,
              ),
              transition: Transition.downToUp,
            );
          } else {
            // Show a bottom sheet if the food item is not customizable
            showModalBottomSheet(
              backgroundColor: Colors.transparent,
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
                      child: Noncustomisedetails(
                          rescommission: widget.rescommission,
                        totalDis: widget.totalDis,
                        restaurantname: widget.restaurantname,
                        itemcountNotifier: itemCountNotifier,
                        foodid: foodIndexvalue.id,
                        index: widget.index,
                        resid: widget.resid,
                        model: widget.model,
                      ),
                    ),
                    Positioned(
                      top: -60,
                      right: 0,
                      left: 0,
                      child: GestureDetector(
                        onTap: () async {
                          Navigator.pop(context);
                          await foodcart.getfoodcartfood(km: widget.totalDis);
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(180, 19, 1, 1),
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Customcolors.DECORATION_WHITE,
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
        child: widget.model.status == false
            ? const SizedBox.shrink()
            : (foodIndexvalue.availableStatus == true &&
                    foodIndexvalue.status == true &&
                    widget.restaurantAvailable?['restaurantAvailable'] ==
                        true &&
                    widget.restaurantAvailable?['activeStatus'] == 'online' &&
                    widget.restaurantAvailable?['status'] == true)
                ? AvailableItem(
                  rescommission: widget.rescommission,
                    foodIndexvalue: foodIndexvalue,
                    resid: widget.resid,
                    totalDis: widget.totalDis,
                    index: widget.index,
                    model: widget.model,
                    restaurantname: widget.restaurantname,
                    itemCountNotifier: itemCountNotifier,
                    offerPercentage: widget.offerPercentage,
                  )
                : UnavailableItem(
                    foodIndexvalue: foodIndexvalue,
                    resid: widget.resid,
                    totalDis: widget.totalDis,
                    index: widget.index,
                    model: widget.model,
                    restaurantname: widget.restaurantname,
                    itemCountNotifier: itemCountNotifier,
                    offerPercentage: widget.offerPercentage,
                    restaurantAvailable: widget.restaurantAvailable,
                  ));
  }
}

iconFunction({iconname}) {
  return Image.asset(
    iconname,
    height: 15,
    width: 15,
  );
}

class ButtonNew extends StatefulWidget {
  final dynamic model;
  final String restaurantId;
  final String restaurantname;
  final int index;
  final dynamic totalDis;
  final ValueNotifier<int> itemcountNotifier;

  const ButtonNew({
    super.key,
    required this.restaurantname,
    required this.model,
    required this.index,
    required this.totalDis,
    required this.restaurantId,
    required this.itemcountNotifier,
  });

  @override
  State<ButtonNew> createState() => ButtonNewState();
}

class ButtonNewState extends State<ButtonNew> {
  final AddProductController controller = Get.put(AddProductController());
// final Foodcartcontroller foodcart = Get.find<Foodcartcontroller>();
// final RedirectController redirect = Get.put(RedirectController());
// final Foodcartcontroller foodcart = Get.put(Foodcartcontroller());

  final Foodcartcontroller foodcart = Get.find<Foodcartcontroller>();
  // final ButtonController buttonController = Get.find<ButtonController>();
  final RedirectController redirect = Get.find<RedirectController>();

  CouponController coupon = CouponController();
  ButtonController buttonController = ButtonController();
  // Flag to track whether the bottom sheet is open
  bool isProcessing = false;
  @override
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      buttonController = Provider.of<ButtonController>(context, listen: false);
      await checkIfItemInCart(); // single method to load cart and set state
    });
  }

  Future<void> checkIfItemInCart() async {
    try {
      var cartItems = await foodcart.getfoodcartfood(km: widget.totalDis);

      var currentItem = cartItems.firstWhere(
        (item) => item['foodId'] == widget.model.foods![widget.index].id,
        orElse: () => null,
      );
      if (!mounted) return;

      setState(() {
        if (currentItem != null) {
          widget.itemcountNotifier.value = currentItem['quantity'];
        } else {
          widget.itemcountNotifier.value = 0;
        }

        if (currentItem != null ||
            widget.itemcountNotifier.value != 0 ||
            currentItem.isNotEmpty) {
          buttonController.showButton();
        } else {
          buttonController.hideButton();
        }
      });

      await buttonController.updateTotalItemCount(foodcart, widget.totalDis);
    } catch (e) {
      print("Error checking if item is in cart: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    dynamic foodmodel = widget.model.foods![widget.index];
    var orderForOthers = Provider.of<InstantUpdateProvider>(context);

    return CustomContainer(
      // padding: EdgeInsets.symmetric(vertical: 3),
      height: 25.h,
      width: 92.w,
      decoration: CustomContainerDecoration.gradientborderdecoration(
          radious: 8.0, borderwidth: 0.6),
      child: ValueListenableBuilder<int>(
        valueListenable: widget.itemcountNotifier,
        builder: (context, itemCount, child) {
          return itemCount == 0
              ? InkWell(
                  onTap: () async {
                    if (UserId == null || UserId.isEmpty) {
                      // Show login required dialog
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
return;
}

                    if (isProcessing) return;

                    setState(() {
                      isProcessing = true;
                    });

                    await checkIfItemInCart();

                    var cartItems =
                        await foodcart.getfoodcartfood(km: widget.totalDis);

                    var isDifferentRestaurant = cartItems.any(
                      (item) => item['restaurantId'] != widget.restaurantId,
                    );

                    if (cartItems != null && isDifferentRestaurant) {
                      Future.delayed(Duration.zero, () {
                        CustomLogoutDialog.show(
                          context: context,
                          title: 'Replace Cart Item?',
                          content:
                              "You can only add products from one restaurant at a time. Do you want to clear the cart?",
                          onConfirm: () async {
                            if (foodmodel.iscustomizable == true ||
                                cartItems == null) {
                              await foodcart.clearCartItem(context: context);
                              coupon.removeCoupon();
                              foodcart.getfoodcartfood(km: widget.totalDis);
                              buttonController.totalItemCountNotifier.value = 0;
                              Navigator.pop(context);
                              addonsBottomSheet(
                                context: context,
                                addons: foodmodel.customizedFood!.addOns,
                                foodtype: foodmodel.foodType.toString(),
                                 variants: foodmodel.customizedFood!.addVariants,
                                 // variants: 0
                              );
                            } else {
                              await foodcart.clearCartItem(context: context);
                              coupon.removeCoupon();
                              foodcart.getfoodcartfood(km: widget.totalDis);
                              buttonController.totalItemCountNotifier.value = 0;
                              widget.itemcountNotifier.value = 1;
                              foodcart.addfood(
                                foodid: foodmodel.id,
                                isCustomized: false,
                                quantity: widget.itemcountNotifier.value,
                                restaurantId: widget.restaurantId,
                              );
                              buttonController.showButton();
                              buttonController.incrementItemCount(1);
                              setState(() {
                                isProcessing = false;
                              });
                              Navigator.pop(context);
                            }

                            setState(() {
                              orderForSomeOneName = '';
                              orderForSomeOnePhone = '';
                            });

                            orderForOthers.upDateInstruction(instruction: '');
                            orderForOthers.updateSomeOneDetaile(
                                someOneName: '', someOneNumber: '');
                          },
                          buttonname: 'Replace',
                          oncancel: () {
                            Navigator.pop(context);
                          },
                        );
                      });
                    } else if (foodmodel.iscustomizable == true ||
                        cartItems == null) {
                      addonsBottomSheet(
                        context: context,
                        addons: foodmodel.customizedFood!.addOns,
                        foodtype: foodmodel.foodType.toString(),
                        variants: foodmodel.customizedFood!.addVariants,
                     // variants: 0
                      );
                    } else {
                      widget.itemcountNotifier.value = 1;

                      foodcart.addfood(
                        foodid: foodmodel.id,
                        isCustomized: false,
                        quantity: widget.itemcountNotifier.value,
                        restaurantId: widget.restaurantId,
                      );

                      buttonController.showButton();
                      buttonController.incrementItemCount(1);
                    }

                    setState(() {
                      isProcessing = false;
                    });
                  },
                  child: Center(
                    child: Text(
                      'ADD',
                      style: CustomTextStyle.addbtn,
                    ),
                  ),
                )

              // ? InkWell(
              //     onTap: () async {
              //       if (isProcessing)
              //         return; // Prevent further clicks during processing

              //       setState(() {
              //         isProcessing = true; // Set processing flag to true
              //       });

              //       await checkIfItemInCart();

              //       var cartItems = await foodcart.getfoodcartfood(
              //           km: widget.totalDis);

              //       var isDifferentRestaurant = cartItems.any(
              //         (item) =>
              //             item['restaurantId'] != widget.restaurantId,
              //       );

              //       if (cartItems != null && isDifferentRestaurant) {
              //         Future.delayed(
              //           Duration.zero,
              //           () {
              //             CustomLogoutDialog.show(
              //                 context: context,
              //                 title: 'Replace Cart Item?',
              //                 content:
              //                     "You can only add products from one restaurant at a time. Do you want to clear the cart?",
              //                 onConfirm: () async {
              //                   if (foodmodel.iscustomizable == true ||
              //                       cartItems == null) {
              //                     await foodcart.clearCartItem(
              //                         context: context);
              //                     coupon.removeCoupon();
              //                     foodcart.getfoodcartfood(
              //                         km: widget.totalDis);
              //                     // Future.delayed(Duration.zero,() => getStorage.write(gRestaurantId,''));
              //                     buttonController
              //                         .totalItemCountNotifier.value = 0;
              //                     Navigator.pop(context);
              //                     addonsBottomSheet(
              //                       context: context,
              //                       addons:
              //                           foodmodel.customizedFood!.addOns,
              //                       foodtype:
              //                           foodmodel.foodType.toString(),
              //                       variants: foodmodel
              //                           .customizedFood!.addVariants,
              //                     );
              //                   } else {
              //                     await foodcart.clearCartItem(
              //                         context: context);
              //                     coupon.removeCoupon();
              //                     foodcart.getfoodcartfood(
              //                         km: widget.totalDis);
              //                     // Future.delayed(Duration.zero,() => getStorage.write(gRestaurantId,''));
              //                     buttonController
              //                         .totalItemCountNotifier.value = 0;
              //                     widget.itemcountNotifier.value = 1;
              //                     foodcart.addfood(
              //                       foodid: foodmodel.id,
              //                       isCustomized: false,
              //                       quantity:
              //                           widget.itemcountNotifier.value,
              //                       restaurantId: widget.restaurantId,
              //                     );

              //                     buttonController.showButton();
              //                     buttonController.incrementItemCount(1);

              //                     setState(() {
              //                       isProcessing =
              //                           false; // Reset processing flag
              //                     });
              //                     Navigator.pop(context);
              //                   }
              //                   setState(() {
              //                     orderForSomeOneName = '';
              //                     orderForSomeOnePhone = '';
              //                   });
              //                   orderForOthers.upDateInstruction(
              //                       instruction: '');
              //                   orderForOthers.updateSomeOneDetaile(
              //                       someOneName: '', someOneNumber: '');
              //                 },
              //                 buttonname: 'Replace',
              //                 oncancel: () {
              //                   Navigator.pop(context);
              //                 });
              //           },
              //         );
              //       } else if (foodmodel.iscustomizable == true ||
              //           cartItems == null) {
              //         addonsBottomSheet(
              //           context: context,
              //           addons: foodmodel.customizedFood!.addOns,
              //           foodtype: foodmodel.foodType.toString(),
              //           variants: foodmodel.customizedFood!.addVariants,
              //         );
              //       } else {
              //         widget.itemcountNotifier.value = 1;

              //         // Future.delayed(Duration.zero,() => getStorage.write(gRestaurantId,widget.restaurantId.toString()));

              //         foodcart.addfood(
              //           foodid: foodmodel.id,
              //           isCustomized: false,
              //           quantity: widget.itemcountNotifier.value,
              //           restaurantId: widget.restaurantId,
              //         );

              //         buttonController.showButton();
              //         buttonController.incrementItemCount(1);
              //       }
              //       setState(() {
              //         isProcessing =
              //             false; // Reset processing flag after bottom sheet is done
              //       });
              //     },
              //     child: Center(
              //       child: Text(
              //         'ADD',
              //         style: CustomTextStyle.addbtn,
              //       ),
              //     ),
              //   )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: SizedBox(
                        // color: Colors.amber,
                        height: MediaQuery.of(context).size.height / 1,
                        child: InkWell(
                          onTap: () async {
                            widget.itemcountNotifier.value--;

                            if (widget.itemcountNotifier.value <= 0) {
                              widget.itemcountNotifier.value = 0;
                              // Future.delayed(Duration.zero,() => getStorage.write(gRestaurantId,''));
                            }
                            buttonController.decrementItemCount(1);
                            //  Provider.of<FoodCartProvider>(context,listen: false).getfoodcartProvider(km: 5);
                            updateItemCount(
                                widget.itemcountNotifier.value, foodmodel);
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

                            widget.itemcountNotifier.value++;
                            updateItemCount(
                                widget.itemcountNotifier.value, foodmodel);
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
    );
  }

  Future<void> updateItemCount(int itemCount, dynamic foodmodel) async {
    final isCustomized = foodmodel.iscustomizable ?? false;
    String selectedVariantId = '';
    List<dynamic> selectedAddOns = [];

    if (isCustomized) {
      // Step 1: Get cart items
      var cartItems = await foodcart.getfoodcartfood(km: widget.totalDis);

      // Step 2: Find current cart item by foodId
      var currentItem = cartItems.firstWhere(
        (item) => item['foodId'] == foodmodel.id,
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
      widget.itemcountNotifier.value = itemCount;

      await foodcart.updateCartItem(
        foodid: foodmodel.id,
        quantity: itemCount,
        isCustomized: isCustomized,
        selectedVariantId: selectedVariantId,
        selectedAddOns: selectedAddOns,
      );
    } else {
      widget.itemcountNotifier.value = 0;

      await foodcart
          .deleteCartItem(foodid: foodmodel.id)
          .whenComplete(() async {
        var cartItems = await foodcart.getfoodcartfood(km: widget.totalDis);
        if (cartItems == null || cartItems.isEmpty) {
          buttonController.hideButton();
        }
        await buttonController.updateTotalItemCount(foodcart, widget.totalDis);
      });
    }
  }

  Future<dynamic> addonsBottomSheet({
    required BuildContext context,
    required variants,
    required addons,
    required String foodtype,
  }) {
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
          totalDis: widget.totalDis,
          restaurantname: widget.restaurantname,
          foodcustomerprice:
              widget.model.foods![widget.index].food!.customerPrice,
          foodtype: foodtype,
          customizedFoodvariants: variants,
          addOns: addons,
          restaurantid: widget.restaurantId,
          foodid: widget.model.foods![widget.index].id,
          itemcountNotifier: widget.itemcountNotifier,
        );
      },
    );
  }
}
