// ignore_for_file: file_names

import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Reorderscreen.dart';
import 'package:testing/Features/OrderScreen/OrderScreenController/OrdersHistorycontroller.dart';
import 'package:testing/Features/OrderScreen/Orderstatus.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/CustomDottedline.dart';
import 'package:testing/utils/Shimmers/FavouriteResgetshimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

class FoodOrderHistory extends StatefulWidget {
  const FoodOrderHistory({super.key});

  @override
  State<FoodOrderHistory> createState() => _FoodOrderHistoryState();
}

class _FoodOrderHistoryState extends State<FoodOrderHistory> {

  OrderHistoryPaginController ordercntoller = Get.put(OrderHistoryPaginController());

 final List<String> imagetext = [
    "Delivered",
    "Cancelled",
    "Processed",
  ];


  @override
  void initState() {
    ordercntoller.getOrderHistoryController.refresh();
    super.initState();
  }



  @override
  void dispose() {
    // ordercntoller.dispose();
    super.dispose();
  }



  refresh() async {
      await Future.delayed(const Duration(seconds: 2),() {
      ordercntoller.getOrderHistoryController.refresh();
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
        pagingController: ordercntoller.getOrderHistoryController,
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(16.0),
        builderDelegate: PagedChildBuilderDelegate<dynamic>(
          animateTransitions: true,
          transitionDuration: const Duration(milliseconds: 500),
          itemBuilder: (context, orders, index) {
      
      final statusDate = orders['orderStatus'] == "delivered"
    ? orders['deliveredAt']
    : orders['orderStatus'] == "rejected"
        ? orders['rejectedAt']
        : orders['orderStatus'] == "cancelled"
            ? orders['cancelledAt']
            : orders['orderStatus'];
       
              
      
                            return InkWell(
                            onTap: () {
                              
                                  var   formatedDate       = formatDate(dateStr: orders['createdAt']);
                                   var formatedCancelledDate    = orders['cancelledAt'] != null ? formatDate(dateStr: orders['cancelledAt']) : '';
                                   var formatedDeliveredDate    = orders['deliveredAt'] != null ? formatDate(dateStr: orders['deliveredAt']) : '';
                                   var formatedRejectedDate     = orders['rejectedAt'] != null ? formatDate(dateStr: orders['rejectedAt']) : '';
                                dynamic platformfee = orders.containsKey('amountDetails')? orders['amountDetails']["platformFee"]  : "";
                          
                                dynamic deliverymanimg     = orders.containsKey('assigneeDetails') ? orders['assigneeDetails']["imgUrl"]  : "";
                                dynamic deliverymanname    = orders.containsKey('assigneeDetails') ? orders['assigneeDetails']["name"] : "";              
                                dynamic razorpaymentId     = orders.containsKey('paymentDetails')  ? orders['paymentDetails']["razorPayPaymentId"] : "";  
                                dynamic razorpaymentstatus = orders.containsKey('paymentDetails')  ? orders['paymentDetails']["paymentStatus"] : "";      
                                dynamic razorPayRefundId   = orders.containsKey('paymentDetails')  ? orders['paymentDetails']["razorPayRefundId"] : "";   

                                Get.to(
                                    Orderstatus(
                                    platformfee: platformfee,
                                      packagingCharge: orders['amountDetails']['packingCharges'],
                                      km: orders['totalKms'],
                                      timeinmins: orders['tripDetails'] != null && orders['tripDetails']["tripTime"] != null
                                      ? orders['tripDetails']["tripTime"] : 0,
                                      invoicePath: orders["invoicePath"],
                                      razorPayRefundId: razorPayRefundId,
                                      paymentStatus: razorpaymentstatus,
                                      razorpaymentId:razorpaymentId ,
                                      deliveredAt: formatedDeliveredDate,
                                      cancelledAt: formatedCancelledDate,
                                      rejectedAt: formatedRejectedDate,
                                      vendorAdminid     :  orders ["vendorAdminId"],
                                      productCategoryId :  orders["productCategoryId"],
                                      ratings           :  orders['ratings'] ,
                                      couponDiscount    : orders['amountDetails']['couponsAmount'],
                                      delivaryAddress   : orders['dropAddress'][0]['fullAddress'].toString().capitalizeFirst.toString(),
                                      delivaryAddresstype:orders['dropAddress'][0]['addressType'].toString().capitalizeFirst.toString(),   
                                      delivaryFee       : orders['amountDetails']['deliveryCharges'],
                                      deliverytip       : orders['amountDetails']['tips'],
                                      grandtotal        : orders['amountDetails']['finalAmount'],
                                      gst               : orders['amountDetails']['tax'],
                                      recievername      : orders['dropAddress'][0]['contactPerson'].toString().capitalizeFirst.toString(), 
                                      recievernumber    : orders['dropAddress'][0]['contactPersonNumber'].toString().capitalizeFirst.toString(),
                                      instructions      : orders['dropAddress'][0]['instructions'].toString().capitalizeFirst.toString(),  
                                      itemTotal         : orders['amountDetails']['cartFoodAmountWithoutCoupon'],
                                      rejectedreason    : orders['rejectedNote'],
                                      orderDate         : formatedDate,
                                      orderId           : orders['orderCode'],
                                      paymentMethod     : orders["paymentMethod"],
                                      resAddres         : orders['pickupAddress'][0]['fullAddress'].toString().capitalizeFirst.toString(),
                                      resName           : orders['pickupAddress'][0]['name'].toString().capitalizeFirst.toString(),
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
                              ? CustomTextStyle.trackgreenordertext : CustomTextStyle.trackredmarktext
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
                              Text(formatDate(dateStr:statusDate),
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
                                        horizontal: 0, vertical: 6),
                                    child: orders['ordersDetails'][index]['foodType'] == 'veg'  ? iconfun(imageName: vegIcon) : orders['ordersDetails'][index]['foodType'] ==  'nonveg' ? iconfun(imageName: nonvegIcon)  : iconfun(imageName: eggIcon),
                                  ),
                                     
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
                            size: Size(MediaQuery.of(context).size.width / 1,
                                20), // Adjust size here
                            painter: DottedLinePainter(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text("₹ ${double.parse(orders['amountDetails']['finalAmount'].toString()).toStringAsFixed(2)}",
                                  style: CustomTextStyle.black14bold,),

                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(Icons.arrow_forward_ios,
                                      color: Customcolors.DECORATION_BLACK,
                                      size: 15),
                                     ],
                              ),
                             orders['subAdminDetails']["activeStatus"]=="offline"|| orders['subAdminDetails']["status"]==false?
                             Container(
                            padding: const EdgeInsets.all(8),
                             decoration: BoxDecoration(
                             color: Colors.grey[200], // light grey background
                             border: Border.all(
                             color: Colors.grey, // grey border
                             width: 1.0,
                             ),
                              borderRadius: BorderRadius.circular(8), // optional rounded corners
                             ),
                             child: const Text(
                            'Not available at the moment',
                             style: CustomTextStyle.addressfetch
                             ),
                             ):
                               InkWell(
                               onTap: () {
                                Get.to(ReorderFood( 
                                cartidlist: orders["cartId"],
                                fulladdress: orders['pickupAddress'][0]['fullAddress'].toString().capitalizeFirst.toString(),
                                restaurantname:  orders['pickupAddress'][0]['name'],
                                // useraddress:orders['dropAddress'][0]['fullAddress'].toString().capitalizeFirst.toString() ,
                                // addressType:orders['dropAddress'][0]['addressType'].toString().capitalizeFirst.toString(),
                                restaurantid:orders['subAdminId'] ,
                                //dropAddress: orders['dropAddress'][0],
                                kilometre: orders["totalKms"],
                                ));
                               },
                                 child: CustomContainer(
                                        decoration: CustomContainerDecoration.gradientbuttondecoration(),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 18),
                                          child: Center(
                                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                              Icon(Icons.replay_outlined,color: Customcolors.DECORATION_WHITE,size: 20,),
                                              SizedBox(width: 5,),
                                                Text(
                                                  "Re Order",
                                                  style: CustomTextStyle.smallwhitetext,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                               )
                               
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
         const CustomSizedBox(height: 120,),
          Image.asset("assets/images/empty order.png",height: 200,),
           const CustomSizedBox(height: 40,),
          const Text("No Orders History Available", style: CustomTextStyle.googlebuttontext),
          SizedBox(height: 5.h,),
          const Text("No Orders yet Delivered/Cancelled.", style: CustomTextStyle.blacktext)
        ],
      ),
    );
  }
}



Widget iconfun({imageName}) {
  return Image(
    image: AssetImage(
      imageName,
    ),
    height: 15,
    width: 20,
  );
}

// String formatDate({required String dateStr}) {
  
//   DateTime dateTime = DateTime.parse(dateStr);
//   dateTime = dateTime.add(Duration(hours: 5, minutes: 30));
//   String formattedDate =  DateFormat("d MMM yyyy 'at' h:mma").format(dateTime).toLowerCase();
  
//   return formattedDate;
// }

// Modified formatDate function to handle nulls
String formatDate({String? dateStr}) {
  if (dateStr == null || dateStr.isEmpty) {
    return '';
  }

  try {
    DateTime dateTime = DateTime.parse(dateStr);
    dateTime = dateTime.add(const Duration(hours: 5, minutes: 30));
    String formattedDate =
        DateFormat("d MMM yyyy 'at' h:mma").format(dateTime).toLowerCase();
    return formattedDate;
  } catch (e) {
    return 'Invalid date';
  }
}