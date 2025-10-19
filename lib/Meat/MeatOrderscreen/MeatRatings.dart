// ignore_for_file: must_be_immutable, file_names

import 'package:dotted_line/dotted_line.dart';
import 'package:testing/Features/OrderScreen/OrderScreenController/RatingController.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatOrderHistoryTabbar/MeatOrdersTab.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Toast/customtoastmessage.dart';
import 'package:testing/utils/exitapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class MeatRatings extends StatefulWidget {
  dynamic status;
  dynamic address;
  dynamic shopName;
  dynamic subAdminid;
  dynamic delivermanid;
  dynamic deliverymanname;
  dynamic delivermanimg;
  dynamic ratings;
  dynamic vendorAdminid;
  dynamic productCategoryId;
  dynamic orderId;
  MeatRatings(
      {required this.delivermanid,
      this.orderId,
      this.deliverymanname,
      this.delivermanimg,
      required this.subAdminid,
      required this.vendorAdminid,
      required this.productCategoryId,
      this.shopName,
      required this.ratings,
      this.address,
      this.status,
      super.key});

  @override
  State<MeatRatings> createState() => _MeatRatingsState();
}

class _MeatRatingsState extends State<MeatRatings> {
  Ratingcontroller rating = Get.put(Ratingcontroller());
  TextEditingController restext = TextEditingController();
  TextEditingController deltext = TextEditingController();
  double _rating = 0; // Initial rating value
// Initial comment value
  double deliveryrating = 0;
  String? _selectedItem;
  String? delselectedItem;
  void _updateComment(double rating) {
    setState(() {
      _rating = rating;
      if (rating == 1) {
      } else if (rating == 2) {
      } else if (rating == 3) {
      } else if (rating == 4) {
      } else if (rating == 5) {}
    });
  }

  void updatedelComment(double rating) {
    setState(() {
      deliveryrating = rating;
      if (rating == 1) {
      } else if (rating == 2) {
      } else if (rating == 3) {
      } else if (rating == 4) {
      } else if (rating == 5) {}
    });
  }

  final List<String> items = [
    "Meat Quality",
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
    "Meat handling"
  ];

