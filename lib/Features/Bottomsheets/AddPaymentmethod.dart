
// ignore_for_file: file_names, must_be_immutable

import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Addfoodcontroller.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/CreateOrdercontroller.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/Getnearbyrescontroller.dart';
import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Redirectcontroller.dart';
import 'package:testing/common/NoteforCOD.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Addpaymentcartaddress extends StatefulWidget {
 bool ispaymentsheet;
 dynamic maxAmount;
 Addpaymentcartaddress({super.key,this.ispaymentsheet = false,required this.maxAmount});

  @override
  State<Addpaymentcartaddress> createState() => _AddpaymentcartaddressState();
}

class _AddpaymentcartaddressState extends State<Addpaymentcartaddress> {
 Nearbyrescontroller nearbyreget = Get.put(Nearbyrescontroller());
 Ordercontroller ordercreate = Get.put(Ordercontroller());
   RedirectController redirect = Get.put(RedirectController());

  Foodcartcontroller foodcart           = Get.put(Foodcartcontroller());
 PaymentMethodController paymentMethodController = Get.put(PaymentMethodController());


  @override
  Widget build(BuildContext context) {
    final totalAmount = double.tryParse(widget.maxAmount) ?? 0.00;

  // final List<dynamic> configs=   redirect.redirectLoadingDetails["data"];
//  final codConfig = configs.firstWhere(
//       (e) => e['key'] == 'cod_enable',
//       orElse: () => null,
//     );

//     final onlineConfig = configs.firstWhere(
//       (e) => e['key'] == 'online_enable',
//       orElse: () => null,
//     );

    // bool codEnabled = codConfig != null && codConfig['value'] == "true";
    // bool onlineEnabled = onlineConfig != null && onlineConfig['value'] == "true";
    bool rescodEnabled =  ordercreate.vedordata['res_showCashOnDelivery'];
    bool resonlineEnabled =ordercreate.vedordata['res_showOnlineDelivery'];
    bool shopcodEnabled =  ordercreate.vedordata['shop_showCashOnDelivery'];
    bool shoponlineEnabled =ordercreate.vedordata['shop_showOnlineDelivery'];


final bool showButtononline = resonlineEnabled || shoponlineEnabled;
final bool showButtonCod = rescodEnabled || shopcodEnabled;

final bool isres = nearbyreget.selectedIndex.value == 0
                                                                          ? true
                                                                          : false;
final bool isshop = nearbyreget.selectedIndex.value ==
                                                                              1
                                                                          ? true
                                                                          : false;

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
                const Text("Payment Method",
              style: CustomTextStyle.addresstitle,
            ),
           5.toHeight,
            const Text( "Choose your preferred payment method and complete your purchase seamlessly!",
              style: CustomTextStyle.chipgrey,
            ),
            ],
          ),
        ),
          20.toHeight,


          Column(
            children: [

              //  if (isres &&  showButtonCod)
                if (isres &&  rescodEnabled)
             Obx(() {
          
                return InkWell(
                  onTap: 
                  
                  foodcart.getbillfoodcart["data"]["totalFoodAmount"]>totalAmount  ? () {
                    paymentMethodController.setPaymentMethod(1); 
                    Navigator.pop(context);
                  } 
                  
                  : 

                
                  
                  (){paymentMethodController.setPaymentMethod(0); 
                    Navigator.pop(context);}, // Disable tap if totalFoodAmount < 500
          
          
                  child: 
                      
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Cash On Delivery',
                          style:foodcart.getbillfoodcart["data"]["totalFoodAmount"]<=totalAmount  ?CustomTextStyle.addresstitle: CustomTextStyle.bottomtext,
                        ),
                        foodcart.getbillfoodcart["data"]["totalFoodAmount"]<=totalAmount? Transform.scale(
                        scale: 1.3,
                        child: Radio(
                          activeColor: Customcolors.darkpurple,
                          value: 0,
                          groupValue: paymentMethodController.selectedPaymentMethod.value,
                          onChanged: (value) {
                            paymentMethodController.setPaymentMethod(value!);
                             Navigator.pop(context);
                          },
                        ),
                      ): Transform.scale(
                        scale: 1.3,
                        child: Radio(
                          activeColor: Customcolors.DECORATION_GREY,
                          value: 0,
                          groupValue: paymentMethodController.selectedPaymentMethod.value,
                          onChanged: null,
                        ),
                      )
                      ],
                    ),
                  ),
                );
              }),
               // if (isres &&  showButtonCod)
                if (isshop &&  shopcodEnabled)
             Obx(() {
          
                return InkWell(
                  onTap: 
                  
                  foodcart.getbillfoodcart["data"]["totalFoodAmount"]>totalAmount  ? () {
                    paymentMethodController.setPaymentMethod(1); 
                    Navigator.pop(context);
                  } 
                  
                  : 

                
                  
                  (){paymentMethodController.setPaymentMethod(0); 
                    Navigator.pop(context);}, // Disable tap if totalFoodAmount < 500
          
          
                  child: 
                      
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Cash On Delivery',
                          style:foodcart.getbillfoodcart["data"]["totalFoodAmount"]<=totalAmount  ?CustomTextStyle.addresstitle: CustomTextStyle.bottomtext,
                        ),
                        foodcart.getbillfoodcart["data"]["totalFoodAmount"]<=totalAmount? Transform.scale(
                        scale: 1.3,
                        child: Radio(
                          activeColor: Customcolors.darkpurple,
                          value: 0,
                          groupValue: paymentMethodController.selectedPaymentMethod.value,
                          onChanged: (value) {
                            paymentMethodController.setPaymentMethod(value!);
                             Navigator.pop(context);
                          },
                        ),
                      ): Transform.scale(
                        scale: 1.3,
                        child: Radio(
                          activeColor: Customcolors.DECORATION_GREY,
                          value: 0,
                          groupValue: paymentMethodController.selectedPaymentMethod.value,
                          onChanged: null,
                        ),
                      )
                      ],
                    ),
                  ),
                );
              }),
          
              //ONLINE PAYMENT COMMENTED
          // if (isres && showButtononline)
          if (isres && resonlineEnabled)
          
              InkWell(
                onTap:() {
                   paymentMethodController.setPaymentMethod(1);
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
                          groupValue: paymentMethodController.selectedPaymentMethod.value,
                          onChanged: (value) {
                            paymentMethodController.setPaymentMethod(value!);
                             Navigator.pop(context);
                          },
                        ),
                      )),
                    ],
                  ),
                ),
              ),
          // if (isres && showButtononline)
           if (isshop && shoponlineEnabled)
          
              InkWell(
                onTap:() {
                   paymentMethodController.setPaymentMethod(1);
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
                          groupValue: paymentMethodController.selectedPaymentMethod.value,
                          onChanged: (value) {
                            paymentMethodController.setPaymentMethod(value!);
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
         if (foodcart.getbillfoodcart["data"]["totalFoodAmount"]>totalAmount ) PaymentNote(totalAmount: totalAmount,)
        ],
      ),
    );
  }
}


