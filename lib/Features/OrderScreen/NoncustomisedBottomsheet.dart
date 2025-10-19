// ignore_for_file: use_build_context_synchronously, void_checks, avoid_print, unnecessary_brace_in_string_interps, file_names, unnecessary_string_interpolations

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:testing/Features/Authscreen/Loginscreen.dart';
import 'package:testing/Features/Bottomsheets/Adduserbottomsheet.dart';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Addfoodcontroller.dart';
import 'package:testing/Features/Foodmodule/Foodviewscreen/AddButtonFunctions/Buttonfunctionalities.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/Getnearbyrescontroller.dart';
import 'package:testing/Features/coupon/couponController.dart';
import 'package:testing/utils/Buttons/CustomAlertDialoug.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomLogoutdialog.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';

import 'package:testing/Features/Foodmodule/Domain/Foodnonvegmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Noncustomisedetails extends StatefulWidget {
   final dynamic rescommission;
  final int index;
  dynamic resid;
  String restaurantname;
  dynamic totalDis;
  final CategoryList model;
  final ValueNotifier<int> itemcountNotifier;
  dynamic foodid;
  Noncustomisedetails(
      {required this.restaurantname,
      required this.totalDis,
      required this.index,
      required this.foodid,
      required this.resid,
      super.key,
      required this.itemcountNotifier,
      required this.model,
      required this.rescommission});

  @override
  State<Noncustomisedetails> createState() => _NoncustomisedetailsState();
}

class _NoncustomisedetailsState extends State<Noncustomisedetails> {
  int _current = 0;
  bool isProcessing = false;
  int localItemCount = 1;
   Nearbyrescontroller nearbyreget = Get.put(Nearbyrescontroller());

