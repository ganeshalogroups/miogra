// ignore_for_file: avoid_print

import 'package:testing/parcel/p_parcel_orders/p_history_details.dart';
import 'package:testing/parcel/p_services_provider/p_historyController.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/CustomDottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../Features/OrderScreen/Orderslist.dart';

class PArcelOrderHistory extends StatefulWidget {
  const PArcelOrderHistory({super.key});

  @override
  State<PArcelOrderHistory> createState() => _PArcelOrderHistoryState();
}

class _PArcelOrderHistoryState extends State<PArcelOrderHistory> {
  @override
  void initState() {
    var getOrderprovider =
        Provider.of<ParcelOrdersHistoryProvider>(context, listen: false);

    getOrderprovider.clearallData().then((value) {
      getOrderprovider.getParcelOrdersPAgination(pageKey: 0);
    });

    super.initState();
  }

  int incrementval = 0;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          // Check the type of notification
          if (notification is ScrollStartNotification) {
            print("Scroll started");
          } else if (notification is ScrollUpdateNotification) {
            print("Scrolling... Offset: ${notification.metrics.pixels}");
          } else if (notification is ScrollEndNotification) {
            var orderHistoryPagination =
                Provider.of<ParcelOrdersHistoryProvider>(context,
                    listen: false);

            if (orderHistoryPagination.getAllDataHistorys.length ==
                orderHistoryPagination.totalCount) {
              print('Incremented Value ========> $incrementval');
            } else {
              setState(() {
                incrementval++;
              });

              orderHistoryPagination.getParcelOrdersPAgination(
                  pageKey: incrementval);
            }
          }

