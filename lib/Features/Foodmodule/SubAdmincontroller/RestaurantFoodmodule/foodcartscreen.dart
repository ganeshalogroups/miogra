// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'dart:async';
import 'package:testing/Features/Bottomsheets/AddPaymentmethod.dart';
import 'package:testing/Features/Bottomsheets/Addadressbottomsheet.dart';
import 'package:testing/Features/Bottomsheets/Additionalinfo.dart';
import 'package:testing/Features/Bottomsheets/Adduserbottomsheet.dart';
import 'package:testing/Features/Bottomsheets/Deliverytips.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/Coupon/Coupon.dart';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Addfoodcontroller.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/Foodgetcontroller.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Cartcustomisation.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodhomepage.dart';
import 'package:testing/Features/Foodmodule/Foodviewscreen/AddButtonFunctions/Buttonfunctionalities.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodviewfirstscreen.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/CreateOrdercontroller.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Unavailablefoodincart.dart';
import 'package:testing/Features/Foodmodule/getFoodCartProvider.dart';
import 'package:testing/Features/Homepage/AddressController/Addresscontroller.dart';
import 'package:testing/PaymentGateway/Razorpay.dart';
import 'package:testing/common/billDataClass.dart';
import 'package:testing/common/cartscreenWidgets.dart';
import 'package:testing/common/commonTextWidgets.dart';
import 'package:testing/common/commonloadingWidget.dart';
import 'package:testing/common/edgeIncetsClass.dart';
import 'package:testing/Features/coupon/couponController.dart';
import 'package:testing/common/reusablefunctions.dart';
import 'package:testing/utils/Buttons/CustomAlertDialoug.dart';
import 'package:testing/utils/Buttons/CustomButton.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customdisabledbutton.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Const/localvaluesmanagement.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/CustomDottedline.dart';
import 'package:testing/utils/Decorations/boxDecoration.dart';
import 'package:testing/utils/Shimmers/BillSummaryShimmer.dart';
import 'package:testing/utils/Shimmers/Foodcartshimmer.dart';
import 'package:testing/utils/Toast/customtoastmessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Redirectcontroller.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddToCartScreen extends StatefulWidget {
  //dynamic vendorId;
  dynamic restaurantId;
  String? restaurantname;
  String? restaurantcity;
  String? fulladdress;
  String? restaurantregion;
  final List<dynamic>? restaurantfoodtitle;
  dynamic restaurantreview;
  dynamic reviews;
  String? restaurantimg;
  dynamic restaurant;
  dynamic menu;
  final List favourListDetails;
  // final List<dynamic>? additionalImages;
  dynamic totalDis;
  bool isFromtab;

  AddToCartScreen({
    super.key,
    this.isFromtab = false,
    required this.totalDis,
   // this.vendorId,
    this.restaurantId,
    required this.fulladdress,
    this.restaurantcity,
    this.restaurantfoodtitle,
    this.restaurantname,
    this.restaurantregion,
    this.restaurantreview,
    this.reviews,
    this.restaurantimg,
    this.restaurant,
    // required this.favouritestatus,
    this.menu,
    this.favourListDetails = const [],
    // this.additionalImages,
  });

  @override
  State<AddToCartScreen> createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
