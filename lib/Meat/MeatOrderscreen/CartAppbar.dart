// ignore_for_file: file_names, unnecessary_string_interpolations, unused_local_variable, must_be_immutable, unnecessary_null_comparison, avoid_print

import 'dart:async';
import 'package:testing/Features/Foodmodule/getFoodCartProvider.dart';
import 'package:testing/Features/Homepage/AddressController/Addresscontroller.dart';
import 'package:testing/Meat/Common/Addcartmeataddress.dart';
import 'package:testing/Meat/Homepage/Meathomepage.dart';
import 'package:testing/Meat/MeatButtonFunctionalities/MeatAddproductController.dart/AddmeatController.dart';
import 'package:testing/Meat/MeatButtonFunctionalities/TotalitemcountButton.dart';
import 'package:testing/Meat/MeatOrderscreen/CartItemdetails.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatOrderController/MeatCouponcontroller.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatOrderController/MeatcreateOrdercontroller.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatOrderHistoryTabbar/ItemDetails.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatPaymentBottomsheet.dart';
import 'package:testing/Meat/MeatOrderscreen/couponClass.dart';
import 'package:testing/Meat/MeatOrderscreen/meatadditionalinfo.dart';
import 'package:testing/Meat/MeatRazorPayment/MeatRazorpayment.dart';
import 'package:testing/Meat/Meatview/Meatproductview.dart';
import 'package:testing/common/cartscreenWidgets.dart';
import 'package:testing/common/commonTextWidgets.dart';
import 'package:testing/utils/Buttons/CustomAlertDialoug.dart';
import 'package:testing/utils/Buttons/CustomButton.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Const/localvaluesmanagement.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/CustomDottedline.dart';
import 'package:testing/utils/Decorations/boxDecoration.dart';
import 'package:testing/utils/Shimmers/Foodcartshimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class CartitemsScreen extends StatefulWidget {
  dynamic shopId;
  String? shopname;
  String? shopcity;
  String? fulladdress;
  String? shopregion;
  String? shopimg;
  bool isFromtab;
  dynamic rating;
  dynamic totalDis;
  dynamic shop;
  final List meatfavourListDetails;
  CartitemsScreen(
      {this.isFromtab = false,
      required this.shopId,
      required this.fulladdress,
      required this.shopcity,
      required this.shopname,
      required this.shopregion,
      required this.rating,
      required this.shopimg,
      required this.totalDis,
      required this.shop,
      this.meatfavourListDetails = const [],
      super.key});

  @override
  State<CartitemsScreen> createState() => _CartitemsScreenState();
}

class _CartitemsScreenState extends State<CartitemsScreen> {
  MeatButtonController buttonController = MeatButtonController();
  MeatAddcontroller meatcart = Get.put(MeatAddcontroller());
  AddressController addresscontroller = Get.put(AddressController());
  MeatPaymentMethodController paymentMethodController = Get.put(MeatPaymentMethodController());
  MeatOrdercontroller createmeatorder = Get.put(MeatOrdercontroller());
  final MeatRazorpaymentIntegration integration = MeatRazorpaymentIntegration();
 
