
// ignore_for_file: file_names

import 'package:testing/Meat/MeatButtonFunctionalities/MeatAddproductController.dart/AddmeatController.dart';
import 'package:testing/common/NoteforCOD.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MeatAddpaymentcartaddress extends StatefulWidget {
 bool ispaymentsheet;
   MeatAddpaymentcartaddress({super.key,this.ispaymentsheet = false,});

  @override
  State<MeatAddpaymentcartaddress> createState() =>MeatAddpaymentcartaddressState();
}

class MeatAddpaymentcartaddressState extends State<MeatAddpaymentcartaddress> {
  MeatAddcontroller meatcart = Get.put(MeatAddcontroller());
  MeatPaymentMethodController paymentMethodController =
      Get.put(MeatPaymentMethodController());

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
                      meatcart.getbillmeatcart["data"]["totalMeatAmount"] > 500
                          ? () {
                              paymentMethodController.setmeatPaymentMethod(1);
                              Navigator.pop(context);
                            }
                          : () {
                              paymentMethodController.setmeatPaymentMethod(0);
                              Navigator.pop(context);
                            }, // Disable tap if totalFoodAmount < 500
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Cash On Delivery',
                           style: meatcart.getbillmeatcart["data"]["totalMeatAmount"] <=500  ?CustomTextStyle.addresstitle: CustomTextStyle.bottomtext,
                        ),
                        meatcart.getbillmeatcart["data"]["totalMeatAmount"] <=500
                            ? Transform.scale(
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
                            : Transform.scale(
                                scale: 1.3,
                                child: Radio(
                                  activeColor: Customcolors.DECORATION_GREY,
                                  value: 0,
                                  groupValue: paymentMethodController
                                      .selectedPaymentMethod.value,
                                  onChanged: null,
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
         if (meatcart.getbillmeatcart["data"]["totalMeatAmount"]>500 ) const PaymentNote()
        ],
      ),
    );
  }
}

class MeatPaymentMethodController extends GetxController {
  var selectedPaymentMethod =  (-1).obs;

  void setmeatPaymentMethod(int value) {
    selectedPaymentMethod.value = value;
  }

  void clearmeatPaymentMethod() {
    selectedPaymentMethod.value = -1; // Reset to default (0 for Cash on Delivery)
  }
}
