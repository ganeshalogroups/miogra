// ignore_for_file: file_names

import 'package:testing/Mart/Cartscreen/Commoncartwidgets/AddmartuserBottomsheet.dart';
import 'package:testing/Mart/Cartscreen/Commoncartwidgets/MartAddpaymentcartaddress.dart';
import 'package:testing/Mart/Cartscreen/Commoncartwidgets/Martadditionalinfo.dart';
import 'package:testing/common/billDataClass.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';

class MartBillwidget extends StatefulWidget {
  const MartBillwidget({super.key});

  @override
  State<MartBillwidget> createState() => _MartBillwidgetState();
}

class _MartBillwidgetState extends State<MartBillwidget> {
bool paymentsheet=false;
  @override
  Widget build(BuildContext context) {
    return  Column(crossAxisAlignment: CrossAxisAlignment.start,
    children:  [
    //  BillSummaryWidget(
    //             basePrice:"₹300.00",
    //             gst:"₹16.00",
    //             packagingCharge:"₹10.00",
    //             couponDiscount:"₹-125.00",
    //             delivaryCharge:"₹10.00",
    //             totalKm: "5",
    //             grandTotal: "₹191.00"
    //           ),10.toHeight,
        MartAddDeliveryInstructions(
            onTapp: () => additionalinfoBottomSheet(context)),
        10.toHeight,
        OrderingforsomeoneContentBoxes(
          ontap: () {addusercartaddressBottomSheet(context);},
        ),
        10.toHeight,
           
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
        return const AddmartuserBottomsheet();
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
        return const MartAdditionalinfo();
      },
    );
  }

  // Future<dynamic> addcartAddressBottomSheet(BuildContext context) {
  //   return showModalBottomSheet(
  //       context: context,
  //       builder: (context) =>
  //           Addmeataddress(totalDis: resGlobalKM, shopid: widget.shopid),
  //       isDismissible: true,
  //       showDragHandle: true,
  //       enableDrag: true);
  // }

  Future<dynamic> addcartPaymentBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Customcolors.DECORATION_WHITE,
      showDragHandle: true,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return  MartAddpaymentcartaddress(ispaymentsheet: true);
      },
  ).then((value) {
     WidgetsBinding.instance.addPostFrameCallback((_) {
      paymentsheet = false; 
    });// Reset after closing the sheet
  });
}}