  Map<int, int> quantities = {};
  List<Map<String, dynamic>> meatList = [];
  List<Map<String, dynamic>> orderDetailsListPay = [];
  Logger log = Logger();
  bool hasUnavailableItem = false;
  bool iscartloading = false;
   bool isButtonLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
     addresscontroller.getaddressapi(context: context,latitude: initiallat,longitude: initiallong);
      integration.initiateRazorPay();
      getttcartDetails();
    });
  }
 forrefresh() {
     WidgetsBinding.instance.addPostFrameCallback((_) {
       addresscontroller.getaddressapi(context: context,latitude: initiallat,longitude: initiallong);
      integration.initiateRazorPay();
      getttcartDetails();
    });
  }
 @override
  void dispose() {
    integration.dispose();
    buttonController.dispose();
    super.dispose();
  }
  
  getttcartDetails() {
    Timer(const Duration(seconds: 0), () async {
      final foodcartprovider = Provider.of<FoodCartProvider>(context, listen: false);
      meatList.clear();
      orderDetailsListPay.clear();

      try {
        await meatcart.getmeatcartmeat(km: foodcartprovider.totalDist);
        setState(() {
          meatList = List.from(meatcart.getmeatcart["data"]["meats"]);
          for (int i = 0; i < meatList.length; i++) {
            quantities[i] = meatList[i]["quantity"];
          }
          _updateOrderDetails();
        });

        if (meatList.isEmpty) {
          // Handle empty foodsList case
          return;
        }
         meatcart.getbillmeatcartmeat(km: resGlobalKM);

        hasUnavailableItem = meatList.any((meat) =>
            meat["meatDetails"]["available"] == false ||
            meat["meatDetails"]["status"] == false);

        if (hasUnavailableItem) {
          Future.delayed(Duration.zero, () {
            CustomLogoutDialog.show(
              context: context,
              title: 'Meat Not Available',
              content: "Added meat item isn't available at this time. Please check back later or choose a different shop.",
              onConfirm: () async {
                meatcart.clearmeatCartItem(context: context);
                meatcart.getmeatcartmeat(km: resGlobalKM);
                Provider.of<MeatButtonController>(context, listen: false).totalItemCountNotifier.value = 0;
                Provider.of<MeatButtonController>(context, listen: false).hidemeatButton();
                Get.off(() => Meathomepage(meatproductcategoryid: meatproductCateId,),transition: Transition.leftToRight);
              },
              buttonname: 'Replace',
              oncancel: () {
                Navigator.pop(context);
              },
            );
          });
        }
      } catch (error) {
        print("Error: $error");
      }
    });
  }

  Future<void> _updateOrderDetails() async {
    orderDetailsListPay.clear();
    for (int i = 0; i < meatList.length; i++) {
      int meatPrice;
      if (meatList[i]["isCustomized"] == false) {
        meatPrice =meatList[i]["meatDetails"]["singleUnCustomizedPriceForMeat"];
      } else if (meatList[i]["selectedVariantId"] == null ||meatList[i]["selectedVariantId"].isEmpty) {
        meatPrice = meatList[i]["addOnsDetails"] != null
            ? meatList[i]["addOnsDetails"]["addOnsAmountForSingle"]
            : 0;
      } else if (meatList[i]["selectedAddOns"] == null ||meatList[i]["selectedAddOns"].isEmpty) {
        meatPrice = meatList[i]["variantDetails"] != null
            ? meatList[i]["variantDetails"]["variantAmountForSingle"]
            : 0;
      } else {
        meatPrice = (meatList[i]["variantDetails"]["variantAmountForSingle"] +
            meatList[i]["addOnsDetails"]["addOnsAmountForSingle"]);
      }

      orderDetailsListPay.add({
        "productType": "meat",
        "description": "",
        "foodId": meatList[i]["meatId"],
        "foodName": meatList[i]["meatDetails"]["meatName"].toString(),
        "foodImage": meatList[i]["meatDetails"]["meatImgUrl"].toString(),
        "quantity": quantities[i] ?? 0, // Use updated quantity
        "foodPrice": double.parse(meatPrice.toString()),
        "totalPrice": double.parse( meatList[i]["meatDetails"]["meat"]["totalPrice"].toString())
      });
    }
  }

 int calculatePrice(int index) {
  final meat = meatList[index]; // Get the meat item at the specified index
  dynamic quantity = quantities[index]; // Get the quantity for this item
  dynamic meatPrice = meat["meatDetails"]["meat"]["customerPrice"];
  
  dynamic variantPrice = 0;
  dynamic addOnsPrice = 0;

  // Calculate variant price if selected
  if (meat["selectedVariantId"] != null && meat["selectedVariantId"].isNotEmpty) {
    variantPrice = meat["variantDetails"]["customizedFood"]["addVariants"]["variantType"]["customerPrice"];
  }

  // Calculate add-ons price if selected
  if (meat["selectedAddOns"] != null && meat["selectedAddOns"].isNotEmpty) {
    for (final addOnId in meat["selectedAddOns"]) {
      // Find the addon details in the addOnsDetails array
      final addOn = meat["addOnsDetails"]["addOnsDetails"]
          .firstWhere((addOnDetail) => addOnDetail["addOns"]["addOnsType"]["_id"] == addOnId, orElse: () => null);
      if (addOn != null) {
        addOnsPrice += addOn["addOns"]["addOnsType"]["customerPrice"];
      }
    }
  }

  // Calculate total price based on conditions
  dynamic totalPrice;
  if (meat["selectedAddOns"] == null || meat["selectedAddOns"].isEmpty) {
    // Add meat price and variant price
    totalPrice = (meatPrice + variantPrice) * quantity;
  } else if (meat["selectedVariantId"] == null || meat["selectedVariantId"].isEmpty) {
    // Add meat price and add-ons price
    totalPrice = (meatPrice + addOnsPrice) * quantity;
  } else {
    // Add meat price, variant price, and add-ons price
    totalPrice = (meatPrice + variantPrice + addOnsPrice) * quantity;
  }

  return totalPrice; // Return as int
}


  Future<void> updateItemCount(int index, int itemCount) async {
    if (itemCount <= 0) {
      await meatcart.deleteCartItem(meatid: meatList[index]["meatId"]).whenComplete(() async {
        setState(() async {
          quantities.remove(index); // Remove quantity from local list
          meatList.removeAt(index);
          quantities = Map.fromIterables(
            List.generate(meatList.length, (i) => i),
            meatList.map((item) => item["quantity"]),
          );
          await _updateOrderDetails();
          await meatcart.getbillmeatcartmeat(km: resGlobalKM);
          if (meatList == null || meatList.isEmpty) {
            buttonController.hidemeatButton();
          }
          await buttonController.updatemeatTotalItemCount( meatcart,);
        });
      });
    } else {
      await meatcart.updatemeatItem(meatid: meatList[index]["meatId"], quantity: itemCount).whenComplete(() {
        setState(() {
          quantities[index] = itemCount;
          meatList[index]["quantity"] = itemCount;
        });
      });
    }
  }

  load({ttlkm}) async {
    if (iscartloading) {
      // Wait for 2 seconds
      await Future.delayed(const Duration(seconds: 0));
      setState(() {
        // Hide the CircularProgressIndicator
        iscartloading = false;
      });
      await meatcart.getbillmeatcartmeat(km: ttlkm);
    }
  }

  @override