///For ------------------>>>>>>Wallet
// class _AddpaymentcartaddressState extends State<Addpaymentcartaddress> {
//   final Foodcartcontroller foodcart = Get.put(Foodcartcontroller());
//   final PaymentMethodController paymentMethodController = Get.put(PaymentMethodController());
//   final Walletcontroller walletget = Get.put(Walletcontroller());

//   @override
//   Widget build(BuildContext context) {
//     final coupon = Provider.of<CouponController>(context, listen: false);

//     double totalFoodAmount = double.tryParse(foodcart.getbillfoodcart["data"]["totalFoodAmount"].toString()) ?? 0.0;
//     double packaging = double.tryParse(foodcart.getbillfoodcart["data"]["totalPackageCharges"].toString()) ?? 0.0;
//     double delivery = double.tryParse(foodcart.getbillfoodcart["data"]["deliveryCharges"].toString()) ?? 0.0;
//     double gst = double.tryParse(foodcart.getbillfoodcart["data"]["totalGST"].toString()) ?? 0.0;
//     double tipAmount = foodcart.selectedTipAmount.value.isNotEmpty
//         ? double.parse(foodcart.selectedTipAmount.value)
//         : 0.0;

//     double discount = 0;
//     if (coupon.isCouponApplied) {
//       if (coupon.coupontype == "percentage") {
//         double percentage = double.parse(coupon.couponamount.replaceAll("%", ""));
//         discount = (percentage / 100) * totalFoodAmount;
//       } else {
//         discount = double.parse(coupon.couponamount.replaceAll("₹", ""));
//       }
//     }

