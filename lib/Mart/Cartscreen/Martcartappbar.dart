// ignore_for_file: file_names

import 'package:testing/Mart/Cartscreen/MartBillwidget.dart';
import 'package:testing/Mart/Cartscreen/MartCouponWidget.dart';
import 'package:testing/Mart/Cartscreen/MartItemDetails.dart';
import 'package:testing/common/cartscreenWidgets.dart';
import 'package:testing/common/commonTextWidgets.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Decorations/boxDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MartCartappbar extends StatefulWidget {
  const MartCartappbar({super.key});

  @override
  State<MartCartappbar> createState() => _MartCartappbarState();
}

class _MartCartappbarState extends State<MartCartappbar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Customcolors.DECORATION_CONTAINERGREY,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 65.h,
        backgroundColor: Customcolors.DECORATION_CONTAINERGREY,
        surfaceTintColor: Customcolors.DECORATION_CONTAINERGREY,
        titleSpacing: 0,
        leading: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Customcolors.DECORATION_BLACK,
          ),
        ),
        title: CartAppBarTitle(
          title: "Moguls Restaurant",
          subTitlel: "Parvathipuram, Nagercoil",
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            /// Address Section
            Container(
              decoration: BoxDecorationsFun.whiteCircelRadiusDecoration(),
              padding: const EdgeInsets.all(12.0),
              child: InkWell(
                onTap: () {},
                child: const CartAddressBar(
                  addressType: "Home",
                  fullAddress: "82b/2, Grown street,...",
                ),
              ),
            ),
            const SizedBox(height: 10),

            /// Item Details Section
            Container(
              decoration: BoxDecorationsFun.whiteCircelRadiusDecoration(radious: 10.0),
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Item Details",
                    style: CustomTextStyle.boldblack12,
                  ),
                  SizedBox(height: 5.h),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: 2,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => const SizedBox(height: 5),
                    itemBuilder: (BuildContext context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const MartItemdetails(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomContainer(
                                    height: 20.h,
                                    width: 65.w,
                                    decoration: CustomContainerDecoration.meatcartgreybuttondecoration(
                                      radious: 7.0,
                                      borderwidth: 0.6,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "ADD",
                                        style: CustomTextStyle.whitemediumtext,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            const Divider(color: Customcolors.DECORATION_LIGHTGREY),
                          ],
                        ),
                      );
                    },
                  ),
                  InkWell(
                    onTap: () {},
                    child: ViewMoreTextArrow(content: "Add more item"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            /// Coupon Section
            const MartCouponWidget(),
            SizedBox(height: 10.h),
            const MartBillwidget()
          ],
        ),
      ),
    );
  }
}

