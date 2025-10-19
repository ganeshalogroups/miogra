// ignore_for_file: must_be_immutable, avoid_print, file_names, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'package:cached_network_image/cached_network_image.dart';
import 'package:testing/Features/Foodmodule/Domain/Foodnonvegmodel.dart';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Addfoodcontroller.dart';
import 'package:testing/Features/Foodmodule/Foodviewscreen/AddButtonFunctions/Buttonfunctionalities.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/FoodsearchTabbar/Disabledcontainerfordishes.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/FoodsearchTabbar/Dishedadd.dart';
import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Redirectcontroller.dart';
import 'package:testing/Features/coupon/couponController.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Dishessubclass extends StatefulWidget {
  dynamic foods;
  dynamic availablenow;
  dynamic index;
  // dynamic index2;
  bool isTabScreen;
  // int current;
  // dynamic additionalImages;
  Dishessubclass({
    super.key,
    this.foods,
    required this.availablenow,
    this.index,
    // required this.current,
    // this.additionalImages,
    this.isTabScreen = false,
    // required this.index2,
  });

  @override
  State<Dishessubclass> createState() => _DishessubclassState();
}

class _DishessubclassState extends State<Dishessubclass> {
  ButtonController buttonController = ButtonController();
  // Foodsearchcontroller createrecentsearch = Get.find<Foodsearchcontroller>();
  RedirectController redirect = Get.find<RedirectController>();
  final Foodcartcontroller foodcart = Get.find<Foodcartcontroller>();

  CouponController coupon = CouponController();
  ValueNotifier<int> itemCountNotifier = ValueNotifier<int>(0);
  @override
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //  foodcart.getfoodcartfood(km:"5");
      buttonController = Provider.of<ButtonController>(context, listen: false);
      checkIfItemInCart();
    });
  }

  Future<void> checkIfItemInCart() async {
    try {
      var cartItems = await foodcart.getfoodcartfood(km: "5");

      var currentItem = cartItems.firstWhere(
        (item) => item['restaurantId'] == widget.foods["restaurantId"],
        orElse: () => null,
      );

      if (currentItem != null &&
          currentItem['restaurantId'] == widget.foods["restaurantId"]) {
        setState(() {
          isCart = true;
          currentItem['quantity'];
          // Provider.of<ButtonController>(context, listen: false).showButton();
        });
      } else if (currentItem != null) {
        setState(() {
          isCart = true;
          // itemCount = currentItem['quantity'];
          Provider.of<ButtonController>(context, listen: false).showButton();
        });

        // setState(() {});
      } else {
        setState(() {
          isCart = false;
          // itemCount = 0;
          Provider.of<ButtonController>(context, listen: false).hideButton();
        });
      }

      // else {
      //   setState(() {
      //     isCart = false;
      //     // Provider.of<ButtonController>(context, listen: false).hideButton();
      //   });
      // }
    } catch (e) {
      print("Error checking if item is in cart: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    List<AddOn> addOnList = [];
    List<AddVariant> variantList = [];
    final isCustomizable = widget.foods["iscustomizable"] == true;

    final dynamic actualPrice = isCustomizable
        ? widget.foods["customizedFood"]["addVariants"][0]["variantType"][0]
            ["customerPrice"]
        : widget.foods["food"]["customerPrice"];
    bool isActive = widget.foods["status"] == true &&
        widget.availablenow["availableNow"] == true;
    if (widget.foods["iscustomizable"] == true) {
      addOnList = (widget.foods["customizedFood"]["addOns"] as List)
          .map((addOn) => AddOn.fromJson(addOn))
          .toList();

      // Convert customizedFoodvariants from JSON to List<AddVariant>
      variantList = (widget.foods["customizedFood"]["addVariants"] as List)
          .map((variant) => AddVariant.fromJson(variant))
          .toList();
    } else {
      const SizedBox();
    }

    if (isActive) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Color.fromARGB(255, 240, 240, 240),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                        padding:
                            const EdgeInsets.only(left: 5, right: 5, top: 5),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: CachedNetworkImage(
                            height: 110,
                            width: 100,
                            imageUrl:
                                "${globalImageUrlLink}${widget.foods["foodImgUrl"].toString()}",
                            fit: BoxFit.fill,
                            placeholder: (context, url) => Image.asset(
                              "${fastxdummyImg}",
                              fit: BoxFit.fill,
                              height: 10,
                              width: 10,
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              "${fastxdummyImg}",
                              fit: BoxFit.fill,
                              height: 10,
                              width: 10,
                            ),
                            // You can specify height and width if needed, or omit them.
                          ),
                        )),
                    widget.foods["iscustomizable"]
                        ? const SizedBox(
                            height: 5,
                          )
                        : const SizedBox(
                            height: 0,
                          ),
                    widget.foods["iscustomizable"]
                        ? const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text("Customisable",
                                style: CustomTextStyle.addressfetch),
                          )
                        : const SizedBox.shrink()
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
                              Expanded(
                                child: Text(
                                  widget.foods["foodName"]
                                      .toString()
                                      .capitalizeFirst
                                      .toString(),
                                  style: CustomTextStyle.googlebuttontext,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Image(
                                image: widget.foods["foodType"] == "nonveg"
                                    ? const AssetImage(
                                        "assets/images/Non veg.png")
                                    : const AssetImage("assets/images/veg.png"),
                                height: 15,
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                          const SizedBox(height: 5),
                          widget.foods["foodDiscription"] == null ||
                                  widget.foods["foodDiscription"] == "" ||
                                  widget.foods["foodDiscription"].isEmpty
                              ? const SizedBox.shrink()
                              : Text(
                                  "${widget.foods["foodDiscription"].toString().trim().capitalizeFirst!}",
                                  style: CustomTextStyle.boldgrey,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "₹ ${actualPrice.toStringAsFixed(1)}",
                            style: CustomTextStyle.foodpricetext,
                          ),
 
                              FoodItemWidget(
                                  foodItemData: widget.foods,
                                  itemCountNotifier: itemCountNotifier,
                                  variantList: variantList,
                                  addOnList: addOnList,
                                  isFromTab: widget.isTabScreen,
                                )
                         ],
                      ),
                      const CustomSizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      // return Disabledishes(rating: rating,foods: widget.foods,index: widget.index,index2: widget.index2,);
      return Disabledishes(
        foods: widget.foods,
      );
    }
  }
}
