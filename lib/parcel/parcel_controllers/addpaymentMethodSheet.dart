


// ignore_for_file: file_names


import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AddParcelPaymentMethodSheet extends StatefulWidget {
  const AddParcelPaymentMethodSheet({super.key});

  @override
  State<AddParcelPaymentMethodSheet> createState() => _AddParcelPaymentMethodSheetState();
}

class _AddParcelPaymentMethodSheetState extends State<AddParcelPaymentMethodSheet> {

//  PaymentMethodOptions  PaymentMethodOptions = Get.put(PaymentMethodOptions());



PaymentMethodOptions paymentMethodOptions =  Get.put(PaymentMethodOptions());




  @override
  Widget build(BuildContext context) {
    
    return CustomContainer(
      decoration: CustomContainerDecoration.whitecontainerdecoration(),
      height: MediaQuery.of(context).size.height / 2.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 160, vertical: 10),
            child: Divider(
              color: Customcolors.DECORATION_GREY,
              thickness: 4,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text("Payment Method",
              style: CustomTextStyle.addresstitle,
            ),
          ),
          const CustomSizedBox(
            height: 5,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text( "Choose your preferred payment method and complete your purchase seamlessly!",
              style: CustomTextStyle.chipgrey,
            ),
          ),
          const CustomSizedBox(height: 20),
          Column(
            children: [
             Obx(() {
                return InkWell(

                  onTap: () {

                    paymentMethodOptions.setPaymentMethod(0);
                    Navigator.pop(context);

                  },


                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       
                     
                        const Text('Cash On Delivery',
                          style:CustomTextStyle.addresstitle,
                        ),
                        Transform.scale(
                        scale: 1.3,
                        child: Radio(
                          activeColor: Customcolors.darkpurple,
                          value: 0,
                          groupValue: paymentMethodOptions.selectedPaymentMethod.value,
                          onChanged: (value) {
                            paymentMethodOptions.setPaymentMethod(value!);
                             Navigator.pop(context);
                          },
                        ),
                      ),
                      ],
                    ),
                  ),
                );
              }),
              InkWell(
                onTap:() {
                   paymentMethodOptions.setPaymentMethod(1);
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Online Payment',
                        style: CustomTextStyle.addresstitle,
                      ),
                      Obx(() => Transform.scale(
                        scale: 1.3,
                        child: Radio(
                          activeColor: Customcolors.darkpurple,
                          value: 1,
                          groupValue: paymentMethodOptions.selectedPaymentMethod.value,
                          onChanged: (value) {
                            paymentMethodOptions.setPaymentMethod(value!);
                             Navigator.pop(context);
                          },
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}







class PaymentMethodOptions extends GetxController {
  var selectedPaymentMethod = (-1).obs;

  void setPaymentMethod(int value) {
    selectedPaymentMethod.value = value;
  }
   void learPaymentMethod() {
    selectedPaymentMethod.value = -1;    // Reset to default (0 for Cash on Delivery)
  }
}
