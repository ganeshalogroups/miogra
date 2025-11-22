// ignore_for_file: must_be_immutable, file_names, unnecessary_brace_in_string_interps

import 'dart:async';

import 'package:testing/Features/Bottomsheets/AddPaymentmethod.dart';
import 'package:testing/Features/Bottomsheets/Addadressbottomsheet.dart';
import 'package:testing/Features/Bottomsheets/Additionalinfo.dart';
import 'package:testing/Features/Bottomsheets/Adduserbottomsheet.dart';
import 'package:testing/Features/Bottomsheets/Deliverytips.dart';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Addfoodcontroller.dart';
import 'package:testing/Features/Foodmodule/Foodviewscreen/AddButtonFunctions/Buttonfunctionalities.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/Coupon/Coupon.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/CreateOrdercontroller.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/Foodgetcontroller.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Cartcustomisation.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodviewfirstscreen.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Unavailablefoodincart.dart';
import 'package:testing/Features/Foodmodule/getFoodCartProvider.dart';
import 'package:testing/Features/Homepage/AddressController/Addresscontroller.dart';
import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Redirectcontroller.dart';
import 'package:testing/Features/OrderScreen/OrderScreenController/ReorderController.dart';
import 'package:testing/Features/OrderScreen/OrdersTab.dart';
import 'package:testing/Features/coupon/couponController.dart';
import 'package:testing/PaymentGateway/Razorpay.dart';
import 'package:testing/common/billDataClass.dart';
import 'package:testing/common/cartscreenWidgets.dart';
import 'package:testing/common/commonTextWidgets.dart';
import 'package:testing/common/commonloadingWidget.dart';
import 'package:testing/common/edgeIncetsClass.dart';
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
import 'package:provider/provider.dart';

class ReorderFood extends StatefulWidget {
dynamic cartidlist;
// dynamic addressType;
String? fulladdress;
String? restaurantname;
dynamic restaurantid;
// String? useraddress;
// dynamic dropAddress;
dynamic kilometre;
ReorderFood({
required this.fulladdress,
// this.useraddress,
// this.addressType,
this.restaurantname,
// required this.dropAddress,
required this.restaurantid,
required this.kilometre,
this.cartidlist,
super.key});

  @override
  State<ReorderFood> createState() => ReorderFoodState();
}

class ReorderFoodState extends State<ReorderFood> {
  ButtonController buttonController = ButtonController();
  ReorderGetcontroller reorder =Get.put(ReorderGetcontroller());
  Foodcartcontroller foodcart = Get.put(Foodcartcontroller());
  Ordercontroller ordercreate = Get.put(Ordercontroller());
  CheckboxController checkboxController = Get.put(CheckboxController());
  PaymentMethodController paymentMethodController =Get.put(PaymentMethodController());
      //  Walletcontroller walletget = Get.put(Walletcontroller());
       RedirectController redirect =Get.put(RedirectController());
  final RazorpaymentIntegration integration = RazorpaymentIntegration();
  AddressController addresscontroller = Get.put(AddressController());
  Ordercontroller createorder = Get.put(Ordercontroller());
  
  final GlobalKey<FormState> tipformKey = GlobalKey<FormState>();
  Map<int, int> quantities = {};
  List<Map<String, dynamic>> foodsList = [];
  List<Map<String, dynamic>> orderDetailsListPay = [];
  List cartIdList=[];
  bool iscartloading = false;
  bool isClicked = false;

