// ignore_for_file: must_be_immutable, file_names, unnecessary_brace_in_string_interps, avoid_print

import 'package:dotted_line/dotted_line.dart';
import 'package:testing/Features/OrderScreen/OrderScreenController/RatingController.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Toast/customtoastmessage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class ParcelRatings extends StatefulWidget {


dynamic status;
dynamic address;

dynamic subAdminid;
dynamic delivermanid;
dynamic deliverymanname;
dynamic delivermanimg;
dynamic ratings;
dynamic vendorAdminid;
dynamic productCategoryId;
dynamic orderId;




  ParcelRatings({
  required this.delivermanid, this.orderId, this.deliverymanname, this.delivermanimg,
  required this.subAdminid,
  required this.vendorAdminid,
  required this.productCategoryId,
  required this.ratings,
   this.address,
  this.status,
  super.key});

  @override
  State<ParcelRatings> createState() => _ParcelRatingsState();
}

class _ParcelRatingsState extends State<ParcelRatings> {
  Ratingcontroller rating = Get.put(Ratingcontroller());
  TextEditingController restext=TextEditingController();
   TextEditingController deltext=TextEditingController();
  double rrating = 0; // Initial rating value
// Initial comment value
  double deliveryrating = 0;
  String? _selectedItem;
  String? delselectedItem;









  void _updateComment(double rating) {
    setState(() {
      rrating = rating;
      if (rating == 1) {
      } else if (rating == 2) {
      } else if (rating == 3) {
      } else if (rating == 4) {
      } else if (rating == 5) {
      }
    });
  }

void updatedelComment(double rating) {
    setState(() {
      deliveryrating = rating;
      print('${deliveryrating}');


      if (rating == 1) {
      } else if (rating == 2) {
      } else if (rating == 3) {
      } else if (rating == 4) {
      } else if (rating == 5) {
      }
    });
  }

  final List<String> deliveryitems = [
    "Fast Delivery",
    "Polite Attitude",
    "Neat & Clean",
    "Responsive",
    "Minimal Calling",
    "Food handling"
  ];

   int  selectedIndex = -1;
   int  selecteddeliveryIndex = -1;
   bool hasRestaurantRating=false;
   bool hasDeliverymanRating=false;


  @override
  void initState() {
    super.initState();
    if (widget.ratings.isNotEmpty) {
      for (var rating in widget.ratings) {


        if (rating['type'] == 'deliveryman') {
          hasDeliverymanRating = true;
          deltext.text = rating['instruction'] ?? '';
          deliveryrating = (rating['rating'] ?? 3).toDouble();
          final delItem = rating['review']?.trim() ?? '';

          if (deliveryitems.contains(delItem)) {
            setState(() {
              // selecteddeliveryIndex = items.indexOf(delItem);
              delselectedItem = delItem; // Highlight this item
            });
          } else {}
        }

      }
    }
  }

