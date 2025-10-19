// ignore_for_file: must_be_immutable, file_names

import 'package:testing/Mart/Common/MartButtonFunctionalites.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Martaddbutton extends StatefulWidget {
bool isFromSidebar;
 ValueNotifier<int> itemcountNotifier;
   Martaddbutton({super.key,this.isFromSidebar=false, required this.itemcountNotifier,});

  @override
  State<Martaddbutton> createState() => _MartaddbuttonState();
}

class _MartaddbuttonState extends State<Martaddbutton> {
bool isProcessing = false;
 MartButtonController martbuttoncontroller = MartButtonController();
  @override
  Widget build(BuildContext context) {
    return  CustomContainer(
    height:widget.isFromSidebar?22.h: 25.h,
      width:widget.isFromSidebar?75: 75.w,
      decoration: CustomContainerDecoration.gradientborderdecoration(
        radious: 8.0,
        borderwidth: 1.2,
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

                    

                      widget.itemcountNotifier.value = 1;

                    

                      martbuttoncontroller.martshowButton();
                      martbuttoncontroller.martincrementItemCount(1);
                    
                     setState(() {
                      isProcessing = false; // Reset processing flag after bottom sheet is done
                    });
                  },


                  
                  child: const Center(
                    child:  Text(
                      'ADD',
                      style: CustomTextStyle.midbold,
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
                             martbuttoncontroller.martdecrementItemCount(1);
                            //  Provider.of<FoodCartProvider>(context,listen: false).getfoodcartProvider(km: 5);
                            //  updateItemCount(widget.itemcountNotifier.value);
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
                          style: CustomTextStyle.meatbold,
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
                                      // updateItemCount(widget.itemcountNotifier.value);
                                      martbuttoncontroller.martincrementItemCount(1);
                                      martbuttoncontroller.martshowButton();
                                      // Provider.of<FoodCartProvider>(context,listen: false).getfoodcartProvider(km: 5);
                                    },
                                  child: const Icon(Icons.add, color: Customcolors.darkpurple,size: 15,weight: 20),
                                ),
                          ),
                      ),
                ],
            );
       
        },
      )
      
      
      // Center(
      //   child: Text('ADD',style: CustomTextStyle.midbold,),) ,
    );
  }

  // Future<void> updateItemCount(int itemCount) async {
  //   if (itemCount > 0) {
  //     await meatcart.updatemeatItem(meatid: widget.meatid, quantity: itemCount);
  //   } else {
  //     await meatcart
  //         .deleteCartItem(meatid: widget.meatid)
  //         .whenComplete(() async {
  //       var cartItems = await meatcart.getmeatcartmeat(km: 0);
  //       if (cartItems == null || cartItems.isEmpty) {
  //         meatbuttonController.hidemeatButton();
  //       }
  //       await meatbuttonController.updatemeatTotalItemCount(meatcart);
  //     });
  //   }
  // }
}