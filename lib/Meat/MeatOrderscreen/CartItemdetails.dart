// ignore_for_file: must_be_immutable, avoid_print, file_names

import 'package:testing/Features/Foodmodule/getFoodCartProvider.dart';
import 'package:testing/Meat/Common/Addcartmeataddress.dart';
import 'package:testing/Meat/Common/AddmeatuserBottomsheet.dart';
import 'package:testing/Meat/Homepage/Meathomepage.dart';
import 'package:testing/Meat/MeatButtonFunctionalities/MeatAddproductController.dart/AddmeatController.dart';
import 'package:testing/Meat/MeatButtonFunctionalities/TotalitemcountButton.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatOrderController/MeatCouponcontroller.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatOrderController/MeatcreateOrdercontroller.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatPaymentBottomsheet.dart';
import 'package:testing/Meat/MeatOrderscreen/meatadditionalinfo.dart';
import 'package:testing/Meat/MeatRazorPayment/MeatRazorpayment.dart';
import 'package:testing/common/billDataClass.dart';
import 'package:testing/common/commonloadingWidget.dart';
import 'package:testing/utils/Buttons/CustomAlertDialoug.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customdisabledbutton.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/localvaluesmanagement.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Decorations/boxDecoration.dart';
import 'package:testing/utils/Shimmers/BillSummaryShimmer.dart';
import 'package:testing/utils/Toast/customtoastmessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class CartBillwidget extends StatefulWidget {
  dynamic shopid;
  bool isFromcartBillwidget;
  List<Map<String, dynamic>> orderDetailsListPay;
  MeatRazorpaymentIntegration integration;
  CartBillwidget({
    super.key,
    required this.shopid,
    required this.integration,
    required this.orderDetailsListPay,
    this.isFromcartBillwidget = false,
  });

  @override
  State<CartBillwidget> createState() => _CartBillwidgetState();
}