Widget build(BuildContext context) {
  var mapaddres = Provider.of<MapDataProvider>(context);
  var updateCount = Provider.of<MeatButtonController>(context);
  final foodcartprovider = Provider.of<FoodCartProvider>(context);
  var coupon = Provider.of<MeatCouponController>(context);
  var instantdata = Provider.of<MeatInstantUpdateProvider>(context);

  return PopScope(
    canPop: false,
    onPopInvoked: (didPop) async {
      Get.off(
        Meatproductviewscreen(
        meatfavourListDetails: widget.meatfavourListDetails,
          fulladdress: widget.fulladdress,
          isFrommeatscreen: widget.isFromtab,
          shopid: widget.shopId,
          city: widget.shopcity,
          imgurl: widget.shopimg,
          shopname: widget.shopname,
          region: widget.shopregion,
          rating: widget.rating, totalDis: resGlobalKM,
        ),
      );
      await meatcart.getmeatcartmeat(km: resGlobalKM);
    },
    child: Scaffold(
      backgroundColor: Customcolors.DECORATION_CONTAINERGREY,
      appBar: AppBar(
        toolbarHeight: 65.h,
        backgroundColor: Customcolors.DECORATION_CONTAINERGREY,
        surfaceTintColor: Customcolors.DECORATION_CONTAINERGREY,
        titleSpacing: 0,
        leading: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () async {
            Get.off(
              Meatproductviewscreen(
              meatfavourListDetails: widget.meatfavourListDetails,
                fulladdress: widget.fulladdress,
                isFrommeatscreen: widget.isFromtab,
                shopid: widget.shopId,
                city: widget.shopcity,
                imgurl: widget.shopimg,
                shopname: widget.shopname,
                region: widget.shopregion,
                rating: widget.rating, totalDis: resGlobalKM,
              ),
            );
            await meatcart.getmeatcartmeat(km: resGlobalKM);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Customcolors.DECORATION_BLACK,
          ),
        ),
        title: CartAppBarTitle(
        title:widget.shopname.toString().capitalizeFirst.toString(),
        subTitlel:widget.fulladdress.toString().capitalizeFirst  ,),
      ),
      body: RefreshIndicator(
      color: Customcolors.darkpurple,
      onRefresh: () async {
      await Future.delayed(const Duration(seconds: 2), () {
        return forrefresh();
       });
      },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecorationsFun.whiteCircelRadiusDecoration(),
                  padding: const EdgeInsets.all(12.0),
                  child: InkWell(
                    onTap: () {
                      addcartAddressBottomSheet(context).then((value) {
                        Future.delayed(
                          const Duration(seconds: 0),
                          () {
                            double totalDistance = double.parse(foodcartprovider.totalDis.split(' ').first.toString());
                            setState(() {
                              meatcart.getbillmeatcartmeat(km: totalDistance);
                            });
                          },
                        );
                      });
                    },
                    child: CartAddressBar(
                      addressType: mapaddres.addressType,
                      fullAddress: mapaddres.fullAddress.toString().substring(0, 20).toString(),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Obx(() {
                  if (meatcart.getmeatcartloading.isTrue) {
                    return const Center(child: Foodcartshimmer());
                  } else if (meatcart.getmeatcart == null || meatcart.getmeatcart["data"] == null) {
                    return const Center(child: Foodcartshimmer());
                  } else if (meatList.isEmpty) {
                    return const SizedBox();
                  } else {
                    return Container(
                      decoration: BoxDecorationsFun.whiteCircelRadiusDecoration(radious: 10.0),
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Item Details",
                            style: CustomTextStyle.boldblack12,
                          ),
                          5.toHeight,
                          ListView.separated(
                            shrinkWrap: true,
                            itemCount: meatList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) => const SizedBox(height: 5),
                            itemBuilder: (BuildContext context, index) {
                              int currentQuantity = quantities[index] ?? 0;
                              var meatName = meatList[index]["meatDetails"]["meatName"].toString();
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Itemdetails(meatImgurl:  meatList[index]["meatDetails"]["meatImgUrl"], meatunit: meatList[index]["meatDetails"]["meat"]["unit"], meatunitValue: meatList[index]["meatDetails"]["meat"]["unitValue"]*quantities[index], calculatePrice: calculatePrice(index), meatName: meatName,),
                                    meatList[index]["meatDetails"]["available"] == true &&
                                            meatList[index]["meatDetails"]["status"] == true
                                        ? CustomContainer(
                                            height: 20.h,
                                            width: 70.w,
                                            decoration: CustomContainerDecoration.gradientborderdecoration(
                                              radious: 7.0,
                                              borderwidth: 0.6,
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                  if (currentQuantity > 1) {
                                                     setState(() {
                                                     quantities[index] = currentQuantity - 1;
                                                     iscartloading = true;
                                                     });
                                                    updateCount.decrementmeatItemCount(1);
                                                    await updateItemCount(index, currentQuantity - 1);
                                                    load(ttlkm: resGlobalKM);
                                                    _updateOrderDetails();
                                                  } else if (currentQuantity == 1) {
                                                   await updateItemCount(index, 0).whenComplete(() {
                                                    if (meatList.isEmpty) {
                                                    Get.off(() => Meathomepage(meatproductcategoryid: meatproductCateId,), transition: Transition.leftToRight);
                                                    meatcart.clearmeatCartItem(context: context);
                                                    meatcart.getmeatcartmeat(km: resGlobalKM);
                                                    Provider.of<MeatButtonController>(context, listen: false).totalItemCountNotifier.value = 0;
                                                    Provider.of<MeatButtonController>(context, listen: false).hidemeatButton();
                                                    coupon.removeCoupon();
                                                  } else { }
                                                });
                                                }
                                              if (coupon.isCouponApplied) {
                                                await meatcart.getbillmeatcartmeat(km: resGlobalKM);
                                              if (meatcart.getbillmeatcart["data"]["totalFoodAmount"] <= coupon.aboveVal) {
                                                coupon.removeCoupon();
                                              } else {
                                                await meatcart.getbillmeatcartmeat(km: resGlobalKM);
                                                }
                                                }
                                              },
                                                  child: const Icon(
                                                    Icons.remove,
                                                    color: Customcolors.darkpurple,
                                                    size: 15,
                                                    weight: 20,
                                                  ),
                                                ),
                                                5.toWidth,
                                                Flexible(
                                                  child: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: Text(
                                                      '${quantities[index]}',
                                                      style: CustomTextStyle.addbtn,
                                                    ),
                                                  ),
                                                ),
                                                5.toWidth,
                                                InkWell(
                                                  onTap: () async {
                                                    setState(() {
                                                     quantities[index] = currentQuantity + 1;
                                                      iscartloading = true;
                                                      });
                                                      updateCount.incrementmeatItemCount(1);
                                                     await updateItemCount(index, currentQuantity + 1,);
                                                    _updateOrderDetails();
                                                    load(ttlkm: resGlobalKM);
                                                  },
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: Customcolors.darkpurple,
                                                    size: 15,
                                                    weight: 20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CustomContainer(
                                              height: 20.h,
                                            width: 65.w,
                                              decoration: CustomContainerDecoration.meatcartgreybuttondecoration(
                                              radious: 7.0,
                                              borderwidth: 0.6,),
                                              child: const Center(
                                                child: Text(
                                                  "ADD",
                                                  style: CustomTextStyle.whitemediumtext,
                                                ),
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 5),
                          CustomPaint(
                            size: Size(MediaQuery.of(context).size.width / 1, 10),
                            painter: DottedLinePainter(),
                          ),
                          InkWell(
                            onTap: () {
                              Get.off(
                Meatproductviewscreen(
                  fulladdress: widget.fulladdress,
                  isFrommeatscreen: widget.isFromtab,
                  shopid: widget.shopId,
                  city: widget.shopcity,
                  imgurl: widget.shopimg,
                  shopname: widget.shopname,
                  region: widget.shopregion,
                  rating: widget.rating, totalDis: resGlobalKM,
                ),
              );
                            },
                            child: ViewMoreTextArrow(content: "Add more item"),
                          ),
                        ],
                      ),
                    );
                  }
                }),
                10.toHeight,
                CouponWidget(shopid: widget.shopId, totalDis: resGlobalKM),
                10.toHeight,
                CartBillwidget(
                  isFromcartBillwidget: hasUnavailableItem,
                  shopid: widget.shopId,
                  orderDetailsListPay: orderDetailsListPay,
                  integration: integration,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: mapaddres.addressType != 'Current' &&
        addresscontroller.getaddressdetails != null
    ? const SizedBox()
    : AnimatedContainer(
        duration: const Duration(milliseconds: 500), // Duration for smooth animation
        curve: Curves.easeInOut,
        height: MediaQuery.sizeOf(context).height / 4.7,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(4, 0),
              blurRadius: 3,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: [
            const Row(
              children: [
                Icon(CupertinoIcons.location, color: Colors.orange),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Where would you like us to deliver this order?',
                    style: CustomTextStyle.splashpermissionTitle,
                  ),
                ),
              ],
            ),
            30.toHeight,
            CustomButton(
              onPressed: () {
                addcartAddressBottomSheet(context).then((value) {
                  Future.delayed(const Duration(seconds: 0), () {
                    double totalDistance = double.parse(
                      foodcartprovider.totalDis
                          .split(' ')
                          .first
                          .toString(),
                    );
                    setState(() {
                      meatcart.getbillmeatcartmeat(km: totalDistance);
                    });
                  });
                });
              },
              borderRadius: BorderRadius.circular(30),
              child: const Text(
                'Add or Select address',
                style: CustomTextStyle.fontWeight15,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


    Future<dynamic> addcartAddressBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) => Addmeataddress(
            totalDis: resGlobalKM, shopid: widget.shopId),
        isDismissible: true,
        showDragHandle: true,
        enableDrag: true);
  }
}
