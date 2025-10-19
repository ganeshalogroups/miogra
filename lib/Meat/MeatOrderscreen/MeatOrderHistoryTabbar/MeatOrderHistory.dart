// ignore_for_file: file_names

import 'package:testing/Meat/MeatOrderscreen/MeatOrderController/MeatOrdersHistorycontroller.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatOrderHistoryTabbar/MeatOrderstatus.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/CustomDottedline.dart';
import 'package:testing/utils/Shimmers/FavouriteResgetshimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

class MeatOrderHistory extends StatefulWidget {
  const MeatOrderHistory({super.key});

  @override
  State<MeatOrderHistory> createState() => _MeatOrderHistoryState();
}

class _MeatOrderHistoryState extends State<MeatOrderHistory> {

 MeatOrderHistoryPaginController meatordercontroller = Get.put(MeatOrderHistoryPaginController());
  @override
  void initState() {
    meatordercontroller.getmeatOrderHistoryController.refresh();
    super.initState();
  }



  @override
  void dispose() {
    // ordercntoller.dispose();
    super.dispose();
  }



  refresh() async {
      await Future.delayed(const Duration(seconds: 2),() {
      meatordercontroller.getmeatOrderHistoryController.refresh();
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
      child: PagedListView<int, dynamic>(
        shrinkWrap: true,
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: false,
        addSemanticIndexes: false,
        pagingController: meatordercontroller.getmeatOrderHistoryController,
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(16.0),
        builderDelegate: PagedChildBuilderDelegate<dynamic>(
          animateTransitions: true,
          transitionDuration: const Duration(milliseconds: 500),
          itemBuilder: (context, orders, index) {
      
      
       
              
      
                            return InkWell(
                            onTap: () {
                              
                                  var   formatedDate       = formatDate(dateStr: orders['createdAt']);
                                dynamic deliverymanimg     = orders.containsKey('assigneeDetails') ? orders['assigneeDetails']["imgUrl"]  : "";
                                dynamic deliverymanname    = orders.containsKey('assigneeDetails') ? orders['assigneeDetails']["name"] : "";              
                                dynamic razorpaymentId     = orders.containsKey('paymentDetails')  ? orders['paymentDetails']["razorPayPaymentId"] : "";  
                                dynamic razorpaymentstatus = orders.containsKey('paymentDetails')  ? orders['paymentDetails']["paymentStatus"] : "";      
                                dynamic razorPayRefundId   = orders.containsKey('paymentDetails')  ? orders['paymentDetails']["razorPayRefundId"] : "";
                                 dynamic paymentmode       = orders.containsKey('paymentDetails')  ? orders['paymentDetails']["paymentMode"]: "";   


                                Get.to(
                                    MeatOrderstatus(
                                      packagingCharge: orders['amountDetails']['packingCharges'],
                                      km: orders['totalKms'],
                                      invoicePath: orders["invoicePath"],
                                      razorPayRefundId: razorPayRefundId,
                                      paymentStatus: razorpaymentstatus,
                                      razorpaymentId:razorpaymentId ,
                                      vendorAdminid     :  orders ["vendorAdminId"],
                                      productCategoryId :  orders["productCategoryId"],
                                      ratings           :  orders['ratings'] ,
                                      couponDiscount    : orders['amountDetails']['couponsAmount'],
                                      delivaryAddress   : orders['dropAddress'][0]['fullAddress'].toString().capitalizeFirst.toString(),
                                      delivaryAddresstype:orders['dropAddress'][0]['addressType'].toString().capitalizeFirst.toString(),   
                                      delivaryFee       : orders['amountDetails']['deliveryCharges'],
                                      grandtotal        : orders['amountDetails']['finalAmount'],
                                      gst               : orders['amountDetails']['tax'],
                                      itemTotal         : orders['amountDetails']['cartFoodAmountWithoutCoupon'],
                                      orderDate         : formatedDate,
                                      orderId           : orders['orderCode'],
                                      paymentMethod     : paymentmode,
                                      shopAddres        : orders['pickupAddress'][0]['fullAddress'].toString().capitalizeFirst.toString(),
                                      shopName          : orders['pickupAddress'][0]['name'].toString().capitalizeFirst.toString(),
                                      status            : orders['orderStatus'],
                                      orderdetails      : orders['ordersDetails'],
                                      subAdminid        : orders['subAdminId'],
                                      delivermanid      : orders['assignedToId']??"",
                                      ordergetid        : orders['_id'],
                                      couponType        : orders['amountDetails']['couponType']??"",
                                      deliverymanimg    : deliverymanimg, 
                                      deliverymanname   : deliverymanname,
                                    ),

                                    transition: Transition.leftToRight);



                            },
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Customcolors.DECORATION_LIGHTGREY, //color of shadow
                          spreadRadius: 5, //spread radius
                          blurRadius: 7, // blur radius
                          offset: Offset(0, 2),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Text(
                              orders['orderStatus'].toString().capitalizeFirst.toString(),
                              style:orders['orderStatus']== "delivered"
                              ? CustomTextStyle.greenordertext : CustomTextStyle.redmarktext
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width/2.2.w,
                                child: Text(
                                  orders['pickupAddress'][0]['name'].toString().capitalizeFirst.toString(),
                                  style: CustomTextStyle.boldblack2,
                                ),
                              ),
                              Text(formatDate(dateStr: orders['createdAt']),
                                  style: CustomTextStyle.smallgrey)
                            ],
                          ),
                          const SizedBox(height: 20),
                          CustomPaint(
                            size: Size(MediaQuery.of(context).size.width / 1,20), // Adjust size here
                            painter: DottedLinePainter(),
                          ),
                          ListView.builder(
                            itemCount: orders['ordersDetails'].length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Row(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  
                                     
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 6),
                                    child: SizedBox(
                                      width: 260,
                                      child: Text(
                                        "${orders['ordersDetails'][index]['quantity']} X ${orders['ordersDetails'][index]['foodName'].toString().capitalizeFirst.toString()}",
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
                            size: Size(MediaQuery.of(context).size.width / 1,20), // Adjust size here
                            painter: DottedLinePainter(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text("₹ ${double.parse(orders['amountDetails']['finalAmount'].toString()).toStringAsFixed(2)}",
                                   style: CustomTextStyle.black14bold,
                                   ),

                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(Icons.arrow_forward_ios,
                                      color: Customcolors.DECORATION_BLACK,
                                      size: 15)
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            );
          },

          firstPageProgressIndicatorBuilder: (context) =>  const Favouriteresgetshimmer(),
          firstPageErrorIndicatorBuilder: (context)  => const Favouriteresgetshimmer(),
          noMoreItemsIndicatorBuilder: (_)           => const SizedBox(),
          newPageErrorIndicatorBuilder: (context)    => const Center(child: Text("No Orders available")),
          newPageProgressIndicatorBuilder: (context) => const SizedBox(),
          noItemsFoundIndicatorBuilder: (context)    => _buildNoDataScreen(context),
             
        ),
      ),
    );
 
  }
  Widget _buildNoDataScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         const CustomSizedBox(height: 80,),
          Image.asset("assets/images/empty order.png",height: 200,),
           const CustomSizedBox(height: 40,),
          const Text("No Orders History Available", style: CustomTextStyle.googlebuttontext),
          const Text("No Orders yet Delivered/Cancelled.", style: CustomTextStyle.blacktext)
        ],
      ),
    );
  }
}
String formatDate({required String dateStr}) {
  
  DateTime dateTime = DateTime.parse(dateStr);
  dateTime = dateTime.add(const Duration(hours: 5, minutes: 30));
  String formattedDate =  DateFormat("d MMM yyyy 'at' h:mma").format(dateTime).toLowerCase();
  
  return formattedDate;
}