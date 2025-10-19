// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:testing/Features/OrderScreen/OrderScreenController/OrdersControllerPagination.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatOrderHistoryTabbar/MeatOrderstatus.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatTrackOrder.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/CustomDottedline.dart';
import 'package:testing/utils/Shimmers/Orderlistshimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';

import '../../../Features/OrderScreen/Orderslist.dart';

class MeatorderlistTab extends StatefulWidget {
bool isFromHome;
MeatorderlistTab({super.key,this.isFromHome =false});

  @override
  State<MeatorderlistTab> createState() => _MeatorderlistTabState();
}

class _MeatorderlistTabState extends State<MeatorderlistTab> {
Timer? timer; // Timer for countdown
final Map<int, int> _countdownValues = {}; 

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetOrdersProvider>(context, listen: false).meatgetOders();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel(); 
    super.dispose();
  }


  refresh() async {
    await Future.delayed(const Duration(seconds: 2), () {
         Provider.of<GetOrdersProvider>(context, listen: false).meatgetOders();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
     color: Customcolors.darkpurple,
      onRefresh: () async {
        await refresh();
      },
      child: Consumer<GetOrdersProvider>(

        builder: (context, value, child) {

          if (value.isLoading) {
           return const Oderlistshimmer();
           } else if (value.orderModel == null || value.orderModel.isEmpty) {
            return Center(child: _buildNoDataScreen(context));
          } else {
            return ListView.separated(
              itemCount: value.orderModel.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {

                   dynamic createdAtforcancellation = value.orderModel[index].containsKey('paymentDetails') ? value.orderModel[index]['paymentDetails']["createdAt"] : "";
                               
                if (_countdownValues.isEmpty) {

                    for (int index = 0; index < value.orderModel.length; index++) {

                      DateTime createdAt      = DateTime.parse(createdAtforcancellation);

                      _countdownValues[index] = getCountdownValue(createdAt);

                    }
                    _startCountdown();


              }


              var createdAt = DateTime.parse(createdAtforcancellation);

  int countdownValue = createdAt != null 
      ? getCountdownValue(createdAt) 
      : 0;


                return Column(
                  children: [
                    InkWell(
                    onTap: () {
                                
                        var formatedDate = formatDate(dateStr: value.orderModel[index]['createdAt']);
                      
                              dynamic deliverymanimg = value.orderModel[index].containsKey('assigneeDetails')  ? value.orderModel[index]['assigneeDetails']["imgUrl"]  :  "";
                                

                          dynamic deliverymanname = value.orderModel[index].containsKey('assigneeDetails')? value.orderModel[index]['assigneeDetails']["name"]  : "";
                          dynamic razorpaymentId = value.orderModel[index].containsKey('paymentDetails') ? value.orderModel[index]['paymentDetails']["razorPayPaymentId"] : "";
                          dynamic razorpaymentstatus =value.orderModel[index].containsKey('paymentDetails') ? value.orderModel[index]['paymentDetails']["paymentStatus"] : "";
                          dynamic razorPayRefundId = value.orderModel[index].containsKey('paymentDetails') ? value.orderModel[index]['paymentDetails']["razorPayRefundId"] : "";
                          dynamic paymentmode =value.orderModel[index].containsKey('paymentDetails') ? value.orderModel[index]['paymentDetails']["paymentMode"]: "";

                                  Get.to(
                                    MeatOrderstatus(
                                      packagingCharge: value.orderModel[index]['amountDetails']['packingCharges'],
                                      km: value.orderModel[index]['totalKms'],
                                      invoicePath: value.orderModel[index]["invoicePath"],
                                      razorPayRefundId: razorPayRefundId,
                                      razorpaymentId: razorpaymentId,
                                      ratings:value.orderModel[index]["ratings"],
                                      vendorAdminid:value.orderModel[index] ["vendorAdminId"],
                                      productCategoryId:value.orderModel[index]["productCategoryId"],
                                      couponDiscount: value.orderModel[index]['amountDetails']['couponsAmount'],
                                      delivaryAddress: value.orderModel[index]['dropAddress'][0]['fullAddress'].toString().capitalizeFirst.toString(),
                                      delivaryAddresstype: value.orderModel[index]['dropAddress'][0]['addressType'].toString().capitalizeFirst.toString(),
                                      delivaryFee: value.orderModel[index]['amountDetails']['deliveryCharges'],
                                      grandtotal: value.orderModel[index]['amountDetails']['finalAmount'],
                                      gst: value.orderModel[index]['amountDetails']['tax'],
                                      itemTotal: value.orderModel[index]['amountDetails']['cartFoodAmountWithoutCoupon'],
                                      orderDate: formatedDate,
                                      orderId: value.orderModel[index]['orderCode'],
                                      paymentMethod: paymentmode,
                                      shopAddres: value.orderModel[index]['pickupAddress'][0]['fullAddress'].toString().capitalizeFirst.toString(),
                                      shopName: value.orderModel[index]['pickupAddress'][0]['name'].toString().capitalizeFirst.toString(),
                                      status:   value.orderModel[index]['orderStatus'],
                                      orderdetails: value.orderModel[index]['ordersDetails'],
                                      subAdminid:  value.orderModel[index]['subAdminId'],
                                      delivermanid:value.orderModel[index]['assignedToId']??"",
                                      ordergetid:value.orderModel[index]['_id'],
                                      couponType: value.orderModel[index]['amountDetails']['couponType']??"",
                                          
                                           deliverymanimg: deliverymanimg,
                                           deliverymanname: deliverymanname, paymentStatus: razorpaymentstatus,
                                    ),
                                    transition: Transition.leftToRight);
                    },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Customcolors
                                  .DECORATION_LIGHTGREY, //color of shadow
                              spreadRadius: 5, //spread radius
                              blurRadius: 7, // blur radius
                              offset: Offset(0, 2),
                            ),
                          ],
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Text(
                                  value.orderModel[index]['orderStatus'],
                                  style: CustomTextStyle.yellowtext,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width/2.2.w,
                                    child: Text(
                                      value.orderModel[index]['pickupAddress'][0]['name'].toString().capitalizeFirst.toString(),
                                      style: CustomTextStyle.boldblack2,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                
                                 Text(formatDate(dateStr: value.orderModel[index]['createdAt']), style: CustomTextStyle.smallgrey)
                               
                                ],
                              ),
                              const SizedBox(height: 20),
                              CustomPaint(
                                size: Size(MediaQuery.of(context).size.width / 1,20), // Adjust size here
                                painter: DottedLinePainter(),
                              ),
                              ListView.builder(
                                itemCount: value.orderModel[index]['ordersDetails'].length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, ind) {
                                  return Row(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 6),
                                        child: SizedBox(
                                        width: 260,
                                          child: Text(
                                            "${value.orderModel[index]['ordersDetails'][ind]['quantity']} X ${value.orderModel[index]['ordersDetails'][ind]['foodName'].toString().capitalizeFirst.toString()}",
                                            style: CustomTextStyle.noboldblack,
                                            overflow: TextOverflow.clip,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                              CustomPaint(
                                size: Size(MediaQuery.of(context).size.width / 1, 20), // Adjust size here
                                painter: DottedLinePainter(),
                              ),


                            if (countdownValue > 0 &&value.orderModel[index]['orderStatus'] == "initiated" )
                               
                              //  SizedBox(
                              //  height: 30,
                              //    child: Marquee(
                              //    text: "You can cancel within ${countdownValue}s of placing your order. After that, cancellation isn’t available.",
                              //         style:CustomTextStyle.rederrortext,
                              //         scrollAxis: Axis.horizontal,
                              //         crossAxisAlignment: CrossAxisAlignment.start,
                              //         blankSpace: 20.0,
                              //         velocity: 50.0,
                              //         startPadding: 10.0,
                              //         accelerationDuration: const Duration(seconds: 1),
                              //         accelerationCurve: Curves.linear,
                              //         decelerationDuration: const Duration(milliseconds: 500),
                              //         decelerationCurve: Curves.easeOut,
                                   
                              //      ),
                              //  ),



                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                      
                      
                                  Row(
                                    children: [
                                      Text("₹ ${double.parse(value.orderModel[index]['amountDetails']['finalAmount'].toString()).toStringAsFixed(2)}",
                                      style: CustomTextStyle.black14bold,),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Icon(Icons.arrow_forward_ios,
                                          color: Customcolors.DECORATION_BLACK,
                                          size: 15)
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                      
                      
                                      var formatedDate = formatDate(dateStr: value.orderModel[index]['createdAt']);
                                          
                                      String createdAt = value.orderModel[index]["paymentDetails"]['createdAt'];
                                     
                      
                                      Get.to(
                                          MeatTrackorder(
                                            isfromhome: widget.isFromHome,
                                            createdAt: createdAt,
                                            ordeID: value.orderModel[index]['_id'],
                                            resname: value.orderModel[index]['pickupAddress'][0]['name'],
                                            status: value.orderModel[index]['orderStatus'],
                                            ordercode: value.orderModel[index]['orderCode'],
                                            datetime: formatedDate,
                                            shoplatlng: LatLng(value.orderModel[index]['pickupAddress'][0]['latitude'], value.orderModel[index]['pickupAddress'][0]['longitude']),
                                            userlat: LatLng( value.orderModel[index]['dropAddress'][0]['latitude'],value.orderModel[index]['dropAddress'][0]['longitude']),    
                                          ),
                                          transition: Transition.leftToRight);
                                    },
                                    child: CustomContainer(
                                      decoration: CustomContainerDecoration.gradientbuttondecoration(),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 20),
                                        child: Center(
                                          child: Text(
                                            "Track Order",
                                            style: CustomTextStyle.smallwhitetext,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
            );
          }
        },
      ),
    );
  }
void _startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _countdownValues.forEach((index, countdownValue) {
          if (countdownValue > 0) {
            _countdownValues[index] = countdownValue - 1;
          }
        });
      });
    });
  }
}


Widget _buildNoDataScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/meat_images/Nomeatorders.gif",height: 200,),
           const CustomSizedBox(height: 35,),
          const Text("No Orders", style: CustomTextStyle.googlebuttontext),
          const Text("You haven’t made any orders yet.", style: CustomTextStyle.blacktext)
        ],
      ),
    );
  }