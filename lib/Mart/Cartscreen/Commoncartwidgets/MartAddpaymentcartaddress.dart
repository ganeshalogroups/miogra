// ignore_for_file: must_be_immutable, file_names

import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MartAddpaymentcartaddress extends StatefulWidget {
 bool ispaymentsheet;
   MartAddpaymentcartaddress({super.key,this.ispaymentsheet = false,});

  @override
  State<MartAddpaymentcartaddress> createState() =>MartAddpaymentcartaddressState();
}

class MartAddpaymentcartaddressState extends State<MartAddpaymentcartaddress> {
  MartPaymentMethodcontroller paymentMethodController = Get.put(MartPaymentMethodcontroller());

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      decoration: CustomContainerDecoration.whitecontainerdecoration(),
      height: MediaQuery.of(context).size.height / 2.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Payment Method",
                  style: CustomTextStyle.addresstitle,
                ),
                5.toHeight,
                const Text(
                  "Choose your preferred payment method and complete your purchase seamlessly!",
                  style: CustomTextStyle.chipgrey,
                ),
              ],
            ),
          ),
          20.toHeight,
          Column(
            children: [
              Obx(() {
                return InkWell(
                  onTap:
                      // meatcart.getbillmeatcart["data"]["totalMeatAmount"] > 500
                      //     ? 
                          () {
                              paymentMethodController.setmeatPaymentMethod(1);
                              Navigator.pop(context);
                            },
                          // : () {
                          //     paymentMethodController.setmeatPaymentMethod(0);
                          //     Navigator.pop(context);
                          //   }, // Disable tap if totalFoodAmount < 500
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Cash On Delivery',
                           style: CustomTextStyle.addresstitle,
                        ),
                        Transform.scale(
                                scale: 1.3,
                                child: Radio(
                                  activeColor: Customcolors.darkpurple,
                                  value: 0,
                                  groupValue: paymentMethodController
                                      .selectedPaymentMethod.value,
                                  onChanged: (value) {
                                    paymentMethodController
                                        .setmeatPaymentMethod(value!);
                                    Navigator.pop(context);
                                  },
                                ),
                              )
                      ],
                    ),
                  ),
                );
              }),
              InkWell(
                onTap: () {
                  paymentMethodController.setmeatPaymentMethod(1);
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Online Payment',
                        style: CustomTextStyle.addresstitle,
                      ),
                      Obx(() => Transform.scale(
                            scale: 1.3,
                            child: Radio(
                              activeColor: Customcolors.darkpurple,
                              value: 1,
                              groupValue: paymentMethodController
                                  .selectedPaymentMethod.value,
                              onChanged: (value) {
                                paymentMethodController
                                    .setmeatPaymentMethod(value!);
                                Navigator.pop(context);
                              },
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        //  if (meatcart.getbillmeatcart["data"]["totalMeatAmount"]>500 ) PaymentNote()
        ],
      ),
    );
  }
}

class MartPaymentMethodcontroller extends GetxController {
  var selectedPaymentMethod =  (-1).obs;

  void setmeatPaymentMethod(int value) {
    selectedPaymentMethod.value = value;
  }

  void clearmeatPaymentMethod() {
    selectedPaymentMethod.value = -1; // Reset to default (0 for Cash on Delivery)
  }
}