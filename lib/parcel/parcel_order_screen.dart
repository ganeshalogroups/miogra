// ignore_for_file: avoid_print

import 'package:dotted_line/dotted_line.dart';
import 'package:testing/Features/Bottomsheets/Additionalinfo.dart';
import 'package:testing/Features/Bottomsheets/Adduserbottomsheet.dart';
import 'package:testing/Features/Bottomsheets/Deliverytips.dart';
import 'package:testing/Features/Bottomsheets/parceldeliverytip.dart';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Addfoodcontroller.dart';
import 'package:testing/Features/coupon/couponController.dart';
import 'package:testing/PaymentGateway/parcel_Razorpay.dart';
import 'package:testing/common/cartscreenWidgets.dart';
import 'package:testing/common/commonTextWidgets.dart';
import 'package:testing/map_provider/Map%20Screens/markervaluse.dart';
import 'package:testing/parcel/model/create_order_model.dart';
import 'package:testing/parcel/p_services_provider/imagePickerProvider.dart';
import 'package:testing/parcel/p_services_provider/p_createParcel_Provider.dart';
import 'package:testing/parcel/p_services_provider/p_distance_provider.dart';
import 'package:testing/parcel/p_services_provider/p_order_controller.dart';
import 'package:testing/parcel/parcel_controllers/addpaymentMethodSheet.dart';
import 'package:testing/utils/Buttons/CustomAlertDialoug.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/commonPlaceOrderButton.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/CustomDottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'p_services_provider/p_address_provider.dart';
import 'parcel_coupon_screen.dart';

// ignore: must_be_immutable
class ParcelOrderScreen extends StatefulWidget {
  bool isFromSingleTrip;
  bool isfromMultiTrip;

  ParcelOrderScreen(
      {super.key, this.isFromSingleTrip = false, this.isfromMultiTrip = false});
  @override
  State<ParcelOrderScreen> createState() => _ParcelOrderScreenState();
}

class _ParcelOrderScreenState extends State<ParcelOrderScreen> {
  PaymentMethodOptions paymentoption = Get.put(PaymentMethodOptions());
  final ParcelRazorpaymentIntegration integration =
      ParcelRazorpaymentIntegration();
  ParcelOrdercontroller parcelOrderController =
      Get.put(ParcelOrdercontroller());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  PaymentMethodOptions paymentMethodOptions = Get.put(PaymentMethodOptions());
  bool paymentsheet = false;
  //Foodcartcontroller foodcart = Get.put(Foodcartcontroller());
  //Foodcartcontroller foodcart = Get.find<Foodcartcontroller>();

  // double tipAmount = 0.0;
//                       foodcart.parcelselectedTipAmount.value.isNotEmpty
//                           ? double.parse(foodcart.parcelselectedTipAmount.value)
//                           : 0.0;

  // Foodcartcontroller foodcart = Get.put(Foodcartcontroller());
// PaymentMethodOptions

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final distanceCal =
          Provider.of<CommonDistanceGetClass>(context, listen: false);

      if (widget.isfromMultiTrip) {
        Provider.of<CreatePArcelProvider>(context, listen: false)
            .getParcelCart(km: distanceCal.finaldistance * 2);
      } else {
        Provider.of<CreatePArcelProvider>(context, listen: false)
            .getParcelCart(km: distanceCal.finaldistance);
      }

