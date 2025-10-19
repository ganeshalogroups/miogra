// ignore_for_file: file_names

import 'package:testing/Mart/Cartscreen/Martcartappbar.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MartAddProductButton extends StatefulWidget {



  const MartAddProductButton({ 
    super.key,
   
  });

  @override
  State<MartAddProductButton> createState() => _MartAddProductButtonState();
}



class _MartAddProductButtonState extends State<MartAddProductButton> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    var btncontroll = Provider.of<MartButtonController>(context);

    return Consumer<MartButtonController>(
      builder: (context, buttonController, child) {
        return ValueListenableBuilder<int>(
          valueListenable: buttonController.totalItemCountNotifier,
          builder: (context, totalCount, child) {



            return Positioned(
              right  : 10,
              bottom : 0,
              left   : 10,
              child  : 
              // totalCount == 0
              //     ? const SizedBox() // If totalCount is 0, hide the button 
              //     : isLoading? 
                  
              //     Container(
              //         height: 50,
              //         width: MediaQuery.of(context).size.width * 0.9,
              //         decoration: CustomContainerDecoration.gradientbuttondecoration(),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceAround,
              //           children: [
              //             Text(
              //               '${btncontroll.totalItemCountNotifier.value} item added',
              //               style: CustomTextStyle.whitemediumtext,
              //             ),
              //             Material(
              //               color: Colors.transparent,
              //               child: Row(
              //                 children:  const [
              //                   CupertinoActivityIndicator(color: Colors.white),
              //                   Icon(Icons.arrow_forward_ios, color: Customcolors.DECORATION_WHITE),
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //       )
                  
                  
              //     : 
                  Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: CustomContainerDecoration.gradientbuttondecoration(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            '${btncontroll.totalItemCountNotifier.value} item added',
                             style: CustomTextStyle.whitemediumtext,
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              onTap: () {
                                   Get.to(const MartCartappbar());


                                      // setState(() {
                                      //   isLoading = true;
                                      // });


                                      // cartProvider.searchRes(restaurantId: widget.restaurantId).then((value) {


                                      //         double  totalDistance = double.parse(cartProvider.totalDis.split(' ').first.toString());

                                      //         foodcart.getbillfoodcartfood(km: totalDistance);



                                      //          print('$totalDistance  =====> hello world1');


                                      //  Future.delayed(Duration.zero,() {
                                        
                                      //            Get.off(AddToCartScreen(
                                      //                   isFromtab        : widget.isfromTabscreen,
                                      //                   additionalImages : widget.additionalImages,
                                      //                   // totalDis: widget.totalDis,
                                      //                   totalDis         :  totalDistance,
                                      //                   favourListDetails:  widget.favourListDetails,
                                      //                   menu             :  widget.menu,
                                      //                   restaurant       :  widget.restaurant,
                                      //                   restaurantId     :  widget.restaurantId,
                                      //                   restaurantcity   :  widget.restaurantcity,
                                      //                   restaurantfoodtitle: widget.restaurantfoodtitle,
                                      //                   restaurantimg    :   widget.restaurantimg,
                                      //                   restaurantname   :   widget.restaurantname,
                                      //                   restaurantregion :  widget.restaurantregion,
                                      //                   restaurantreview :  widget.restaurantreview,
                                      //                   reviews          :  widget.reviews, fulladdress:widget.fulladdress ,),
                                      //                   transition       : Transition.rightToLeft,
                                      //                   );
                                      //  },);




                                      //                 }
                                      //               ).whenComplete(() {

                                      //                  setState(() {
                                      //                   isLoading = false;
                                      //                   });

                                      //               }
                                      //             );



                              },

                              
                              child: Row(
                                children:  [
                                  isLoading ? const CupertinoActivityIndicator() : const Text("View Cart", style: CustomTextStyle.whitemediumtext),
                                  const Icon(Icons.arrow_forward_ios, color: Customcolors.DECORATION_WHITE),
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



class MartButtonController with ChangeNotifier {
  bool _isButtonVisible = false;
  ValueNotifier<int> totalItemCountNotifier = ValueNotifier<int>(0);

  bool get isButtonVisible => _isButtonVisible;

  void martshowButton() {
    _isButtonVisible = true;
    notifyListeners();
  }

  void marthideButton() {
    _isButtonVisible = false;
     totalItemCountNotifier.value = 0;
    notifyListeners();
  }

void martincrementItemCount(int count) {
    totalItemCountNotifier.value += count;
    notifyListeners();
  }

  void martdecrementItemCount(int count) {
    totalItemCountNotifier.value = (totalItemCountNotifier.value - count).clamp(0, double.infinity).toInt();
    loge.i(count);
    notifyListeners();
  }



// Future<void> martupdateTotalItemCount(Foodcartcontroller foodcart, dynamic km) async {

//     try {

//         var cartItems = await foodcart.getfoodcartfood(km: km);
//         int totalQuantity = cartItems.fold(0, (sum, item) => sum + (item['quantity'] ?? 0),
//       );

//         loge.i('==Total Quantity --==> $totalQuantity');
//         totalItemCountNotifier.value = totalQuantity;

      
//       notifyListeners();
//     } catch (e) {
//       print("Error updating total item count: $e");
//     }
//   }

}