//     double grandTotal = totalFoodAmount + packaging + delivery + gst + tipAmount - discount;

//     double walletBalance = double.tryParse(walletget.walletdetails?["data"]["walletTotalAmount"].toString() ?? '0') ?? 0.0;

//     return CustomContainer(
//       decoration: CustomContainerDecoration.whitecontainerdecoration(),
//       height: MediaQuery.of(context).size.height / 2.3,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Payment Method", style: CustomTextStyle.addresstitle),
//                 5.toHeight,
//                 Text(
//                   "Choose your preferred payment method and complete your purchase seamlessly!",
//                   style: CustomTextStyle.chipgrey,
//                 ),
//               ],
//             ),
//           ),
//           20.toHeight,

//           /// Wallet Payment
//           if (walletBalance > 0)
//             InkWell(
//               onTap: walletBalance >= grandTotal
//                   ? () {
//                       paymentMethodController.setPaymentMethod(2);
//                       Navigator.pop(context);
//                     }
//                   : null,
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Wallet (${walletBalance.toStringAsFixed(2)})',
//                       style: walletBalance >= grandTotal
//                           ? CustomTextStyle.addresstitle
//                           : CustomTextStyle.bottomtext,
//                     ),
//                     Obx(() => Transform.scale(
//                           scale: 1.3,
//                           child: Radio(
//                             activeColor: walletBalance >= grandTotal
//                                 ? Customcolors.darkpurple
//                                 : Customcolors.DECORATION_GREY,
//                             value: 2,
//                             groupValue: paymentMethodController.selectedPaymentMethod.value,
//                             onChanged: walletBalance >= grandTotal
//                                 ? (value) {
//                                     paymentMethodController.setPaymentMethod(value as int);
//                                     Navigator.pop(context);
//                                   }
//                                 : null,
//                           ),
//                         )),
//                   ],
//                 ),
//               ),
//             ),