  int selectedIndex = -1;
  int selecteddeliveryIndex = -1;
  bool hasRestaurantRating = false;
  bool hasDeliverymanRating = false;
  bool isButtonDisabled = false;

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
              selecteddeliveryIndex = items.indexOf(delItem);
              delselectedItem = delItem; // Highlight this item
            });
          } else {}
        }
        if (rating['type'] == 'meat') {
          hasRestaurantRating = true;
          // Set the initial values based on the rating data
          _rating = (rating['rating'] ?? 3).toDouble();
          restext.text =
              rating['instruction'] ?? ''; // Set the text field value
          // Update the comment based on the rating
          _updateComment(_rating);
          final selectedItem = rating['review'];

          if (items.contains(selectedItem)) {
            setState(() {
              selectedIndex = items.indexOf(selectedItem);
              _selectedItem = selectedItem; // Update selected item
            });
          }
        }
      }
      setState(() {
        isButtonDisabled = deliveryrating > 0 && _rating > 0;
      });
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    Widget buildContainer(String item, int index) {
      bool isSelected =
          hasRestaurantRating && _selectedItem == item || _selectedItem == item;
      return InkWell(
        onTap: () {
          setState(() {
            selectedIndex = index;
            _selectedItem = item; // Update selected item
          });
        },
        child: Center(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: isSelected
                    ? Customcolors.darkpurple
                    : Customcolors.DECORATION_GREY,
              ),
              gradient: isSelected
                  ? const LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Customcolors.lightpurple,Customcolors.darkpurple],
                    )
                  : const LinearGradient(
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
              child: isSelected
                  ? Text(
                      item,
                      softWrap: true,
                      style: CustomTextStyle.white12text,
                    )
                  : Text(
                      item,
                      softWrap: true,
                      style: CustomTextStyle.dividertext,
                    ),
            ),
          ),
        ),
      );
    }

    Widget builddelContainer(String item, int index) {
      bool isSelected = hasDeliverymanRating && delselectedItem == item ||
          delselectedItem == item;
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
            gradient: isSelected
                ? const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Customcolors.lightpurple,
                Customcolors.darkpurple],
                  )
                : const LinearGradient(
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
            child: isSelected
                ? Text(
                    item,
                    softWrap: true,
                    style: CustomTextStyle.white12text,
                  )
                : Text(
                    item,
                    softWrap: true,
                    style: CustomTextStyle.dividertext,
                  ),
          ),
        ),
      );
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        await ExitApp.meatratingpop();
      },
      child: Scaffold(
        backgroundColor: Customcolors.DECORATION_CONTAINERGREY,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start of the column
              children: [
                InkWell(
                  onTap: () {
                    Get.off(const MeatOrderTab());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start, // Align children to the start (left) of the row
                    children: [
                      const Icon(
                        Icons.arrow_back,
                        color: Customcolors.DECORATION_BLACK,
                      ), // Icon widget
                      const SizedBox(width:13), // Add some space between the icon and text
                      Text(
                        widget.shopName.toString(),
                        style: CustomTextStyle.boldblack2,
                      ),
                      const Spacer(),
                      Text(
                        "${widget.status}",
                        style: CustomTextStyle.greenordertext,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36),
                      child: Text(
                        "${widget.address}",
                        style: CustomTextStyle.mapgrey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
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
                          "Your Rating For Meat",
                          style: TextStyle(
                            fontSize: 14,
                            color: Customcolors.DECORATION_BLACK,
                            fontFamily: 'Poppins-Regular',
                          ),
                        ),
                        const SizedBox(height: 6),
                        RatingBar.builder(
                          initialRating: _rating,
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
                            _updateComment(rating);
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
                          "What did the shop impress you with?",
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
                            children: [
                              widget.delivermanimg != null
                                  ? CircleAvatar(
                                      backgroundImage: NetworkImage(widget.delivermanimg.toString()),
                                      radius: 25,
                                    )
                                  : Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      child: Image.asset(
                                        "assets/images/Profile.png",
                                        height: 45,
                                        width: 45,
                                      ),
                                    ),
                              const SizedBox(width:16), // Adjust spacing between image and text
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start, // Align text to start of column
                                children: [
                                  Text(
                                    "${widget.deliverymanname.toString().capitalizeFirst}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Customcolors.DECORATION_BLACK,
                                      fontFamily: 'Poppins-Regular',
                                    ),
                                  ),
                                  const SizedBox(height:3), // Adjust spacing between texts
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
                              shadows: [
                                Shadow(color: Colors.amber, blurRadius: 6),
                              ],
                            ),
                            decoration: IconDecoration(
                              border: IconBorder(color: Colors.amber, width: 4),
                            ),
                          ),
                          onRatingUpdate: (rating) {
                            updatedelComment(rating);
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
                          "What did the shop impress you with?",
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
                            listViewBuilderOptions: ListViewBuilderOptions(physics: const NeverScrollableScrollPhysics()),
                            children: List.generate(
                              deliveryitems.length,
                              (index) => builddelContainer(deliveryitems[index], index),
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
                    decoration: isButtonDisabled
                        ? CustomContainerDecoration.greybuttondecoration()
                        : CustomContainerDecoration.gradientbuttondecoration(),
                    child: ElevatedButton(
                      onPressed: isButtonDisabled
                          ? () {
                            AppUtils.showToast("You have already rated. Thank you! 😊");
                          } // Disable button if `isButtonDisabled` is true
                          : () {
                              if (deliveryrating < 1 && _rating < 1) {
                                AppUtils.showToast("Please rate both the Delivery Person and Shop.");
                              } else {
                                rating.addmeatrating(
                                    rating: _rating,
                                    productOrUserId: widget.subAdminid,
                                    review: _selectedItem ?? 'No Selection',
                                    orderId: widget.orderId,
                                    instruction: restext.text,
                                    productcateid: widget.productCategoryId,
                                    vendoradminid: widget.vendorAdminid);

                                rating.adddelrating(
                                    isFrommeatFlow: true,
                                    type: "meat",
                                    rating: deliveryrating,
                                    productOrUserId: widget.delivermanid,
                                    review: delselectedItem ?? 'No Selection',
                                    orderId: widget.orderId,
                                    instruction: deltext.text,
                                    productcateid: widget.productCategoryId,
                                    vendoradminid: widget.vendorAdminid);
                              }

                              // Get.to(CancelOrderDetails());
                            },
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