class _CartBillwidgetState extends State<CartBillwidget> {
  MeatAddcontroller meatcart = Get.put(MeatAddcontroller());
  MeatButtonController buttonController = MeatButtonController();
  MeatPaymentMethodController paymentMethodController = Get.put(MeatPaymentMethodController());
  MeatOrdercontroller createmeatorder = Get.put(MeatOrdercontroller());
  bool iscartloading = false;
  bool isButtonLoading = false;
  bool paymentsheet=false;
  Logger log = Logger();
  load({ttlkm}) async {
    if (iscartloading) {
      await Future.delayed(const Duration(seconds: 0));
      setState(() {
        iscartloading = false;
      });
      await meatcart.getbillmeatcartmeat(km: ttlkm);
    }
  }
 @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
       if (paymentsheet) {
      addcartPaymentBottomSheet(context);}
    });
  }

   showCustomPaymentDialog(BuildContext context) {
  CustomcartLogoutDialog.show(
    context: context,
    title: 'Your Payment Method Changed! ',
    content: "Cash on Delivery isn't available for orders above ₹500. Continue your fresh meat order and enjoy! 🥩",
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
  Widget build(BuildContext context) {
    final foodcartprovider = Provider.of<FoodCartProvider>(context);
    var instantdata = Provider.of<MeatInstantUpdateProvider>(context);
    var mapaddres = Provider.of<MapDataProvider>(context);
    var coupon = Provider.of<MeatCouponController>(context);
    String coupountext() {
      if (coupon.coupontype == "percentage") {
        return "${coupon.couponamount}%";
      } else if (coupon.coupontype == "subtraction") {
        return "₹${coupon.couponamount}";
      } else {
        return "0.0"; // Return a default value if no valid coupon type
      }
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GetBuilder<MeatAddcontroller>(
          builder: (meatcart) {
            if (meatcart.getbillmeatcartloading.isTrue) {
              return const Center(child: Billshimmer());
            } else if (iscartloading) {
              return const Center(child: Billshimmer());
            } else if (meatcart.getbillmeatcart == null) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (meatcart.getbillmeatcart["data"].isEmpty) {
              return const Center(child: Text("No orders Available!"));
            } else {
              return BillSummaryWidget(
                basePrice:"₹${meatcart.getbillmeatcart["data"]["totalMeatAmount"].toStringAsFixed(2)}",
                gstAndOtherCharges:"₹${meatcart.getbillmeatcart["data"]["totalGST"].toStringAsFixed(2)}",
                packagingCharge:"₹${meatcart.getbillmeatcart["data"]["totalPackageCharges"].toStringAsFixed(2)}",
                couponDiscount: coupountext() != '0.0'
                    ? "-${coupountext()}"
                    : coupountext(),
                delivaryCharge:"₹${meatcart.getbillmeatcart["data"]["deliveryCharges"].toStringAsFixed(2)}",
                totalKm: foodcartprovider.totalDis,
                grandTotal: coupon.isCouponApplied
                    ? "₹${coupon.coupontype == "percentage" ? (() {
                        dynamic totcsamount;
                        double percentage = double.parse(coupon.couponamount.replaceAll("%", ""));
                        // Convert dynamic values to double
                        double totalMeatAmount = double.parse(meatcart.getbillmeatcart["data"]["totalMeatAmount"].toString());
                        // Calculate the final amount using dynamic values
                        double check = (percentage / 100) * totalMeatAmount;

                        totcsamount = meatcart.getbillmeatcart["data"]["totalMeatAmount"] -check;

                        return (totcsamount +meatcart.getbillmeatcart["data"]["totalPackageCharges"] +
                                meatcart.getbillmeatcart["data"]["deliveryCharges"] +
                                meatcart.getbillmeatcart["data"]["totalGST"])
                            .toStringAsFixed(2); })() : (() {
                        dynamic totcsamount;
                        double couponAmount = double.parse( coupon.couponamount.replaceAll("₹", ""));

                        // Convert dynamic value to double
                        double totalAmount = double.parse(meatcart.getbillmeatcart["data"]["totalMeatAmount"].toString());
                        // Calculate the amount after subtracting the coupon amount
                        totcsamount = totalAmount - couponAmount;

                        return (totcsamount +
                                meatcart.getbillmeatcart["data"]["totalPackageCharges"] +
                                meatcart.getbillmeatcart["data"]["deliveryCharges"] +
                                meatcart.getbillmeatcart["data"]["totalGST"])
                            .toStringAsFixed(2);
                      })()}"
                    : "₹${meatcart.getbillmeatcart["data"]["totalAmount"].toStringAsFixed(2)}",
              );
            }
          },
        ),
        10.toHeight,
        MeatAddDeliveryInstructions(
            onTapp: () => additionalinfoBottomSheet(context)),
        10.toHeight,
        OrderingforsomeoneContentBoxes(
          ontap: () {addusercartaddressBottomSheet(context);},
        ),
        10.toHeight,
         Container(
      decoration: BoxDecorationsFun.whiteCircelRadiusDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Pay using', style: CustomTextStyle.addressfeildtext),
                10.toHeight,
                Obx(() {
                  String paymentMethodText;
               int selectedPaymentMethod = paymentMethodController.selectedPaymentMethod.value;
                  if (meatcart.getbillmeatcartloading.isTrue) {
                    return const Text(
                      "Loading....",
                      style: CustomTextStyle.adresssubtext,
                    );
                  }
                  else if(iscartloading){
                     return const Text(
                      "Loading....",
                       style: CustomTextStyle.adresssubtext,
                      );
                  } else if (selectedPaymentMethod == 0 && meatcart.getbillmeatcart["data"]["totalMeatAmount"] > 500) {
    // Change payment method to Online Payment
     WidgetsBinding.instance.addPostFrameCallback((_) {
    paymentsheet=true;
    paymentMethodController.selectedPaymentMethod.value = 1; // 1 represents Online Payment
    showCustomPaymentDialog(context);});
  }
                  paymentMethodText = selectedPaymentMethod == -1
                                   ? "Select Your PaymentMethod"
                                   : (selectedPaymentMethod == 0
                                   ? "Cash on Delivery"
                                   : "Online Payment");
                  return Text(paymentMethodText,
                      style: CustomTextStyle.adresssubtext);
                }),
              ],
            ),
            InkWell(
               onTap: () {
                                 WidgetsBinding.instance.addPostFrameCallback((_) {
                                paymentsheet = true; // Set true when tapped
                                });
                                  addcartPaymentBottomSheet(context);
                                },
              child: const Row(
                children: [
                  Text(
                    "Change",
                    style: TextStyle(
                      color: Customcolors.darkpurple,
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
  
        // SelectPaymentOption(
        // paymentsheet: true,
        // ontap: () {
        //   WidgetsBinding.instance.addPostFrameCallback((_) {
        //   paymentsheet = true; // Set true when tapped
        //  });
        //   addcartPaymentBottomSheet(context);
        // }, showCustomPaymentDialog:  showCustomPaymentDialog(context) ),
         14.toHeight,
         const Text("CANCELLATION POLICY",style: CustomTextStyle.chipgreybold,),
          5.toHeight,
         const Text("Ensure the freshness of your meat by confirming your order. Payments are non-refundable.",
         style: CustomTextStyle.cartminigrey,),10.toHeight,
        if (widget.isFromcartBillwidget)
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: CustomContainerDecoration.greybuttondecoration(),
              child: ElevatedButton(
                onPressed: () {
                  CustomcartLogoutDialog.show(
                    context: context,
                    title: 'Meat Not Available',
                    content:"Added meat item isn't available at this time. Please check back later or choose a different shop.",
                    onConfirm: () async {
                      meatcart.clearmeatCartItem(context: context);
                      meatcart.getmeatcartmeat(km: resGlobalKM);
                      buttonController.totalItemCountNotifier.value = 0;
                      Provider.of<MeatButtonController>(context, listen: false).hidemeatButton();
                      Get.off(() => Meathomepage( meatproductcategoryid: meatproductCateId,),transition: Transition.leftToRight);
                    },
                    buttonname: 'Replace',
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: Obx(() {
                  if (meatcart.getbillmeatcartloading.isTrue || iscartloading) {
                    return const Center(
                      child: CupertinoActivityIndicator(color: Colors.white),
                    );
                  } else if (meatcart.getbillmeatcart == null) {
                    return const CircularProgressIndicator();
                  } else if (meatcart.getbillmeatcart["data"].isEmpty) {
                    return const Center(
                      child: Text("No orders Available!"),
                    );
                  } else {
                    dynamic totcsamount = 0;

                    if (coupon.isCouponApplied) {
                      if (coupon.coupontype == "percentage") {
                        double percentage = double.parse(coupon.couponamount.replaceAll("%", ""));
                        double totalMeatAmount = double.parse(meatcart.getbillmeatcart["data"]["totalMeatAmount"].toString(),
                        );
                        double discount = (percentage / 100) * totalMeatAmount;
                        totcsamount = totalMeatAmount - discount;
                      } else {
                        double couponAmount = double.parse(coupon.couponamount.replaceAll("₹", ""));
                        double totalAmount = double.parse(meatcart.getbillmeatcart["data"]["totalMeatAmount"].toString(),
                        );
                        totcsamount = totalAmount - couponAmount;
                      }
                    }

                    return Column(
                      children: [
                        if (coupon.isCouponApplied)
                          Text(
                            "₹${(totcsamount + meatcart.getbillmeatcart["data"]["totalPackageCharges"] + meatcart.getbillmeatcart["data"]["deliveryCharges"] + meatcart.getbillmeatcart["data"]["totalGST"]).toStringAsFixed(2)} | Place order",
                            style: CustomTextStyle.loginbuttontext,
                          )
                        else
                          Text(
                            "₹${meatcart.getbillmeatcart["data"]["totalAmount"].toStringAsFixed(2)} | Place order",
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
            if (meatcart.getbillmeatcartloading.isTrue) {
              return ReusableLoadingDummyButton(heighht: 50);
            } else if (iscartloading) {
              return ReusableLoadingDummyButton(heighht: 50);
            } else if (meatcart.getbillmeatcart == null) {
              return const CupertinoActivityIndicator();
            } else if (meatcart.getbillmeatcart["data"].isEmpty) {
              return const Center(child: Text("No orders Available!"));
            } else {
              dynamic totsamount;

              if (coupon.isCouponApplied) {
                if (coupon.coupontype == "percentage") {
                  double percentage =double.parse(coupon.couponamount.replaceAll("%", ""));
                  dynamic totalMeatAmount = meatcart.getbillmeatcart["data"]["totalMeatAmount"];
                  dynamic totalAmount =meatcart.getbillmeatcart["data"]["totalAmount"];
                  totsamount = double.parse((totalAmount - ((percentage / 100) * totalMeatAmount)).toStringAsFixed(2));
                } else {
                  double couponAmount =double.parse(coupon.couponamount.replaceAll("₹", ""));
                  dynamic totalAmount = meatcart.getbillmeatcart["data"]["totalAmount"];
                  totsamount = double.parse((totalAmount - couponAmount).toStringAsFixed(2));
                }
              } else {
                totsamount = 0;
              }

              return isButtonLoading
                  ? Center(
                      child: CustomdisabledButton(
                        onPressed: () {},
                        borderRadius: BorderRadius.circular(30),
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: const Text('Order Processing..',style: CustomTextStyle.loginbuttontext),
                      ),
                    )
                  : Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: CustomContainerDecoration
                            .gradientbuttondecoration(),
                        child: ElevatedButton(
                            onPressed:paymentMethodController.selectedPaymentMethod.value == -1?
                                          (){
                                           CustomcartLogoutDialog.show(
                                            context: context,
                                            title: 'Uh oh!',
                                             content:"Almost there! Choose your payment method to proceed! 🍖",
                                             onConfirm: () async {
                                             Navigator.pop(context);
                                             setState(() {
                                               paymentsheet=true;
                                             });
                                              addcartPaymentBottomSheet(context);
                                              },
                                             buttonname: 'Ok',
                                            );}: () async {
                              setState(() {
                                isButtonLoading = true;
                              });

                              dynamic selectedPaymentMethod =paymentMethodController.selectedPaymentMethod.value;
                              dynamic paymentMethodText;

                              if (selectedPaymentMethod == 0 &&
                                meatcart.getbillmeatcart["data"]["totalMeatAmount"] <= 500) {
                                paymentMethodText ='OFFLINE'; // Cash On Delivery
                              } else {
                                paymentMethodText = 'ONLINE'; // Online Payment
                              }

                              List<Map<String, dynamic>> dropAddress = [
                                {
                                  'name': username,
                                  "userType": "consumer",
                                  "houseNo": mapaddres.localAddressData['houseNo'],
                                  "locality":mapaddres.localAddressData['locality'],
                                  "landMark":mapaddres.localAddressData['landMark'],
                                  "fullAddress": mapaddres.localAddressData['fullAddress'],
                                  "street":mapaddres.localAddressData['street'],
                                  "city": mapaddres.localAddressData['city'],
                                  "district":mapaddres.localAddressData['district'],
                                  "state": mapaddres.localAddressData['state'],
                                  "country":mapaddres.localAddressData['country'],
                                  "postalCode":mapaddres.localAddressData['postalCode'],
                                  "contactType": "myself",
                                  "paymentMethod": paymentMethodText,
                                  "contactPerson": instantdata.otherName != ''
                                      ? instantdata.otherName
                                      : username,
                                  "contactPersonNumber":
                                      instantdata.otherNumber != ''
                                          ? instantdata.otherNumber
                                          : mapaddres.localAddressData['contactPersonNumber'],
                                  "addressType":mapaddres.localAddressData['addressType'],
                                  "latitude":mapaddres.localAddressData['latitude'],
                                  "longitude":mapaddres.localAddressData['longitude'],
                                  "delivered": false,
                                }
                              ];

                              if (dropAddress.isNotEmpty &&
                                  dropAddress[0]['latitude'] != null &&
                                  dropAddress[0]['latitude'] != 0 &&
                                  dropAddress[0]['longitude'] != null &&
                                  dropAddress[0]['longitude'] != 0 &&
                                  dropAddress[0]['contactPerson'] != null &&
                                  dropAddress[0]['contactPersonNumber'] !=null &&
                                  dropAddress[0]['fullAddress'] != null) {
                                LatLng dropLocation = LatLng(
                                    dropAddress[0]['latitude'],
                                    dropAddress[0]['longitude']);
                                print('Drop Location ..... $dropLocation');
                                log.i(dropAddress[0]);
                                if (coupon.isCouponApplied) {
                                  if (coupon.coupontype == "percentage") {
                                    // Convert the percentage string to a double
                                    double percentage = double.parse(coupon.couponamount.replaceAll("%", ""),);
                                    dynamic totalMeatAmount =meatcart.getbillmeatcart["data"]["totalMeatAmount"];
                                    dynamic totalAmount = meatcart.getbillmeatcart["data"]["totalAmount"];
                                    totsamount = double.parse(
                                      (totalAmount -((percentage / 100) *totalMeatAmount)).toStringAsFixed(2),
                                    );
                                  } else {
                                    double couponAmount = double.parse(coupon.couponamount.replaceAll("₹", ""),
                                    );
                                    dynamic totalAmount = meatcart.getbillmeatcart["data"]["totalAmount"];
                                    totsamount = double.parse((totalAmount - couponAmount).toStringAsFixed(2));
                                  }
                                } else {
                                  totsamount =
                                      0; // Default to 0 when no coupon is applied
                                }
                                dynamic totcsamount;
                                if (coupon.isCouponApplied) {
                                  if (coupon.coupontype == "percentage") {
                                    double percentage = double.parse(coupon.couponamount.replaceAll("%", ""),
                                    );
                                    double totalMeatAmount = double.parse(
                                      meatcart.getbillmeatcart["data"]["totalMeatAmount"].toString(),
                                    );
                                    double check =
                                        (percentage / 100) * totalMeatAmount;
                                    totcsamount = meatcart.getbillmeatcart["data"]["totalMeatAmount"] - check;
                                  } else {
                                    double couponAmount = double.parse(coupon.couponamount.replaceAll("₹", ""));
                                    double totalAmount = double.parse(meatcart.getbillmeatcart["data"]["totalMeatAmount"].toString());
                                    totcsamount = totalAmount - couponAmount;
                                  }
                                } else {
                                  totcsamount = 0;
                                }
                                dynamic cou = coupon.isCouponApplied
                                    ? int.parse(coupon.couponamount)
                                    : 0;
                                if (coupon.isCouponApplied) {
                                  createmeatorder.createOrderList(
                                    context: context,
                                    isCouponApplied: true,
                                    integration:widget.integration,
                                    ordersDetails: widget.orderDetailsListPay,
                                    productCategoryid: meatproductCateId,
                                    userid: UserId,
                                    subAdminid: widget.shopid,
                                    vendorAdminId: meatcart.getbillmeatcart["data"]["subAdminDetails"]["parentAdminUserId"],
                                    dropAddress: dropAddress,
                                    cartAmount: meatcart.getbillmeatcart["data"]["totalAmount"],
                                    couponid: coupon.couponId,
                                    cartFoodamount: totcsamount,
                                    cartFoodAmountWithoutCoupon: meatcart.getbillmeatcart["data"]["totalMeatAmount"],
                                    orderBasicamount:meatcart.getbillmeatcart["data"] ["totalMeatAmount"],
                                    finalamount: totcsamount +meatcart.getbillmeatcart["data"] ["totalPackageCharges"] +
                                    meatcart.getbillmeatcart["data"]["deliveryCharges"] +meatcart.getbillmeatcart["data"]["totalGST"],
                                    deliveryCharges:meatcart.getbillmeatcart["data"]["deliveryCharges"],
                                    tax: meatcart.getbillmeatcart["data"]["totalGST"],
                                    couponsamount: cou,
                                    discountAmount: cou,
                                    paymentMethod: paymentMethodText,
                                    totalKms: resGlobalKM,
                                    baseKm: resGlobalKM,
                                    additionalInstructions:instantdata.meatdelInstruction,
                                    packagingcharge:meatcart.getbillmeatcart["data"]["totalPackageCharges"],
                                  )
                                      .then((value) {
                                    Future.delayed(const Duration(seconds: 3), () {
                                      setState(() {
                                        isButtonLoading = false;
                                      });
                                    });
                                  });
                                } else {
                                  createmeatorder
                                      .createOrderList(
                                    context: context,
                                    isCouponApplied: false,
                                    integration: widget.integration,
                                    ordersDetails: widget.orderDetailsListPay,
                                    productCategoryid: meatproductCateId,
                                    userid: UserId,
                                    subAdminid: widget.shopid,
                                    vendorAdminId:meatcart.getbillmeatcart["data"]["subAdminDetails"]["parentAdminUserId"],
                                    dropAddress: dropAddress,
                                    cartAmount: meatcart.getbillmeatcart["data"]["totalAmount"],
                                    cartFoodamount:meatcart.getbillmeatcart["data"]["totalMeatAmount"],
                                    cartFoodAmountWithoutCoupon:meatcart.getbillmeatcart["data"]["totalMeatAmount"],
                                    orderBasicamount:meatcart.getbillmeatcart["data"]["totalMeatAmount"],
                                    finalamount: meatcart.getbillmeatcart["data"]["totalAmount"],
                                    deliveryCharges:meatcart.getbillmeatcart["data"]["deliveryCharges"],
                                    tax: meatcart.getbillmeatcart["data"]["totalGST"],
                                    couponsamount: 0,
                                    discountAmount: 0,
                                    paymentMethod: paymentMethodText,
                                    totalKms: resGlobalKM,
                                    baseKm: resGlobalKM,
                                    additionalInstructions:instantdata.meatdelInstruction,
                                    packagingcharge:meatcart.getbillmeatcart["data"]["totalPackageCharges"],
                                  )
                                      .then((value) {
                                    Future.delayed(const Duration(seconds: 3), () {
                                      setState(() {
                                        isButtonLoading = false;
                                      });
                                    });
                                  });
                                }
                              } else {
                                AppUtils.showToast('Invalid address information');
                                addcartAddressBottomSheet(context).then((value) {
                                  Future.delayed(const Duration(seconds: 0), () {
                                    double totalDistance = double.parse(foodcartprovider.totalDis.split(' ').first.toString());
                                    setState(() {
                                      meatcart.getbillmeatcartmeat(km: totalDistance);
                                    });
                                  });
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              textStyle: const TextStyle(fontSize: 16),
                            ),
                            child: Column(
                              children: [
                                if (coupon.isCouponApplied) ...[
                                  Text(
                                      "₹${totsamount..toStringAsFixed(2)} | Place order",
                                      style: CustomTextStyle.loginbuttontext),
                                ] else ...[
                                  Text(
                                    "₹${meatcart.getbillmeatcart["data"]["totalAmount"].toStringAsFixed(2)} | Place order",
                                    style: CustomTextStyle.loginbuttontext,
                                  ),
                                ],
                              ],
                            )),
                      ),
                    );
            }
          }),
        const SizedBox(height: 7),
      ],
    );
  }

Future<dynamic> addusercartaddressBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Customcolors.DECORATION_WHITE,
      showDragHandle: true,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return const AddmeatuserBottomsheet();
      },
    );
  }


  Future<dynamic> additionalinfoBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Customcolors.DECORATION_WHITE,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return const MeatAdditioninfo();
      },
    );
  }

  Future<dynamic> addcartAddressBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) =>
            Addmeataddress(totalDis: resGlobalKM, shopid: widget.shopid),
        isDismissible: true,
        showDragHandle: true,
        enableDrag: true);
  }

  Future<dynamic> addcartPaymentBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Customcolors.DECORATION_WHITE,
      showDragHandle: true,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return  MeatAddpaymentcartaddress(ispaymentsheet: true);
      },
  ).then((value) {
     WidgetsBinding.instance.addPostFrameCallback((_) {
      paymentsheet = false; 
    });// Reset after closing the sheet
  });
}}
