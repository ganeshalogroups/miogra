// ignore_for_file: file_names

import 'package:dotted_line/dotted_line.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class Matratings extends StatefulWidget {
  const Matratings({super.key});

  @override
  State<Matratings> createState() => _MatratingsState();
}

class _MatratingsState extends State<Matratings> {
  TextEditingController restext = TextEditingController();
  TextEditingController deltext = TextEditingController();

  final List<String> items = [
    "Food Quality",
    "Packaging",
    "Portion size",
    "Value For Money",
    "Taste",
    "Customer Service"
  ];
  final List<String> deliveryitems = [
    "Fast Delivery",
    "Polite Attitude",
    "Neat & Clean",
    "Responsive",
    "Minimal Calling",
    "Food handling"
  ];
  @override
  Widget build(BuildContext context) {
    Widget buildContainer(String item, int index) {
      return InkWell(
        onTap: () {
        },
        child: Center(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Customcolors.DECORATION_GREY,
              ),
              gradient: const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Customcolors.DECORATION_WHITE,
                      Customcolors.DECORATION_WHITE
                    ],
                  ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Center(
              child: Text(
                      item,
                      softWrap: true,
                      style: CustomTextStyle.dividertext,
                    )
                 
            ),
          ),
        ),
      );
    }

    Widget builddelContainer(String item, int index) {
      // bool isSelected = hasDeliverymanRating && delselectedItem == item ||
      //     delselectedItem == item;
      return InkWell(
        onTap: () {
          // setState(() {
          //   selecteddeliveryIndex = index;
          //   delselectedItem = item; // Update selected item
          // });
        },
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color:Customcolors.DECORATION_GREY,
            ),
            gradient:  const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Customcolors.DECORATION_WHITE,
                      Customcolors.DECORATION_WHITE
                    ],
                  ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Center(
            child: Text(
                    item,
                    softWrap: true,
                   style: CustomTextStyle.dividertext,
                  )
          ),
        ),
      );
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
      },
      child: Scaffold(
        backgroundColor: Customcolors.DECORATION_CONTAINERGREY,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .start, // Align children to the start of the column
              children: [
                InkWell(
                  onTap: () {
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment
                        .start, // Align children to the start (left) of the row
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: Customcolors.DECORATION_BLACK,
                      ), // Icon widget
                      SizedBox(
                          width:
                              13), // Add some space between the icon and text
                      Text(
                        "Time Pass Restaurant",
                        style: CustomTextStyle.boldblack2,
                      ),
                      Spacer(),
                      Text(
                        "delivered",
                        style: CustomTextStyle.greenordertext,
                      ),
                    ],
                  ),
                ),
                const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 36),
                      child: Text(
                        "Parvathipuram, Nagercoil ",
                        style: CustomTextStyle.mapgrey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  // height: 90.h,
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Customcolors.DECORATION_WHITE,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Your Rating For Food",
                          style: TextStyle(
                            fontSize: 14,
                            color: Customcolors.DECORATION_BLACK,
                            fontFamily: 'Poppins-Regular',
                          ),
                        ),
                        const SizedBox(height: 6),
                        RatingBar.builder(
                          initialRating: 4,
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
                              shadows: [
                                Shadow(color: Colors.amber, blurRadius: 6),
                              ],
                            ),
                            decoration: IconDecoration(
                              border: IconBorder(color: Colors.amber, width: 4),
                            ),
                          ),
                          onRatingUpdate: (rating) {
                          },
                        ),
                        const SizedBox(height: 10),
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
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "What did the restaurant impress you with?",
                          style: TextStyle(
                            fontSize: 14,
                            color: Customcolors.DECORATION_BLACK,
                            fontFamily: 'Poppins-Regular',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
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
                              items.length,
                              (index) => buildContainer(items[index], index),
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
                          cursorWidth: 2.0, // Set the cursor width
                          cursorRadius: const Radius.circular(5.0),
                          controller: restext,
                          decoration: const InputDecoration(
                            hintText: 'Tell us what you loved',
                            helperStyle: CustomTextStyle.grey12,
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
                              borderSide: BorderSide(
                                  color: Customcolors.DECORATION_GREY),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Customcolors.DECORATION_GREY),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
                Container(
                  // height: 90.h,
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Customcolors.DECORATION_WHITE,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [ Container(
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
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment
                                    .start, // Align text to start of column
                                children: [
                                  Text(
                                    "Jeru",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Customcolors.DECORATION_BLACK,
                                      fontFamily: 'Poppins-Regular',
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          3), // Adjust spacing between texts
                                  Text(
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
                          initialRating: 3,
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
                              shadows: [
                                Shadow(color: Colors.amber, blurRadius: 6),
                              ],
                            ),
                            decoration: IconDecoration(
                              border: IconBorder(color: Colors.amber, width: 4),
                            ),
                          ),
                          onRatingUpdate: (rating) {
                          },
                        ),
                        const SizedBox(height: 10),
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
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "What did the restaurant impress you with?",
                          style: TextStyle(
                            fontSize: 14,
                            color: Customcolors.DECORATION_BLACK,
                            fontFamily: 'Poppins-Regular',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
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
                              (index) => builddelContainer(
                                  deliveryitems[index], index),
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
                          cursorWidth: 2.0, // Set the cursor width
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
                              borderSide: BorderSide(
                                  color: Customcolors.DECORATION_GREY),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Customcolors.DECORATION_GREY),
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
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: CustomContainerDecoration.gradientbuttondecoration(),
                    child: ElevatedButton(
                    onPressed: () {
                      
                    },
                      // onPressed: isButtonDisabled
                      //     ? () {
                      //       AppUtils.showToast("You have already rated. Thank you! 😊");
                      //     } // Disable button if `isButtonDisabled` is true
                      //     : () {
                      //         if (deliveryrating < 1 && _rating < 1) {
                      //           AppUtils.showToast(
                      //               "Please rate both the Delivery Person and Restaurant.");
                      //         } else {
                      //           rating.addrating(
                      //               rating: _rating,
                      //               productOrUserId: widget.subAdminid,
                      //               review: _selectedItem ?? 'No Selection',
                      //               orderId: widget.orderId,
                      //               instruction: restext.text,
                      //               productcateid: widget.productCategoryId,
                      //               vendoradminid: widget.vendorAdminid);

                      //           rating.adddelrating(
                      //             type: "restaurant",
                      //               rating: deliveryrating,
                      //               productOrUserId: widget.delivermanid,
                      //               review: delselectedItem ?? 'No Selection',
                      //               orderId: widget.orderId,
                      //               instruction: deltext.text,
                      //               productcateid: widget.productCategoryId,
                      //               vendoradminid: widget.vendorAdminid);
                      //         }

                      //         // Get.to(CancelOrderDetails());
                      //       },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: const Text(
                        'Submit',
                        style: CustomTextStyle.loginbuttontext,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
