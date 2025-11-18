// ignore_for_file: file_names, must_be_immutable

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testing/Meat/MeatButtonFunctionalities/MeatAddproductController.dart/AddmeatController.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatPaymentBottomsheet.dart';
import 'package:testing/Meat/MeatOrderscreen/meatadditionalinfo.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/CustomDottedline.dart';
import 'package:testing/utils/Decorations/boxDecoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
  
class BillData extends StatelessWidget {
  final String content;
  final String value;
  final bool isDiscount;

  const BillData({
    super.key,
    required this.content,
    required this.value,
    this.isDiscount = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          content,
           style: TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    fontFamily: 'Poppins-Medium',
            ) 
        ),
        Text(
          value,
          style: isDiscount
              ?  TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: Colors.green,
    fontFamily: 'Poppins-Medium',
            ) 
              :  TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    fontFamily: 'Poppins-Medium',
            ) 
        ),
      ],
    );
  }
}

// Cart Screen Essencial Things  ==

class BillContentBoxes extends StatelessWidget {
  final VoidCallback ontap;
  final String content;

  const BillContentBoxes(
      {super.key, required this.ontap, required this.content});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width / 1,
        decoration: BoxDecorationsFun.whiteCircelRadiusDecoration(),
        child: instructions(instructions: content),
      ),
    );
  }
}

class BillSummaryWidget extends StatelessWidget {
 // dynamic amountForDistanceForDeliveryman;
  dynamic basePrice;
  dynamic delivaryCharge;
  dynamic gstAndOtherCharges;
  dynamic couponDiscount;
  dynamic grandTotal;
  dynamic totalKm;
  dynamic packagingCharge;
  dynamic deliverytip;
  dynamic platfomfee;
  final dynamic redirectLoadingDetails;
  BillSummaryWidget({
    super.key,
   
    required this.basePrice,
    required this.delivaryCharge,
    required this.gstAndOtherCharges,
    required this.couponDiscount,
    required this.grandTotal,
    required this.totalKm,
 //   this.amountForDistanceForDeliveryman,
    this.packagingCharge,
    this.deliverytip,
    this.platfomfee, this.redirectLoadingDetails
  });

String getFormattedTotalKm() {
  String raw = totalKm.toString().toLowerCase().trim();

  // Remove 'm' or 'km' if present
  raw = raw.replaceAll('km', '').replaceAll('m', '').trim();

  double km = double.tryParse(raw) ?? 0.0;

  // Check if original input was in meters (e.g., ends with 'm')
  bool isInMeters = totalKm.toString().toLowerCase().contains('m') && !totalKm.toString().toLowerCase().contains('km');

  if (isInMeters) {
    km = km / 1000; // Convert meters to km
    return "${km.toStringAsFixed(3)} km";
  } else {
    return "${km.toStringAsFixed(1)} km";
  }
}

  double getAppConfigKmFromRedirect() {
    if (redirectLoadingDetails["data"] != null &&
        redirectLoadingDetails["data"] is List) {
      for (var item in redirectLoadingDetails["data"]) {
        if (item is Map && item['key'] == 'restaurantDistanceKm') {
          return double.tryParse(item['value'].toString()) ?? 0.0;
        }
      }
    }
    return 0.0;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
        decoration: BoxDecorationsFun.whiteCircelRadiusDecoration(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          10.toHeight,
         Text('Order Summary', style: TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    fontFamily: 'Poppins-Medium',
            )  ),
          10.toHeight,
          BillData(content: 'Item Total', value: basePrice),
          10.toHeight,
        //   BillData(
        //       // content: 'Delivery Charge (upto ${getFormattedTotalKm()})',
        //        content: double.tryParse(getFormattedTotalKm().replaceAll(' km', ''))! > 1
        //  ? 'Delivery Charge (upto ${getFormattedTotalKm()})'
        //  : 'Delivery Charge',value: delivaryCharge),
    BillData(
      content: double.tryParse(getFormattedTotalKm().replaceAll(' km', ''))! > 1 &&
           double.tryParse(getFormattedTotalKm().replaceAll(' km', ''))! <= getAppConfigKmFromRedirect()
      ? 'Delivery Charge (upto ${getFormattedTotalKm()})'
      : 'Delivery Charge',
      value: delivaryCharge,
    ),

          10.toHeight,
          BillData(content: 'Packaging Charge', value: packagingCharge),
          10.toHeight,
          BillData(content: 'GST and Other Charges', value: gstAndOtherCharges),
          10.toHeight,
           BillData(content: 'Platform Fee', value: '${platfomfee}'),
            10.toHeight,
              // BillData(content: 'Delivery Tip', value: deliverytip),
           // if (deliverytip != null )
            if ( deliverytip != 0.0 )
            BillData(content: 'Delivery Tip', value: '${deliverytip.toStringAsFixed(2)}'),
              if ( deliverytip != 0.0  )
            10.toHeight,
              if ( couponDiscount != "0.0"  )
          BillData(
              content: 'Coupon Discount',
              value: '$couponDiscount',
              isDiscount: true),
                if ( couponDiscount != "0.0" )
          20.toHeight,
          DotLine(),
          BillData(content: 'Grand Total', value: grandTotal),
        ]));
  }
}