//           /// Cash On Delivery
//           Obx(() {
//             bool isEnabled = totalFoodAmount <= 500;
//             return InkWell(
//               onTap: () {
//                 paymentMethodController.setPaymentMethod(0);
//                 Navigator.pop(context);
//               },
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     InkWell(
//                     onTap: () {
//                       print(walletBalance);
//                     },
//                       child: Text(
//                         'Cash On Delivery',
//                         style: isEnabled ? CustomTextStyle.addresstitle : CustomTextStyle.bottomtext,
//                       ),
//                     ),
//                     Transform.scale(
//                       scale: 1.3,
//                       child: Radio(
//                         activeColor:
//                             isEnabled ? Customcolors.darkpurple : Customcolors.DECORATION_GREY,
//                         value: 0,
//                         groupValue: paymentMethodController.selectedPaymentMethod.value,
//                         onChanged: isEnabled
//                             ? (value) {
//                                 paymentMethodController.setPaymentMethod(value as int);
//                                 Navigator.pop(context);
//                               }
//                             : null,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             );
//           }),

//           /// Online Payment
//           InkWell(
//             onTap: () {
//               paymentMethodController.setPaymentMethod(1);
//               Navigator.pop(context);
//             },
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('Online Payment', style: CustomTextStyle.addresstitle),
//                   Obx(() => Transform.scale(
//                         scale: 1.3,
//                         child: Radio(
//                           activeColor: Customcolors.darkpurple,
//                           value: 1,
//                           groupValue: paymentMethodController.selectedPaymentMethod.value,
//                           onChanged: (value) {
//                             paymentMethodController.setPaymentMethod(value as int);
//                             Navigator.pop(context);
//                           },
//                         ),
//                       )),
//                 ],
//               ),
//             ),
//           ),

//           if (totalFoodAmount > 500) PaymentNote()
//         ],
//       ),
//     );
//   }
// }

class PaymentMethodController extends GetxController {
  var selectedPaymentMethod = (-1).obs;

  void setPaymentMethod(int value) {
    selectedPaymentMethod.value = value;
  }
   void clearPaymentMethod() {
    selectedPaymentMethod.value = -1; // Reset to default (0 for Cash on Delivery)
  }
}


///For ------------------>>>>>>Wallet
// class PaymentMethodController extends GetxController {
//   var selectedPaymentMethod = (-1).obs;

//   void setPaymentMethod(int value) {
//     selectedPaymentMethod.value = value;
//   }

//   void clearPaymentMethod() {
//     selectedPaymentMethod.value = -1; // Reset to no selection
//   }

//   bool isCashOnDeliverySelected() => selectedPaymentMethod.value == 0;
//   bool isOnlinePaymentSelected() => selectedPaymentMethod.value == 1;
//   bool isWalletSelected() => selectedPaymentMethod.value == 2;
// }


// //For Reorder only
// class ReorderAddpaymentcartaddress extends StatefulWidget {
//   const ReorderAddpaymentcartaddress({super.key});

//   @override
//   State<ReorderAddpaymentcartaddress> createState() =>ReorderAddpaymentcartaddressState();
// }

// class ReorderAddpaymentcartaddressState extends State<ReorderAddpaymentcartaddress> {

//    ReorderGetcontroller reorderget=Get.put(ReorderGetcontroller());
//  PaymentMethodController paymentMethodController = Get.put(PaymentMethodController());


//   @override
//   Widget build(BuildContext context) {
//     return CustomContainer(
//       decoration: CustomContainerDecoration.whitecontainerdecoration(),
//       height: MediaQuery.of(context).size.height / 2.5,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
         
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//                 Text("Payment Method",
//               style: CustomTextStyle.addresstitle,
//             ),
//            5.toHeight,
//             Text( "Choose your preferred payment method and complete your purchase seamlessly!",
//               style: CustomTextStyle.chipgrey,
//             ),
//             ],
//           ),
//         ),
//           20.toHeight,
//           Column(
//             children: [
//              Obx(() {
//                 return InkWell(
//                   onTap: reorderget.reorderModel["data"]["totalFoodAmount"]>500  ? () {
//                     paymentMethodController.setPaymentMethod(1); 
//                     Navigator.pop(context);
//                   } : (){paymentMethodController.setPaymentMethod(0); 
//                     Navigator.pop(context);}, // Disable tap if totalFoodAmount < 500
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('Cash On Delivery',
//                           style:reorderget.reorderModel["data"]["totalFoodAmount"]<=500  ?CustomTextStyle.addresstitle: CustomTextStyle.bottomtext,
//                         ),
//                         reorderget.reorderModel["data"]["totalFoodAmount"]<=500? Transform.scale(
//                         scale: 1.3,
//                         child: Radio(
//                           activeColor: Customcolors.darkpurple,
//                           value: 0,
//                           groupValue: paymentMethodController.selectedPaymentMethod.value,
//                           onChanged: (value) {
//                             paymentMethodController.setPaymentMethod(value!);
//                              Navigator.pop(context);
//                           },
//                         ),
//                       ): Transform.scale(
//                         scale: 1.3,
//                         child: Radio(
//                           activeColor: Customcolors.DECORATION_GREY,
//                           value: 0,
//                           groupValue: paymentMethodController.selectedPaymentMethod.value,
//                           onChanged: null,
//                         ),
//                       )
//                       ],
//                     ),
//                   ),
//                 );
//               }),
//               InkWell(
//                 onTap:() {
//                    paymentMethodController.setPaymentMethod(1);
//                   Navigator.pop(context);
//                 },
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('Online Payment',
//                         style: CustomTextStyle.addresstitle,
//                       ),
//                       Obx(() => Transform.scale(
//                         scale: 1.3,
//                         child: Radio(
//                           activeColor: Customcolors.darkpurple,
//                           value: 1,
//                           groupValue: paymentMethodController.selectedPaymentMethod.value,
//                           onChanged: (value) {
//                             paymentMethodController.setPaymentMethod(value!);
//                              Navigator.pop(context);
//                           },
//                         ),
//                       )),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//          if (reorderget.reorderModel["data"]["totalFoodAmount"]>500 ) PaymentNote()
//         ],
//       ),
//     );
//   }
// }