//  dynamic productviewprovider;
//  void com(){
// setState(() {
//     productviewprovider = Provider.of<FoodProductviewPaginations>(context).foodDetails;
// });
//  }

  ButtonController buttonController = ButtonController();
  // Foodcartcontroller foodcart = Get.put(Foodcartcontroller());
  final Foodcartcontroller foodcart = Get.find<Foodcartcontroller>();

  Ordercontroller ordercreate = Get.put(Ordercontroller());
  CheckboxController checkboxController = Get.put(CheckboxController());
  PaymentMethodController paymentMethodController =
      Get.put(PaymentMethodController());
  // Walletcontroller walletget = Get.put(Walletcontroller());
  final RazorpaymentIntegration integration = RazorpaymentIntegration();
  AddToCartController addToCartController = Get.put(AddToCartController());
  AddressController addresscontroller = Get.put(AddressController());
  Ordercontroller createorder = Get.put(Ordercontroller());
  RedirectController redirect = Get.put(RedirectController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //  TipsstoredController tipscontroller= Get.put(TipsstoredController());
  Map<int, int> quantities = {};
  List<Map<String, dynamic>> foodsList = [];

   List<Map<dynamic, dynamic>> mergedList = [];

  List<Map<String, dynamic>> orderDetailsListPay = [];
  List cartIdList = [];
  bool iscartloading = false;
  bool isClicked = false;

  bool isButtonLoading = false;
  bool paymentsheet = false;

  Logger log = Logger();
  bool hasUnavailableItem = false;
  int commission =0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      addresscontroller.getaddressapi(
          context: context, latitude: initiallat, longitude: initiallong);
      integration.initiateRazorPay();
    
      //  walletget.getwalletDetails();
      getttcartDetails();
      if (paymentsheet) {
        addcartPaymentBottomSheet(context);
      }

      ordercreate.Vendercash( foodcart
                                                                          .getfoodcart["data"]
                                                                      ["restaurantDetails"][
                                                                  "parentAdminUserId"],);
    });
  }

 

  Future<void> forrefresh() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final coupon = Provider.of<CouponController>(context, listen: false);
      final buttonController =
          Provider.of<ButtonController>(context, listen: false);

      try {
        // API calls
        addresscontroller.getaddressapi(
            context: context, latitude: initiallat, longitude: initiallong);
        integration.initiateRazorPay();
        redirect.getredirectDetails();

        await foodcart.getfoodcartfood(km: resGlobalKM);
        await foodcart.getbillfoodcartfood(km: resGlobalKM);
       await   redirect.getredirectDetails();//1
        final cartData = foodcart.getfoodcart?["data"];
        final foodsData = cartData != null ? (cartData["foods"] ?? []) : [];
        final billData = foodcart.getbillfoodcart?["data"];

        // ✅ Safely handle null or empty checks
        if (foodsData.isEmpty || billData == null || billData.isEmpty) {
          foodcart.clearCartItem(context: context);
          buttonController.totalItemCountNotifier.value = 0;
          buttonController.hideButton();
          coupon.removeCoupon();
          paymentMethodController.clearPaymentMethod();
          checkboxController.clearSelectedCheckboxText();
          foodcart.clearTipAmount();
          Get.off(() => const Foodscreen(), transition: Transition.leftToRight);
        } else {
          setState(() {
            foodsList = List.from(foodsData);
            quantities.clear();
            for (int i = 0; i < foodsList.length; i++) {
              quantities[i] = foodsList[i]["quantity"];
            }
            iscartloading = true;
          });
          await load(ttlkm: resGlobalKM);
          await _updateOrderDetails();
        }
      } catch (e, stack) {
        print("Error in forrefresh: $e");
      }
    });
  }

  getttcartDetails() {
    Timer(const Duration(seconds: 0), () async {
      final foodcartprovider =
          Provider.of<FoodCartProvider>(context, listen: false);
       //   final categortPro =   Provider.of<FoodProductviewPaginations>(context, listen: false);
      foodsList.clear();
      orderDetailsListPay.clear();
      cartIdList.clear();

      try {



        await foodcart.getfoodcartfood(km: foodcartprovider.totalDist);
        setState(() {
          foodsList = List.from(foodcart.getfoodcart["data"]["foods"]);

          for (int i = 0; i < foodsList.length; i++) {
            quantities[i] = foodsList[i]["quantity"];
          }
          _updateOrderDetails();
        });

        if (foodsList.isEmpty) {
          // Handle empty foodsList case
          return;
        }

        foodcart.getbillfoodcartfood(km: resGlobalKM);
  redirect.getredirectDetails();//2
        hasUnavailableItem = foodsList.any((food) =>
            food["foodDetails"]["available"] == false ||
            food["foodDetails"]["status"] == false);

        if (hasUnavailableItem) {
          Future.delayed(Duration.zero, () {
            CustomclearcartDialog.show(
              context: context,
              title: 'Food Not Available',
              content:
                  "Some items in your cart are not available at the moment. Remove them to proceed with your order.",
              onConfirm: () async {
                Navigator.pop(context);
              },
              buttonname: 'Continue',
            );
          });
        }
      } catch (error) {
        print("Error: $error");
      }
    });
  }

  checkkgetttcartDetails() {
    Timer(const Duration(seconds: 0), () async {
      final foodcartprovider =
          Provider.of<FoodCartProvider>(context, listen: false);

      try {
        await foodcart.getfoodcartfood(km: foodcartprovider.totalDist);
        setState(() {
          foodsList = List.from(foodcart.getfoodcart["data"]["foods"]);

          for (int i = 0; i < foodsList.length; i++) {
            quantities[i] = foodsList[i]["quantity"];
          }
          _updateOrderDetails();
        });

        if (foodsList.isEmpty) {
          // Handle empty foodsList case
          return;
        }

        foodcart.getbillfoodcartfood(km: resGlobalKM);
  redirect.getredirectDetails();//3
        hasUnavailableItem = foodsList.any((food) =>
            food["foodDetails"]["available"] == false ||
            food["foodDetails"]["status"] == false);
      } catch (error) {
        print("Error: $error");
      }
    });
  }

  void showCustomPaymentDialog(BuildContext context) {
    CustomcartLogoutDialog.show(
      context: context,
      title: 'Your Payment Method Changed! ',
      content:
          "Cash on Delivery isn't available for orders above ₹500. Continue your tasty order and enjoy! 😋",
      onConfirm: () async {
        Navigator.pop(context); // Close dialog
        setState(() {
          paymentsheet = true; // Open payment sheet
        });
        addcartPaymentBottomSheet(context); // Open payment options
      },
      buttonname: 'Ok',
    );
  }

  dynamic addressError;
  dynamic appconfigkm;
  dynamic codMaxAmount;
  @override
  void dispose() {
    integration.dispose();
    buttonController.dispose();
    super.dispose();
  }

  bool isCouponApplied = false;

  void applyCoupon() {
    setState(() {
      isCouponApplied = true;
    });
  }

  void removeCoupon() {
    setState(() {
      isCouponApplied = false;
    });
  }

  Future<void> checkIfItemInCart() async {
    try {
      if (!mounted) return; // Check if the widget is still mounted

      if (foodsList.isEmpty ||
          foodsList.every((item) => item['foodId'] == null)) {
        setState(() {
          Provider.of<ButtonController>(context, listen: false).hideButton();
          Provider.of<CouponController>(context, listen: false).removeCoupon();
        });
        // Update item count and button visibility

        await Provider.of<ButtonController>(context, listen: false)
            .updateTotalItemCount(foodcart, widget.totalDis);
      } else {
        setState(() {
          Provider.of<ButtonController>(context, listen: false).showButton();
        });
        await buttonController.updateTotalItemCount(foodcart, widget.totalDis);
      }
    } catch (e) {
      print("Error checking if item is in cart: $e");
    }
  }

  Future<void> _updateOrderDetails() async {
    // Update orderDetailsListPay with the current quantities
   
    orderDetailsListPay.clear();
    cartIdList.clear();
    for (int i = 0; i < foodsList.length; i++) {
      dynamic foodPrice;
      if (foodsList[i]["isCustomized"] == false) {
        foodPrice =
            foodsList[i]["foodDetails"]?["singleUnCustomizedPriceForFood"] ?? 0;
      } else if (foodsList[i]["selectedVariantId"] != null &&
          (foodsList[i]["selectedAddOns"] as List?)?.isNotEmpty == true) {
        foodPrice =
            (foodsList[i]["variantDetails"]?["variantAmountForSingle"] ?? 0) +
                (foodsList[i]["addOnsDetails"]?["addOnsAmountForSingle"] ?? 0);
      } else {
        foodPrice =
            foodsList[i]["variantDetails"]?["variantAmountForSingle"] ?? 0;
      }

      orderDetailsListPay.add({
        "productType": "restaurant",
        "description": "",
        "foodId": foodsList[i]["foodId"],
        "foodName": foodsList[i]["foodDetails"]["foodName"].toString(),
        "foodImage": foodsList[i]["foodDetails"]["foodImgUrl"].toString(),
        "foodType": foodsList[i]["foodDetails"]["foodType"].toString(),
        "quantity": quantities[i] ?? 0, // Use updated quantity
        "foodPrice": double.parse(foodPrice.toString()),
        "totalPrice": double.parse(
            foodsList[i]["foodDetails"]["food"]["totalPrice"].toString()),
        "selectedVariant": foodsList[i]["isCustomized"] == true
            ? foodsList[i]["variantDetails"]["customizedFood"]["addVariants"]
            : [],
        // "selectedAddOns":foodsList[i]["isCustomized"] == true&& foodsList[i]["addOnsDetails"]["addOnsDetails"] != null &&
        //    foodsList[i]["addOnsDetails"]["addOnsDetails"].isNotEmpty?foodsList[i]["addOnsDetails"]["addOnsDetails"]:[]
        "selectedAddOns": (foodsList[i]["isCustomized"] == true &&
                foodsList[i]["addOnsDetails"]?["addOnsDetails"] != null &&
                (foodsList[i]["addOnsDetails"]["addOnsDetails"] as List)
                    .isNotEmpty)
            ? foodsList[i]["addOnsDetails"]["addOnsDetails"]
            : [],
      });
 
      cartIdList.add(foodsList[i]["_id"].toString());
    }
  }

  Future<void> updateItemCountSmart(
    int index,
    int itemCount,
    BuildContext context, {
    bool forceDelete = false,
  }) async {
    final item = foodsList[index];
    final isCustomized = item["isCustomized"] == true;

    if (itemCount <= 0 || forceDelete) {
      print("Deleting item: $forceDelete");

      await foodcart
          .deleteCartItem(foodid: item["foodId"])
          .whenComplete(() async {
        setState(() async {
          quantities.remove(index);
          foodsList.removeAt(index);

          quantities = Map.fromIterables(
            List.generate(foodsList.length, (i) => i),
            foodsList.map((item) => item["quantity"]),
          );

          await _updateOrderDetails();
          await foodcart.getbillfoodcartfood(km: resGlobalKM);
          await   redirect.getredirectDetails();//4
          await checkkgetttcartDetails();

          if (foodsList == null || foodsList.isEmpty) {
            Get.off(() => const Foodscreen(),
                transition: Transition.leftToRight);
            foodcart.clearCartItem(context: context);
            Provider.of<ButtonController>(context, listen: false)
                .totalItemCountNotifier
                .value = 0;
            Provider.of<ButtonController>(context, listen: false).hideButton();
          }

          await buttonController.updateTotalItemCount(
              foodcart, widget.totalDis);
        });
      });
    } else {
      await foodcart
          .updateCartItem(
        foodid: item["foodId"],
        quantity: itemCount,
        isCustomized: isCustomized,
        selectedVariantId:
            item["isCustomized"] == true ? item["selectedVariantId"] : "",
        selectedAddOns: (item["isCustomized"] == true &&
                item["selectedAddOns"] != null &&
                (item["selectedAddOns"] as List).isNotEmpty)
            ? item["selectedAddOns"]
            : [],
      )
          .whenComplete(() {
        setState(() {
          quantities[index] = itemCount;
          foodsList[index]["quantity"] = itemCount;
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
      await foodcart.getbillfoodcartfood(km: ttlkm);
      await   redirect.getredirectDetails();//5
    }
  }


  dynamic calculatePrice(int index) {
    final food = foodsList[index];
    final quantity = (quantities[index] ?? 1);

    double price = 0;

    if (food["isCustomized"] == false) {
      price = (food["foodDetails"]?["singleUnCustomizedPriceForFood"] ?? 0)
              .toDouble() *
          quantity;
    } else if (food["selectedVariantId"] == null ||
        food["selectedVariantId"].isEmpty) {
      price =
          (food["addOnsDetails"]?["addOnsAmountForSingle"] ?? 0).toDouble() *
              quantity;
    } else if (food["selectedAddOns"] == null ||
        food["selectedAddOns"].isEmpty) {
      price =
          (food["variantDetails"]?["variantAmountForSingle"] ?? 0).toDouble() *
              quantity;
    } else {
      final double variantPrice =
          (food["variantDetails"]?["variantAmountForSingle"] ?? 0).toDouble();
      final double addOnPrice =
          (food["addOnsDetails"]?["addOnsAmountForSingle"] ?? 0).toDouble();
      price = (variantPrice + addOnPrice) * quantity;
    }

    return price.toStringAsFixed(2); // Always returns string like "99.00"
  }

  @override
  Widget build(BuildContext context) {

      var productviewprovider = Provider.of<FoodProductviewPaginations>(context).foodDetails;
 mergedList  =  orderDetailsListPay
      .map((item) => {...item, ...productviewprovider})
      .toList();

      print("orderDetailsListPay from array:$mergedList");
    
    // final categortPro =   Provider.of<FoodProductviewPaginations>(context, listen: false);
//  var productviewprovider = Provider.of<FoodProductviewPaginations>(context).foodDetails;
 //  int maxLength = orderDetailsListPay.length > productviewprovider.length ? orderDetailsListPay.length : productviewprovider.length;
// commission = productviewprovider.foodDetails["categoryList"]["foods"]["commission"];

  // for (int i = 0; i < maxLength; i++) {
  //   Map<String, dynamic> map = {};

  //   if (i < orderDetailsListPay.length) map.addAll(orderDetailsListPay[i]);
  //   if (i < productviewprovider.length) map.addAll(productviewprovider[i]);

  //   .add(map);
  // }

    var coupon = Provider.of<CouponController>(context);
    var mapaddres = Provider.of<MapDataProvider>(context);
    var updateCount = Provider.of<ButtonController>(context);
    final foodcartprovider = Provider.of<FoodCartProvider>(context);
    var instantdata = Provider.of<InstantUpdateProvider>(context);

    String getFormattedText() {
      if (coupon.coupontype == "percentage") {
        return "Save ${coupon.couponamount}% more with Miogra";
      } else if (coupon.coupontype == "subtraction") {
        return "Save ₹${coupon.couponamount} more with Miogra";
      } else {
        return "Get Your Coupon";
      }
    }

    String coupountext() {
      if (coupon.coupontype == "percentage") {
        // Remove the '%' sign and return the numeric value
        return "${coupon.couponamount}%";
      } else if (coupon.coupontype == "subtraction") {
        // Remove the '₹' sign and return the numeric value
        return "₹${coupon.couponamount}";
      } else {
        return "0.0"; // Return a default value if no valid coupon type
      }
    }

    double getAppConfigKmFromRedirect() {
      if (redirect.redirectLoadingDetails["data"] != null &&
          redirect.redirectLoadingDetails["data"] is List) {
        for (var item in redirect.redirectLoadingDetails["data"]) {
          if (item is Map && item['key'] == 'restaurantDistanceKm') {
            return double.tryParse(item['value'].toString()) ?? 0.0;
          }
        }
      }
      return 0.0;
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        Get.off(
          Foodviewscreen(
            // fulladdress: widget.fulladdress,
            isFromDishScreeen: widget.isFromtab,
            totalDis: widget.totalDis,
            restaurantId: widget.restaurantId,
          ),
        );
        await foodcart.getfoodcartfood(km: resGlobalKM);
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
              Get.off(Foodviewscreen(
                isFromDishScreeen: widget.isFromtab,
                totalDis: resGlobalKM,
                restaurantId: widget.restaurantId,
              ));

              await foodcart.getfoodcartfood(km: resGlobalKM);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Customcolors.DECORATION_BLACK,
            ),
          ),
          title: CartAppBarTitle(
             // title:
                 // widget.vendorId.toString().capitalizeFirst.toString(),
               title:
                   widget.restaurantname.toString().capitalizeFirst.toString(),

              subTitlel: "${widget.fulladdress.toString().capitalizeFirst}"),
        ),
        body: RefreshIndicator(
          color: Customcolors.darkpurple,
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 2), () {
              return forrefresh();
            });
          },
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: paddingAll(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      5.toHeight,
                      Container(
                        decoration:
                            BoxDecorationsFun.whiteCircelRadiusDecoration(),
                        padding: paddingAll(padding: 12.0),
                        child: InkWell(
                          onTap: () {
                            addcartAddressBottomSheet(context).then((value) {
                              Future.delayed(
                                const Duration(seconds: 0),
                                () {
                                  double totalDistance = double.parse(
                                      foodcartprovider.totalDis
                                          .split(' ')
                                          .first
                                          .toString());
                                  setState(() {
                                    foodcart.getbillfoodcartfood(
                                        km: totalDistance);
                                         // redirect.getredirectDetails();//6
                                  });
                                },
                              );
                            });
                          },
                          child: CartAddressBar(
                              addressType: mapaddres.addressType,
                              fullAddress: mapaddres.fullAddress.toString()),
                        ),
                      ),
                      const SizedBox(height: 10),
                      itemDetails(updateCount, coupon),
                      mapaddres.addressType != 'Current' &&
                              addresscontroller.getaddressdetails != null
                          ? 20.toHeight
                          : 10.toHeight,
                      mapaddres.addressType != 'Current' &&
                              addresscontroller.getaddressdetails != null
                          ? Container(
                              decoration: BoxDecorationsFun
                                  .whiteCircelRadiusDecoration(),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 23,
                                          height: 35,
                                          child: Image.asset(
                                              "assets/images/discount.png"),
                                        ),

                                        SizedBox(width: 11.w),
                                        Row(
                                          children: [
                                            Text(
                                              getFormattedText(),
                                              style:
                                                  CustomTextStyle.boldblack12,
                                            ),
                                          ],
                                        ),
                                        // SizedBox(width: 46.w),
                                        const Spacer(
                                          flex: 1,
                                        ),
                                        coupon.isCouponApplied
                                            ? InkWell(
                                                onTap: () {
                                                  coupon.removeCoupon();
                                                },
                                                child: const Text("Remove",
                                                    // style: CustomTextStyle
                                                    //     .DECORATION_regulartext
                                                    style: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins-Medium',
      color: Customcolors.darkpurple
      ),
                                                        ),
                                              )
                                            : InkWell(
                                                onTap: () {
                                                  Get.to(
                                                      Couponscreen(
                                                        restaurantid:
                                                            widget.restaurantId,
                                                        totalDis:
                                                            widget.totalDis,
                                                        isCouponApplied:
                                                            isCouponApplied,
                                                        apply: applyCoupon,
                                                        remove: removeCoupon,
                                                        vendorAdminId: foodcart
                                                                        .getbillfoodcart[
                                                                    "data"][
                                                                "restaurantDetails"]
                                                            [
                                                            "parentAdminUserId"],
                                                      ),
                                                      transition: Transition
                                                          .rightToLeft,
                                                      duration: const Duration(
                                                          milliseconds: 200),
                                                      curve: Curves.easeIn);
                                                },
                                                child: const Text("Apply",
                                                    style: CustomTextStyle
                                                        .DECORATION_regulartext)), //
                                      ],
                                    ),
                                    8.toHeight,
                                    DotLine(height: 0),
                                    8.toHeight,
                                    InkWell(
                                      onTap: () {
                                        Get.to(
                                            Couponscreen(
                                              vendorAdminId:
                                                  foodcart.getbillfoodcart[
                                                              "data"]
                                                          ["restaurantDetails"]
                                                      ["parentAdminUserId"],
                                              restaurantid: widget.restaurantId,
                                              totalDis: widget.totalDis,
                                              isCouponApplied: isCouponApplied,
                                              apply: applyCoupon,
                                              remove: removeCoupon,
                                            ),
                                            transition: Transition.rightToLeft,
                                            duration: const Duration(
                                                milliseconds: 200),
                                            curve: Curves.easeIn);
                                      },
                                      child: ViewMoreTextArrow(
                                          content: "View more coupon"),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                      mapaddres.addressType != 'Current' &&
                              addresscontroller.getaddressdetails != null
                          ? 15.toHeight
                          : 5.toHeight,
                      GetBuilder<Foodcartcontroller>(
                        builder: (foodcart) {
                          if (foodcart.getbillfoodcartloading.isTrue) {
                            return const Center(child: Billshimmer());
                          } else if (iscartloading) {
                            return const Center(child: Billshimmer());
                          } else if (foodcart.getbillfoodcart == null) {
                            return const Center(
                                child: CupertinoActivityIndicator());
                          } else if (foodcart.getbillfoodcart["data"].isEmpty) {
                            return const Center(
                                child: Text("No orders Available!"));
                          } else {
                            double tipAmount = foodcart
                                    .selectedTipAmount.value.isNotEmpty
                                ? double.parse(foodcart.selectedTipAmount.value)
                                : 0.0;
                            return BillSummaryWidget(
                             // amountForDistanceForDeliveryman:"₹${foodcart.getbillfoodcart["data"]["foods"]["amountForDistanceForDeliveryman"].toStringAsFixed(2)}",
                              basePrice:
                                  "₹${foodcart.getbillfoodcart["data"]["totalFoodAmount"].toStringAsFixed(2)}",
                              gst:
                                  "₹${foodcart.getbillfoodcart["data"]["totalGST"].toStringAsFixed(2)}",
                              packagingCharge:
                                  "₹${foodcart.getbillfoodcart["data"]["totalPackageCharges"].toStringAsFixed(2)}",
                              couponDiscount: coupountext() != '0.0'
                                  ? "-${coupountext()}"
                                  : coupountext(),
                              deliverytip: tipAmount,
                              platfomfee:
                                  "${foodcart.getbillfoodcart["data"]["platformFeeCharge"].toStringAsFixed(2)}",
                              delivaryCharge:
                                  "₹${foodcart.getbillfoodcart["data"]["deliveryCharges"].toStringAsFixed(2)}",
                              totalKm: foodcartprovider.totalDis,
                              redirectLoadingDetails:
                                  redirect.redirectLoadingDetails,
                              grandTotal: coupon.isCouponApplied
                                  ? "₹${coupon.coupontype == "percentage" ? (() {
                                      dynamic totcsamount;
                                      double percentage = double.parse(coupon
                                          .couponamount
                                          .replaceAll("%", ""));
                                      // Convert dynamic values to double
                                      double totalFoodAmount = double.parse(
                                          foodcart.getbillfoodcart["data"]
                                                  ["totalFoodAmount"]
                                              .toString());
                                      // Calculate the final amount using dynamic values
                                      double check =
                                          (percentage / 100) * totalFoodAmount;

                                      totcsamount =
                                          foodcart.getbillfoodcart["data"]
                                                  ["totalFoodAmount"] -
                                              check;

                                      return (totcsamount +
                                              foodcart.getbillfoodcart["data"]
                                                  ["totalPackageCharges"] +
                                              foodcart.getbillfoodcart["data"]
                                                  ["platformFeeCharge"] +
                                              foodcart.getbillfoodcart["data"]
                                                  ["deliveryCharges"] +
                                              foodcart.getbillfoodcart["data"]
                                                  ["totalGST"] +
                                              tipAmount)
                                          .roundToDouble()
                                          .toStringAsFixed(2);
                                    })() : (() {
                                      dynamic totcsamount;
                                      double couponAmount = double.parse(coupon
                                          .couponamount
                                          .replaceAll("₹", ""));

                                      // Convert dynamic value to double
                                      double totalAmount = double.parse(foodcart
                                          .getbillfoodcart["data"]
                                              ["totalFoodAmount"]
                                          .toString());
                                      // Calculate the amount after subtracting the coupon amount
                                      totcsamount = totalAmount - couponAmount;

                                      return (totcsamount +
                                              tipAmount +
                                              foodcart.getbillfoodcart["data"]
                                                  ["totalPackageCharges"] +
                                              foodcart.getbillfoodcart["data"]
                                                  ["platformFeeCharge"] +
                                              foodcart.getbillfoodcart["data"]
                                                  ["deliveryCharges"] +
                                              foodcart.getbillfoodcart["data"]
                                                  ["totalGST"])
                                          .roundToDouble()
                                          .toStringAsFixed(2);
                                    })()}"
                                  : "₹${(foodcart.getbillfoodcart["data"]["totalAmount"] + tipAmount).roundToDouble().toStringAsFixed(2)}",
                            );
                          }
                        },
                      ),

                      mapaddres.addressType != 'Current' &&
                              addresscontroller.getaddressdetails != null
                          ? 10.toHeight
                          : 5.toHeight,
                      mapaddres.addressType != 'Current' &&
                              addresscontroller.getaddressdetails != null
                          ? AddDeliveryInstructions(
                              onTapp: () => aadditionalinfoBottomSheet(context))
                          : const SizedBox.shrink(),
                      mapaddres.addressType != 'Current' &&
                              addresscontroller.getaddressdetails != null
                          ? 10.toHeight
                          : 5.toHeight,
                      mapaddres.addressType != 'Current' &&
                              addresscontroller.getaddressdetails != null
                          ? DriverTipSelector(
                              externalFormKey: _formKey,
                            )
                          : const SizedBox.shrink(),
                      mapaddres.addressType != 'Current' &&
                              addresscontroller.getaddressdetails != null
                          ? 10.toHeight
                          : 5.toHeight,
                      mapaddres.addressType != 'Current' &&
                              addresscontroller.getaddressdetails != null
                          ? InkWell(onTap: () {
                              addusercartaddressBottomSheet(context);
                            }, child: Consumer<InstantUpdateProvider>(
                              builder: (context, value, child) {
                                if (value.otherName != '' &&
                                    value.otherNumber != '') {
                                  return Container(
                                    decoration: BoxDecorationsFun
                                        .whiteCircelRadiusDecoration(),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width /
                                                        1.5,
                                                child: Text(
                                                  'You’re confirming this order ${value.otherName}',
                                                  style: CustomTextStyle
                                                      .blackbold14,
                                                ),
                                              ),
                                              3.toHeight,
                                              SizedBox(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width /
                                                        1.5,
                                                child: Text(
                                                  'We’ll keep you updated on your delivery  \n through the number ${value.otherNumber}',
                                                  style: CustomTextStyle
                                                      .carttblack,
                                                  maxLines: null,
                                                ),
                                              ),
                                            ],
                                          ),

                                          const Row(
                                            children: [
                                              Text(
                                                "Edit",
                                                style: TextStyle(
                                                  color:Customcolors.darkpurple,
                                                  fontFamily: 'Poppins-Regular',
                                                ),
                                              ),
                                              Icon(
                                                Icons.keyboard_arrow_right,
                                                color:Customcolors.darkpurple,
                                              ),
                                            ],
                                          ), //
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container(
                                    height: 40,
                                    decoration: BoxDecorationsFun
                                        .whiteCircelRadiusDecoration(),
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Ordering for someone else?',
                                            style: CustomTextStyle.carttblack,
                                          ),
                                          Text(
                                            "Add details",
                                            style: TextStyle(
                                              color: Customcolors.darkpurple,
                                              fontFamily: 'Poppins-Regular',
                                            ),
                                          ), //
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              },
                            ))
                          : const SizedBox.shrink(),
                      mapaddres.addressType != 'Current' &&
                              addresscontroller.getaddressdetails != null
                          ? const SizedBox(height: 10)
                          : const SizedBox(
                              height: 5,
                            ),
                      mapaddres.addressType != 'Current' &&
                              addresscontroller.getaddressdetails != null
                          ? Container(
                              decoration: BoxDecorationsFun
                                  .whiteCircelRadiusDecoration(),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween, // Add this line to distribute space evenly
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start, // Add this line to align text to the start
                                      children: [
                                        const Text('Pay using',
                                            style: CustomTextStyle
                                                .addressfeildtext),
                                        10.toHeight,
                                        Obx(() {
                                          String paymentMethodText;
                                          int selectedPaymentMethod =
                                              paymentMethodController
                                                  .selectedPaymentMethod.value;

                                          // Loading states
                                          if (foodcart
                                              .getbillfoodcartloading.isTrue) {
                                            return const Text(
                                              "Loading....",
                                              style:
                                                  CustomTextStyle.adresssubtext,
                                            );
                                          } else if (iscartloading) {
                                            return const Text(
                                              "Loading....",
                                              style:
                                                  CustomTextStyle.adresssubtext,
                                            );
                                          } else if (foodcart.getbillfoodcart ==
                                              null) {
                                            return const CircularProgressIndicator();
                                          }

                                          // Logic to check if Cash On Delivery is selected and totalFoodAmount > 500
                                          else if (selectedPaymentMethod == 0 &&
                                              foodcart.getbillfoodcart["data"]
                                                      ["totalFoodAmount"] >
                                                  500) {
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) {
                                              paymentsheet = true;
                                              paymentMethodController
                                                      .selectedPaymentMethod
                                                      .value =
                                                  1; // 1 represents Online Payment
                                              showCustomPaymentDialog(context);
                                            });
                                          }

                                          // Set payment method text based on the selected method
                                          paymentMethodText =
                                              selectedPaymentMethod == -1
                                                  ? "Select Your Payment Method"
                                                  : (selectedPaymentMethod == 0
                                                      ? "Cash on Delivery"
                                                      : (selectedPaymentMethod ==
                                                              1
                                                          ? "Online Payment"
                                                          : "Wallet Payment"));

                                          return Text(
                                            paymentMethodText,
                                            style: CustomTextStyle
                                                .adresssubtext, // Custom style for payment method text
                                          );
                                        }),

                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                   
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) async{
                                               // await     redirect.getredirectDetails();
                                                await    ordercreate.Vendercash(foodcart
                                                                          .getfoodcart["data"]
                                                                      ["restaurantDetails"][
                                                                  "parentAdminUserId"],);
                                          paymentsheet =
                                              true; // Set true when tapped
                                             addcartPaymentBottomSheet(context);   
                                        });
                                       
                                       
                                      },
                                      child: const Row(
                                        children: [
                                          Text(
                                            "Change",
                                            style: TextStyle(
                                              color:Customcolors.darkpurple,
                                              fontFamily: 'Poppins-Regular',
                                            ),
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_right,
                                            color: Customcolors.darkpurple
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),

                      14.toHeight,
                      const Text("HELP US MINIMIZE FOOD WASTE",
                          style: CustomTextStyle.chipgreybold),
                      5.toHeight,
                      const Text(
                        "Kindly review your order and address. You can only cancel within 1 minute no changes or refunds after.",
                        style: CustomTextStyle.cartminigrey,
                      ),
                      SizedBox(height: 14.h),
                      if (hasUnavailableItem)
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: CustomContainerDecoration
                                .gradientbuttondecoration(),
                            child: ElevatedButton(
                              onPressed: () {
                                CustomclearcartDialog.show(
                                  context: context,
                                  title: 'Food Not Available',
                                  content:
                                      "Some items in your cart are not available at the moment. Remove them to proceed with your order.",
                                  onConfirm: () async {
                                    Navigator.pop(context);
                                  },
                                  buttonname: 'Continue',
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                textStyle: const TextStyle(fontSize: 16),
                              ),
                              child: Obx(() {
                                if (foodcart.getbillfoodcartloading.isTrue) {
                                  return const Center(
                                      child: CupertinoActivityIndicator(
                                          color: Colors.white));
                                } else if (iscartloading) {
                                  return const Center(
                                      child: CupertinoActivityIndicator(
                                          color: Colors.white));
                                } else if (foodcart.getbillfoodcart == null) {
                                  return const CircularProgressIndicator();
                                } else if (foodcart
                                    .getbillfoodcart["data"].isEmpty) {
                                  return const Center(
                                      child: Text("No orders Available !"));
                                } else {
                                  double tipAmount = foodcart
                                          .selectedTipAmount.value.isNotEmpty
                                      ? double.parse(
                                          foodcart.selectedTipAmount.value)
                                      : 0.0;
                                  return Column(
                                    children: [
                                      Text(
                                        coupon.isCouponApplied
                                            ? "₹${coupon.coupontype == "percentage" ? (() {
                                                dynamic totcsamount;
                                                double percentage =
                                                    double.parse(coupon
                                                        .couponamount
                                                        .replaceAll("%", ""));
                                                // Convert dynamic values to double
                                                double totalFoodAmount =
                                                    double.parse(foodcart
                                                        .getbillfoodcart["data"]
                                                            ["totalFoodAmount"]
                                                        .toString());
                                                // Calculate the final amount using dynamic values
                                                double check =
                                                    (percentage / 100) *
                                                        totalFoodAmount;

                                                totcsamount =
                                                    foodcart.getbillfoodcart[
                                                                "data"][
                                                            "totalFoodAmount"] -
                                                        check;

                                                return (totcsamount +
                                                        foodcart.getbillfoodcart[
                                                                "data"][
                                                            "totalPackageCharges"] +
                                                        foodcart.getbillfoodcart[
                                                                "data"][
                                                            "platformFeeCharge"] +
                                                        foodcart.getbillfoodcart[
                                                                "data"][
                                                            "deliveryCharges"] +
                                                        foodcart.getbillfoodcart[
                                                                "data"]
                                                            ["totalGST"] +
                                                        tipAmount)
                                                    .roundToDouble()
                                                    .toStringAsFixed(2);
                                              })() : (() {
                                                dynamic totcsamount;
                                                double couponAmount =
                                                    double.parse(coupon
                                                        .couponamount
                                                        .replaceAll("₹", ""));

                                                // Convert dynamic value to double
                                                double totalAmount =
                                                    double.parse(foodcart
                                                        .getbillfoodcart["data"]
                                                            ["totalFoodAmount"]
                                                        .toString());
                                                // Calculate the amount after subtracting the coupon amount
                                                totcsamount =
                                                    totalAmount - couponAmount;

                                                return (totcsamount +
                                                        tipAmount +
                                                        foodcart.getbillfoodcart[
                                                                "data"][
                                                            "totalPackageCharges"] +
                                                        foodcart.getbillfoodcart[
                                                                "data"][
                                                            "platformFeeCharge"] +
                                                        foodcart.getbillfoodcart[
                                                                "data"][
                                                            "deliveryCharges"] +
                                                        foodcart.getbillfoodcart[
                                                            "data"]["totalGST"])
                                                    .roundToDouble()
                                                    .toStringAsFixed(2);
                                              })()} | Place orde"
                                            : "₹${(foodcart.getbillfoodcart["data"]["totalAmount"] + tipAmount).roundToDouble().toStringAsFixed(2)} | Place orde",
                                        style: CustomTextStyle.loginbuttontext,
                                      ),
                                    ],
                                  );
                                }
                              }),
                            ),
                          ),
                        )
                      else
                        Obx(() {
                          dynamic minimumAmount = 0;

                          if (redirect.redirectLoadingDetails["data"] != null) {
                            var data = redirect.redirectLoadingDetails["data"];
                            for (var item in data) {
                              if (item['key'] == 'orderMinimumAmount') {
                                var orderMinimumAmount = item['value'];
                                minimumAmount = double.tryParse(
                                        orderMinimumAmount.toString()) ??
                                    0;
                                break;
                              }
                            }
                          }

                          if (foodcart.getbillfoodcartloading.isTrue) {
                            return ReusableLoadingDummyButton(heighht: 50);
                          } else if (iscartloading) {
                            return ReusableLoadingDummyButton(heighht: 50);
                          } else if (foodcart.getbillfoodcart["data"]
                                  ["totalFoodAmount"] <
                              minimumAmount) {
                            return Column(
                              mainAxisSize: MainAxisSize
                                  .min, // Adjusts the column height to fit the content

                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors
                                        .red[100], // Optional: background color
                                    borderRadius: BorderRadius.circular(
                                        8), // Rounded corners
                                  ),
                                  child: Text(
                                    "Craving something delicious? Order now with a minimum food total of Rs.${minimumAmount}!",
                                    style: CustomTextStyle.rederrortext,
                                    textAlign: TextAlign
                                        .center, // Centers the text horizontally
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Center(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    width: MediaQuery.of(context).size.width *
                                        0.9, // Adjust width to screen size
                                    decoration: CustomContainerDecoration
                                        .lightgreybuttondecoration(),
                                    child: const Center(
                                      child: Text(
                                        "Place Order",
                                        style: CustomTextStyle
                                            .loginbuttontext, // Button text style
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else if (foodcart.getbillfoodcart["data"]
                                  ["totalQuantity"] >
                              20) {
                            return Column(
                              mainAxisSize: MainAxisSize
                                  .min, // Adjusts the column height to fit the content

                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors
                                        .red[100], // Optional: background color
                                    borderRadius: BorderRadius.circular(
                                        8), // Rounded corners
                                  ),
                                  child: const Text(
                                    "Order limit exceeded! Please reduce the food quantity below 20 to continue.",
                                    style: CustomTextStyle.rederrortext,
                                    textAlign: TextAlign
                                        .center, // Centers the text horizontally
                                  ),
                                ),
                                8.toHeight,
                                Center(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    width: MediaQuery.of(context).size.width *
                                        0.9, // Adjust width to screen size
                                    decoration: CustomContainerDecoration
                                        .lightgreybuttondecoration(),
                                    child: const Center(
                                      child: Text(
                                        "Place Order ",
                                        style: CustomTextStyle
                                            .loginbuttontext, // Button text style
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else if (foodcart.getbillfoodcart == null) {
                            return const CircularProgressIndicator();
                          } else if (foodcart.getbillfoodcart["data"].isEmpty) {
                            return const Center(
                                child: Text("No orders Available !"));
                          } else {
                            dynamic totsamount;

                            if (coupon.isCouponApplied) {
                              if (coupon.coupontype == "percentage") {
                                // Convert the percentage string to a double
                                double percentage = double.parse(
                                    coupon.couponamount.replaceAll("%", ""));
                                dynamic totalFoodAmount = foodcart
                                        .getbillfoodcart["data"][
                                    "totalFoodAmount"]; // Assume dynamic but numeric
                                dynamic totalAmount = foodcart
                                    .getbillfoodcart["data"]["totalAmount"];

                                totsamount = double.parse((totalAmount -
                                        ((percentage / 100) * totalFoodAmount))
                                    .toStringAsFixed(2));
                              } else {
                                // Convert the coupon amount string to a double
                                double couponAmount = double.parse(
                                    coupon.couponamount.replaceAll("₹", ""));
                                dynamic totalAmount = foodcart
                                    .getbillfoodcart["data"]["totalAmount"];
                                totsamount = double.parse(
                                    (totalAmount - couponAmount)
                                        .toStringAsFixed(2));
                              }
                            } else {
                              totsamount =
                                  0; // Default to 0 when no coupon is applied
                            }
                            double tipAmount = foodcart
                                    .selectedTipAmount.value.isNotEmpty
                                ? double.parse(foodcart.selectedTipAmount.value)
                                : 0.0;
                            return isButtonLoading
                                ? Center(
                                    child: CustomdisabledButton(
                                      onPressed: () {},
                                      borderRadius: BorderRadius.circular(30),
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: const Text('Order Processing..',
                                          style:
                                              CustomTextStyle.loginbuttontext),
                                    ),
                                  )
                                : Center(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9, // Adjust the width based on screen size
                                      decoration: CustomContainerDecoration
                                          .gradientbuttondecoration(),

                                      child: ElevatedButton(
                                          onPressed: paymentMethodController
                                                      .selectedPaymentMethod
                                                      .value ==
                                                  -1
                                              ? () {
                                                  CustomcartLogoutDialog.show(
                                                    context: context,
                                                    title: 'Uh oh!',
                                                    content:
                                                        "Almost there! Choose your payment method to proceed! 🍜",
                                                    onConfirm: () async {
                                                      Navigator.pop(context);
                                                      setState(() {
                                                        paymentsheet = true;
                                                      });

                                                      await   ordercreate.Vendercash( foodcart
                                                                          .getfoodcart["data"]
                                                                      ["restaurantDetails"][
                                                                  "parentAdminUserId"],);
                                                      addcartPaymentBottomSheet(
                                                          context);
                                                    },
                                                    buttonname: 'Ok',
                                                  );
                                                }
                                              : () async {
                                                  if (_formKey.currentState ==
                                                          null ||
                                                      !_formKey.currentState!
                                                          .validate()) {
                                                    Get.snackbar(
                                                      "Invalid Tip",
                                                      "The delivery tip entered is not valid. Please try again.",
                                                      backgroundColor: Customcolors
                                                          .DECORATION_ERROR_RED,
                                                      titleText: const Text(
                                                        "Invalid Tip",
                                                        style: CustomTextStyle
                                                            .white12text,
                                                      ),
                                                      messageText: const Text(
                                                        "The delivery tip entered is not valid. Please try again.",
                                                        style: CustomTextStyle
                                                            .white12text,
                                                      ),
                                                    );
                                                    return;
                                                  }

                                                  setState(() {
                                                    isButtonLoading = true;
                                                  });

                                                  dynamic
                                                      selectedPaymentMethod =
                                                      paymentMethodController
                                                          .selectedPaymentMethod
                                                          .value;
                                                  dynamic paymentMethodText;

                                                  // Determine text based on selected payment method
                                                  if (selectedPaymentMethod ==
                                                          0 &&
                                                      foodcart.getbillfoodcart[
                                                                  "data"][
                                                              "totalFoodAmount"] <=
                                                          500) {
                                                    paymentMethodText =
                                                        'OFFLINE'; // Cash On Delivery
                                                  }
                                                  // else if (selectedPaymentMethod == 2) {
                                                  // paymentMethodText = 'WALLET'; // Wallet Payment
                                                  // }
                                                  else {
                                                    paymentMethodText =
                                                        'ONLINE'; // Online Payment
                                                  }

                                                  // String fullAddresss = "${addressType == 'Other' ? '${addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["instructions"].toString()}, ' : ''}${addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["landMark"].toString()} , ${addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["houseNo"].toString()} , ${addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["fullAddress"].toString()}.",

                                                  List<Map<String, dynamic>>
                                                      dropAddress = [
                                                    {
                                                      'name': username,
                                                      "userType": "consumer",
                                                      "houseNo": mapaddres
                                                              .localAddressData[
                                                          'houseNo'],
                                                      "locality": mapaddres
                                                              .localAddressData[
                                                          'locality'],
                                                      "landMark": mapaddres
                                                              .localAddressData[
                                                          'landMark'],
                                                      "fullAddress": mapaddres
                                                              .localAddressData[
                                                          'fullAddress'],
                                                      "street": mapaddres
                                                              .localAddressData[
                                                          'street'],
                                                      "city": mapaddres
                                                              .localAddressData[
                                                          'city'],
                                                      "district": mapaddres
                                                              .localAddressData[
                                                          'district'],
                                                      "state": mapaddres
                                                              .localAddressData[
                                                          'state'],
                                                      "country": mapaddres
                                                              .localAddressData[
                                                          'country'],
                                                      "postalCode": mapaddres
                                                              .localAddressData[
                                                          'postalCode'],
                                                      "contactType": "myself",
                                                      "paymentMethod":
                                                          paymentMethodText,
                                                      "contactPerson":
                                                          instantdata.otherName !=
                                                                  ''
                                                              ? instantdata
                                                                  .otherName
                                                              : username,
                                                      "contactPersonNumber": instantdata
                                                                  .otherNumber !=
                                                              ''
                                                          ? instantdata
                                                              .otherNumber
                                                          : mapaddres
                                                                  .localAddressData[
                                                              'contactPersonNumber'],
                                                      "addressType": mapaddres
                                                              .localAddressData[
                                                          'addressType'],
                                                      "latitude": mapaddres
                                                              .localAddressData[
                                                          'latitude'],
                                                      "longitude": mapaddres
                                                              .localAddressData[
                                                          'longitude'],
                                                      "instructions": mapaddres
                                                              .localAddressData[
                                                          "instructions"],
                                                      "delivered": false,
                                                    }
                                                  ];

                                                  if (dropAddress.isNotEmpty &&
                                                      dropAddress[0][
                                                              'latitude'] !=
                                                          null &&
                                                      dropAddress[0][
                                                              'latitude'] !=
                                                          0 &&
                                                      dropAddress[0][
                                                              'longitude'] !=
                                                          null &&
                                                      dropAddress[0]
                                                              ['longitude'] !=
                                                          0 &&
                                                      dropAddress[0][
                                                              'contactPerson'] !=
                                                          null &&
                                                      dropAddress[0][
                                                              'contactPersonNumber'] !=
                                                          null &&
                                                      dropAddress[0]
                                                              ['fullAddress'] !=
                                                          null) {
                                                    LatLng tttt = LatLng(
                                                        dropAddress[0]
                                                            ['latitude'],
                                                        dropAddress[0]
                                                            ['longitude']);

                                                    print(
                                                        'Drop Location ..... $tttt');

                                                    log.i(dropAddress[0]);
                                                    if (coupon
                                                        .isCouponApplied) {
                                                      if (coupon.coupontype ==
                                                          "percentage") {
                                                        // Convert the percentage string to a double
                                                        double percentage =
                                                            double.parse(coupon
                                                                .couponamount
                                                                .replaceAll(
                                                                    "%", ""));
                                                        dynamic
                                                            totalFoodAmount =
                                                            foodcart.getbillfoodcart[
                                                                    "data"][
                                                                "totalFoodAmount"]; // Assume dynamic but numeric
                                                        dynamic totalAmount =
                                                            foodcart.getbillfoodcart[
                                                                    "data"]
                                                                ["totalAmount"];
                                                        totsamount = double
                                                            .parse((totalAmount -
                                                                    ((percentage /
                                                                            100) *
                                                                        totalFoodAmount))
                                                                .toStringAsFixed(
                                                                    2));
                                                      } else {
                                                        // Convert the coupon amount string to a double
                                                        double couponAmount =
                                                            double.parse(coupon
                                                                .couponamount
                                                                .replaceAll(
                                                                    "₹", ""));
                                                        dynamic totalAmount =
                                                            foodcart.getbillfoodcart[
                                                                    "data"]
                                                                ["totalAmount"];
                                                        totsamount = double
                                                            .parse((totalAmount -
                                                                    couponAmount)
                                                                .toStringAsFixed(
                                                                    2));
                                                      }
                                                    } else {
                                                      totsamount =
                                                          0; // Default to 0 when no coupon is applied
                                                    }

                                                    dynamic totcsamount;
                                                    if (coupon
                                                        .isCouponApplied) {
                                                      if (coupon.coupontype ==
                                                          "percentage") {
                                                        // Convert the percentage string to a double
                                                        double percentage =
                                                            double.parse(coupon
                                                                .couponamount
                                                                .replaceAll(
                                                                    "%", ""));

                                                        // Convert dynamic values to double
                                                        double totalFoodAmount =
                                                            double.parse(foodcart
                                                                .getbillfoodcart[
                                                                    "data"][
                                                                    "totalFoodAmount"]
                                                                .toString());

                                                        // Calculate the final amount using dynamic values
                                                        double check =
                                                            (percentage / 100) *
                                                                totalFoodAmount;
                                                        totcsamount =
                                                            foodcart.getbillfoodcart[
                                                                        "data"][
                                                                    "totalFoodAmount"] -
                                                                check;
                                                      } else {
                                                        // Convert the coupon amount string to a double
                                                        double couponAmount =
                                                            double.parse(coupon
                                                                .couponamount
                                                                .replaceAll(
                                                                    "₹", ""));

                                                        // Convert dynamic value to double
                                                        double totalAmount =
                                                            double.parse(foodcart
                                                                .getbillfoodcart[
                                                                    "data"][
                                                                    "totalFoodAmount"]
                                                                .toString());

                                                        // Calculate the amount after subtracting the coupon amount
                                                        totcsamount =
                                                            totalAmount -
                                                                couponAmount;
                                                      }
                                                    } else {
                                                      totcsamount =
                                                          0; // Default value
                                                    }

                                                    dynamic cou = coupon
                                                            .isCouponApplied
                                                        ? int.parse(
                                                            coupon.couponamount)
                                                        : 0;

                                                    if (coupon
                                                        .isCouponApplied) {
                                                      ordercreate
                                                          .createOrderList(
                                                         //   commision: 20,
                                                          //  commision: productviewprovider.restaurantDetails["categoryList"]["foods"]["commission"],
                                                              cartIdList:
                                                                  cartIdList,
                                                              context: context,
                                                              isCouponApplied:
                                                                  true,
                                                              integration:
                                                                  integration,
                                                              ordersDetails:
                                                       mergedList,
                                                              productCategoryid:
                                                                  productCateId,
                                                              userid: UserId,
                                                              subAdminid: widget
                                                                  .restaurantId,
                                                              vendorAdminId:
                                                                  foodcart.getfoodcart["data"]
                                                                          ["restaurantDetails"][
                                                                      "parentAdminUserId"],
                                                              dropAddress:
                                                                  dropAddress,
                                                              cartAmount: foodcart
                                                                      .getbillfoodcart["data"][
                                                                  "totalAmount"],
                                                              couponid: coupon
                                                                  .couponId,
                                                              cartFoodamount:
                                                                  totcsamount,
                                                              cartFoodAmountWithoutCoupon:
                                                                  foodcart.getbillfoodcart["data"][
                                                                      "totalFoodAmount"],
                                                              orderBasicamount:
                                                                  foodcart.getbillfoodcart["data"]
                                                                      [
                                                                      "totalFoodAmount"],
                                                              // finalamount: totsamount,
                                                              finalamount: totcsamount +
                                                                  foodcart.getbillfoodcart["data"]
                                                                      ["totalPackageCharges"] +
                                                                  foodcart.getbillfoodcart["data"]["deliveryCharges"] +
                                                                  tipAmount +
                                                                  foodcart.getbillfoodcart["data"]["totalGST"] +
                                                                  foodcart.getbillfoodcart["data"]["platformFeeCharge"],
                                                              deliveryCharges: foodcart.getbillfoodcart["data"]["deliveryCharges"],
                                                              tax: foodcart.getbillfoodcart["data"]["totalGST"],
                                                              tips: tipAmount,
                                                              couponsamount: cou,
                                                              discountAmount: cou,
                                                              paymentMethod: paymentMethodText,
                                                              totalKms: resGlobalKM,
                                                              baseKm: resGlobalKM,
                                                              additionalInstructions: instantdata.delInstruction,
                                                              packagingcharge: foodcart.getbillfoodcart["data"]["totalPackageCharges"],
                                                              platformFee: foodcart.getbillfoodcart["data"]["platformFeeCharge"],
                                                              amountForDistanceForDeliveryman: foodcart.getbillfoodcart["data"]["foods"][0]["amountForDistanceForDeliveryman"])

                                                          .then((value) {
                                                        Future.delayed(
                                                          const Duration(
                                                              seconds: 3),
                                                          () {
                                                            setState(() {
                                                              isButtonLoading =
                                                                  false;
                                                            });
                                                          },
                                                        );
                                                      });
                                                    } else {
                                                      print(
                                                          "orderDetailsListPay:${mergedList}");
                                                      print(cartIdList);
                                                      ordercreate
                                                          .createOrderList(
                                                       //     commision: 20,
                                                          //  commision: productviewprovider.restaurantDetails["categoryList"]["foods"]["commission"],
                                                              cartIdList:
                                                                  cartIdList,
                                                              context: context,
                                                              isCouponApplied:
                                                                  false,
                                                              integration:
                                                                  integration,
                                                              ordersDetails:
                                                        mergedList,
                                                              productCategoryid:
                                                                  productCateId,
                                                              userid: UserId,
                                                              subAdminid: widget
                                                                  .restaurantId,
                                                              vendorAdminId: foodcart
                                                                          .getfoodcart["data"]
                                                                      ["restaurantDetails"][
                                                                  "parentAdminUserId"],
                                                              dropAddress:
                                                                  dropAddress,
                                                              cartAmount: foodcart
                                                                      .getbillfoodcart["data"][
                                                                  "totalAmount"],
                                                              cartFoodamount:
                                                                  foodcart.getbillfoodcart["data"][
                                                                      "totalFoodAmount"],
                                                              cartFoodAmountWithoutCoupon:
                                                                  foodcart.getbillfoodcart["data"][
                                                                      "totalFoodAmount"],
                                                              orderBasicamount:
                                                                  foodcart.getbillfoodcart["data"]
                                                                      ["totalFoodAmount"],
                                                              finalamount: foodcart.getbillfoodcart["data"]["totalAmount"] + tipAmount,
                                                              deliveryCharges: foodcart.getbillfoodcart["data"]["deliveryCharges"],
                                                              tax: foodcart.getbillfoodcart["data"]["totalGST"],
                                                              tips: tipAmount,
                                                              couponsamount: 0,
                                                              discountAmount: 0,
                                                              platformFee: foodcart.getbillfoodcart["data"]["platformFeeCharge"],
                                                              paymentMethod: paymentMethodText,
                                                              totalKms: resGlobalKM,
                                                              baseKm: resGlobalKM,
                                                              additionalInstructions: instantdata.delInstruction,
                                                              packagingcharge: foodcart.getbillfoodcart["data"]["totalPackageCharges"],
                                                                amountForDistanceForDeliveryman: foodcart.getbillfoodcart["data"]["foods"][0]["amountForDistanceForDeliveryman"])
                                                          .then((value) {
                                                        Future.delayed(
                                                          const Duration(
                                                              seconds: 3),
                                                          () {
                                                            setState(() {
                                                              isButtonLoading =
                                                                  false;
                                                            });
                                                          },
                                                        );
                                                      });
                                                    }
                                                  } else {
                                                    // Show toast message
                                                    AppUtils.showToast(
                                                        'Invalid address information');

                                                    addcartAddressBottomSheet(
                                                            context)
                                                        .then((value) {
                                                      Future.delayed(
                                                        const Duration(
                                                            seconds: 0),
                                                        () {
                                                          double totalDistance =
                                                              double.parse(
                                                                  foodcartprovider
                                                                      .totalDis
                                                                      .split(
                                                                          ' ')
                                                                      .first
                                                                      .toString());
                                                          setState(() {
                                                            foodcart.getbillfoodcartfood(
                                                                km: totalDistance);
                                                                //  redirect.getredirectDetails();//7
                                                          });
                                                        },
                                                      );
                                                    });
                                                  }
                                                },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.transparent,
                                            shadowColor: Colors.transparent,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            textStyle:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          child: Column(
                                            children: [
                                              getFinalAmount(coupon, tipAmount),
                                            ],
                                          )),
                                    ),
                                  );
                          }
                        }),
                      const SizedBox(height: 7)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomSheet: () {
          // 1. Get Configured KM Limit
          double configKm = getAppConfigKmFromRedirect();

          // 2. Clean and parse total distance from provider
          String cleaned =
              foodcartprovider.totalDis.replaceAll(RegExp(r'[^0-9.]'), '');
          double totalDistance = double.tryParse(cleaned) ?? 0.0;

          // 3. Check if the distance is out of range
          bool isOutOfRange = totalDistance > configKm;

          // 4. Debug Logs
          print("configKm = $configKm");
          print("cleanedDistance = $cleaned");
          print("isOutOfRange = $isOutOfRange");
          print("mapaddres.addressType = ${mapaddres.addressType}");
          print(
              "getaddressdetails != null = ${addresscontroller.getaddressdetails != null}");

          // 5. Show warning if user is out of range
          if (isOutOfRange) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              height: MediaQuery.of(context).size.height / 3.7,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(15),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.dangerous,
                            color: Customcolors.DECORATION_ERROR_RED),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Oops! You're out of our delivery loop",
                                style: CustomTextStyle.boldredtext,
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Try selecting a different location within our reach.",
                                style: CustomTextStyle.chipgreybold,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: CustomButton(
                        borderRadius: BorderRadius.circular(30),
                        onPressed: () {
                          Get.off(const Foodscreen());
                        },
                        child: const Text(
                          "Explore More Restaurants",
                          style: CustomTextStyle.addressfeildbutton,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          // 6. If address type is not "Current" and address data is present, don't show anything
          if (mapaddres.addressType != 'Current' &&
              addresscontroller.getaddressdetails != null) {
            return const SizedBox.shrink();
          }

          // 7. Otherwise, show prompt to select or add address
          return AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            height: MediaQuery.sizeOf(context).height / 3.7,
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
                const SizedBox(height: 30),
                CustomButton(
                  onPressed: () {
                    addcartAddressBottomSheet(context).then((value) {
                      Future.delayed(Duration.zero, () {
                        double totalDistance = double.tryParse(
                              foodcartprovider.totalDis.split(' ').first,
                            ) ??
                            0.0;
                        setState(() {
                          foodcart.getbillfoodcartfood(km: totalDistance);
                          //  redirect.getredirectDetails();//8
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
          );
        }(),

      ),
    );
  }

  Text getFinalAmount(CouponController coupon, double tipAmount) {
    return Text(
      coupon.isCouponApplied
          ? "₹${coupon.coupontype == "percentage" ? (() {
              dynamic totcsamount;
              double percentage =
                  double.parse(coupon.couponamount.replaceAll("%", ""));
              // Convert dynamic values to double
              double totalFoodAmount = double.parse(foodcart
                  .getbillfoodcart["data"]["totalFoodAmount"]
                  .toString());
              // Calculate the final amount using dynamic values
              double check = (percentage / 100) * totalFoodAmount;

              totcsamount =
                  foodcart.getbillfoodcart["data"]["totalFoodAmount"] - check;

              return (totcsamount +
                      foodcart.getbillfoodcart["data"]["totalPackageCharges"] +
                      foodcart.getbillfoodcart["data"]["platformFeeCharge"] +
                      foodcart.getbillfoodcart["data"]["deliveryCharges"] +
                      foodcart.getbillfoodcart["data"]["totalGST"] +
                      tipAmount)
                  .roundToDouble()
                  .toStringAsFixed(2);
            })() : (() {
              dynamic totcsamount;
              double couponAmount =
                  double.parse(coupon.couponamount.replaceAll("₹", ""));

              // Convert dynamic value to double
              double totalAmount = double.parse(foodcart.getbillfoodcart["data"]
                      ["totalFoodAmount"]
                  .toString());
              // Calculate the amount after subtracting the coupon amount
              totcsamount = totalAmount - couponAmount;

              return (totcsamount +
                      tipAmount +
                      foodcart.getbillfoodcart["data"]["totalPackageCharges"] +
                      foodcart.getbillfoodcart["data"]["platformFeeCharge"] +
                      foodcart.getbillfoodcart["data"]["deliveryCharges"] +
                      foodcart.getbillfoodcart["data"]["totalGST"])
                  .roundToDouble()
                  .toStringAsFixed(2);
            })()} | Place order"
          : "₹${(foodcart.getbillfoodcart["data"]["totalAmount"] + tipAmount).roundToDouble().toStringAsFixed(2)} | Place order",
      style: CustomTextStyle.loginbuttontext,
    );
  }

  Obx itemDetails(ButtonController updateCount, CouponController coupon) {
    return Obx(() {
      if (foodcart.getfoodcartloading.isTrue) {
        return const Center(child: Foodcartshimmer());
      } else if (foodcart.getfoodcart == null ||
          foodcart.getfoodcart["data"] == null) {
        return const Center(child: Foodcartshimmer());
      } else if (foodsList.isEmpty) {
        return const SizedBox();
      } else {
        return Container(
          decoration: BoxDecorationsFun.whiteCircelRadiusDecoration(),
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  print(widget.restaurantId);
                },
                child: const Text("Item Details",
                    style: CustomTextStyle.boldblack12),
              ),
              5.toHeight,
              ListView.separated(
                shrinkWrap: true,
                itemCount: foodsList.length,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => 5.toHeight,
                itemBuilder: (BuildContext context, index) {
                  int currentQuantity = quantities[index] ?? 0;
                  var foodName =
                      foodsList[index]["foodDetails"]["foodName"].toString();
                  bool isCustomized = foodsList[index]["isCustomized"] == true;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: foodsList[index]["foodDetails"]["available"] ==
                                true &&
                            foodsList[index]["foodDetails"]["status"] == true
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      5.toHeight,
                                      Builder(
                                        builder: (context) {
                                          String foodType = foodsList[index]
                                                  ["foodDetails"]["foodType"] ??
                                              '';
                                          String assetPath = getFoodTypeIcon(
                                              foodType: foodType);

                                          return assetPath.isNotEmpty
                                              ? Image.asset(assetPath,
                                                  height: 15, width: 15)
                                              : const SizedBox.shrink();
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 5),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // SizedBox(
                                      //   width: 200,
                                      //   child: Text(
                                      //     foodName.capitalizeFirst.toString(),
                                      //     style: CustomTextStyle.carttblack,
                                      //     overflow: TextOverflow.clip,
                                      //   ),
                                      // ),
                                      SizedBox(
                                        width: 200,
                                        child: Text(
                                          foodName.capitalizeFirst.toString(),
                                          style: CustomTextStyle.carttblack,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                      isCustomized
                                          ? Row(
                                              children: [
                                                Cartcustomisation(
                                                  foodid: foodsList[index]
                                                      ["foodId"],
                                                  iscustomizable: true,
                                                  foodtype: foodsList[index]
                                                          ["foodDetails"]
                                                      ["foodType"],
                                                  resname:
                                                      widget.restaurantname,
                                                  resid: widget.restaurantId,
                                                  onUpdated: () async {
                                                    await refreshAfterCustomization();
                                                  },
                                                ),
                                                Text(
                                                  "₹${calculatePrice(index)}",
                                                  style: CustomTextStyle
                                                      .foodDescription,
                                                ),
                                              ],
                                            )
                                          : Text(
                                              "₹${calculatePrice(index)}",
                                              style: CustomTextStyle
                                                  .foodDescription,
                                            ),
                                    ],
                                  ),
                                ],
                              ),
                              CustomContainer(
                                // height: 20.h,
                                // width: 70.w,
                                height: 25.h,
                                width: 90.w,
                                decoration: CustomContainerDecoration
                                    .gradientborderdecoration(
                                  radious: 7.0,
                                  borderwidth: 0.6,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        if (currentQuantity > 1) {
                                          setState(() {
                                            quantities[index] =
                                                currentQuantity - 1;
                                            iscartloading = true;
                                          });

                                          updateCount.decrementItemCount(1);
                                          await updateItemCountSmart(index,
                                              currentQuantity - 1, context);
                                          load(ttlkm: resGlobalKM);
                                          _updateOrderDetails();
                                        } else if (currentQuantity == 1) {
                                          await updateItemCountSmart(
                                                  index, 0, context)
                                              .whenComplete(() {
                                            if (foodsList.isEmpty) {
                                              paymentMethodController
                                                  .clearPaymentMethod();
                                              checkboxController
                                                  .clearSelectedCheckboxText();
                                              foodcart.clearTipAmount();
                                              Get.off(() => const Foodscreen(),
                                                  transition:
                                                      Transition.leftToRight);
                                              foodcart.clearCartItem(
                                                  context: context);
                                              foodcart.getfoodcartfood(
                                                  km: resGlobalKM);
                                              Provider.of<ButtonController>(
                                                      context,
                                                      listen: false)
                                                  .totalItemCountNotifier
                                                  .value = 0;
                                              Provider.of<ButtonController>(
                                                      context,
                                                      listen: false)
                                                  .hideButton();
                                              coupon.removeCoupon();
                                            }
                                          });
                                        }

                                        if (coupon.isCouponApplied) {
                                          await foodcart.getbillfoodcartfood(
                                              km: resGlobalKM);
                                         // await     redirect.getredirectDetails();//9
                                          if (foodcart.getbillfoodcart["data"]
                                                  ["totalFoodAmount"] <=
                                              coupon.aboveVal) {
                                            coupon.removeCoupon();
                                          } else {
                                            await foodcart.getbillfoodcartfood(
                                                km: resGlobalKM);

                                               // await  redirect.getredirectDetails(); //10
                                          }
                                        }
                                      },
                                      child: const Icon(Icons.remove,
                                          color: Customcolors.darkpurple,
                                          size: 15,
                                          weight: 20),
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
                                          quantities[index] =
                                              currentQuantity + 1;
                                          iscartloading = true;
                                        });
                                        updateCount.incrementItemCount(1);
                                        await updateItemCountSmart(index,
                                            currentQuantity + 1, context);
                                        _updateOrderDetails();
                                        load(ttlkm: resGlobalKM);
                                      },
                                      child: const Icon(Icons.add,
                                          color: Customcolors.darkpurple,
                                          size: 15,
                                          weight: 20),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Opacity(
                              opacity: 0.6,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Builder(
                                        builder: (context) {
                                          String foodType = foodsList[index]
                                                          ["foodDetails"]
                                                      ["foodType"]
                                                  ?.toString() ??
                                              '';
                                          String assetPath = getFoodTypeIcon(
                                              foodType: foodType);
                                          return assetPath.isNotEmpty
                                              ? Image.asset(assetPath,
                                                  height: 15, width: 15)
                                              : const SizedBox.shrink();
                                        },
                                      ),
                                      const SizedBox(width: 5),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 150,
                                            child: Text(
                                              foodName.capitalizeFirst
                                                  .toString(),
                                              style: CustomTextStyle.carttblack,
                                              overflow: TextOverflow.clip,
                                            ),
                                          ),
                                          Text(
                                            "₹${calculatePrice(index)}",
                                            style:
                                                CustomTextStyle.foodDescription,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  UnavailableFoodItem(
                                    onTap: () async {
                                      await updateItemCountSmart(
                                          index, 0, forceDelete: true, context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                  );
                },
              ),
              10.toHeight,
              DotLine(height: 8),
              foodcart.getfoodcart["data"]["restaurantDetails"]
                              ["activeStatus"] ==
                          "online" &&
                      foodcart.getfoodcart["data"]["restaurantDetails"]
                              ["status"] ==
                          true
                  ? InkWell(
                      onTap: () {
                        Get.off(Foodviewscreen(
                          isFromDishScreeen: widget.isFromtab,
                          totalDis: resGlobalKM,
                          restaurantId: widget.restaurantId,
                        ));
                      },
                      child: ViewMoreTextArrow(content: "Add more item"),
                    )
                  : const Center(
                      child: Text(
                        "Restaurant Unavilable",
                        style: CustomTextStyle.redmarktext,
                        textAlign: TextAlign.center,
                      ),
                    ),
            ],
          ),
        );
      }
    });
  }

  Future<void> refreshAfterCustomization() async {
    setState(() {
      foodsList = List.from(foodcart.getfoodcart["data"]["foods"]);
      for (int i = 0; i < foodsList.length; i++) {
        quantities[i] = foodsList[i]["quantity"];
      }
      iscartloading = true;
    });
    await load(ttlkm: resGlobalKM);
    await _updateOrderDetails();
  }

  double _containerHeight = 200; // Initial height

  void expandContainer() {
    setState(() {
      _containerHeight = _containerHeight == 200
          ? MediaQuery.of(context).size.height * 0.6
          : 200;
    });
  }

  Future<dynamic> addcartPaymentBottomSheet(BuildContext context) {
    if (redirect.redirectLoadingDetails["data"] != null) {
      var data = redirect.redirectLoadingDetails["data"];
      for (var item in data) {
        if (item['key'] == 'codMaxAmount') {
          codMaxAmount = item['value'];
          break;
        }
      }
    }
    return showModalBottomSheet(
      backgroundColor: Customcolors.DECORATION_WHITE,
      showDragHandle: true,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        Get.put(RedirectController(). getredirectDetails );
        return 
        Addpaymentcartaddress(
          ispaymentsheet: true,
          maxAmount: codMaxAmount,
          
        );
      },
    ).then((value) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        paymentsheet = false;
      }); // Reset after closing the sheet
    });
  }

  Future<dynamic> addcartAddressBottomSheet(BuildContext context) {
    if (redirect.redirectLoadingDetails["data"] != null) {
      var data = redirect.redirectLoadingDetails["data"];
      for (var item in data) {
        if (item['key'] == 'addressError') {
          addressError = item['value'];
          break;
        }
      }
    }

    if (redirect.redirectLoadingDetails["data"] != null) {
      var data = redirect.redirectLoadingDetails["data"];
      for (var item in data) {
        if (item['key'] == 'restaurantDistanceKm') {
          appconfigkm = item['value'];
          break;
        }
      }
    }
    return showModalBottomSheet(
        context: context,
        builder: (context) => Addcartaddress(
              totalDis: resGlobalKM,
              restaurantId: widget.restaurantId,
              addresserror: addressError,
              appconfigkm: appconfigkm,
              isFromCartScreen: true,
            ),
        isDismissible: true,
        showDragHandle: true,
        enableDrag: true);
  }

  Future<dynamic> addusercartaddressBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Customcolors.DECORATION_WHITE,
      showDragHandle: true,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return const Addusercartaddress();
      },
    );
  }

  Future<dynamic> aadditionalinfoBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Customcolors.DECORATION_WHITE,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return const Additioninfo();
      },
    );
  }
}

class AddToCartController extends GetxController {
  var isClicked = false.obs; // Observable variable

  void toggleButton() {
    isClicked.value = !isClicked.value; // Toggle between true/false
  }

  void setClicked(bool value) {
    isClicked.value = value; // Set specific state
  }
}