          return true;
        },
        child: Column(
          children: [
            Expanded(
              child: Consumer<ParcelOrdersHistoryProvider>(
                builder: (context, value, child) {
                  if (value.isLoading) {
                    return SizedBox(
                        width: MediaQuery.of(context).size.width / 1,
                        child: const Center(
                            child: CupertinoActivityIndicator(
                          color: Colors.black,
                        )));
                  } else if (value.getAllDataHistorys.isEmpty) {
                    return Center(child: _buildNoDataScreen(context));
                  } else {
// _isLoading ? _data.length + 1 : _data.length,

                    return ListView.separated(
                        itemCount: value.isNextPageLoad
                            ? value.getAllDataHistorys.length + 1
                            : value.getAllDataHistorys.length,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 15),
                        padding: const EdgeInsets.all(12.0),
                        itemBuilder: (context, index) {
                          //  if (index >= _data.length) {
                          //                 return Center(
                          //                   child: Padding(
                          //                     padding: const EdgeInsets.all(16.0),
                          //                     child: CupertinoActivityIndicator(),
                          //                   ),
                          //                 );
                          //               }

                          if (index >= value.getAllDataHistorys.length) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: CupertinoActivityIndicator(),
                              ),
                            );
                          }

                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  var formatedDate = formatDate(
                                      dateStr: value.getAllDataHistorys[index]
                                          ['createdAt']);

                                  dynamic deliverymanimg = value
                                          .getAllDataHistorys[index]
                                          .containsKey('assigneeDetails')
                                      ? value.getAllDataHistorys[index]
                                          ['assigneeDetails']["imgUrl"]
                                      : "";

                                  dynamic deliverymanname = value
                                          .getAllDataHistorys[index]
                                          .containsKey('assigneeDetails')
                                      ? value.getAllDataHistorys[index]
                                          ['assigneeDetails']["name"]
                                      : "";
                                  dynamic razorpaymentId = value
                                          .getAllDataHistorys[index]
                                          .containsKey('paymentDetails')
                                      ? value.getAllDataHistorys[index]
                                              ['paymentDetails']
                                          ["razorPayPaymentId"]
                                      : "";
                                  dynamic razorpaymentstatus = value
                                          .getAllDataHistorys[index]
                                          .containsKey('paymentDetails')
                                      ? value.getAllDataHistorys[index]
                                          ['paymentDetails']["paymentStatus"]
                                      : "";
                                  dynamic razorPayRefundId = value
                                          .getAllDataHistorys[index]
                                          .containsKey('paymentDetails')
                                      ? value.getAllDataHistorys[index]
                                          ['paymentDetails']["razorPayRefundId"]
                                      : "";

                                  Get.to(
                                      ParcelOrderHistoryDetails(
                                        // deliveryType
                                        triptype:
                                            value.getAllDataHistorys[index]
                                                ['deliveryType'],
                                        dropAddressType: value
                                                .getAllDataHistorys[index]
                                            ['dropAddress'][0]['addressType'],
                                        pickupAddresType: value
                                                .getAllDataHistorys[index]
                                            ['pickupAddress'][0]['addressType'],
                                        dropaddress: value
                                                .getAllDataHistorys[index]
                                            ['dropAddress'][0]['fullAddress'],
                                        pickupaddress: value
                                                .getAllDataHistorys[index]
                                            ['pickupAddress'][0]['fullAddress'],
                                        parcelDetails:
                                            value.getAllDataHistorys[index]
                                                ['parcelDetails'],

                                        km: value.getAllDataHistorys[index]
                                            ['totalKms'],
                                        invoicePath:
                                            value.getAllDataHistorys[index]
                                                ["invoicePath"],
                                        razorPayRefundId: razorPayRefundId,
                                        razorpaymentId: razorpaymentId,
                                        ratings: value.getAllDataHistorys[index]
                                            ["ratings"],
                                        vendorAdminid:
                                            value.getAllDataHistorys[index]
                                                ["vendorAdminId"],
                                        productCategoryId:
                                            value.getAllDataHistorys[index]
                                                ["productCategoryId"],
                                        couponDiscount: value
                                                .getAllDataHistorys[index]
                                            ['amountDetails']['couponsAmount'],
                                        delivaryAddress: value
                                            .getAllDataHistorys[index]
                                                ['dropAddress'][0]
                                                ['fullAddress']
                                            .toString()
                                            .capitalizeFirst
                                            .toString(),
                                        delivaryAddresstype: value
                                            .getAllDataHistorys[index]
                                                ['dropAddress'][0]
                                                ['addressType']
                                            .toString()
                                            .capitalizeFirst
                                            .toString(),
                                        delivaryFee:
                                            value.getAllDataHistorys[index]
                                                    ['amountDetails']
                                                ['deliveryCharges'],
                                        grandtotal: value
                                                .getAllDataHistorys[index]
                                            ['amountDetails']['finalAmount'],
                                        gst: value.getAllDataHistorys[index]
                                            ['amountDetails']['tax'],
                                        itemTotal:
                                            value.getAllDataHistorys[index]
                                                    ['amountDetails']
                                                ['cartFoodAmountWithoutCoupon'],
                                        orderId: value.getAllDataHistorys[index]
                                            ['orderCode'],
                                        paymentMethod: value
                                                .getAllDataHistorys[index]
                                            ['paymentDetails']["paymentMode"],
                                        resName: value.getAllDataHistorys[index]
                                                ['pickupAddress'][0]['name']
                                            .toString()
                                            .capitalizeFirst
                                            .toString(),
                                        status: value.getAllDataHistorys[index]
                                            ['orderStatus'],
                                        subAdminid:
                                            value.getAllDataHistorys[index]
                                                ['subAdminId'],
                                        delivermanid:
                                            value.getAllDataHistorys[index]
                                                    ['assignedToId'] ??
                                                "",
                                        ordergetid: value
                                            .getAllDataHistorys[index]['_id'],
                                        couponType:
                                            value.getAllDataHistorys[index]
                                                        ['amountDetails']
                                                    ['couponType'] ??
                                                "",
                                        deliverymanimg: deliverymanimg,
                                        deliverymanname: deliverymanname,
                                        orderDate: formatedDate,
                                        paymentStatus: razorpaymentstatus,
                                        platformfee: value
                                                .getAllDataHistorys[index]
                                            ['amountDetails']['platformFee'],
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 15),
                                          child: Text(
                                              value.getAllDataHistorys[index]
                                                      ['orderStatus']
                                                  .toString()
                                                  .capitalizeFirst
                                                  .toString(),
                                              style: value.getAllDataHistorys[
                                                              index]
                                                          ['orderStatus'] ==
                                                      "delivered"
                                                  ? CustomTextStyle
                                                      .greenordertext
                                                  : CustomTextStyle
                                                      .redmarktext),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              value.getAllDataHistorys[index]
                                                      ['parcelDetails']
                                                      ['packageType']
                                                  .toString()
                                                  .capitalizeFirst
                                                  .toString(),
                                              style: CustomTextStyle.boldblack2,
                                            ),
                                            Text(
                                                value.getAllDataHistorys[index]
                                                        ['orderCode']
                                                    .toString(),
                                                style:
                                                    CustomTextStyle.smallgrey)
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                            '${value.getAllDataHistorys[index]['deliveryType'].toString().capitalizeFirst} Trip',
                                            style: CustomTextStyle.black14),
                                        const SizedBox(height: 20),
                                        CustomPaint(
                                          size: Size(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1,
                                              20), // Adjust size here
                                          painter: DottedLinePainter(),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                                "₹ ${value.getAllDataHistorys[index]['amountDetails']['finalAmount'].toStringAsFixed(2)}",
                                                style: CustomTextStyle
                                                    .black14bold),
                                            10.toWidth,
                                            const Icon(Icons.arrow_forward_ios,
                                                color: Customcolors
                                                    .DECORATION_BLACK,
                                                size: 15)
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
                        });
                  }
                },
              ),
            ),
          ],
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
          const CustomSizedBox(
            height: 80,
          ),
          Image.asset(
            "assets/images/No orders.png",
            height: 200,
          ),
          const CustomSizedBox(height: 40),
          const Text(
            "You haven’t made any orders yet. Start exploring and place your first order now!",
            style: CustomTextStyle.blacktext,
          ),
        ],
      ),
    );
  }
}