  bool isButtonLoading = false;
  bool paymentsheet=false;
  dynamic addressError;
  dynamic appconfigkm;
  dynamic codMaxAmount;
  Logger log = Logger();
  bool hasUnavailableItem = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      addresscontroller.getaddressapi(context: context,latitude: initiallat,longitude: initiallong);
      integration.initiateRazorPay();
      await reorder.reordercart(cartidlist: widget.cartidlist);
      getttcartDetails();
      //  walletget.getwalletDetails();  
        redirect.getredirectDetails();
      reorder.reordertofoodget(restaurantId: widget.restaurantid);
       if (paymentsheet) {
      addcartPaymentBottomSheet(context);
  }
    });
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

    await foodcart.deleteCartItem(foodid: item["foodId"]).whenComplete(() async {
      setState(() async {
        quantities.remove(index);
        foodsList.removeAt(index);

        quantities = Map.fromIterables(
          List.generate(foodsList.length, (i) => i),
          foodsList.map((item) => item["quantity"]),
        );

        await _updateOrderDetails();
        await foodcart.getbillfoodcartfood(km: resGlobalKM);
        await checkkgetttcartDetails();

        if (foodsList == null ||foodsList.isEmpty) {
        
          Get.off(() => const OrdersHistory(), transition: Transition.leftToRight);
          foodcart.clearCartItem(context: context);
          Provider.of<ButtonController>(context, listen: false).totalItemCountNotifier.value = 0;
          Provider.of<ButtonController>(context, listen: false).hideButton();
        }

        await buttonController.updateTotalItemCount(foodcart, widget.kilometre);
      });
    });
  } else {
    await foodcart
        .updateCartItem(
      foodid: item["foodId"],
      quantity: itemCount,
      isCustomized: isCustomized,
      selectedVariantId:item["isCustomized"] == true?item["selectedVariantId"] :"",
        selectedAddOns: (item["isCustomized"] == true &&item["selectedAddOns"] != null &&
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

  
  // forrefresh() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) async {
  //      addresscontroller.getaddressapi(context: context,latitude: initiallat,longitude: initiallong);
  //     integration.initiateRazorPay();
  //      await reorder.reordercart(cartidlist: widget.cartidlist);
  //     getttcartDetails();
  //      redirect.getredirectDetails();
  //       // walletget.getwalletDetails();
  //     reorder.reordertofoodget(restaurantId: widget.restaurantid);
  //     getttcartDetails();
  //   });
  // }

// forrefresh() {
//   WidgetsBinding.instance.addPostFrameCallback((_) async {
//     final coupon = Provider.of<CouponController>(context, listen: false);
//     final buttonController = Provider.of<ButtonController>(context, listen: false);

//     try {
//        addresscontroller.getaddressapi(context: context, latitude: initiallat, longitude: initiallong);
//       integration.initiateRazorPay();
//       redirect.getredirectDetails();

//       await foodcart.getfoodcartfood(km: resGlobalKM);
//       await foodcart.getbillfoodcartfood(km: resGlobalKM);

//       final cartData = foodcart.getfoodcart?["data"];
//       final foodsData = cartData != null ? (cartData ?? []) : [];
//       final billData = foodcart.getbillfoodcart?["data"];

//       // ✅ Safely handle null or empty checks
//       if (foodsData.isEmpty || billData == null || billData.isEmpty) {
//         foodcart.clearCartItem(context: context);
//         buttonController.totalItemCountNotifier.value = 0;
//         buttonController.hideButton();
//         coupon.removeCoupon();

//         Get.off(() => const OrdersHistory(), transition: Transition.leftToRight);
//       } else {
//         setState(() {
//           foodsList = List.from(foodsData);
//           quantities.clear();
//           for (int i = 0; i < foodsList.length; i++) {
//             quantities[i] = foodsList[i]["quantity"];
//           }
//           _updateOrderDetails();
//         });
//       }
//     } catch (e, stack) {
//       print("Error in forrefresh: $e");
//     }
//   });
// }
Future<void> forrefresh() async {
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    final coupon = Provider.of<CouponController>(context, listen: false);
    final buttonController = Provider.of<ButtonController>(context, listen: false);

    try {
      // API calls
      addresscontroller.getaddressapi(context: context, latitude: initiallat, longitude: initiallong);
      integration.initiateRazorPay();
      redirect.getredirectDetails();

      await foodcart.getfoodcartfood(km: resGlobalKM);
      await foodcart.getbillfoodcartfood(km: resGlobalKM);

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
        Get.off(() => const OrdersHistory(), transition: Transition.leftToRight);
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
      final foodcartprovider = Provider.of<FoodCartProvider>(context, listen: false);
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

        hasUnavailableItem = foodsList.any((food) =>
            food["foodDetails"]["available"] == false ||
            food["foodDetails"]["status"] == false);

        if (hasUnavailableItem) {
          Future.delayed(Duration.zero, () {
            CustomclearcartDialog.show(
            context: context,
            title: 'Food Not Available',
            content:"Some items in your cart are not available at the moment. Remove them to proceed with your order.",
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
      final foodcartprovider = Provider.of<FoodCartProvider>(context, listen: false);

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
        //  foodcart.clearCartItem(context: context);
        //     Provider.of<ButtonController>(context, listen: false).totalItemCountNotifier.value = 0;
        //     Provider.of<ButtonController>(context, listen: false).hideButton();

        // // ✅ Navigate to ordersHistory
        // Get.off(() => const OrdersHistory(), transition: Transition.leftToRight);
          
          // Handle empty foodsList case
          return;
        }

        foodcart.getbillfoodcartfood(km: resGlobalKM);

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
    content: "Cash on Delivery isn't available for orders above ₹500. Continue your tasty order and enjoy! 😋",
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
            .updateTotalItemCount(foodcart, widget.kilometre);
      } else {
        setState(() {
          Provider.of<ButtonController>(context, listen: false).showButton();
        });
        await buttonController.updateTotalItemCount(foodcart, widget.kilometre);
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
  foodPrice = foodsList[i]["foodDetails"]?["singleUnCustomizedPriceForFood"] ?? 0;
} else if (foodsList[i]["selectedVariantId"] != null && (foodsList[i]["selectedAddOns"] as List?)?.isNotEmpty == true) {
  foodPrice = (foodsList[i]["variantDetails"]?["variantAmountForSingle"] ?? 0) +(foodsList[i]["addOnsDetails"]?["addOnsAmountForSingle"] ?? 0);
} else {
  foodPrice = foodsList[i]["variantDetails"]?["variantAmountForSingle"] ?? 0;
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
        "totalPrice": double.parse(foodsList[i]["foodDetails"]["food"]["totalPrice"].toString()),
        "selectedVariant":foodsList[i]["isCustomized"] == true?foodsList[i]["variantDetails"]["customizedFood"]["addVariants"]:[],
        // "selectedAddOns":foodsList[i]["isCustomized"] == true&& foodsList[i]["addOnsDetails"]["addOnsDetails"] != null &&
        //    foodsList[i]["addOnsDetails"]["addOnsDetails"].isNotEmpty?foodsList[i]["addOnsDetails"]["addOnsDetails"]:[]
        "selectedAddOns": (foodsList[i]["isCustomized"] == true &&foodsList[i]["addOnsDetails"]?["addOnsDetails"] != null &&
        (foodsList[i]["addOnsDetails"]["addOnsDetails"] as List).isNotEmpty)
    ? foodsList[i]["addOnsDetails"]["addOnsDetails"]
    : [],

      });

      print("orderDetailsListPay from array:${orderDetailsListPay}");
      cartIdList.add(foodsList[i]["_id"].toString());
    }
  }
  // Future<void> _updateOrderDetails() async {
  //   // Update orderDetailsListPay with the current quantities
  //   orderDetailsListPay.clear();
  //   cartIdList.clear();
  //   for (int i = 0; i < foodsList.length; i++) {
  //     int foodPrice;
  //     if (foodsList[i]["isCustomized"] == false) {
  //       foodPrice =foodsList[i]["foodDetails"]["singleUnCustomizedPriceForFood"];
  //     } else if (foodsList[i]["selectedVariantId"] == null ||foodsList[i]["selectedVariantId"].isEmpty) {
  //       foodPrice = foodsList[i]["addOnsDetails"] != null
  //           ? foodsList[i]["addOnsDetails"]["addOnsAmountForSingle"]
  //           : 0;
  //     } else if (foodsList[i]["selectedAddOns"] == null ||foodsList[i]["selectedAddOns"].isEmpty) {
  //       foodPrice = foodsList[i]["variantDetails"] != null
  //           ? foodsList[i]["variantDetails"]["variantAmountForSingle"]
  //           : 0;
  //     } else {
  //       foodPrice = (foodsList[i]["variantDetails"]["variantAmountForSingle"] +foodsList[i]["addOnsDetails"]["addOnsAmountForSingle"]);
  //     }

  //     orderDetailsListPay.add({
  //       "productType": "restaurant",
  //       "description": "",
  //       "foodId": foodsList[i]["foodId"],
  //       "foodName": foodsList[i]["foodDetails"]["foodName"].toString(),
  //       "foodImage": "${globalImageUrlLink}${foodsList[i]["foodDetails"]["foodImgUrl"].toString()}",
  //       "foodType": foodsList[i]["foodDetails"]["foodType"].toString(),
  //       "quantity": quantities[i] ?? 0, // Use updated quantity
  //       "foodPrice": double.parse(foodPrice.toString()),
  //       "totalPrice": double.parse(foodsList[i]["foodDetails"]["food"]["totalPrice"].toString()),
  //        "selectedVariant":foodsList[i]["isCustomized"] == true?foodsList[i]["variantDetails"]["customizedFood"]["addVariants"]:[],
  //       // "selectedAddOns":foodsList[i]["isCustomized"] == true&& foodsList[i]["addOnsDetails"]["addOnsDetails"] != null &&
  //       //    foodsList[i]["addOnsDetails"]["addOnsDetails"].isNotEmpty?foodsList[i]["addOnsDetails"]["addOnsDetails"]:[]
  //       "selectedAddOns": (foodsList[i]["isCustomized"] == true &&
  //                  foodsList[i]["addOnsDetails"]?["addOnsDetails"] != null &&
  //                  (foodsList[i]["addOnsDetails"]["addOnsDetails"] as List).isNotEmpty)
  //   ? foodsList[i]["addOnsDetails"]["addOnsDetails"]
  //   : [],

  //     });
  //     cartIdList.add(foodsList[i]["_id"].toString());
  //   }
  // }

  // Future<void> updateItemCount(int index, int itemCount ,context, {bool forceDelete = false}) async {
  //   if (itemCount <= 0 || forceDelete) {
  //     // Remove item from local storage and API
  //     print(forceDelete);
  //     await foodcart
  //         .deleteCartItem(foodid: foodsList[index]["foodId"])
  //         .whenComplete(() async {
  //       // Update local state
  //       setState(() async {
  //         quantities.remove(index); // Remove quantity from local list
  //         foodsList.removeAt(index); // Remove item from the list
  //         // Update quantities map after removing item
  //         quantities = Map.fromIterables(
  //           List.generate(foodsList.length, (i) => i),
  //           foodsList.map((item) => item["quantity"]),
  //         );
  //         await _updateOrderDetails();
  //         await foodcart.getbillfoodcartfood(km: resGlobalKM);
      
  //          // **Immediately call getttcartDetails** to update the state and check for unavailable items
  //         await checkkgetttcartDetails();

  //         if (foodsList == null || foodsList.isEmpty) {
  //          // ✅ Navigate to ordersHistory
  //           Get.off(() => const OrdersHistory(), transition: Transition.leftToRight);
  //         }
  //           // buttonController.hideButton();
  //           foodcart.clearCartItem(context: context);
  //           Provider.of<ButtonController>(context, listen: false).totalItemCountNotifier.value = 0;
  //           Provider.of<ButtonController>(context, listen: false).hideButton();

       
  //         await buttonController.updateTotalItemCount(
  //             foodcart, widget.kilometre);
  //       });
  //     });
  //   } else {
  //     await foodcart
  //         .updateCartItem(
  //             foodid: foodsList[index]["foodId"], quantity: itemCount)
  //         .whenComplete(() {
  //       setState(() {
  //         quantities[index] = itemCount;
  //         foodsList[index]["quantity"] = itemCount;
  //       });
  //     });
  //   }
  // }
Future<void> updateItemCount(int index, int itemCount, context, {bool forceDelete = false}) async {
  if (itemCount <= 0 || forceDelete) {
    print(forceDelete);

    // Perform async work first
    await foodcart.deleteCartItem(foodid: foodsList[index]["foodId"]);

    // Update local state synchronously
    setState(() {
      quantities.remove(index);
      foodsList.removeAt(index);

      quantities = Map.fromIterables(
        List.generate(foodsList.length, (i) => i),
        foodsList.map((item) => item["quantity"]),
      );
    });

    // Now continue async logic
    await _updateOrderDetails();
    await foodcart.getbillfoodcartfood(km: resGlobalKM);
    await checkkgetttcartDetails();

    if (foodsList.isEmpty) {
  Get.off(() => const OrdersHistory(), transition: Transition.leftToRight);

  // Defer context-based operations safely
  Future.delayed(Duration.zero, () {
    foodcart.clearCartItem(context: context);
    Provider.of<ButtonController>(context, listen: false).totalItemCountNotifier.value = 0;
    Provider.of<ButtonController>(context, listen: false).hideButton();
  });
}


    await buttonController.updateTotalItemCount(foodcart, widget.kilometre);
  } else {
    await foodcart.updateCartItem(
    isCustomized: false,
      foodid: foodsList[index]["foodId"],
      quantity: itemCount,
    );

    setState(() {
      quantities[index] = itemCount;
      foodsList[index]["quantity"] = itemCount;
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
      print("//////////////listtttt/////////////////");
    }
  }

  // dynamic calculatePrice(int index) {
  //   final food = foodsList[index];
  //   if (food["isCustomized"] == false) {
  //     return food["foodDetails"]["singleUnCustomizedPriceForFood"] * quantities[index];
  //   } else if (food["selectedVariantId"] == null || food["selectedVariantId"].isEmpty) {
  //     return food["addOnsDetails"]["addOnsAmountForSingle"] * quantities[index];
  //   } else if (food["selectedAddOns"] == null || food["selectedAddOns"].isEmpty) {
  //     return food["variantDetails"]["variantAmountForSingle"] * quantities[index];
  //   } else {
  //     return (food["variantDetails"]["variantAmountForSingle"] +  food["addOnsDetails"]["addOnsAmountForSingle"]) * quantities[index];
  //   }
  // }
dynamic calculatePrice(int index) {
  final food = foodsList[index];
  final quantity = (quantities[index] ?? 1);

  double price = 0;

  if (food["isCustomized"] == false) {
    price = (food["foodDetails"]?["singleUnCustomizedPriceForFood"] ?? 0).toDouble() * quantity;
  } else if (food["selectedVariantId"] == null || food["selectedVariantId"].isEmpty) {
    price = (food["addOnsDetails"]?["addOnsAmountForSingle"] ?? 0).toDouble() * quantity;
  } else if (food["selectedAddOns"] == null || food["selectedAddOns"].isEmpty) {
    price = (food["variantDetails"]?["variantAmountForSingle"] ?? 0).toDouble() * quantity;
  } else {
    final double variantPrice = (food["variantDetails"]?["variantAmountForSingle"] ?? 0).toDouble();
    final double addOnPrice = (food["addOnsDetails"]?["addOnsAmountForSingle"] ?? 0).toDouble();
    price = (variantPrice + addOnPrice) * quantity;
  }

  return price.toStringAsFixed(2); // Always returns string like "99.00"
}
  @override
  Widget build(BuildContext context) {
     var productviewprovider = Provider.of<FoodProductviewPaginations>(context);
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
           await Get.off(const OrdersHistory());
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
              await Get.off(const OrdersHistory());
              await foodcart.getfoodcartfood(km: resGlobalKM);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Customcolors.DECORATION_BLACK,
            ),
          ),
          title: CartAppBarTitle(
              title: widget.restaurantname.toString().capitalizeFirst.toString(),
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
                    children: [
                      5.toHeight,
                      Container(
                        decoration:BoxDecorationsFun.whiteCircelRadiusDecoration(),
                        padding: paddingAll(padding: 12.0),
                        child: InkWell(
                          onTap: () {
                            addcartAddressBottomSheet(context).then((value) {
                              Future.delayed(
                                const Duration(seconds: 0),
                                () {
                                  double totalDistance = double.parse(
                                      foodcartprovider.totalDis.split(' ').first.toString());
                                  setState(() {
                                     foodcart.getbillfoodcartfood( km: totalDistance);
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
                    mapaddres.addressType != 'Current' && addresscontroller.getaddressdetails != null?   20.toHeight:10.toHeight,
                     mapaddres.addressType != 'Current' && addresscontroller.getaddressdetails != null? 
                      Container(
                        decoration: BoxDecorationsFun.whiteCircelRadiusDecoration(),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 23,
                                    height: 35,
                                    child: Image.asset("assets/images/discount.png"),
                                  ),

                                  SizedBox(width: 11.w),
                                  Row(
                                    children: [
                                      Text(
                                        getFormattedText(),
                                        style: CustomTextStyle.boldblack12,
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
                                              style: CustomTextStyle.DECORATION_regulartext),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            Get.to(
                                                Couponscreen(
                                                vendorAdminId:foodcart.getbillfoodcart["data"] ["restaurantDetails"]["parentAdminUserId"],
                                                  restaurantid:widget.restaurantid,
                                                  totalDis: widget.kilometre,
                                                  isCouponApplied: isCouponApplied,
                                                  apply: applyCoupon,
                                                  remove: removeCoupon,
                                                ),
                                                transition: Transition.rightToLeft,
                                                duration: const Duration(milliseconds: 200),
                                                curve: Curves.easeIn);
                                          },
                                          child: const Text("Apply",style: CustomTextStyle.DECORATION_regulartext)), //
                                ],
                              ),
                              8.toHeight,
                              DotLine(height: 0),
                              8.toHeight,
                              InkWell(
                                onTap: () {
                                  Get.to(
                                      Couponscreen(
                                      vendorAdminId:foodcart.getbillfoodcart["data"] ["restaurantDetails"]["parentAdminUserId"],
                                        restaurantid: widget.restaurantid,
                                        totalDis: widget.kilometre,
                                        isCouponApplied: isCouponApplied,
                                        apply: applyCoupon,
                                        remove: removeCoupon,
                                      ),
                                      transition: Transition.rightToLeft,
                                      duration: const Duration(milliseconds: 200),
                                      curve: Curves.easeIn);
                                },
                                child: ViewMoreTextArrow(content: "View more coupon"),
                              ),
                            ],
                          ),
                        ),
                      ):const SizedBox.shrink(),
                      mapaddres.addressType != 'Current' && addresscontroller.getaddressdetails != null?  15.toHeight:5.toHeight,
                         GetBuilder<Foodcartcontroller>(
                        builder: (foodcart) {
                          if (foodcart.getbillfoodcartloading.isTrue) {
                            return const Center(child: Billshimmer());
                          } else if (iscartloading) {
                            return const Center(child: Billshimmer());
                          } else if (foodcart.getbillfoodcart == null) {
                            return const Center(child:  CupertinoActivityIndicator());
                          } else if (foodcart.getbillfoodcart["data"].isEmpty) {
                            return const Center(child: Text("No orders Available!"));
                          } else {
                          double tipAmount = foodcart.selectedTipAmount.value.isNotEmpty
                          ? double.parse(foodcart.selectedTipAmount.value): 0.0;
                            return BillSummaryWidget(
                              basePrice:"₹${foodcart.getbillfoodcart["data"]["totalFoodAmount"].toStringAsFixed(2)}",
                              gstAndOtherCharges:"${(foodcart.getbillfoodcart["data"]["totalGST"] + foodcart.getbillfoodcart["data"]["foods"][0]["otherCharges"]).toStringAsFixed(2)}",

                              packagingCharge:"₹${foodcart.getbillfoodcart["data"]["totalPackageCharges"].toStringAsFixed(2)}",
                              couponDiscount: coupountext() != '0.0'? "-${coupountext()}": coupountext(),
                              deliverytip: tipAmount,
                              platfomfee: "${foodcart.getbillfoodcart["data"] ["platformFeeCharge"].toStringAsFixed(2)}",
                              delivaryCharge:"₹${foodcart.getbillfoodcart["data"]["deliveryCharges"].toStringAsFixed(2)}",
                              totalKm: foodcartprovider.totalDis,
                              redirectLoadingDetails: redirect.redirectLoadingDetails,
                              grandTotal: coupon.isCouponApplied
                                  ? "₹${coupon.coupontype == "percentage" ? (() {
                                      dynamic totcsamount;
                                      double percentage = double.parse(coupon.couponamount.replaceAll("%", ""));
                                      // Convert dynamic values to double
                                      double totalFoodAmount = double.parse(foodcart.getbillfoodcart["data"]["totalFoodAmount"].toString());
                                      // Calculate the final amount using dynamic values
                                      double check =(percentage / 100) * totalFoodAmount;

                                      totcsamount =foodcart.getbillfoodcart["data"]["totalFoodAmount"] -  check;

                                      return (totcsamount +foodcart.getbillfoodcart["data"]["totalPackageCharges"] +foodcart.getbillfoodcart["data"] ["platformFeeCharge"]+ foodcart.getbillfoodcart["data"]["foods"][0]["otherCharges"]+
                                              foodcart.getbillfoodcart["data"]["deliveryCharges"] + foodcart.getbillfoodcart["data"]["totalGST"]+tipAmount).roundToDouble().toStringAsFixed(2);
                                    })() : (() {
                                      dynamic totcsamount;
                                      double couponAmount = double.parse(coupon.couponamount.replaceAll("₹", ""));

                                      // Convert dynamic value to double
                                      double totalAmount = double.parse(foodcart.getbillfoodcart["data"]["totalFoodAmount"].toString());
                                      // Calculate the amount after subtracting the coupon amount
                                      totcsamount = totalAmount - couponAmount;

                                      return (totcsamount +tipAmount+foodcart.getbillfoodcart["data"]["totalPackageCharges"] +foodcart.getbillfoodcart["data"] ["platformFeeCharge"]+ foodcart.getbillfoodcart["data"]["foods"][0]["otherCharges"]+
                                              foodcart.getbillfoodcart["data"]["deliveryCharges"] +foodcart.getbillfoodcart["data"]["totalGST"]).roundToDouble().toStringAsFixed(2);
                                    })()}": "₹${(foodcart.getbillfoodcart["data"]["totalAmount"]+tipAmount+ foodcart.getbillfoodcart["data"]["foods"][0]["otherCharges"]).roundToDouble().toStringAsFixed(2)}",
                            );
                          }
                        },
                      ),
                     
                      // GetBuilder<Foodcartcontroller>(
                      //   builder: (foodcart) {
                      //     if (foodcart.getbillfoodcartloading.isTrue) {
                      //       return const Center(child: Billshimmer());
                      //     } else if (iscartloading) {
                      //       return const Center(child: Billshimmer());
                      //     } else if (foodcart.getbillfoodcart == null) {
                      //        return const Center(child: Billshimmer());
                      //     } else if (foodcart.getbillfoodcart["data"].isEmpty) {
                      //       return const Center(child: Text("No orders Available!"));
                      //     } else {
                      //     double tipAmount = foodcart.selectedTipAmount.value.isNotEmpty
                      //     ? double.parse(foodcart.selectedTipAmount.value): 0.0;
                      //       return BillSummaryWidget(
                      //         basePrice:"₹${foodcart.getbillfoodcart["data"]["totalFoodAmount"].toStringAsFixed(2)}",
                      //         gst:"₹${foodcart.getbillfoodcart["data"]["totalGST"].toStringAsFixed(2)}",
                      //         packagingCharge:"₹${foodcart.getbillfoodcart["data"]["totalPackageCharges"].toStringAsFixed(2)}",
                      //         couponDiscount: coupountext() != '0.0'? "-${coupountext()}": coupountext(),
                      //         deliverytip: tipAmount,
                      //         platfomfee: "${foodcart.getbillfoodcart["data"] ["platformFeeCharge"].toStringAsFixed(2)}",
                      //         delivaryCharge:"₹${foodcart.getbillfoodcart["data"]["deliveryCharges"].toStringAsFixed(2)}",
                      //         totalKm: foodcartprovider.totalDis,
                      //         grandTotal: coupon.isCouponApplied
                      //             ? "₹${coupon.coupontype == "percentage" ? (() {
                      //                 dynamic totcsamount;
                      //                 double percentage = double.parse(coupon.couponamount.replaceAll("%", ""));
                      //                 // Convert dynamic values to double
                      //                 double totalFoodAmount = double.parse(foodcart.getbillfoodcart["data"]["totalFoodAmount"].toString());
                      //                 // Calculate the final amount using dynamic values
                      //                 double check =(percentage / 100) * totalFoodAmount;

                      //                 totcsamount =foodcart.getbillfoodcart["data"]["totalFoodAmount"] -  check;

                      //                 return (totcsamount +foodcart.getbillfoodcart["data"]["totalPackageCharges"] +foodcart.getbillfoodcart["data"] ["platformFeeCharge"]+
                      //                         foodcart.getbillfoodcart["data"]["deliveryCharges"] + foodcart.getbillfoodcart["data"]["totalGST"]+tipAmount).toStringAsFixed(2);
                      //               })() : (() {
                      //                 dynamic totcsamount;
                      //                 double couponAmount = double.parse(coupon.couponamount.replaceAll("₹", ""));

                      //                 // Convert dynamic value to double
                      //                 double totalAmount = double.parse(foodcart.getbillfoodcart["data"]["totalFoodAmount"].toString());
                      //                 // Calculate the amount after subtracting the coupon amount
                      //                 totcsamount = totalAmount - couponAmount;

                      //                 return (totcsamount+tipAmount +foodcart.getbillfoodcart["data"]["totalPackageCharges"] +foodcart.getbillfoodcart["data"] ["platformFeeCharge"]+
                      //                         foodcart.getbillfoodcart["data"]["deliveryCharges"] +foodcart.getbillfoodcart["data"]["totalGST"]) .toStringAsFixed(2);
                      //               })()}": "₹${(foodcart.getbillfoodcart["data"]["totalAmount"]+tipAmount).toStringAsFixed(2)}",
                      //       );
                      //     }
                      //   },
                      // ),
                       
                       mapaddres.addressType != 'Current' && addresscontroller.getaddressdetails != null? 10.toHeight:5.toHeight,
                       mapaddres.addressType != 'Current' && addresscontroller.getaddressdetails != null? AddDeliveryInstructions(onTapp: () => aadditionalinfoBottomSheet(context)):const SizedBox.shrink(),
                      mapaddres.addressType != 'Current' && addresscontroller.getaddressdetails != null? 10.toHeight:5.toHeight,
                      mapaddres.addressType != 'Current' && addresscontroller.getaddressdetails != null? DriverTipSelector(externalFormKey:tipformKey ,):const SizedBox.shrink(),
                      mapaddres.addressType != 'Current' && addresscontroller.getaddressdetails != null? 10.toHeight:5.toHeight,
                       mapaddres.addressType != 'Current' && addresscontroller.getaddressdetails != null? InkWell(onTap: () {
                        addusercartaddressBottomSheet(context);
                      }, child: Consumer<InstantUpdateProvider>(
                        builder: (context, value, child) {
                          if (value.otherName != '' &&
                              value.otherNumber != '') {
                            return Container(
                              decoration: BoxDecorationsFun.whiteCircelRadiusDecoration(),
                              child: Padding(
                                padding: const EdgeInsets.symmetric( horizontal: 12, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                        width: MediaQuery.sizeOf(context).width / 1.5,
                                          child: Text(
                                            'You’re confirming this order ${value.otherName}',
                                            style: CustomTextStyle.blackbold14,
                                          ),
                                        ),
                                        3.toHeight,
                                        SizedBox(
                                          width: MediaQuery.sizeOf(context).width / 1.5,
                                          child: Text(
                                            'We’ll keep you updated on your delivery  \n through the number ${value.otherNumber}',
                                            style: CustomTextStyle.carttblack,
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
                                          color: Customcolors.darkpurple,
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
                              decoration: BoxDecorationsFun.whiteCircelRadiusDecoration(),
                              child: const Padding(
                                padding:EdgeInsets.symmetric(horizontal: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      )):const SizedBox.shrink(),
                     mapaddres.addressType != 'Current' && addresscontroller.getaddressdetails != null? const SizedBox(height: 10):const SizedBox(height: 5,),



//                        Container(
//   decoration: BoxDecorationsFun.whiteCircelRadiusDecoration(),
//   child: Padding(
//     padding: EdgeInsets.all(12.0),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween, // Add this line to distribute space evenly
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start, // Add this line to align text to the start
//           children: [
//             Text('Pay using', style: CustomTextStyle.addressfeildtext),
//             10.toHeight,
          
//           Obx(() {
//   String paymentMethodText;
//   int selectedPaymentMethod = paymentMethodController.selectedPaymentMethod.value;

//   if (foodcart.getbillfoodcartloading.isTrue || iscartloading) {
//     return Text("Loading....", style: CustomTextStyle.adresssubtext);
//   } else if (foodcart.getbillfoodcart == null) {
//     return CircularProgressIndicator();
//   }

//   double tipAmount = foodcart.selectedTipAmount.value.isNotEmpty
//       ? double.parse(foodcart.selectedTipAmount.value)
//       : 0.0;

//   double totalFoodAmount = double.tryParse(foodcart.getbillfoodcart["data"]["totalFoodAmount"].toString()) ?? 0.0;
//   double totalAmount = double.tryParse(foodcart.getbillfoodcart["data"]["totalAmount"].toString()) ?? 0.0;
//   double grandTotal = totalAmount + tipAmount;

//   // Handle Wallet Payment restriction
//   if (selectedPaymentMethod == 2) {
//     double walletBalance = double.tryParse(walletget.walletdetails?["data"]["walletTotalAmount"].toString() ?? "0") ?? 0.0;
//     if (walletBalance < grandTotal) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         paymentMethodController.selectedPaymentMethod.value = -1;
//         showCustomPaymentDialog(
//           context,
//           title: 'Wallet Payment Not Available',
//           content: 'Your wallet balance is insufficient. Please choose another payment method.',
//         );
//       });
//     }
//   }

//   // Handle CoD restriction
//   if (selectedPaymentMethod == 0 && totalFoodAmount > 500) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       paymentMethodController.selectedPaymentMethod.value = 1; // Set to Online
//       showCustomPaymentDialog(
//         context,
//         title: 'Your Payment Method Changed!',
//         content: "Cash on Delivery isn't available for orders above ₹500. Continue your tasty order and enjoy! 😋",
//       );
//     });
//   }

//   // Set the display text
//   paymentMethodText = selectedPaymentMethod == -1
//       ? "Select Your Payment Method"
//       : (selectedPaymentMethod == 0
//           ? "Cash on Delivery"
//           : (selectedPaymentMethod == 1
//               ? "Online Payment"
//               : "Wallet Payment"));

//   return Text(paymentMethodText, style: CustomTextStyle.adresssubtext);
// }),

//           ],
//         ),
//         InkWell(
//           onTap: () {
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               paymentsheet = true; // Set true when tapped
//             });
//             addcartPaymentBottomSheet(context);
//           },
//           child: Row(
//             children: const [
//               Text(
//                 "Change",
//                 style: TextStyle(
//                   color: Color.fromRGBO(245, 92, 36, 0.792),
//                   fontFamily: 'Poppins-Regular',
//                 ),
//               ),
//               Icon(
//                 Icons.keyboard_arrow_right,
//                 color: Color.fromRGBO(245, 92, 36, 0.792),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   ),
// ),
// Obx(() {
//   if (paymentMethodController.selectedPaymentMethod.value == 2) {
//     return Column(
//       children: [
//       SizedBox(height: 8,),
//         Container(
//           margin: const EdgeInsets.only(top: 8),
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: Colors.green.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: Colors.green),
//           ),
//           child: Row(
//             children:  [
//            Image.asset(
//             'assets/images/savings.gif', // Add your image path here
//             // width: 30, // You can adjust the size
//             height: 40,
//             fit: BoxFit.fitHeight,
//           ),
//               SizedBox(width: 8),
//               Expanded(
//                 child: Text(
//                   "The amount will be debited from your wallet.",
//                   style: CustomTextStyle.greenitalicordertext,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   } else {
//     return const SizedBox.shrink();
//   }
// }),

                      Container(
                        decoration: BoxDecorationsFun.whiteCircelRadiusDecoration(),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Add this line to distribute space evenly
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start, // Add this line to align text to the start
                                children: [
                                  const Text('Pay using',style: CustomTextStyle.addressfeildtext),
                                  10.toHeight,
                                  Obx(() {
                                    String paymentMethodText;
                                        int selectedPaymentMethod = paymentMethodController.selectedPaymentMethod.value;
                                    if (foodcart.getbillfoodcartloading.isTrue) {
                                      return const Text(
                                        "Loading....",
                                        style: CustomTextStyle.adresssubtext,
                                      );
                                    } else if (iscartloading) {
                                      return const Text(
                                        "Loading....",
                                        style: CustomTextStyle.adresssubtext,
                                      );
                                    } else if (foodcart.getbillfoodcart ==null) {
                                     return const Text(
                                        "Loading....",
                                        style: CustomTextStyle.adresssubtext,
                                      );
                                    } 
                              // Logic to check if Cash On Delivery is selected and totalFoodAmount > 500
                                    else if (selectedPaymentMethod == 0 && foodcart.getbillfoodcart["data"]["totalFoodAmount"] > 500) {
                                    WidgetsBinding.instance.addPostFrameCallback((_) {
                                    paymentsheet=true;
                                    paymentMethodController.selectedPaymentMethod.value = 1; // 1 represents Online Payment
                                    showCustomPaymentDialog(context);});
                                    }
                                  //  int selectedPaymentMethod = paymentMethodController.selectedPaymentMethod.value;
                                   paymentMethodText = selectedPaymentMethod == -1
                                   ? "Select Your PaymentMethod"
                                   : (selectedPaymentMethod == 0
                                   ? "Cash on Delivery"
                                   : "Online Payment");
                                    return Text(
                                      paymentMethodText,
                                      style: CustomTextStyle.adresssubtext, // Custom style for payment method text
                                    );
                                  }),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                 WidgetsBinding.instance.addPostFrameCallback((_) async{
                                paymentsheet = true; // Set true when tapped
                                  await     redirect.getredirectDetails();
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
                                      color: Customcolors.darkpurple,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      
                      14.toHeight,
                      // Text(
                      //   "Review your order and address to avoid cancellations".toUpperCase(),
                      //   style: CustomTextStyle.chipgreybold,
                      // ),
                      // 5.toHeight,
                      // Text(
                      //   "Please review your order and address. Changes or refunds aren’t possible after placing, unless canceled within 1 minute. Let’s reduce food waste.",
                      //   style: CustomTextStyle.cartminigrey,
                      // ),
                      const Text("HELP US MINIMIZE FOOD WASTE", style: CustomTextStyle.chipgreybold),
                      5.toHeight,
                      const Text("Kindly review your order and address. You can only cancel within 1 minute no changes or refunds after.",
                     style: CustomTextStyle.cartminigrey,
                      ),
                      SizedBox(height: 14.h),
                      if (hasUnavailableItem)
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: CustomContainerDecoration.gradientbuttondecoration(),
                            child: ElevatedButton(
                              onPressed: () {
                                CustomclearcartDialog.show(
                                  context: context,
                                  title: 'Food Not Available',
                                  content:"Some items in your cart are not available at the moment. Remove them to proceed with your order.",
                                  onConfirm: () async {
                                  Navigator.pop(context);
                                  },
                                  buttonname: 'Continue',
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                padding:const EdgeInsets.symmetric(vertical: 16),
                                textStyle: const TextStyle(fontSize: 16),
                              ),
                              child: Obx(() {
                                if (foodcart.getbillfoodcartloading.isTrue) {
                                  return const Center(
                                      child: CupertinoActivityIndicator( color: Colors.white));
                                } else if (iscartloading) {
                                  return const Center(
                                      child: CupertinoActivityIndicator( color: Colors.white));
                                } else if (foodcart.getbillfoodcart == null) {
                                  return const Center(
                                      child: CupertinoActivityIndicator( color: Colors.white));
                                } else if (foodcart.getbillfoodcart["data"].isEmpty) {
                                  return const Center(child: Text("No orders Available !"));
                                } else {
                                   double tipAmount = foodcart.selectedTipAmount.value.isNotEmpty
                                                     ? double.parse(foodcart.selectedTipAmount.value): 0.0;
                            return  Column(
                              children: [
                                Text(
                                  coupon.isCouponApplied
                                      ? "₹${coupon.coupontype == "percentage" ? (() {
                                          dynamic totcsamount;
                                   double percentage = double.parse(coupon.couponamount.replaceAll("%", ""));
                                      // Convert dynamic values to double
                                      double totalFoodAmount = double.parse(foodcart.getbillfoodcart["data"]["totalFoodAmount"].toString());
                                      // Calculate the final amount using dynamic values
                                      double check =(percentage / 100) * totalFoodAmount;
                            
                                      totcsamount =foodcart.getbillfoodcart["data"]["totalFoodAmount"] -  check;
                            
                                      return (totcsamount +foodcart.getbillfoodcart["data"]["totalPackageCharges"] +foodcart.getbillfoodcart["data"] ["platformFeeCharge"]+
                                              foodcart.getbillfoodcart["data"]["deliveryCharges"] + foodcart.getbillfoodcart["data"]["totalGST"]+tipAmount).roundToDouble().toStringAsFixed(2);
                                    })() : (() {
                                      dynamic totcsamount;
                                      double couponAmount = double.parse(coupon.couponamount.replaceAll("₹", ""));
                            
                                      // Convert dynamic value to double
                                      double totalAmount = double.parse(foodcart.getbillfoodcart["data"]["totalFoodAmount"].toString());
                                      // Calculate the amount after subtracting the coupon amount
                                      totcsamount = totalAmount - couponAmount;
                            
                                      return (totcsamount+tipAmount +foodcart.getbillfoodcart["data"]["totalPackageCharges"] +foodcart.getbillfoodcart["data"] ["platformFeeCharge"]+
                                              foodcart.getbillfoodcart["data"]["deliveryCharges"] +foodcart.getbillfoodcart["data"]["totalGST"]).roundToDouble().toStringAsFixed(2);
                                    })()} | Place order"
                                      : "₹${(foodcart.getbillfoodcart["data"]["totalAmount"] + tipAmount).roundToDouble().toStringAsFixed(2)} | Place order",
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
      minimumAmount = double.tryParse(orderMinimumAmount.toString()) ?? 0;
      break;
    }
  }
}
                          if (foodcart.getbillfoodcartloading.isTrue) {
                            return ReusableLoadingDummyButton(heighht: 50);
                          } else if (iscartloading) {
                            return ReusableLoadingDummyButton(heighht: 50);
                          } else if (foodcart.getbillfoodcart == null) {
                              return ReusableLoadingDummyButton(heighht: 50);
                                } else if (foodcart.getbillfoodcart["data"] ["totalFoodAmount"] < minimumAmount) {
                            return Column(
                              mainAxisSize: MainAxisSize.min, // Adjusts the column height to fit the content

                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.9,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.red[100], // Optional: background color
                                    borderRadius: BorderRadius.circular( 8), // Rounded corners
                                  ),
                                  child: Text(
                                    "Craving something delicious? Order now with a minimum food total of Rs.${minimumAmount}!",
                                    style: CustomTextStyle.rederrortext,
                                    textAlign: TextAlign.center, // Centers the text horizontally
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Center(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    width: MediaQuery.of(context).size.width * 0.9, // Adjust width to screen size
                                    decoration: CustomContainerDecoration.lightgreybuttondecoration(),
                                    child: const Center(
                                      child: Text(
                                        "Place Order",
                                        style: CustomTextStyle.loginbuttontext, // Button text style
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else if (foodcart.getbillfoodcart["data"]["totalQuantity"] > 20) {
                            return Column(
                              mainAxisSize: MainAxisSize.min, // Adjusts the column height to fit the content

                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.9,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.red[100], // Optional: background color
                                    borderRadius: BorderRadius.circular( 8), // Rounded corners
                                  ),
                                  child: const Text(
                                    "Order limit exceeded! Please reduce the food quantity below 20 to continue.",
                                    style: CustomTextStyle.rederrortext,
                                    textAlign: TextAlign.center, // Centers the text horizontally
                                  ),
                                ),
                                8.toHeight,
                                Center(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    width: MediaQuery.of(context).size.width *  0.9, // Adjust width to screen size
                                    decoration: CustomContainerDecoration.lightgreybuttondecoration(),
                                    child: const Center(
                                      child: Text(
                                        "Place Order ",
                                        style: CustomTextStyle.loginbuttontext, // Button text style
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else if (foodcart.getbillfoodcart["data"].isEmpty) {
                            return const Center(child: Text("No orders Available !"));
                          } else {
                            dynamic totsamount;

                            if (coupon.isCouponApplied) {
                              if (coupon.coupontype == "percentage") {
                                // Convert the percentage string to a double
                                double percentage = double.parse( coupon.couponamount.replaceAll("%", ""));
                                dynamic totalFoodAmount = foodcart.getbillfoodcart["data"]["totalFoodAmount"]; // Assume dynamic but numeric
                                dynamic totalAmount = foodcart.getbillfoodcart["data"]["totalAmount"];

                                totsamount = double.parse((totalAmount - ((percentage / 100) * totalFoodAmount)) .toStringAsFixed(2));
                              } else {
                                // Convert the coupon amount string to a double
                                double couponAmount = double.parse( coupon.couponamount.replaceAll("₹", ""));
                                dynamic totalAmount = foodcart.getbillfoodcart["data"]["totalAmount"];
                                totsamount = double.parse((totalAmount - couponAmount).toStringAsFixed(2));
                              }
                            } else {
                              totsamount = 0; // Default to 0 when no coupon is applied
                            }
 double tipAmount = foodcart.selectedTipAmount.value.isNotEmpty
                                                     ? double.parse(foodcart.selectedTipAmount.value): 0.0;
                          
                            return isButtonLoading
                                ? Center(
                                    child: CustomdisabledButton(
                                      onPressed: () {},
                                      borderRadius: BorderRadius.circular(30),
                                      width: MediaQuery.of(context).size.width * 0.9,
                                      child: const Text('Order Processing..', style:CustomTextStyle.loginbuttontext),
                                    ),
                                  )
                                : Center(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.9, // Adjust the width based on screen size
                                      decoration: CustomContainerDecoration.gradientbuttondecoration(),

                                      child: ElevatedButton(
                                          onPressed: paymentMethodController.selectedPaymentMethod.value == -1?
                                          (){
                                           CustomcartLogoutDialog.show(
                                            context: context,
                                            title: 'Uh oh!',
                                             content:"Almost there! Choose your payment method to proceed! 🍜",
                                             onConfirm: () async {
                                             Navigator.pop(context);
                                             setState(() {
                                               paymentsheet=true;
                                             });
                                              addcartPaymentBottomSheet(context);
                                              },
                                             buttonname: 'Ok',
                                            );}:() async {
                                          if (tipformKey.currentState == null || !tipformKey.currentState!.validate()) {
                                         Get.snackbar(
                                         "Invalid Tip","The delivery tip entered is not valid. Please try again.",
                                          backgroundColor: Customcolors.DECORATION_ERROR_RED,
                                         titleText: const Text("Invalid Tip",style: CustomTextStyle.white12text,),
                                         messageText: const Text("The delivery tip entered is not valid. Please try again.",style: CustomTextStyle.white12text,),);
                                             return;
                                            }
                                            setState(() {
                                              isButtonLoading = true;
                                            });

                                            dynamic selectedPaymentMethod = paymentMethodController.selectedPaymentMethod.value;
                                            dynamic paymentMethodText;

                                            if (selectedPaymentMethod == 0 && foodcart.getbillfoodcart["data"]["totalFoodAmount"] <= 500) {
                                              paymentMethodText = 'OFFLINE'; // Cash On Delivery
                                            }
                                            else if (selectedPaymentMethod == 2) {
                                            paymentMethodText = 'WALLET'; // Wallet Payment
                                            }
                                            else {
                                              paymentMethodText =  'ONLINE'; // Online Payment
                                            }

                                            // String fullAddresss = "${addressType == 'Other' ? '${addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["instructions"].toString()}, ' : ''}${addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["landMark"].toString()} , ${addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["houseNo"].toString()} , ${addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["fullAddress"].toString()}.",

                                            List<Map<String, dynamic>>
                                                dropAddress = [
                                              {
                                                'name': username,
                                                "userType": "consumer",
                                                "houseNo":  mapaddres.localAddressData['houseNo'],
                                                "locality":mapaddres.localAddressData['locality'],
                                                "landMark":mapaddres.localAddressData['landMark'],
                                                "fullAddress":mapaddres.localAddressData[ 'fullAddress'],
                                                "street": mapaddres.localAddressData['street'],
                                                "city": mapaddres.localAddressData['city'],
                                                "district": mapaddres.localAddressData[ 'district'],
                                                "state": mapaddres.localAddressData['state'],
                                                "country": mapaddres.localAddressData['country'],
                                                "postalCode": mapaddres.localAddressData['postalCode'],
                                                "contactType": "myself",
                                                "paymentMethod": paymentMethodText,
                                                "contactPerson":instantdata.otherName != ''
                                                        ? instantdata.otherName
                                                        : username,

                                                "contactPersonNumber": instantdata.otherNumber !=''
                                                    ? instantdata.otherNumber
                                                    : mapaddres.localAddressData['contactPersonNumber'],
                                                "addressType": mapaddres.localAddressData['addressType'],
                                                "latitude":mapaddres.localAddressData['latitude'],
                                                "longitude":mapaddres.localAddressData['longitude'],
                                                "instructions":mapaddres.localAddressData["instructions"],
                                                "delivered": false,
                                              }
                                            ];

                                            if (dropAddress.isNotEmpty &&
                                                dropAddress[0]['latitude'] !=null &&
                                                dropAddress[0]['latitude'] !=0 &&
                                                dropAddress[0]['longitude'] !=null &&
                                                dropAddress[0]['longitude'] != 0 &&
                                                dropAddress[0] ['contactPerson'] != null &&
                                                dropAddress[0][ 'contactPersonNumber'] !=null &&
                                                dropAddress[0]['fullAddress'] !=null) {
                                              LatLng tttt = LatLng(
                                                  dropAddress[0]['latitude'],
                                                  dropAddress[0]['longitude']);

                                              print('Drop Location ..... $tttt');

                                              log.i(dropAddress[0]);
                                              if (coupon.isCouponApplied) {
                                                if (coupon.coupontype =="percentage") {
                                                  // Convert the percentage string to a double
                                                  double percentage = double.parse(coupon .couponamount.replaceAll("%", ""));
                                                  dynamic totalFoodAmount =foodcart.getbillfoodcart["data"]["totalFoodAmount"]; // Assume dynamic but numeric
                                                  dynamic totalAmount = foodcart.getbillfoodcart[ "data"]["totalAmount"];
                                                  totsamount = double.parse(
                                                      (totalAmount -((percentage / 100) *totalFoodAmount)) .toStringAsFixed(2));
                                                } else {
                                                  // Convert the coupon amount string to a double
                                                  double couponAmount =double.parse(coupon .couponamount.replaceAll("₹", ""));
                                                  dynamic totalAmount = foodcart  .getbillfoodcart["data"]["totalAmount"];
                                                  totsamount = double.parse( (totalAmount - couponAmount) .toStringAsFixed(2));
                                                }
                                              } else {
                                                totsamount =  0; // Default to 0 when no coupon is applied
                                              }

                                              dynamic totcsamount;
                                              if (coupon.isCouponApplied) {
                                                if (coupon.coupontype == "percentage") {
                                                  // Convert the percentage string to a double
                                                  double percentage = double.parse(coupon .couponamount .replaceAll("%", ""));

                                                  // Convert dynamic values to double
                                                  double totalFoodAmount = double.parse(foodcart.getbillfoodcart[ "data"]["totalFoodAmount"].toString());

                                                  // Calculate the final amount using dynamic values
                                                  double check =(percentage / 100) *totalFoodAmount;
                                                  totcsamount =  foodcart.getbillfoodcart[ "data"][ "totalFoodAmount"] - check;
                                                } else {
                                                  // Convert the coupon amount string to a double
                                                  double couponAmount = double.parse(coupon .couponamount .replaceAll("₹", ""));

                                                  // Convert dynamic value to double
                                                  double totalAmount = double.parse(foodcart .getbillfoodcart[ "data"][ "totalFoodAmount"] .toString());

                                                  // Calculate the amount after subtracting the coupon amount
                                                  totcsamount = totalAmount -   couponAmount;
                                                }
                                              } else {
                                                totcsamount =  0; // Default value
                                              }

                                              dynamic cou =   coupon.isCouponApplied
                                                      ? int.parse( coupon.couponamount)
                                                      : 0;
                                                double tipAmount = foodcart.selectedTipAmount.value.isNotEmpty
                                                ? double.parse(foodcart.selectedTipAmount.value): 0.0;

                                              if (coupon.isCouponApplied) {
                                                ordercreate
                                                    .createOrderList( 
                                                     orderCommision: 0,
                                                      // commision: productviewprovider.restaurantDetails["categoryList"]["foods"]["commission"],
                                                    cartIdList: cartIdList,
                                                        context: context,
                                                        isCouponApplied: true,
                                                        integration:  integration,
                                                        ordersDetails: orderDetailsListPay,
                                                        productCategoryid:  productCateId,
                                                        userid: UserId,
                                                        subAdminid: widget .restaurantid,
                                                        vendorAdminId:  foodcart.getfoodcart["data"]["restaurantDetails"]["parentAdminUserId"],
                                                        dropAddress:  dropAddress,
                                                        cartAmount: foodcart  .getbillfoodcart["data"]["totalAmount"],
                                                        couponid: coupon.couponId,
                                                        cartFoodamount:    totcsamount,
                                                        cartFoodAmountWithoutCoupon: foodcart .getbillfoodcart["data"]  ["totalFoodAmount"],
                                                        orderBasicamount: foodcart .getbillfoodcart["data"] ["totalFoodAmount"],
                                                        // finalamount: totsamount,
                                                        finalamount: totcsamount + foodcart.getbillfoodcart["data"] ["totalPackageCharges"] +
                                                            foodcart.getbillfoodcart["data"]["deliveryCharges"] +foodcart.getbillfoodcart["data"] ["platformFeeCharge"]+
                                                            foodcart.getbillfoodcart["data"]["totalGST"]+ tipAmount,
                                                        deliveryCharges: foodcart.getbillfoodcart["data"]["deliveryCharges"],
                                                        tax: foodcart.getbillfoodcart["data"]["totalGST"],
                                                        tips:tipAmount,
                                                        couponsamount: cou,
                                                        discountAmount: cou,
                                                        paymentMethod: paymentMethodText,
                                                        totalKms: resGlobalKM,
                                                        baseKm: resGlobalKM,
                                                        additionalInstructions: instantdata.delInstruction,
                                                        packagingcharge: foodcart.getbillfoodcart["data"]["totalPackageCharges"], platformFee: foodcart.getbillfoodcart["data"] ["platformFeeCharge"],
                                                          amountForDistanceForDeliveryman: foodcart.getbillfoodcart["data"]["foods"][0]["amountForDistanceForDeliveryman"],
                                                          otherCharges:  foodcart.getbillfoodcart["data"]["foods"][0]["otherCharges"],
                                                          )
                                                    .then((value) {
                                                  Future.delayed(const Duration(seconds: 3),
                                                    () {
                                                      setState(() {
                                                        isButtonLoading = false;
                                                      });
                                                    },
                                                  );
                                                });
                                              } else {
                                                ordercreate.createOrderList(
                                                  orderCommision: 0,
                                                  // commision: productviewprovider.restaurantDetails["categoryList"]["foods"]["commission"],
                                                    cartIdList: cartIdList,
                                                        context: context,
                                                        isCouponApplied: false,
                                                        integration: integration,
                                                        ordersDetails: orderDetailsListPay,
                                                        productCategoryid: productCateId,
                                                        userid: UserId,
                                                        subAdminid: widget.restaurantid,
                                                        vendorAdminId: foodcart.getfoodcart["data"] ["restaurantDetails"][  "parentAdminUserId"],
                                                        dropAddress:  dropAddress,
                                                        cartAmount: foodcart.getbillfoodcart["data"] ["totalAmount"],
                                                        cartFoodamount: foodcart.getbillfoodcart["data"] ["totalFoodAmount"],
                                                        cartFoodAmountWithoutCoupon: foodcart.getbillfoodcart["data"] ["totalFoodAmount"],
                                                        orderBasicamount: foodcart.getbillfoodcart["data"] ["totalFoodAmount"],
                                                        finalamount: foodcart.getbillfoodcart["data"]  ["totalAmount"]+ tipAmount,
                                                        deliveryCharges: foodcart.getbillfoodcart["data"]  ["deliveryCharges"],
                                                        tax: foodcart.getbillfoodcart["data"]["totalGST"],
                                                        tips:tipAmount,
                                                        couponsamount: 0,
                                                        discountAmount: 0,
                                                        paymentMethod: paymentMethodText,
                                                        totalKms: resGlobalKM,
                                                        baseKm: resGlobalKM,
                                                        additionalInstructions: instantdata.delInstruction,
                                                        packagingcharge: foodcart.getbillfoodcart["data"]["totalPackageCharges"],  platformFee: foodcart.getbillfoodcart["data"] ["platformFeeCharge"],
                                                          amountForDistanceForDeliveryman: foodcart.getbillfoodcart["data"]["foods"][0]["amountForDistanceForDeliveryman"],
                                                           otherCharges:  foodcart.getbillfoodcart["data"]["foods"][0]["otherCharges"],)
                                                    .then((value) {
                                                  Future.delayed( const Duration(seconds: 3),
                                                    () {
                                                      setState(() {
                                                        isButtonLoading = false;
                                                      });
                                                    },
                                                  );
                                                });
                                              }
                                            } else {
                                              // Show toast message
                                              AppUtils.showToast('Invalid address information');

                                              addcartAddressBottomSheet(context).then((value) {
                                                Future.delayed(const Duration(seconds: 0),
                                                  () {
                                                    double totalDistance =double.parse(foodcartprovider.totalDis.split(' ').first.toString());
                                                    setState(() {
                                                      foodcart.getbillfoodcartfood(km: totalDistance);
                                                    });
                                                  },
                                                );
                                              });
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.transparent,
                                            shadowColor: Colors.transparent,
                                            padding: const EdgeInsets.symmetric( vertical: 10),
                                            textStyle:const TextStyle(fontSize: 16),
                                          ),
                                          child:Column(
                                            children: [
                                              getFinalAmount(coupon, tipAmount),
                                            ],
                                          )
                                          ),
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
  String cleaned = foodcartprovider.totalDis.replaceAll(RegExp(r'[^0-9.]'), '');
  double totalDistance = double.tryParse(cleaned) ?? 0.0;

  // 3. Check if the distance is out of range
  bool isOutOfRange = totalDistance > configKm;

  // 4. Debug Logs
  print("configKm = $configKm");
  print("cleanedDistance = $cleaned");
  print("isOutOfRange = $isOutOfRange");
  print("mapaddres.addressType = ${mapaddres.addressType}");
  print("getaddressdetails != null = ${addresscontroller.getaddressdetails != null}");

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
                Icon(Icons.dangerous, color: Customcolors.DECORATION_ERROR_RED),
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
                  Get.off(const OrdersHistory());
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
  if (mapaddres.addressType != 'Current' && addresscontroller.getaddressdetails != null) {
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
        // bottomSheet: mapaddres.addressType != 'Current' &&
        //         addresscontroller.getaddressdetails != null
        //     ? const SizedBox()
        //     : AnimatedContainer(
        //         duration: const Duration(milliseconds: 500), // Duration for smooth animation
        //         curve: Curves.easeInOut,
        //         height:  MediaQuery.sizeOf(context).height / 3.7,
        //         width: MediaQuery.of(context).size.width,
        //         padding: const EdgeInsets.all(15),
        //         decoration: BoxDecoration(
        //           borderRadius: const BorderRadius.only(
        //               topLeft: Radius.circular(30),
        //               topRight: Radius.circular(30)),
        //           color: Colors.white,
        //           boxShadow: [
        //             BoxShadow(
        //               color: Colors.grey.withOpacity(0.2),
        //               offset: const Offset(4, 0),
        //               blurRadius: 3,
        //               spreadRadius: 2,
        //             ),
        //           ],
        //         ),
        //         child: Column(
        //           children: [
        //             const Row(
        //               children: [
        //                 Icon(CupertinoIcons.location, color: Colors.orange),
        //                 SizedBox(width: 10),
        //                 Expanded(
        //                   child: Text(
        //                     'Where would you like us to deliver this order?',
        //                     style: CustomTextStyle.splashpermissionTitle,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //             30.toHeight,
        //             CustomButton(
        //               onPressed: () {
        //                 addcartAddressBottomSheet(context).then((value) {
        //                   Future.delayed(
        //                     const Duration(seconds: 0),
        //                     () {
        //                       double totalDistance = double.parse(
        //                           foodcartprovider.totalDis.split(' ').first.toString());

        //                       setState(() {
        //                         foodcart.getbillfoodcartfood(km: totalDistance);
        //                       });
        //                     },
        //                   );
        //                 });
        //               },
        //               borderRadius: BorderRadius.circular(30),
        //               child: const Text('Add or Select address',
        //                   style: CustomTextStyle.fontWeight15),
        //             )
        //           ],
        //         ),
        //       ),
     
      ),
    );
  }

Text getFinalAmount(CouponController coupon, double tipAmount) {
  return Text(
    coupon.isCouponApplied
        ? "₹${coupon.coupontype == "percentage" ? (() {
            dynamic totcsamount;
            double percentage =double.parse(coupon.couponamount.replaceAll("%", ""));
            // Convert dynamic values to double
            double totalFoodAmount = double.parse(foodcart.getbillfoodcart["data"]["totalFoodAmount"].toString());
            // Calculate the final amount using dynamic values
            double check = (percentage / 100) * totalFoodAmount;

            totcsamount =foodcart.getbillfoodcart["data"]["totalFoodAmount"] - check;

            return (totcsamount +foodcart.getbillfoodcart["data"]["totalPackageCharges"] +
                    foodcart.getbillfoodcart["data"]["platformFeeCharge"] +
                    foodcart.getbillfoodcart["data"]["deliveryCharges"] +
                    foodcart.getbillfoodcart["data"]["totalGST"] +
                    tipAmount).roundToDouble().toStringAsFixed(2);
          })() : (() {
            dynamic totcsamount;
            double couponAmount =double.parse(coupon.couponamount.replaceAll("₹", ""));

            // Convert dynamic value to double
            double totalAmount = double.parse(foodcart.getbillfoodcart["data"]["totalFoodAmount"].toString());
            // Calculate the amount after subtracting the coupon amount
            totcsamount = totalAmount - couponAmount;

            return (totcsamount +tipAmount +foodcart.getbillfoodcart["data"]["totalPackageCharges"] +
                    foodcart.getbillfoodcart["data"]["platformFeeCharge"] +
                    foodcart.getbillfoodcart["data"]["deliveryCharges"] +
                    foodcart.getbillfoodcart["data"]["totalGST"]).roundToDouble().toStringAsFixed(2);})()} | Place order"
        : "₹${(foodcart.getbillfoodcart["data"]["totalAmount"] + tipAmount).roundToDouble().toStringAsFixed(2)} | Place order",
    style: CustomTextStyle.loginbuttontext,
  );
}


Obx itemDetails(ButtonController updateCount, CouponController coupon) {
  return Obx(() {
    if (foodcart.getfoodcartloading.isTrue) {
      return const Center(child: Foodcartshimmer());
    } else if (foodcart.getfoodcart == null || foodcart.getfoodcart["data"] == null) {
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
            const Text("Item Details", style: CustomTextStyle.boldblack12),
            5.toHeight,
            ListView.separated(
              shrinkWrap: true,
              itemCount: foodsList.length,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => 5.toHeight,
              itemBuilder: (BuildContext context, index) {
                int currentQuantity = quantities[index] ?? 0;
                var foodName = foodsList[index]["foodDetails"]["foodName"].toString();
                bool isCustomized = foodsList[index]["isCustomized"] == true;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: foodsList[index]["foodDetails"]["available"] == true &&
                          foodsList[index]["foodDetails"]["status"] == true
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    5.toHeight,
                                    Builder(
                                      builder: (context) {
                                        String foodType = foodsList[index]["foodDetails"]["foodType"] ?? '';
                                        String assetPath = getFoodTypeIcon(foodType: foodType);

                                        return assetPath.isNotEmpty
                                            ? Image.asset(assetPath, height: 15, width: 15)
                                            : const SizedBox.shrink();
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                                                foodid: foodsList[index]["foodId"],
                                                iscustomizable: true,
                                                foodtype: foodsList[index]["foodDetails"]["foodType"],
                                                resname: widget.restaurantname,
                                                resid: widget.restaurantid,
                                                onUpdated: () async {
                                                  refreshAfterCustomization();
                                                },
                                              ),
                                              Text(
                                                "₹${calculatePrice(index)}",
                                                style: CustomTextStyle.foodDescription,
                                              ),
                                            ],
                                          )
                                        : Text(
                                            "₹${calculatePrice(index)}",
                                            style: CustomTextStyle.foodDescription,
                                          ),
                                  ],
                                ),
                              ],
                            ),
                            CustomContainer(
                              // height: 20.h,
                              // width: 70.w,
                               height : 25.h, 
                                width  : 90.w, 
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

                                        updateCount.decrementItemCount(1);
                                        await updateItemCountSmart(index, currentQuantity - 1, context);
                                        load(ttlkm: resGlobalKM);
                                        _updateOrderDetails();
                                      } else if (currentQuantity == 1) {
                                        await updateItemCountSmart(index, 0, context).whenComplete(() {
                                          if (foodsList.isEmpty) {
                                            paymentMethodController.clearPaymentMethod();
                                            checkboxController.clearSelectedCheckboxText();
                                            foodcart.clearTipAmount();
                                            Get.off(() => const OrdersHistory(), transition: Transition.leftToRight);
                                            foodcart.clearCartItem(context: context);
                                            foodcart.getfoodcartfood(km: resGlobalKM);
                                            Provider.of<ButtonController>(context, listen: false).totalItemCountNotifier.value = 0;
                                            Provider.of<ButtonController>(context, listen: false).hideButton();
                                            coupon.removeCoupon();
                                          }
                                        });
                                      }

                                      if (coupon.isCouponApplied) {
                                        await foodcart.getbillfoodcartfood(km: resGlobalKM);
                                        if (foodcart.getbillfoodcart["data"]["totalFoodAmount"] <= coupon.aboveVal) {
                                          coupon.removeCoupon();
                                        } else {
                                          await foodcart.getbillfoodcartfood(km: resGlobalKM);
                                        }
                                      }
                                    },
                                    child: const Icon(Icons.remove, color: Customcolors.darkpurple, size: 15, weight: 20),
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
                                      updateCount.incrementItemCount(1);
                                      await updateItemCountSmart(index, currentQuantity + 1, context);
                                      _updateOrderDetails();
                                      load(ttlkm: resGlobalKM);
                                    },
                                    child: const Icon(Icons.add, color: Customcolors.darkpurple, size: 15, weight: 20),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Builder(
                                      builder: (context) {
                                        String foodType = foodsList[index]["foodDetails"]["foodType"]?.toString() ?? '';
                                        String assetPath = getFoodTypeIcon(foodType: foodType);
                                        return assetPath.isNotEmpty
                                            ? Image.asset(assetPath, height: 15, width: 15)
                                            : const SizedBox.shrink();
                                      },
                                    ),
                                    const SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                        width: 150,
                                          child: Text(
                                            foodName.capitalizeFirst.toString(),
                                            style: CustomTextStyle.carttblack,
                                            overflow: TextOverflow.clip,
                                          ),
                                        ),
                                        Text(
                                          "₹${calculatePrice(index)}",
                                          style: CustomTextStyle.foodDescription,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                UnavailableFoodItem(
                                  onTap: () async {
                                    await updateItemCountSmart(index, 0, forceDelete: true, context);
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
            foodcart.getfoodcart["data"]["restaurantDetails"]["activeStatus"] == "online" &&
                    foodcart.getfoodcart["data"]["restaurantDetails"]["status"] == true
                ? InkWell(
                    onTap: () {
                      Get.off(Foodviewscreen(
                        isFromDishScreeen: false,
                        totalDis: resGlobalKM,
                        restaurantId: widget.restaurantid,
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
        return  Addpaymentcartaddress(ispaymentsheet: true, maxAmount: codMaxAmount,);
      },
  ).then((value) {
     WidgetsBinding.instance.addPostFrameCallback((_) {
      paymentsheet = false; 
    });// Reset after closing the sheet
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
        builder: (context) => Addcartaddress(totalDis: resGlobalKM, restaurantId: widget.restaurantid,addresserror: addressError,appconfigkm: appconfigkm,),
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
      shape: const RoundedRectangleBorder( borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return const Additioninfo();
      },
    );
  }
}



 