  Foodcartcontroller foodcart = Get.put(Foodcartcontroller());
  ButtonController buttonController = ButtonController();
  FoodCustomizationController foodCustomizationController =
      Get.put(FoodCustomizationController());
  CouponController coupon = CouponController();
  @override
  void initState() {
    // buttonController = Provider.of<ButtonController>(context, listen: false);
    Timer(Duration.zero, () {
      foodcart.getfoodcartfood(km: widget.totalDis);
    });
    // checkIfItemInCart();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      buttonController = Provider.of<ButtonController>(context, listen: false);
      checkIfItemInCart();
    });

    // selectedVariantId = widget.customizedFoodvariants![0].variantType![0].id.toString();
    //  if (foodCustomizationController.selectedVariantId.value == null||foodCustomizationController.selectedVariantId.value.isEmpty) {
    //  WidgetsBinding.instance.addPostFrameCallback((_){
    //     setState(() {
    //       foodCustomizationController.updateVariant(selectedVariantId);
    //     });
    //     print("secondselectedVariantId${selectedVariantId}");});
    //   }

    super.initState();
  }

  Future<void> addInitialwithoutcustomiseToCart() async {
    widget.itemcountNotifier.value = localItemCount;

    var cartItems = await foodcart.getfoodcartfood(km: widget.totalDis);
    var currentItem = cartItems.firstWhere(
      (item) => item['foodId'] == widget.foodid,
      orElse: () => null,
    );
    if (currentItem != null) {
      int existingQuantity = currentItem['quantity'];
      if (localItemCount > 0) {
        int updatedQuantity = existingQuantity + localItemCount;

        await foodcart
            .updateCartItem(
          isCustomized: false,
          foodid: widget.foodid,
          quantity: updatedQuantity,
        )
            .whenComplete(() {
          widget.itemcountNotifier.value = updatedQuantity;
          setState(() {
            buttonController.showButton();
            buttonController.incrementItemCount(updatedQuantity);
            Navigator.pop(context);
          });
        });

        // print('========kkk 6');

        await buttonController.updateTotalItemCount(foodcart, widget.totalDis);
      } else {
        await foodcart
            .deleteCartItem(foodid: widget.foodid)
            .whenComplete(() async {
          var updatedCartItems =
              await foodcart.getfoodcartfood(km: widget.totalDis);

          if (updatedCartItems == null || updatedCartItems.isEmpty) {
            buttonController.hideButton();
          }

          await buttonController.updateTotalItemCount(
              foodcart, widget.totalDis);

          Navigator.pop(context);
        });
      }
    } else {
      await buttonController.updateTotalItemCount(foodcart, widget.totalDis);

      await foodcart
          .addfood(
        foodid: widget.foodid,
        isCustomized: false,
        quantity: localItemCount,
        restaurantId: widget.resid.toString(),
      )
          .whenComplete(() {
        setState(() {
          isProcessing =
              false; // Reset processing flag after bottom sheet is done

          foodCustomizationController.foodCustomerPrice.value = 0.0;
          buttonController.showButton();
          buttonController.incrementItemCount(localItemCount);
          Navigator.pop(context);
        });
      });
    }
  }

  Future<void> checkIfItemInCart() async {
    try {
      var cartItems = await foodcart.getfoodcartfood(km: widget.totalDis);
      var currentItem = cartItems.firstWhere(
        (item) => item['foodId'] == widget.model.foods![widget.index].id,
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
          buttonController.showButton();
        } else {
          buttonController.hideButton();
        }
      });

      await buttonController.updateTotalItemCount(foodcart, widget.totalDis);
    } catch (e) {
      print('From non Cost9omizedBottomSheet');
      print("Error checking if item is in cart: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
 //dynamic totalPrice =   ( widget.model.foods![widget.index].food!.customerPrice  +   (((  widget.model.foods![widget.index].commission ?? widget.rescommission) / 100) *   widget.model.foods![widget.index].food!.customerPrice)) * localItemCount;
    dynamic totalPrice =
        widget.model.foods![widget.index].food!.customerPrice * localItemCount;

    var orderForOthers = Provider.of<InstantUpdateProvider>(context);

    return PopScope(
      canPop: true, // Set this to true if you want to allow popping
      onPopInvoked: (didPop) async {
        // Perform any custom logic here, like saving state or analytics
        if (didPop) {
          // The pop was invoked, perform any necessary cleanup
          return Future.value(true); // Allow the pop to continue
        }
        return Future.value(false);
      },
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: Customcolors.DECORATION_WHITE,
        ),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                // "${globalImageUrlLink}${widget.model.foods![widget.index].additionalImage!}".isEmpty ?
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  child: widget.model.foods![widget.index].availableStatus ==
                              true &&
                          widget.model.foods![widget.index].status == true &&
                          widget.model.status == true
                      ? CachedNetworkImage(
                          placeholder: (context, url) =>
                              Image.asset("${fastxdummyImg}"),
                          errorWidget: (context, url, error) =>
                              Image.asset("${fastxdummyImg}"),
                          width: MediaQuery.of(context).size.width,
                          imageUrl:
                              "${globalImageUrlLink}${widget.model.foods![widget.index].foodImgUrl.toString()}",
                          fit: BoxFit.fill,
                          height: 270.h,
                        )
                      : ColorFiltered(
                          colorFilter: const ColorFilter.mode(
                            Colors.grey,
                            BlendMode.saturation,
                          ),
                          child: CachedNetworkImage(
                            placeholder: (context, url) =>
                                Image.asset("${fastxdummyImg}"),
                            errorWidget: (context, url, error) =>
                                Image.asset("${fastxdummyImg}"),
                            width: MediaQuery.of(context).size.width,
                            imageUrl:
                                "${globalImageUrlLink}${widget.model.foods![widget.index].foodImgUrl.toString()}",
                            fit: BoxFit.fill,
                            height: 270.h,
                          ),
                        ),
                )
              ],
            ),
            10.toHeight,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Builder(
                          builder: (context) {
                            String foodType =
                                widget.model.foods![widget.index].foodType ??
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
                                assetPath = '';
                            }

                            return assetPath.isNotEmpty
                                ? Image.asset(assetPath, height: 15)
                                : const SizedBox.shrink();
                          },
                        ),
                      ),
                      10.toHeight,
                    ],
                  ),
                  10.toHeight,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: Text(
                          widget.model.foods![widget.index].foodName
                              .toString()
                              .capitalizeFirst
                              .toString(),
                          overflow: TextOverflow.clip,
                          style: CustomTextStyle.googlebuttontext,
                        ),
                      ),
                    ],
                  ),
                  CustomSizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        // width: 350,
                        child: widget.model.foods![widget.index].foodDiscription
                                .toString()
                                .capitalizeFirst
                                .toString()
                                .isEmpty
                            ? const SizedBox.shrink()
                            : Text(
                                widget
                                    .model.foods![widget.index].foodDiscription
                                    .toString()
                                    .capitalizeFirst
                                    .toString(),
                                textAlign: TextAlign
                                    .justify, // Justifies the text for better alignment
                                style: CustomTextStyle.profiletitle,
                                maxLines: 5,
                                softWrap: true,
                                overflow: TextOverflow
                                    .clip, // Ensures text wraps to the next line
                              ),
                      ),
                    ],
                  ),
                  widget.model.foods![widget.index].iscustomizable == true
                      ? 10.toHeight
                      : 15.toHeight,
                if(nearbyreget.selectedIndex.value==0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Food Preperation Time : ",
                        style: widget.model.foods![widget.index]
                                        .availableStatus ==
                                    true &&
                                widget.model.status == true &&
                                widget.model.foods![widget.index].status == true
                            ? //CustomTextStyle.DECORATION_regulartext
                            TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins-Medium',
      color: Color(0xFF623089))
                            : CustomTextStyle.profiletitle,
                      ),
                      Flexible(
                        // width: 350,
                        child: widget.model.foods![widget.index].preparationTime
                                .toString()
                                .capitalizeFirst
                                .toString()
                                .isEmpty
                            ? Text(
                                "Not Mentioned",
                                textAlign: TextAlign
                                    .justify, // Justifies the text for better alignment
                                style: widget.model.foods![widget.index]
                                                .availableStatus ==
                                            true &&
                                        widget.model.status == true &&
                                        widget.model.foods![widget.index]
                                                .status ==
                                            true
                                    ? CustomTextStyle.rederrortext
                                    : CustomTextStyle.profiletitle,
                                softWrap: true,
                                overflow: TextOverflow
                                    .clip, // Ensures text wraps to the next line
                              )
                            : Text(
                                widget
                                    .model.foods![widget.index].preparationTime
                                    .toString()
                                    .capitalizeFirst
                                    .toString(),
                                textAlign: TextAlign
                                    .justify, // Justifies the text for better alignment
                                style:  TextStyle(
      fontSize: 12,
      color: Customcolors.DECORATION_BLACK,
      fontFamily: 'Poppins-Medium'),
                                // CustomTextStyle.profiletitle,
                                softWrap: true,
                                overflow: TextOverflow
                                    .clip, // Ensures text wraps to the next line
                              ),
                      ),
                    ],
                  ),
                  10.toHeight,
               if(nearbyreget.selectedIndex.value==0)   Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          "Ingredients Added         : ",
                          // "Ingredients Added in ${widget.model.foods![widget.index].foodName} : ",
                          style: widget.model.foods![widget.index]
                                          .availableStatus ==
                                      true &&
                                  widget.model.status == true &&
                                  widget.model.foods![widget.index].status ==
                                      true
                              ?TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins-Medium',
      color: Color(0xFF623089))
                              // CustomTextStyle.DECORATION_regulartext
                              : CustomTextStyle.profiletitle,
                        ),
                      ),
                      Flexible(
                        child: widget
                                .model.foods![widget.index].ingredients!.isEmpty
                            ? Text(
                                "Not Mentioned",
                                textAlign: TextAlign.justify,
                                style: widget.model.foods![widget.index]
                                                .availableStatus ==
                                            true &&
                                        widget.model.status == true &&
                                        widget.model.foods![widget.index]
                                                .status ==
                                            true
                                    ? CustomTextStyle.rederrortext
                                    :
                                     CustomTextStyle.profiletitle,
                                softWrap: true,
                                overflow: TextOverflow.clip,
                              )
                            : Text(
                                widget.model.foods![widget.index].ingredients!
                                    .join(', ')
                                    .capitalizeFirst
                                    .toString(),
                                style: 
  TextStyle(
      fontSize: 12,
      color: Customcolors.DECORATION_BLACK,
      fontFamily: 'Poppins-Medium'),
                               //  CustomTextStyle.profiletitle,
                                softWrap: true,
                                overflow: TextOverflow.clip,
                              ),
                      ),
                    ],
                  ),
                  CustomSizedBox(height: 5.h),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                    child: widget.model.foods![widget.index].availableStatus ==
                                true &&
                            widget.model.foods![widget.index].status == true &&
                            widget.model.status == true
                        ? Column(
                            children: [
                              SizedBox(
                                height: 25.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ValueListenableBuilder<int>(
                                    valueListenable: widget.itemcountNotifier,
                                    builder: (context, itemCount, child) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2),
                                        width: 100,
                                        decoration: CustomContainerDecoration
                                            .customisedbuttondecoration(),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                if (UserId == null ||
                                                    UserId.isEmpty) {
                                                  // Show login required dialog
                                                   showDialog(
  context: context,
  builder: (_) => LoginRequiredDialog(
    title: "Login Required",
    content: "Please login to update this item to your cart.",
    cancelText: "Later",
    confirmText: "Log In",
    onConfirm: () {
      // Navigate or perform any action
      Get.offAll(() => const Loginscreen());
    },
  ),
);
                                                  return; // Exit early if not logged in
                                                }

                                                // Continue only if user is logged in
                                                if (localItemCount > 1) {
                                                  setState(() {
                                                    localItemCount--;
                                                  });
                                                  // Optionally update item count in controller
                                                } else if (localItemCount ==
                                                    1) {
                                                  Navigator.pop(
                                                      context); // Close bottom sheet or screen
                                                }
                                              },

                                              // onTap: () {
                                              //   if (localItemCount > 1) {
                                              //     setState(() {
                                              //       localItemCount--;
                                              //     });
                                              //     // buttonController.decrementItemCount(1);
                                              //     // buttonController.updateItemCount(widget.foodid, _localItemCount);
                                              //   } else if (localItemCount ==
                                              //       1) {
                                              //     Navigator.pop(
                                              //         context); // If the count is 1, remove the item and pop the screen\
                                              //   }
                                              // },
                                              child: const Icon(Icons.remove,
                                                  color: Customcolors.darkpurple),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              '$localItemCount',
                                              style: CustomTextStyle
                                                  .decorationORANGEtext22,
                                            ),
                                            const SizedBox(width: 8),
                                            InkWell(
                                              onTap: () {
                                                if (UserId == null ||
                                                    UserId.isEmpty) {
                                                  // Show login required dialog
                                                  showDialog(
  context: context,
  builder: (_) => LoginRequiredDialog(
    title: "Login Required",
    content: "Please login to update this item to your cart.",
    cancelText: "Later",
    confirmText: "Log In",
    onConfirm: () {
      // Navigate or perform any action
      Get.offAll(() => const Loginscreen());
    },
  ),
);
                                                  return; // Exit if not logged in
                                                }

                                                // Continue only if user is logged in
                                                setState(() {
                                                  localItemCount++;
                                                });
                                                buttonController.showButton();
                                                // buttonController.incrementItemCount(1);
                                              },

                                              // onTap: () {
                                              //   setState(() {
                                              //     localItemCount++;
                                              //   });
                                              //   buttonController.showButton();
                                              //   // buttonController.incrementItemCount(1);
                                              // },
                                              child: const Icon(Icons.add,
                                                  color: Customcolors.darkpurple),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  InkWell(
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

                                        return; // Stop further execution
                                      }

                                      if (isProcessing) return;

                                      setState(() {
                                        isProcessing = true;
                                      });

                                      var cartItems = await foodcart
                                          .getfoodcartfood(km: widget.totalDis);
                                      var isDifferentRestaurant = cartItems.any(
                                          (item) =>
                                              item['restaurantId'] !=
                                              widget.resid);

                                      if (isDifferentRestaurant) {
                                        _showReplaceCartDialog(orderForOthers);
                                      } else {
                                        addInitialwithoutcustomiseToCart();
                                      }

                                      setState(() {
                                        isProcessing = false;
                                      });
                                    },

                                    // onTap: () async {
                                    //   if (isProcessing) return;

                                    //       setState(() {
                                    //         isProcessing = true;
                                    //       });

                                    //   var cartItems = await foodcart.getfoodcartfood( km: widget.totalDis);
                                    //   var isDifferentRestaurant =  cartItems.any( (item) =>  item['restaurantId'] !=  widget.resid );

                                    //   if (isDifferentRestaurant) {
                                    //  _showReplaceCartDialog(orderForOthers) ;

                                    //   } else {
                                    //     addInitialwithoutcustomiseToCart();
                                    //   }
                                    // },

                                    //  onTap: () => addInitialAddOnsToCart(),

                                    child: CustomContainer(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      decoration: CustomContainerDecoration
                                          .gradientbuttondecoration(),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 20),
                                        child: Center(
                                          child: Text(//Add Item
                                            "Add Item  | ₹${totalPrice}",
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                CustomTextStyle.smallwhitetext,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              SizedBox(height: 15.h),
                              CustomContainer(
                                width: MediaQuery.of(context).size.width * 0.8,
                                decoration: CustomContainerDecoration
                                    .greybuttondecoration(),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 20),
                                  child: Center(
                                    child: Text(
                                      "Food is Not Available for now",
                                      overflow: TextOverflow.ellipsis,
                                      style: CustomTextStyle.smallwhitetext,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  void _showReplaceCartDialog(InstantUpdateProvider orderForOthers) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomLogoutDialog(
          // context: context,
          title: 'Replace Cart Item?',
          content:
              "You can only add products from one restaurant at a time. Do you want to clear the cart?",
          onConfirm: () async {
            await foodcart.clearCartItem(context: context);
            coupon.removeCoupon();
            foodcart.getfoodcartfood(km: widget.totalDis);
            buttonController.totalItemCountNotifier.value = 0;
            setState(() {
              orderForSomeOneName = '';
              orderForSomeOnePhone = '';
            });
            orderForOthers.upDateInstruction(instruction: '');
            orderForOthers.updateSomeOneDetaile(
                someOneName: '', someOneNumber: '');

            Navigator.pop(context);
            addInitialwithoutcustomiseToCart();
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