Widget instructions({instructions}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(instructions, style: CustomTextStyle.carttblack),
        const Icon(
          Icons.keyboard_arrow_right,
          color: Customcolors.DECORATION_GREY,
        ),
      ],
    ),
  );
}

class SelectPaymentOption extends StatefulWidget {
  final VoidCallback ontap;
 final Future<void> Function(BuildContext) showCustomPaymentDialog;

  bool paymentsheet;
   SelectPaymentOption({super.key, required this.ontap,this.paymentsheet=false, required this.showCustomPaymentDialog});

  @override
  State<SelectPaymentOption> createState() => _SelectPaymentOptionState();
}

class _SelectPaymentOptionState extends State<SelectPaymentOption> {
  MeatAddcontroller meatcart = Get.put(MeatAddcontroller());
  MeatPaymentMethodController paymentMethodController =Get.put(MeatPaymentMethodController());
   bool iscartloading = false;
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
    return Container(
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
                  }  else if (meatcart.getbillmeatcart == null) {
                    return const CupertinoActivityIndicator();
                  } else if (selectedPaymentMethod == 0 && meatcart.getbillmeatcart["data"]["totalMeatAmount"] > 500) {
    // Change payment method to Online Payment
     WidgetsBinding.instance.addPostFrameCallback((_) {
     widget.paymentsheet=true;
     paymentMethodController.selectedPaymentMethod.value = 1; // 1 represents Online Payment
     widget.showCustomPaymentDialog(context);
    });
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
              onTap: widget.ontap,
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
    );
  }
}



class OrderingforsomeoneContentBoxes extends StatelessWidget {
  final VoidCallback ontap;

  const OrderingforsomeoneContentBoxes({
    required this.ontap,
    super.key,
  });

  @override
   Widget build(BuildContext context) {
    return Consumer<MeatInstantUpdateProvider>(
      builder: (context, value, child) {
        bool isOrderingForSomeoneElse =value.otherName.isNotEmpty && value.otherNumber.isNotEmpty;
        
        return InkWell(
          onTap: ontap,
          child: Container(
            decoration: BoxDecorationsFun.whiteCircelRadiusDecoration(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // If ordering for someone else, show their details
                  isOrderingForSomeoneElse
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'You are ordering for ${value.otherName}',
                              style: CustomTextStyle.carttblack,
                            ),
                            3.toHeight,
                            SizedBox(
                            width: MediaQuery.sizeOf(context).width / 1.5,
                              child: Text(
                                'We will share order delivery communication on ${value.otherNumber}',
                                style: CustomTextStyle.carttblack,
                              ),
                            ),
                          ],
                        )
                      : const Text(
                          'Ordering for someone else?',
                          style: CustomTextStyle.carttblack,
                        ),
                  // Conditional text for either "Edit" or "Add details"
                  Text(
                    isOrderingForSomeoneElse ? 'Edit' : 'Add details',
                    style: const TextStyle(
                      color: Customcolors.darkpurple,
                      fontFamily: 'Poppins-Regular',
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
