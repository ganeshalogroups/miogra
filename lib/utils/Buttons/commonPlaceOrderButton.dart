
// ignore_for_file: file_names

import 'package:testing/parcel/p_services_provider/p_order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'CustomTextstyle.dart';


class CommonPlaceOrderButton extends StatefulWidget {
  final dynamic totalamt;
  final VoidCallback ontap;

  const CommonPlaceOrderButton({
    super.key,
    required this.totalamt,
    required this.ontap,
  });

  @override
  State<CommonPlaceOrderButton> createState() => CommonPlaceOrderButtonState();
}

class CommonPlaceOrderButtonState extends State<CommonPlaceOrderButton> {
  final ParcelOrdercontroller parcelOrderController = Get.put(ParcelOrdercontroller());
  final RxBool isLoading = false.obs;

  bool get isButtonLoading =>  parcelOrderController.iscreateOrderLoading.isTrue ||  parcelOrderController.isCODLoading.isTrue || parcelOrderController.iscreaterazorpayOrderLoading.isTrue ||  isLoading.isTrue;
    
    


  void handleTap() {
    if (!isLoading.value) {
      isLoading.value = true;

      // Navigate immediately to ParcelOrderProcess
      widget.ontap();

      // Reset the loading state after an artificial delay if needed
      Future.delayed(const Duration(seconds: 3), () {
        isLoading.value = false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
        onTap    : isButtonLoading ? null : handleTap,
        child    : Container(
          height : MediaQuery.of(context).size.height * 0.06,
          width  : MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: isButtonLoading
                ? const LinearGradient(colors: [Colors.grey, Colors.grey]) : const LinearGradient(colors: [Customcolors.lightpurple,
                
             Customcolors.darkpurple]),
             
          ),
          child: Center(
            child: isButtonLoading
                ? const Text('Loading...', style: CustomTextStyle.loginbuttontext)
                : Text('₹ ${widget.totalamt} | Place order', style: CustomTextStyle.loginbuttontext),
          ),
        ),
      );
    });
  }
}