  @override
  Widget build(BuildContext context) {

    


  Widget builddelContainer(String item, int index) {
  bool isSelected = hasDeliverymanRating && delselectedItem == item||delselectedItem == item;
    return InkWell(
      onTap: () {
        setState(() {
          selecteddeliveryIndex = index;
          delselectedItem = item; // Update selected item
        });
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected
                ? Customcolors.darkpurple
                : Customcolors.DECORATION_GREY,
          ),
          gradient:  isSelected
              ? const LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [  Color(0xFFAE62E8),
 Color(0xFF623089)],
                )
              : const LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Customcolors.DECORATION_WHITE, Customcolors.DECORATION_WHITE],
                ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: Center(
          child: isSelected
              ? Text(
            item,
            softWrap: true,
            style: CustomTextStyle.white12text,
          ):Text(
            item,
            softWrap: true,
            style: CustomTextStyle.dividertext,
          ),
        ),
      ),
    );
  }
   
    return Scaffold(
      backgroundColor: Customcolors.DECORATION_CONTAINERGREY,
      appBar: AppBar(title: const Text('Rate Order',style: CustomTextStyle.blackbold14),centerTitle: true,),
      body  : SafeArea(
       child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start of the column
            children: [
     
        
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Customcolors.DECORATION_WHITE,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                          widget.delivermanimg != null?
                                   
    
                          CircleAvatar(backgroundImage: NetworkImage( widget.delivermanimg.toString()),radius: 25,)
                         
                                : Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    child: Image.asset(
                                      "assets/images/Profile.png",
                                      height: 45,
                                      width: 45,
                                    ),
                                  ),
                  
                            const SizedBox(
                                width:
                                    16), // Adjust spacing between image and text
                            Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // Align text to start of column
                              children:  [
                                Text(
                                  "${widget.deliverymanname.toString().capitalizeFirst}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Customcolors.DECORATION_BLACK,
                                    fontFamily: 'Poppins-Regular',
                                  ),
                                ),
                                const SizedBox(
                                    height: 3), // Adjust spacing between texts
                                const Text(
                                  "100+ 5star Deliveries",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Customcolors.DECORATION_BLACK,
                                    fontFamily: 'Poppins-Regular',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        "Your Rating For Delivery",
                        style: TextStyle(
                          fontSize: 14,
                          color: Customcolors.DECORATION_BLACK,
                          fontFamily: 'Poppins-Regular',
                        ),
                      ),
                      const SizedBox(height: 6),
                      RatingBar.builder(
                        initialRating: deliveryrating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 25,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 2),
                        itemBuilder: (context, _) => const DecoratedIcon(

                          icon: Icon(
                            Icons.star,
                            size: 36,
                            color: Colors.amber,
                            shadows: [Shadow(color: Colors.amber, blurRadius: 6)]),
                            decoration: IconDecoration( border: IconBorder(color: Colors.amber, width: 4)
                          ),
                        ),

                        onRatingUpdate: (rating) {
                          updatedelComment(rating);
                        },


                      ),
                      10.toHeight,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: DottedLine(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.center,
                          lineLength: double.infinity,
                          lineThickness: 1.0,
                          dashLength: 4.0,
                          dashColor: Colors.black,
                          dashGradient: const [
                            Color.fromARGB(255, 169, 169, 169),
                            Color.fromARGB(255, 185, 187, 188)
                          ],
                          dashRadius: 4,
                          dashGapLength: 6,
                          dashGapColor: Colors.white,
                          dashGapRadius: 5,
                        ),
                      ),
                       10.toHeight,
                      const Text(
                        "What did our delivery partner impress you with?",
                        style: TextStyle(
                          fontSize: 14,
                          color: Customcolors.DECORATION_BLACK,
                          fontFamily: 'Poppins-Regular',
                        ),
                      ),

                      10.toHeight,
                   
                      SizedBox(
                        height: 110,
                        child: ResponsiveGridList(
                          minItemWidth: 40,
                          maxItemsPerRow: 3,
                          minItemsPerRow: 3,
                          horizontalGridSpacing: 5,
                          horizontalGridMargin: 1,
                          listViewBuilderOptions: ListViewBuilderOptions(
                              physics: const NeverScrollableScrollPhysics()),
                          children: List.generate(
                            deliveryitems.length,
                            (index) =>builddelContainer (deliveryitems[index], index), 
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: DottedLine(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.center,
                          lineLength: double.infinity,
                          lineThickness: 1.0,
                          dashLength: 4.0,
                          dashColor: Colors.black,
                          dashGradient: const [
                            Color.fromARGB(255, 169, 169, 169),
                            Color.fromARGB(255, 185, 187, 188)
                          ],
                          dashRadius: 4,
                          dashGapLength: 6,
                          dashGapColor: Colors.white,
                          dashGapRadius: 5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                       cursorColor: Customcolors.DECORATION_GREY,
                       cursorWidth: 2.0,                           // Set the cursor width
                       cursorRadius: const Radius.circular(5.0), 
                      controller: deltext,
                        decoration: const InputDecoration(
                          hintText: 'Tell us what you loved',
                          hintStyle: CustomTextStyle.hinttextstyl,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 10),
                          isDense: false,
                          isCollapsed: false,
                          counterText: "",
                          errorMaxLines: 2,
                          fillColor: Colors.transparent,
                          filled: true,
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Customcolors.DECORATION_GREY),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Customcolors.DECORATION_GREY),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),


              Center(
                  child      : Container(
                  width      : MediaQuery.of(context).size.width * 0.9,
                  decoration :hasDeliverymanRating?CustomContainerDecoration.greybuttondecoration(): CustomContainerDecoration.gradientbuttondecoration(),
                     
                  child: ElevatedButton(
                    onPressed:hasDeliverymanRating? () {
                            AppUtils.showToast("You have already rated. Thank you! 😊");
                          }: () {




                      if(deliveryrating < 1){


                            AppUtils.showToast('Rate The DelivaryMan Before Submit');


                      }  else {


                        rating.adddelrating( 
                           type: "services",
                          isFromParcelFlow : true,
                          rating           : deliveryrating,
                          productOrUserId  : widget.delivermanid,
                          review           : delselectedItem ?? 'No Selection',
                          orderId          : widget.orderId,
                          instruction      : deltext.text,
                          productcateid    : widget.productCategoryId,
                          vendoradminid    : widget.vendorAdminid);

                        }

                           // Get.to(CancelOrderDetails());


                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent,  shadowColor: Colors.transparent),
                      

                    child: const Text( 'Submit', style: CustomTextStyle.loginbuttontext),
                     
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
