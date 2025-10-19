// ignore_for_file: unused_field, file_names, use_build_context_synchronously, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:testing/Features/Authscreen/Loginscreen.dart';
import 'package:testing/Features/Bottomsheets/Adduserbottomsheet.dart';
import 'package:testing/Features/Foodmodule/Domain/Foodnonvegmodel.dart';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Addfoodcontroller.dart';
import 'package:testing/Features/Foodmodule/Foodviewscreen/AddButtonFunctions/Buttonfunctionalities.dart';
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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProductDetails extends StatefulWidget {
  final int index;
  final dynamic resid;
  final List<AddVariant>? customizedFoodvariants;
  final List<AddOn>? addOns;
  final CategoryList model;
  final String restaurantname;
  final dynamic totalDis;
  final ValueNotifier<int> itemcountNotifier;
  final dynamic foodid;
  const ProductDetails(
      {this.customizedFoodvariants,
      required this.restaurantname,
      this.addOns,
      required this.totalDis,
      required this.index,
      required this.model,
      required this.foodid,
      required this.resid,
      super.key,
      required this.itemcountNotifier});

  @override
  State<ProductDetails> createState() => ProductDetailsState();
}

class ProductDetailsState extends State<ProductDetails> {
  final Foodcartcontroller foodcart = Get.find<Foodcartcontroller>();
  ButtonController buttonController = ButtonController();
  final FoodCustomizationController foodCustomizationController =
      Get.put(FoodCustomizationController());
  final CouponController coupon = CouponController();
  final int _current = 0;
  bool isProcessing = false;
  final List<String> selectedCategories = [];
  List<String> selectedaddons = [];
  String? selectedVariantId;
  int localItemCount = 1;
  String? addonid;

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
      List<String> selectedAddOnsFromCart =
          List<String>.from(currentItem['selectedAddOns'] ?? []);

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
        foodCustomizationController.selectedAddons
            .addAll(selectedAddOnsFromCart);

        foodCustomizationController.baseVariantPrice.value = variantPrice;
        foodCustomizationController.addonPrices = patchAddonPrices;
        foodCustomizationController
            .calculateTotalPrice(); // triggers foodCustomerPrice update