      integration.initiateRazorPay();
      //    ever<String>(foodcart.parcelselectedTipAmount, (value) {
      //   setState(() {
      //     tipAmount = value.isNotEmpty ? double.tryParse(value) ?? 0.0 : 0.0;
      //   });
      // });
    });
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    var cartApiData = Provider.of<CreatePArcelProvider>(context, listen: false);
    var coupon = Provider.of<CouponController>(context);
    final picdropProvider = Provider.of<ParcelAddressProvider>(context);
    final packagecontentdata = Provider.of<CreatePArcelProvider>(context);
    final distanceCal =
        Provider.of<CommonDistanceGetClass>(context, listen: false);
    var instantdata = Provider.of<InstantUpdateProvider>(context);

    String getFormattedText() {
      if (coupon.pcoupontype == "percentage") {
        return "Save ${coupon.pcouponamount}% more with FastX";
      } else if (coupon.pcoupontype == "subtraction") {
        return "Save ₹${coupon.pcouponamount} more with FastX";
      } else {
        return "Get Your Coupon";
      }
    }

    String coupountext() {
      if (coupon.pcoupontype == "percentage") {
        // Remove the '%' sign and return the numeric value
        return "${coupon.pcouponamount} %";
      } else if (coupon.pcoupontype == "subtraction") {
        // Remove the '₹' sign and return the numeric value
        return "₹ ${coupon.pcouponamount}";
      } else {
        return "0.0"; // Return a default value if no valid coupon type
      }
    }

    double couponValue() {
      if (coupon.pcoupontype == "percentage") {
        // Remove the '%' sign and return the numeric value
        return double.parse(coupon.pcouponamount.toString()).toDouble();
      } else if (coupon.pcoupontype == "subtraction") {
        // Remove the '₹' sign and return the numeric value
        return double.parse(coupon.pcouponamount.toString()).toDouble();
      } else {
        return 0.0; // Return a default value if no valid coupon type
      }
    }

    double tipAmount = Provider.of<TipsProvider>(context).tipamount.isNotEmpty
        ? double.parse(Provider.of<TipsProvider>(context).tipamount)
        : 0.0;
    return PopScope(
      onPopInvoked: (didPop) {
        Provider.of<CouponController>(context, listen: false)
            .parcelremoveCoupon();
      },
      child: Scaffold(
        appBar: AppBar(
            title: const Text('Order Summary', style: CustomTextStyle.profile),
            surfaceTintColor: Colors.white),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Consumer<CreatePArcelProvider>(
              builder: (context, value, child) {
                if (value.isLoading) {
                  return const Center(
                      child: const CupertinoActivityIndicator());
                } else if (value.getCartModel == null ||
                    value.getCartModel.isEmpty) {
                  return const Center(child: Text('No DAta Available'));
                } else {
                  print(value.getCartModel);
                  //  GetBuilder<Foodcartcontroller>(
                  //   builder: (foodcart) {

                  // double tipAmount =
                  //     foodcart.parcelselectedTipAmount.value.isNotEmpty
                  //         ? double.parse(foodcart.parcelselectedTipAmount.value)
                  //         : 0.0;

                  // });

                  var addressType =
                      value.getCartModel['pickupDetails'][0]['addressType'];
                  var fullAddress =
                      value.getCartModel['pickupDetails'][0]['fullAddress'];
                  var phonenumer = value.getCartModel['pickupDetails'][0]
                      ['contactPersonNumber'];

                  var daddressType =
                      value.getCartModel['dropDetails'][0]['addressType'];
                  var dfullAddress =
                      value.getCartModel['dropDetails'][0]['fullAddress'];
                  var dphonenumer = value.getCartModel['dropDetails'][0]
                      ['contactPersonNumber'];

                  var pachagename = value.getCartModel['packageType'];
                  var packageType = value.getCartModel['unit'];
                  var packageWeight = value.getCartModel['value'];

                  var deliverycharges = value.getCartModel['deliveryCharges'];
                  var gstValue = value.getCartModel['totalGST'];
                  var totalAmount = value.getCartModel['totalAmount'];
                  var baseprice = value.getCartModel['basePrice'];

                  var othersType = value.getCartModel['otherType'];
                  var packageImage = value.getCartModel['packageImage'];
                  double finalAmount =
                      double.parse(totalAmount.toString()) + tipAmount;
                  var platformCharge = value.getCartModel['platformFeeCharge'];
                  return Column(
                    children: [
                      Container(
                        // color: Colors.amber,
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white),
                        child: Column(
                          children: [
                            15.toHeight,
                            EditIconRowWidget(
                                addresstype: 'Pickup Location', ontap: () {}),
                            10.toHeight,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                    addressType == 'Home'
                                        ? homeicon
                                        : addressType == 'Other'
                                            ? othersicon
                                            : workicon,
                                    height: 20,
                                    width: 20),
                                8.toWidth,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(addressType,
                                        style: CustomTextStyle.blackbold14),
                                    5.toHeight,
                                    SizedBox(
                                      width: 280.w,
                                      child: Text(
                                        fullAddress,
                                        style: CustomTextStyle.darkgrey12,
                                      ),
                                    ),
                                    5.toHeight,
                                    Text('+91 $phonenumer',
                                        style: CustomTextStyle.darkgrey12),
                                  ],
                                ),
                              ],
                            ),
                            20.toHeight,
                            CustomPaint(
                              size: Size(MediaQuery.of(context).size.width / 1,
                                  20), // Adjust size here
                              painter: DottedLinePainter(),
                            ),
                            EditIconRowWidget(
                                addresstype: 'Drop Location', ontap: () {}),
                            10.toHeight,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                    daddressType == 'Home'
                                        ? homeicon
                                        : daddressType == 'Other'
                                            ? othersicon
                                            : workicon,
                                    height: 20,
                                    width: 20),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(daddressType,
                                        style: CustomTextStyle.blackbold14),
                                    // CustomSizedBox(height: 4.h),
                                    5.toHeight,

                                    SizedBox(
                                      width: 280.w,
                                      child: Text(
                                        dfullAddress,
                                        style: CustomTextStyle.darkgrey12,
                                      ),
                                    ),
                                    5.toHeight,
                                    Text('+91 $dphonenumer',
                                        style: CustomTextStyle.darkgrey12),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      20.toHeight,

                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white),
                        width: MediaQuery.of(context).size.width / 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Package Details',
                                style: CustomTextStyle.seemore10),
                            15.toHeight,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Package Type',
                                    style: CustomTextStyle.blackbold14),
                                Text('$pachagename',
                                    style: CustomTextStyle.blackbold14)
                              ],
                            ),
                            10.toHeight,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Package Weight',
                                    style: CustomTextStyle.blackbold14),
                                Text('$packageWeight $packageType',
                                    style: CustomTextStyle.blackbold14)
                              ],
                            ),
                            10.toHeight,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Total Distance',
                                    style: CustomTextStyle.blackbold14),
                                widget.isfromMultiTrip
                                    ? Text(
                                        '${(distanceCal.finaldistance * 2).toInt()} km', // Ensures no decimal
                                        style: CustomTextStyle.blackbold14,
                                      )
                                    : Text(
                                        '${distanceCal.finaldistance.toInt()} km', // Ensures no decimal
                                        style: CustomTextStyle.blackbold14,
                                      )
                              ],
                            ),
                          ],
                        ),
                      ),

                      10.toHeight,

                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white),
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
                                        // "Save ₹${coupon.couponAmt} more with GET125",
                                        getFormattedText(),
                                        style: CustomTextStyle.boldblack12,
                                      ),
                                    ],
                                  ),

                                  const Spacer(flex: 1),

                                  coupon.pisCouponApplied
                                      ? InkWell(
                                          onTap: () {
                                            coupon.parcelremoveCoupon();
                                          },
                                          child: const Text(
                                            "Remove",
                                            style: CustomTextStyle
                                                .DECORATION_regulartext,
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            Get.to(
                                                ParcelCouponScreen(
                                                  isfromSingleTrip:
                                                      widget.isFromSingleTrip,
                                                  baseprice: totalAmount,
                                                  apply: applyCoupon,
                                                  isCouponApplied:
                                                      isCouponApplied,
                                                  remove: removeCoupon,
                                                ),
                                                transition: Transition.zoom);
                                          },
                                          child: const Text("Apply",
                                              style: CustomTextStyle
                                                  .DECORATION_regulartext)), //
                                ],
                              ),
                              8.toHeight,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2),
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
                                  dashGapColor: Colors.white,
                                  dashGapRadius: 5,
                                ),
                              ),
                              8.toHeight,
                              InkWell(
                                onTap: () {
                                  Get.to(
                                      ParcelCouponScreen(
                                        isfromSingleTrip:
                                            widget.isFromSingleTrip,
                                        baseprice: baseprice,
                                        apply: applyCoupon,
                                        isCouponApplied: isCouponApplied,
                                        remove: removeCoupon,
                                      ),
                                      transition: Transition.zoom);
                                },
                                child: ViewMoreTextArrow(
                                    content: "View more coupon"),
                              ),
                            ],
                          ),
                        ),
                      ),

                      20.toHeight,
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            10.toHeight,
                            const Text('Bill Summary',
                                style: CustomTextStyle.seemore10),
                            10.toHeight,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Base price',
                                  style: CustomTextStyle.blacktext,
                                ),
                                Text(
                                  '₹ ${baseprice.toString()}',
                                  style: CustomTextStyle.blacktext,
                                ),

                                // Text('${calculateDiscountedAmount(basePrice: baseprice.toDouble(),couponText: coupountext(),couponType: coupon.pcoupontype)}',style: CustomTextStyle.blacktext,),
                              ],
                            ),
                            10.toHeight,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                widget.isfromMultiTrip
                                    ? Text(
                                        'Delivery Charge (upto ${distanceCal.finaldistance * 2} km)',
                                        style: CustomTextStyle.blacktext,
                                      )
                                    : Text(
                                        'Delivery Charge (upto ${distanceCal.finaldistance} km)',
                                        style: CustomTextStyle.blacktext,
                                      ),
                                Text('₹ $deliverycharges',
                                    style: CustomTextStyle.blacktext),
                              ],
                            ),
                            10.toHeight,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'GST',
                                  style: CustomTextStyle.blacktext,
                                ),
                                Text(
                                  '₹ $gstValue',
                                  style: CustomTextStyle.blacktext,
                                ),
                              ],
                            ),
                            10.toHeight,
                            //       Obx(() {
                            //         double tipAmount =
                            //  foodcart.parcelselectedTipAmount.value.isNotEmpty
                            //      ? double.parse(foodcart.parcelselectedTipAmount.value)
                            //      : 0.0;
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Delivery Tip',
                                  style: CustomTextStyle.blacktext,
                                ),
                                Text(
                                  '₹ $tipAmount',
                                  style: CustomTextStyle.blacktext,
                                ),
                              ],
                            ),
                            //}
                            // ),
                            10.toHeight,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Platform Charge',
                                  style: CustomTextStyle.blacktext,
                                ),
                                Text(
                                  '₹ $platformCharge',
                                  style: CustomTextStyle.blacktext,
                                ),
                              ],
                            ),
                            10.toHeight,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('coupon Discount',
                                    style: CustomTextStyle.blacktext),

                                // Text('$gstValue',style: CustomTextStyle.blacktext,),
                                // Text('0',style: CustomTextStyle.blacktext,),

                                Text(
                                    coupountext() != '0.0'
                                        ? "- ${coupountext()}"
                                        : coupountext(),
                                    style: CustomTextStyle.decorationORANGEtext)
                              ],
                            ),
                            20.toHeight,
                            CustomPaint(
                              size: Size(MediaQuery.of(context).size.width / 1,
                                  20), // Adjust size here
                              painter: DottedLinePainter(),
                            ),
                            //       Obx(() {
                            //         double tipAmount =
                            //  foodcart.parcelselectedTipAmount.value.isNotEmpty
                            //      ? double.parse(foodcart.parcelselectedTipAmount.value)
                            //      : 0.0;
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Grand Total',
                                  style: CustomTextStyle.blacktext,
                                ),
                                if (coupon.pisCouponApplied) ...[
                                  Text(
                                    "₹${findeGrandTotalFunction(
                                      tips: tipAmount,
                                      basePrice: calculateDiscountedAmount(
                                          basePrice: baseprice.toDouble(),
                                          couponText: coupountext(),
                                          couponType: coupon.pcoupontype),
                                      deliveryChareg: deliverycharges,
                                      gst: gstValue,
                                    ).round()}",
                                    style: CustomTextStyle.blacktext,
                                  ),
                                ] else ...[
                                  Text('₹ ${finalAmount.round()}',
                                      style: CustomTextStyle.blacktext),
                                ]
                              ],
                            )
                            //  })
                          ],
                        ),
                      ),
                      10.toHeight,
                      AddDeliveryInstructions(
                          onTapp: () => aadditionalinfoBottomSheet(context)),
                      ParcelDriverTipSelector(
                        externalFormKey: _formKey,
                      ),

                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Pay using',
                                      style: CustomTextStyle.addressfeildtext),
                                  10.toHeight,
                                  // Obx(
                                  //   () => paymentoption
                                  //               .selectedPaymentMethod.value ==
                                  //           0
                                  //       ? const Text('Cash On Delivery',
                                  //           style:
                                  //               CustomTextStyle.adresssubtext)
                                  //       : const Text('Online Payment',
                                  //           style:
                                  //               CustomTextStyle.adresssubtext),
                                  // )

                                  Obx(() {
                                    String paymentMethodText;
                                    int selectedPaymentMethod =
                                        paymentMethodOptions
                                            .selectedPaymentMethod.value;

                                    paymentMethodText =
                                        selectedPaymentMethod == -1
                                            ? "Select Payment"
                                            : (selectedPaymentMethod == 0
                                                ? "Cash on Delivery"
                                                : (selectedPaymentMethod == 1
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
                                  addcartPaymentBottomSheet(context);
                                },
                                child: const Row(
                                  children: [
                                    Text(
                                      "Change",
                                      style: TextStyle(
                                        color:
                                      Customcolors.darkpurple,
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
                      ),

                      20.toHeight,

                      CommonPlaceOrderButton(
                          ontap: () {
                            if (paymentMethodOptions
                                    .selectedPaymentMethod.value ==
                                -1) {
                              //() {
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
                                  addcartPaymentBottomSheet(context);
                                },
                                buttonname: 'Ok',
                              );
                              //  };
                            } else {
                              if (coupon.pisCouponApplied) {
                                double totalkkm = widget.isfromMultiTrip
                                    ? distanceCal.finaldistance * 2
                                    : distanceCal.finaldistance;

                                print(
                                    'Yes Coupon Applied ..${coupon.pcouponTypee} - ${coupon.pcouponAmt} ');

                                // double discountAmountt = calculatePercentage(amount: baseprice.toDouble(), percentage:  double.parse(coupon.pcouponAmt).toDouble());

                                double discountAmountt = couponValue();

                                // double discountAmountt  = calculateDiscountedAmount(basePrice: baseprice.toDouble(),couponText: coupountext(),couponType: coupon.pcoupontype);

                                print('ed Bas assss $discountAmountt');

                                var coupontype = widget.isfromMultiTrip
                                    ? coupon.rTrippcouponTypee
                                    : coupon.pcouponTypee;

                                var amountdetails = AmountDetails(
                                  platformCharge: platformCharge,
                                  tips: tipAmount,
                                  cartFoodAmountWithoutCoupon: baseprice,
                                  deliveryCharges: deliverycharges,
                                  finalAmount: findeGrandTotalFunction(
                                          basePrice: calculateDiscountedAmount(
                                              basePrice: baseprice.toDouble(),
                                              couponText: coupountext(),
                                              couponType: coupon.pcoupontype),
                                          deliveryChareg: deliverycharges,
                                          gst: gstValue,
                                          tips: tipAmount)
                                      .round(),
                                  orderBasicAmount: calculateDiscountedAmount(
                                      basePrice: baseprice.toDouble(),
                                      couponText: coupountext(),
                                      couponType: coupon.pcoupontype),
                                  packingCharges: 0.0,
                                  tax: gstValue,
                                  couponsAmount: discountAmountt,
                                  couponType: coupontype,
                                );
                                // couponType

                                var parcelDetailll = ParcelDetails(
                                    otherType: othersType ?? '',
                                    packageImage: packageImage,
                                    packageType: pachagename,
                                    parcelTripType: widget.isFromSingleTrip
                                        ? 'single'
                                        : 'round',
                                    unit: packageType,
                                    value: packageWeight);
                                print(
                                    '|||||||||||||||||||||||||||||||||||||||||||>>>>>>>>>>>>>>>>>>$platformCharge');

                                print(
                                    'Check...3 ${distanceCal.finaldistance} =- <| -=  ${distanceCal.finaldistance.runtimeType}');

                                OrderData createOrder = OrderData(
                                    platformCharge: platformCharge,
                                    // name: username,
                                    deliveryType: widget.isFromSingleTrip
                                        ? 'single'
                                        : 'round',
                                    shareUserIds: [UserId],
                                    productCategoryId: productCategoryId,
                                    userId: UserId,
                                    subAdminType: parcelservice,
                                    vendorAdminId: vendorIdforParcel,
                                    dropAddress: [
                                      value.getCartModel['dropDetails'].first
                                    ],
                                    pickupAddress: [
                                      value.getCartModel['pickupDetails'].first
                                    ],
                                    parcelDetails: parcelDetailll,
                                    type: 'mobile',
                                    amountDetails: amountdetails,
                                    // orderStatus   : paymentoption.selectedPaymentMethod.value == 0 ? 'initiated' : 'created',
                                    orderStatus: 'created',
                                    discountAmount: discountAmountt,
                                    totalKms: totalkkm.toString(),
                                    baseKm: totalkkm.toString(),
                                    additionalInstructions:
                                        instantdata.delInstruction,
                                    paymentMethod: paymentoption
                                                .selectedPaymentMethod.value ==
                                            0
                                        ? 'OFFLINE'
                                        : 'ONLINE');

                                Map<String, dynamic> ordeee =
                                    createOrder.toJson();

                                // print('-----=====${"₹${coupon.coupontype == "percentage" ? (totalAmount - ((double.parse(coupountext().replaceAll("%", "")) / 100) * totalAmount )).toStringAsFixed(2) : (totalAmount - double.parse(coupountext().replaceAll("₹", ""))).toStringAsFixed(2)}"}');
                                // loge.i(ordeee);

                                parcelOrderController.createOrderList(
                                    isFromSingleTrip: widget.isFromSingleTrip,
                                    orderdata: createOrder,
                                    integration: integration,
                                    isCouponApplied: isCouponApplied,
                                    context: context);
                              } else {
                                var coupontype = widget.isfromMultiTrip
                                    ? coupon.rTrippcouponTypee
                                    : coupon.pcouponTypee;

                                double totalkkm = widget.isfromMultiTrip
                                    ? distanceCal.finaldistance * 2
                                    : distanceCal.finaldistance;

                                print('Yes Coupon Not Applied  .. ');

                                var amountdetails = AmountDetails(
                                  platformCharge: platformCharge,
                                  tips: tipAmount,
                                  cartFoodAmountWithoutCoupon: baseprice,
                                  deliveryCharges: deliverycharges,
                                  finalAmount:
                                      (totalAmount + tipAmount).round(),
                                  //  finalAmount: finalAmount,
                                  orderBasicAmount: baseprice.toDouble(),
                                  packingCharges: 0.0,
                                  tax: gstValue,
                                  couponsAmount: 0,
                                  couponType: coupontype,
                                );

                                var parcelDetailll = ParcelDetails(
                                    otherType: othersType ?? '',
                                    packageImage: packageImage,
                                    packageType: pachagename,
                                    parcelTripType: widget.isFromSingleTrip
                                        ? 'single'
                                        : 'round',
                                    unit: packageType,
                                    value: packageWeight);

                                print(
                                    '|||||||||||||||||||||||||||||||||||||||||||>>>>>>>>>>>>>>>>>>$platformCharge');

                                print(
                                    'Check...3 ${distanceCal.finaldistance} =-  -  ${distanceCal.finaldistance.runtimeType}');

                                OrderData createOrder = OrderData(
                                    platformCharge: platformCharge,
                                    // name: username,
                                    deliveryType: widget.isFromSingleTrip
                                        ? 'single'
                                        : 'round',
                                    shareUserIds: [UserId],
                                    productCategoryId: productCategoryId,
                                    userId: UserId,
                                    subAdminType: parcelservice,
                                    vendorAdminId: vendorIdforParcel,
                                    dropAddress: [
                                      value.getCartModel['pickupDetails'].first
                                    ],
                                    pickupAddress: [
                                      value.getCartModel['dropDetails'].first
                                    ],
                                    parcelDetails: parcelDetailll,
                                    type: 'mobile',
                                    amountDetails: amountdetails,
                                    // orderStatus   : paymentoption.selectedPaymentMethod.value == 0 ? 'initiated' : 'created',
                                    orderStatus: 'created',
                                    discountAmount: 0,
                                    totalKms: totalkkm.toString(),
                                    baseKm: totalkkm.toString(),
                                    additionalInstructions:
                                        instantdata.delInstruction,
                                    paymentMethod: paymentoption
                                                .selectedPaymentMethod.value ==
                                            0
                                        ? 'OFFLINE'
                                        : 'ONLINE');

                                Map<String, dynamic> ordeee =
                                    createOrder.toJson();

                                print(
                                    '-----===== from Non Applied Coupon<<<==>>>  tt');
                                loge.i(ordeee);

                                parcelOrderController.createOrderList(
                                    isFromSingleTrip: widget.isFromSingleTrip,
                                    orderdata: createOrder,
                                    integration: integration,
                                    isCouponApplied: isCouponApplied,
                                    context: context);
                              }
                            }
                          },
                          totalamt: (coupon.pisCouponApplied)
                              ? findeGrandTotalFunction(
                                  tips: tipAmount,
                                  basePrice: calculateDiscountedAmount(
                                      basePrice: baseprice.toDouble(),
                                      couponText: coupountext(),
                                      couponType: coupon.pcoupontype),
                                  deliveryChareg: deliverycharges,
                                  gst: gstValue,
                                ).round()
                              : finalAmount.round()

                          // totalamt: findeGrandTotalFunction(
                          //     basePrice: calculateDiscountedAmount(
                          //         basePrice: baseprice.toDouble(),
                          //         couponText: coupountext(),
                          //         couponType: coupon.pcoupontype),
                          //     deliveryChareg: deliverycharges,
                          //     gst: gstValue,
                          //     tips: tipAmount)
                          ),

                      20.toHeight,

                      // couponCard(),

                      30.toHeight,
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
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

  double calculateDiscountedAmount(
      {required String couponType,
      required double basePrice,
      required String couponText}) {
    if (couponType == "percentage") {
      double discountPercentage = double.parse(couponText.replaceAll("%", ""));
      return basePrice - ((discountPercentage / 100) * basePrice);
      // return (discountPercentage / 100) * basePrice;
    } else {
      double discountAmount = double.parse(couponText.replaceAll("₹", ""));
      return basePrice - discountAmount;
      // return discountAmount;
    }
  }

  double findeGrandTotalFunction({basePrice, deliveryChareg, gst, tips}) {
    return basePrice + deliveryChareg + gst + tips;
  }

  double calculateSubstractTotal(
      {required double amount, required double basamt}) {
    return amount - basamt;
  }

  double calculatePercentage(
      {required double amount, required double percentage}) {
    return amount * (percentage / 100);
  }

  Map<String, dynamic> createAddressDetails(
      {String? name,
      String? addressId,
      String? userType,
      required String houseNo,
      required String locality,
      String? landMark,
      required String fullAddress,
      String? street,
      required String city,
      String? district,
      String? state,
      required String country,
      String? postalCode,
      String? contactType,
      required String contactPerson,
      required String contactPersonNumber,
      String? addressType,
      double? latitude,
      double? longitude,
      required bool delivered}) {
    return {
      'name': name,
      'addressId': addressId,
      "userType": userType,
      "houseNo": houseNo,
      "locality": locality,
      "landMark": landMark,
      "fullAddress": fullAddress,
      "street": street,
      "city": city,
      "district": district,
      "state": state,
      "country": country,
      "postalCode": postalCode,
      "contactType": contactType,
      "contactPerson": contactPerson,
      "contactPersonNumber": contactPersonNumber,
      "addressType": addressType,
      "latitude": latitude,
      "longitude": longitude,
      "delivered": delivered,
    };
  }
}

Map<String, dynamic> createParcelCaerData({
  required String userId,
  required String unit,
  required double km,
  required int value,
  required String otherType,
  required String packageType,
  required String packageImage,
  required dynamic basePrice,
  required List<Map<String, dynamic>> dropDetails,
  required List<Map<String, dynamic>> pickupDetails,
}) {
  return {
    "userId": userId,
    "unit": unit,
    "km": km,
    "value": value,
    "otherType": otherType,
    "packageType": packageType,
    "packageImage": packageImage,
    "basePrice": basePrice,
    "dropDetails": dropDetails,
    "pickupDetails": pickupDetails,
  };
}

Future<dynamic> addcartPaymentBottomSheet(BuildContext context) {
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
      return Stack(
        clipBehavior:
            Clip.none, // Allow the close icon to float outside the bottom sheet
        children: [
          const AddParcelPaymentMethodSheet(),
          Positioned(
            top: -60, // Position it floating above the sheet
            right: 0, // Align it towards the right, adjust as needed
            left: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
              },
              child: Container(
                width: 40, // Size of the container
                height: 40,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(180, 19, 1, 1)),

                child: const Icon(
                  weight: 10,
                  Icons.close,
                  color: Customcolors.DECORATION_WHITE,
                  // size: 30.0,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

// ignore: must_be_immutable
class EditIconRowWidget extends StatelessWidget {
  String addresstype;
  final VoidCallback ontap;

  EditIconRowWidget(
      {super.key, required this.addresstype, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(addresstype, style: CustomTextStyle.parcelordertitle),
      ],
    );
  }
}
