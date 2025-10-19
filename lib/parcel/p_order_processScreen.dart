

// ignore_for_file: file_names

import 'package:testing/Features/coupon/couponController.dart';
import 'package:testing/parcel/p_parcel_orders/ordr_successscreen.dart';
import 'package:testing/parcel/p_services_provider/p_Round_Trip_Validation.dart';
import 'package:testing/parcel/p_services_provider/p_address_provider.dart';
import 'package:testing/parcel/p_services_provider/p_validation_errorProvider.dart';
import 'package:testing/parcel/parcel_controllers/addpaymentMethodSheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';





class ParcelOrderProcess extends StatefulWidget {
  const ParcelOrderProcess({super.key});

  @override
  State<ParcelOrderProcess> createState() => _ParcelOrderProcessState();
}

class _ParcelOrderProcessState extends State<ParcelOrderProcess> {


  PaymentMethodOptions paymentoption  =  Get.put(PaymentMethodOptions()); 



  @override
  void initState() {

    Future.delayed(const Duration(milliseconds: 5200), () {

        Provider.of<ParcelAddressProvider>(context,listen: false).clearAddressMapData();
        Provider.of<ParcelAddressProvider>(context,listen: false).addPackageContent(content: null);
        Provider.of<ValidationErrorProvider>(context,listen: false).clearSingleTripData();

        Provider.of<RoundTripLOcatDataProvider>(context,listen: false).clearAddressMapData();
        Provider.of<RoundTripLOcatDataProvider>(context,listen: false).addPackageContent(content: null);
        Provider.of<RoundValidationErrorProvider>(context,listen: false).clearRoundTripData();

        Provider.of<CouponController>(context,listen: false).parcelremoveCoupon();
        Provider.of<CouponController>(context,listen: false).rTripparcelremoveCoupon();
        paymentoption.setPaymentMethod(1);

    });


    Future.delayed(const Duration(milliseconds: 5200), () {
      Future.delayed(Duration.zero, () => Get.off(const ParcelOrderCreatedDoneScreen()));
    });
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: SizedBox(
            height: 200.0.h,
            child: Lottie.asset("assets/parcel_images/parcelOrder_process.json"),
          ),
        ),
      ),
    );
  }
}



