// ignore_for_file: must_be_immutable, avoid_print, file_names

import 'package:testing/Meat/MeatButtonFunctionalities/MeatAddproductController.dart/AddmeatController.dart';
import 'package:testing/Meat/MeatButtonFunctionalities/TotalitemcountButton.dart';
import 'package:testing/Meat/MeatOrderscreen/meatadditionalinfo.dart';
import 'package:testing/Meat/Meatview/MeatAddons.dart';
import 'package:testing/utils/Buttons/CustomAlertDialoug.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MeatbuttonNew extends StatefulWidget {
  dynamic totalDis; 
  final String shopId;
  dynamic meatindex;
  dynamic meatid;
  dynamic meatcustomerprice;
  dynamic shopname;
  final ValueNotifier<int> itemcountNotifier;

  MeatbuttonNew({
    super.key,
    required this.meatindex,
    required this.shopname,
    required this.shopId,
    required this.totalDis,
    required this.meatid,
    required this.meatcustomerprice,
    required this.itemcountNotifier,
  });

  @override
  State<MeatbuttonNew> createState() => MeatbuttonNewState();
}

class MeatbuttonNewState extends State<MeatbuttonNew> {
  MeatAddcontroller meatcart = Get.put(MeatAddcontroller());
  MeatButtonController meatbuttonController = MeatButtonController();
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      meatcart.getmeatcartmeat(km: widget.totalDis);
      meatbuttonController =
          Provider.of<MeatButtonController>(context, listen: false);
      checkIfItemInCart();
    });
  }

  Future<void> checkIfItemInCart() async {
    try {
      var cartItems = await meatcart.getmeatcartmeat(km:  widget.totalDis);
      var currentItem = cartItems.firstWhere(
        (item) => item['meatId'] == widget.meatid,
        orElse: () => null,
      );

      setState(() {
        if (currentItem != null) {
          widget.itemcountNotifier.value = currentItem['quantity'];
        } else {
          widget.itemcountNotifier.value = 0;
        }

        if (currentItem != null ||
            widget.itemcountNotifier.value != 0 ||
            currentItem.isNotEmpty) {
          meatbuttonController.showmeatButton();
        } else {
          meatbuttonController.hidemeatButton();
        }
      });

      await meatbuttonController.updatemeatTotalItemCount(meatcart);
    } catch (e) {
      print("Error checking if item is in cart: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
  var orderForOthers  = Provider.of<MeatInstantUpdateProvider>(context);

    return CustomContainer(
      height: 25.h,
      width: 92.w,
      decoration: CustomContainerDecoration.gradientborderdecoration(
        radious: 8.0,
        borderwidth: 0.6,
      ),
      child: ValueListenableBuilder<int>(
        valueListenable: widget.itemcountNotifier,
        builder: (context, itemCount, child) {
          return itemCount == 0
              ?  InkWell(

                  onTap: () async {

                      if (isProcessing) return;   // Prevent further clicks during processing
                                                  
                      setState(() {                
                        isProcessing = true;      // Set processing flag to true
                      });

                    await checkIfItemInCart();


                    var cartItems = await meatcart.getmeatcartmeat(km:  widget.totalDis);

                        var isDifferentshop = cartItems.any(
                          (item) => item['subAdminId'] != widget.shopId,
                        );


                    if ( cartItems !=null &&  isDifferentshop ) {

                      Future.delayed(Duration.zero,() {
          
                              CustomLogoutDialog.show(
                                    context: context,
                                    title:   'Replace Cart Item?',
                                    content:  "You can only add products from one shop at a time. Do you want to clear the cart?",
                                    onConfirm: () async {
                                     if (widget.meatindex["iscustomizable"] == true || cartItems==null ) {
                     
                         await meatcart.clearmeatCartItem(context: context);
                                       meatcart.getmeatcartmeat(km:  widget.totalDis);
                                      // Future.delayed(Duration.zero,() => getStorage.write(gRestaurantId,''));
                                      meatbuttonController.totalItemCountNotifier.value = 0;
                                        Navigator.pop(context);
                        addonsBottomSheet(
                          context  : context,
                          addons   : widget.meatindex["customizedFood"]["addOns"],
                          variants : widget.meatindex["customizedFood"]["addVariants"],
                        );
                    }
                    else{         await meatcart.clearmeatCartItem(context: context);
                                           meatcart.getmeatcartmeat(km:  widget.totalDis);
                                      // Future.delayed(Duration.zero,() => getStorage.write(gRestaurantId,''));
                                      meatbuttonController.totalItemCountNotifier.value = 0;
                                      widget.itemcountNotifier.value = 1;
        meatcart.addmeat(
          meatid: widget.meatid,
          isCustomized: false,
          quantity: widget.itemcountNotifier.value,
          shopId: widget.shopId,
        );

        meatbuttonController.showmeatButton();
        meatbuttonController.incrementmeatItemCount(1);

        setState(() {
          isProcessing = false; // Reset processing flag
        });
                                      Navigator.pop(context);}
                                      setState(() {
                                          meatorderForSomeOneName = '';
                                          meatorderForSomeOnePhone ='';
                                        });
                                        orderForOthers.meatupDateInstruction(instruction: '');
                                        orderForOthers.meatupdateSomeOneDetaile(someOneName:'', someOneNumber: '');

                                    
                                    },
                                    buttonname: 'Replace', oncancel: () { 
                                            Navigator.pop(context); });
                                  },
                              );
                            }
                    
                     else if (widget.meatindex["iscustomizable"] == true || cartItems==null ) {
                     
                        addonsBottomSheet(
                          context  : context,
                          addons   : widget.meatindex["customizedFood"]["addOns"],
                          variants : widget.meatindex["customizedFood"]["addVariants"],
                        );
                    }


                     else {

                      widget.itemcountNotifier.value = 1;

                      // Future.delayed(Duration.zero,() => getStorage.write(gRestaurantId,widget.restaurantId.toString()));      

                      meatcart.addmeat(
          meatid: widget.meatid,
          isCustomized: false,
          quantity: widget.itemcountNotifier.value,
          shopId: widget.shopId,
        );

                      meatbuttonController.showmeatButton();
                      meatbuttonController.incrementmeatItemCount(1);
                    }
                     setState(() {
                      isProcessing = false; // Reset processing flag after bottom sheet is done
                    });
                  },


                  
                  child: Center(
                    child: Text(
                      'ADD',
                      style: CustomTextStyle.addbtn,
                    ),
                  ),
                ): Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: SizedBox(
                        // color: Colors.amber,
                        height: MediaQuery.of(context).size.height/1,
                        child: InkWell(
                          onTap: () async {

                                widget.itemcountNotifier.value--;

                            if (widget.itemcountNotifier.value <= 0) {

                                widget.itemcountNotifier.value = 0;
                                // Future.delayed(Duration.zero,() => getStorage.write(gRestaurantId,''));

                            }
                             meatbuttonController.decrementmeatItemCount(1);
                            //  Provider.of<FoodCartProvider>(context,listen: false).getfoodcartProvider(km: 5);
                             updateItemCount(widget.itemcountNotifier.value);
                          },
                          child: const Icon(Icons.remove, color: Customcolors.darkpurple,size: 15,weight: 20),
                             
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          '$itemCount',
                          style: CustomTextStyle.addbtn,
                          // style: CustomTextStyle.decorationORANGEtext22,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),

                      Expanded(
                          child: SizedBox(
                            // color: Colors.amber,
                            height: MediaQuery.of(context).size.height/1,
                                child: InkWell(
                                    onTap: () {

                                      // print('yeah its Clicked...');

                                      widget.itemcountNotifier.value++;
                                      updateItemCount(widget.itemcountNotifier.value);
                                      meatbuttonController.incrementmeatItemCount(1);
                                      meatbuttonController.showmeatButton();
                                      // Provider.of<FoodCartProvider>(context,listen: false).getfoodcartProvider(km: 5);
                                    },
                                  child: const Icon(Icons.add, color: Customcolors.darkpurple,size: 15,weight: 20),
                                ),
                          ),
                      ),
                ],
            );
       
        },
      ),
    );
  }

  Future<void> updateItemCount(int itemCount) async {
    if (itemCount > 0) {
      await meatcart.updatemeatItem(meatid: widget.meatid, quantity: itemCount);
    } else {
      await meatcart
          .deleteCartItem(meatid: widget.meatid)
          .whenComplete(() async {
        var cartItems = await meatcart.getmeatcartmeat(km: 0);
        if (cartItems == null || cartItems.isEmpty) {
          meatbuttonController.hidemeatButton();
        }
        await meatbuttonController.updatemeatTotalItemCount(meatcart);
      });
    }
  }

  
  Future<dynamic> addonsBottomSheet({
    required BuildContext context,
    required variants,
    required addons,
  }) {
    return showModalBottomSheet(
      backgroundColor: Customcolors.DECORATION_WHITE,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Meataddons(
          shopname: widget.shopname,
          customizedFoodvariants: variants,
          addOns: addons,
          shopid: widget.shopId,
          meatid: widget.meatid,
          itemcountNotifier: widget.itemcountNotifier,
        );
      },
    );
  }

}
