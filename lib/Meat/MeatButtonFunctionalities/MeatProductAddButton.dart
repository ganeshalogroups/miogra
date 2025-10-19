// ignore_for_file: file_names, must_be_immutable

import 'package:testing/Features/Foodmodule/getFoodCartProvider.dart';
import 'package:testing/Meat/MeatButtonFunctionalities/MeatAddproductController.dart/AddmeatController.dart';
import 'package:testing/Meat/MeatButtonFunctionalities/TotalitemcountButton.dart';
import 'package:testing/Meat/MeatOrderscreen/CartAppbar.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MeatAddproductbutton extends StatefulWidget {
  dynamic shopId;
  String? shopname;
  String? shopcity;
  String? shopregion;
  String? shopimg;
  bool isfromTabscreen;
  String? fulladdress;
   dynamic rating;
   final List meatfavourListDetails;
   dynamic shop;
   dynamic totalDis;
  MeatAddproductbutton({
    required this.shopId,
    required this.shopcity,
    required this.shopname,
    required this.fulladdress,
    required this.shopregion,
    required this.shopimg,
    required this.shop,
    required this.rating,
    required this.totalDis,
    this.isfromTabscreen = false,
    this.meatfavourListDetails = const [],
    super.key});

  @override
  State<MeatAddproductbutton> createState() => _MeatAddproductbuttonState();
}

class _MeatAddproductbuttonState extends State<MeatAddproductbutton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    MeatAddcontroller meatcart = Get.put(MeatAddcontroller());
    var meatbuttoncontroller = Provider.of<MeatButtonController>(context);
    var cartProvider = Provider.of<FoodCartProvider>(context, listen: false);
    return Consumer<MeatButtonController>(
      builder: (context, buttonController, child) {
        return ValueListenableBuilder<int>(
          valueListenable: buttonController.totalItemCountNotifier,
          builder: (context, totalCount, child) {
            return Positioned(
              right: 10,
              bottom: 0,
              left: 10,
              child: totalCount == 0
                  ? const SizedBox() // If totalCount is 0, hide the button
                  : isLoading
                      ? Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: CustomContainerDecoration
                              .gradientbuttondecoration(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                '${meatbuttoncontroller.totalItemCountNotifier.value} item added',
                                style: CustomTextStyle.whitemediumtext,
                              ),
                              const Material(
                                color: Colors.transparent,
                                child: Row(
                                  children: [
                                    CupertinoActivityIndicator(
                                        color: Colors.white),
                                    Icon(Icons.arrow_forward_ios,
                                        color: Customcolors.DECORATION_WHITE),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: CustomContainerDecoration
                              .gradientbuttondecoration(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                '${meatbuttoncontroller.totalItemCountNotifier.value} item added',
                                style: CustomTextStyle.whitemediumtext,
                              ),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius:const BorderRadius.all(Radius.circular(10)),
                                  onTap: () {
                                  setState(() {
                                  isLoading = true;
                                   });

                                  cartProvider.searchShop(shopId: widget.shopId).then((value) {
                                  double totalDistance = double.parse(cartProvider.totalDis.split(' ').first.toString());

                                  meatcart.getbillmeatcartmeat(km: totalDistance);
                                  Future.delayed(Duration.zero, () {
                                 Get.to(CartitemsScreen(
                                     shopId: widget.shopId,
                                     fulladdress: widget.fulladdress,
                                     shopcity:widget.shopcity, 
                                     shopname: widget.shopname, 
                                     shopregion:widget.shopregion, 
                                     meatfavourListDetails:widget.meatfavourListDetails ,
                                     shopimg: widget.shopimg, rating: widget.rating,
                                     totalDis: totalDistance, shop: widget.shop,),transition: Transition.leftToRight);
                                  });
                                 }).whenComplete(() {
                                 setState(() {
                                 isLoading = false;
                                  });
                                 });
                                },
                                  child: Row(
                                    children: [
                                      isLoading
                                          ? const CupertinoActivityIndicator()
                                          : const Text("View Cart",
                                              style: CustomTextStyle
                                                  .whitemediumtext),
                                      const Icon(Icons.arrow_forward_ios,
                                          color: Customcolors.DECORATION_WHITE),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
            );
          },
        );
      },
    );
  }
}