        localItemCount = currentItem['quantity'] ?? 1;
        widget.itemcountNotifier.value = localItemCount;
      });
    } else {
      // If first time, set default variant
      if (widget.customizedFoodvariants != null &&
          widget.customizedFoodvariants!.isNotEmpty) {
        var firstVariant = widget.customizedFoodvariants![0].variantType?.first;
        if (firstVariant != null) {
          setState(() {
            foodCustomizationController.selectedVariantId.value =
                firstVariant.id.toString();
            foodCustomizationController.baseVariantPrice.value =
                firstVariant.customerPrice?.toDouble() ?? 0.0;
            foodCustomizationController.selectedAddons.clear();
            foodCustomizationController.addonPrices.clear();
            foodCustomizationController.calculateTotalPrice();
          });
        }
      }
    }
  }

  Future<void> addInitialAddOnsToCart() async {
    widget.itemcountNotifier.value = localItemCount;
    var cartItems = await foodcart.getfoodcartfood(km: widget.totalDis);
    var currentItem = cartItems.firstWhere(
      (item) => item['foodId'] == widget.foodid,
      orElse: () => null,
    );

    final String selectedVariantId =
        foodCustomizationController.selectedVariantId.value ?? '';
    final List<String> selectedAddOns =
        foodCustomizationController.selectedAddons.toSet().toList();

    if (currentItem != null) {
      int existingQuantity = currentItem['quantity'];
      if (localItemCount > 0) {
        // int updatedQuantity = existingQuantity + localItemCount;
        int updatedQuantity = localItemCount;
        await foodcart
            .updateCartItem(
          isCustomized: true,
          foodid: widget.foodid,
          quantity: updatedQuantity,
          selectedVariantId: selectedVariantId,
          selectedAddOns: selectedAddOns,
        )
            .whenComplete(() async {
          print("${updatedQuantity}");
          await patchCartToUI(); // ✅ Immediately reflect changes
          widget.itemcountNotifier.value = updatedQuantity;
          setState(() {
            buttonController.showButton();
            buttonController.incrementItemCount(localItemCount);
            Navigator.pop(context);
          });
          await buttonController.updateTotalItemCount(
              foodcart, widget.totalDis);
        });
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
      await _addOrUpdateItemInCart(selectedVariantId, selectedAddOns);
    }
  }

  Future<void> _addOrUpdateItemInCart(
      String selectedVariantId, List<String> selectedAddOns) async {
    await foodcart
        .addfood(
      foodid: widget.foodid,
      isCustomized: true,
      selectedVariantId: selectedVariantId,
      selectedAddOns: selectedAddOns,
      quantity: localItemCount,
      restaurantId: widget.resid.toString(),
    )
        .whenComplete(() async {
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

  @override
  Widget build(BuildContext context) {
    final foodmodel = widget.model.foods![widget.index];
    final double finalPrice =
        foodCustomizationController.foodCustomerPrice.value;
    return PopScope(
      canPop: true, // Set this to true if you want to allow popping
      onPopInvoked: (didPop) async {
        if (didPop) {
          // ignore: void_checks
          return Future.value(true); // Allow the pop to continue
        }
        // ignore: void_checks
        return Future.value(false);
      },
      child: Scaffold(
        // bottomNavigationBar: Container(height: 40,color: Colors.amber,),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: foodmodel.availableStatus == true &&
                              foodmodel.status == true &&
                              widget.model.status == true
                          ? CachedNetworkImage(
                              memCacheHeight: 150,
                              memCacheWidth: 150,
                              placeholder: (context, url) =>
                                  Image.asset("${fastxdummyImg}"),
                              errorWidget: (context, url, error) =>
                                  Image.asset("${fastxdummyImg}"),
                              width: MediaQuery.of(context).size.width,
                              imageUrl:
                                  "${globalImageUrlLink}${foodmodel.foodImgUrl.toString()}",
                              fit: BoxFit.fill,
                              height: 270.h,
                            )
                          : ColorFiltered(
                              colorFilter: const ColorFilter.mode(
                                Colors.grey,
                                BlendMode.saturation,
                              ),
                              child: CachedNetworkImage(
                                memCacheHeight: 150,
                                memCacheWidth: 150,
                                placeholder: (context, url) =>
                                    Image.asset("${fastxdummyImg}"),
                                errorWidget: (context, url, error) =>
                                    Image.asset("${fastxdummyImg}"),
                                width: MediaQuery.of(context).size.width,
                                imageUrl:
                                    "${globalImageUrlLink}${foodmodel.foodImgUrl.toString()}",
                                fit: BoxFit.fill,
                                height: 270.h,
                              ),
                            ),
                    )
                  ],
                ),
                const CustomSizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Builder(
                              builder: (context) {
                                String foodType = foodmodel.foodType ?? '';
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
                                    assetPath =
                                        ''; // Default path or leave it empty if there's no image
                                }

                                return assetPath.isNotEmpty
                                    ? Image.asset(
                                        assetPath,
                                        height: 15,
                                      )
                                    : const SizedBox
                                        .shrink(); // Return an empty widget if there's no image
                              },
                            ),
                          ),
                          10.toWidth,
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              foodmodel.foodName
                                  .toString()
                                  .capitalizeFirst
                                  .toString(),
                              maxLines: null,
                              style: CustomTextStyle.subheading,
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
                            child: foodmodel.foodDiscription
                                    .toString()
                                    .capitalizeFirst
                                    .toString()
                                    .isEmpty
                                ? const SizedBox.shrink()
                                : Text(
                                    foodmodel.foodDiscription
                                        .toString()
                                        .capitalizeFirst
                                        .toString(),
                                    textAlign: TextAlign
                                        .justify, // Justifies the text for better alignment
                                    style: CustomTextStyle.profiletitle,
                                    softWrap: true,
                                    overflow: TextOverflow
                                        .clip, // Ensures text wraps to the next line
                                  ),
                          ),
                        ],
                      ),
                      const CustomSizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Food Preperation Time : ",
                            style: foodmodel.availableStatus == true &&
                                    widget.model.status == true &&
                                    foodmodel.status == true
                                ? CustomTextStyle.DECORATION_regulartext
                                : CustomTextStyle.profiletitle,
                          ),
                          Flexible(
                            // width: 350,
                            child: foodmodel.preparationTime
                                    .toString()
                                    .capitalizeFirst
                                    .toString()
                                    .isEmpty
                                ? Text(
                                    "Not Mentioned",
                                    textAlign: TextAlign
                                        .justify, // Justifies the text for better alignment
                                    style: foodmodel.availableStatus == true &&
                                            widget.model.status == true &&
                                            foodmodel.status == true
                                        ? CustomTextStyle.rederrortext
                                        : CustomTextStyle.profiletitle,
                                    softWrap: true,
                                    overflow: TextOverflow
                                        .clip, // Ensures text wraps to the next line
                                  )
                                : Text(
                                    foodmodel.preparationTime
                                        .toString()
                                        .capitalizeFirst
                                        .toString(),
                                    textAlign: TextAlign
                                        .justify, // Justifies the text for better alignment
                                    style: CustomTextStyle.profiletitle,
                                    softWrap: true,
                                    overflow: TextOverflow
                                        .clip, // Ensures text wraps to the next line
                                  ),
                          ),
                        ],
                      ),
                      const CustomSizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              "Ingredients Added         : ",
                              style: foodmodel.availableStatus == true &&
                                      widget.model.status == true &&
                                      foodmodel.status == true
                                  ? CustomTextStyle.DECORATION_regulartext
                                  : CustomTextStyle.profiletitle,
                            ),
                          ),
                          Flexible(
                            child: foodmodel.ingredients!.isEmpty
                                ? Text(
                                    "Not Mentioned",
                                    textAlign: TextAlign.justify,
                                    style: foodmodel.availableStatus == true &&
                                            widget.model.status == true &&
                                            foodmodel.status == true
                                        ? CustomTextStyle.rederrortext
                                        : CustomTextStyle.profiletitle,
                                    softWrap: true,
                                    overflow: TextOverflow.clip,
                                  )
                                : Text(
                                    foodmodel.ingredients!
                                        .join(', ')
                                        .capitalizeFirst
                                        .toString(),
                                    style: CustomTextStyle.profiletitle,
                                    softWrap: true,
                                    overflow: TextOverflow.clip,
                                  ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Color.fromARGB(255, 239, 239, 239),
                        thickness: 2.0,
                      ),
                      CustomSizedBox(height: 5.h),
                      buildVariantList(foodmodel: foodmodel),
                      const Divider(
                        color: Color.fromARGB(255, 239, 239, 239),
                        thickness: 2.0,
                        indent: 10.0, // Left indentation
                        endIndent: 10.0, // Right indentation
                      ),
                      CustomSizedBox(height: 5.h),
                      buildAddOnsList(foodmodel: foodmodel),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 2),
                        child: foodmodel.availableStatus == true &&
                                foodmodel.status == true &&
                                widget.model.status == true
                            ? Row(
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
                                                if (localItemCount > 1) {
                                                  setState(() {
                                                    localItemCount--;
                                                  });
                                                } else if (localItemCount ==
                                                    1) {
                                                  Navigator.pop(context);
                                                }
                                              },
                                              child: const Icon(Icons.remove,
                                                  color:Customcolors.darkpurple),
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
                                              if (UserId == null || UserId.isEmpty) {
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
return;
}
                                                setState(() {
                                                  localItemCount++;
                                                });
                                                buttonController.showButton();
                                              },
                                              child: const Icon(Icons.add,
                                                  color:Customcolors.darkpurple),
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
return;
}

                                      if (isProcessing)
                                        return; // Prevent further clicks during processing

                                      setState(() {
                                        isProcessing =
                                            true; // Set processing flag to true
                                      });

                                      var cartItems = await foodcart
                                          .getfoodcartfood(km: widget.totalDis);

                                      var isDifferentRestaurant = cartItems.any(
                                          (item) =>
                                              item['restaurantId'] !=
                                              widget.resid);

                                      if (isDifferentRestaurant) {
                                        showReplaceCartDialog();
                                      } else {
                                        addInitialAddOnsToCart();
                                      }
                                    },
                                    child: CustomContainer(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      decoration: CustomContainerDecoration
                                          .gradientbuttondecoration(),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 20),
                                        child: Center(
                                          child: Obx(() {
                                            final double finalPrice =
                                                foodCustomizationController
                                                    .foodCustomerPrice.value;
                                            final double totalPrice =
                                                finalPrice * localItemCount;
                                            return Text(
                                              "Add Item | ₹${totalPrice.toStringAsFixed(2)}",
                                              overflow: TextOverflow.ellipsis,
                                              style: CustomTextStyle
                                                  .smallwhitetext,
                                            );
                                          }),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : CustomContainer(
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
                      )
                    ],
                  ),
                ),
                const CustomSizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildVariantList({foodmodel}) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.customizedFoodvariants!.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.customizedFoodvariants![index].variantGroupName
                  .toString()
                  .capitalizeFirst
                  .toString(),
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyle.smallboldblack,
            ),
            CustomSizedBox(height: 3.h),
            if (index == 0) ...[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  "Select any 1 option",
                  style: CustomTextStyle.addressfetch,
                ),
              ),
              CustomSizedBox(height: 3.h),
            ],
            CustomSizedBox(height: 3.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
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
              physics: const NeverScrollableScrollPhysics(),
              itemCount:
                  widget.customizedFoodvariants![index].variantType!.length,
              itemBuilder: (context, i) {
                String variantId = widget
                    .customizedFoodvariants![index].variantType![i].id
                    .toString();
                dynamic variantPrice = widget.customizedFoodvariants![index]
                    .variantType![i].customerPrice;
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Builder(
                            builder: (context) {
                              String foodType = foodmodel.foodType ?? '';
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
                                  assetPath =
                                      ''; // Default path or leave it empty if there's no image
                              }

                              return assetPath.isNotEmpty
                                  ? Image.asset(assetPath, height: 15)
                                  : const SizedBox.shrink();
                            },
                          ),
                          5.toWidth,
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width / 1.9,
                            child: Text(
                              widget.customizedFoodvariants![index]
                                  .variantType![i].variantName
                                  .toString()
                                  .capitalizeFirst
                                  .toString(),
                              maxLines: null,
                              style: CustomTextStyle.black12,
                            ),
                          ),
                        ],
                      ),
                      // Spacer(),
                      Row(
                        children: [
                          Text(
                            "+ ₹${widget.customizedFoodvariants![index].variantType![i].customerPrice.toString()}",
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyle.black12,
                          ),
                          Transform.scale(
                            scale: 1,
                            child: Radio(
                              activeColor: foodmodel.availableStatus == true &&
                                      widget.model.status == true &&
                                      foodmodel.status == true
                                  ? Customcolors.darkpurple
                                  : Customcolors.DECORATION_GREY,
                              value: variantId,
                              groupValue: foodCustomizationController
                                  .selectedVariantId.value,
                              onChanged: foodmodel.availableStatus == true &&
                                      widget.model.status == true &&
                                      foodmodel.status == true
                                  ? (String? newValue) {
                                      setState(() {
                                        foodCustomizationController
                                            .updateVariant(
                                                newValue, variantPrice!);
                                      });
                                    }
                                  : null,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                        ],
                      )
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

  Widget buildAddOnsList({foodmodel}) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.addOns!.length,
      itemBuilder: (context, index1) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                widget.addOns![index1].addOnsGroupName
                    .toString()
                    .capitalizeFirst
                    .toString(),
                overflow: TextOverflow.ellipsis,
                style: CustomTextStyle.smallboldblack,
              ),
            ),
            CustomSizedBox(height: 3.h),
            if (index1 == 0) ...[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  "Choose Add-Ons",
                  style: CustomTextStyle.addressfetch,
                ),
              ),
            ],
            CustomSizedBox(height: 3.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
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
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.addOns![index1].addOnsType!.length,
              itemBuilder: (context, i) {
                // var addOn = widget.addOns![index1].addOnsList![index];
                String addOnId =
                    widget.addOns![index1].addOnsType![i].id.toString();
                dynamic addOnPrice = widget.addOns![index1].addOnsType![i]
                    .customerPrice; // Keep as int
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Builder(
                            builder: (context) {
                              String foodType =
                                  widget.addOns![index1].addOnsType![i].type ??
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
                          5.toWidth,
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.9,
                            child: Text(
                              widget.addOns![index1].addOnsType![i].variantName
                                  .toString()
                                  .capitalizeFirst
                                  .toString(),
                              maxLines: null,
                              style: CustomTextStyle.black12,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "+ ₹${widget.addOns![index1].addOnsType![i].customerPrice.toString()}",
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: CustomTextStyle.black12,
                          ),
                          Transform.scale(
                            scale: 1,
                            child: Checkbox(
                              activeColor: foodmodel.availableStatus == true &&
                                      widget.model.status == true &&
                                      foodmodel.status == true
                                  ? Customcolors.darkpurple
                                  : Customcolors.DECORATION_GREY,
                              value: foodCustomizationController.selectedAddons
                                  .contains(addOnId),
                              onChanged: foodmodel.availableStatus == true &&
                                      widget.model.status == true &&
                                      foodmodel.status == true
                                  ? (bool? newValue) {
                                      setState(() {
                                        foodCustomizationController.toggleAddon(
                                            addOnId, addOnPrice!);
                                      });
                                    }
                                  : null,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                        ],
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

  void showReplaceCartDialog() {
    var orderForOthers =
        Provider.of<InstantUpdateProvider>(context, listen: false);
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
            Navigator.pop(context);
            addInitialAddOnsToCart();
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
      },
    ).whenComplete(() {
      // Ensure isProcessing is reset when dialog is closed by any method
      setState(() {
        isProcessing = false;
      });
    });
  }
}
