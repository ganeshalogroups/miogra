// ignore_for_file: file_names

import 'package:testing/Features/Foodmodule/Domain/Foodnonvegmodel.dart';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Addfoodcontroller.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Addons.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cartcustomisation extends StatefulWidget {
  final String foodid;
  final dynamic iscustomizable;
  final dynamic foodtype;
  final dynamic resname;
  final dynamic resid;
  final VoidCallback? onUpdated;
  const Cartcustomisation({
    super.key,
    required this.foodid, this.iscustomizable, this.foodtype, this.resname, this.resid, this.onUpdated, 
  });

  @override
  State<Cartcustomisation> createState() => _CartcustomisationState();
}

class _CartcustomisationState extends State<Cartcustomisation> {
Foodcartcontroller getcustomisation =Get.put(Foodcartcontroller());
  bool _isExpanded = false;
   List<AddOn> addOnList = [];
  List<AddVariant> variantList = [];


  void _toggleCustomizationSheet() async {
  await getcustomisation.getcustomisationDetails(foodid: widget.foodid);



 if( widget.iscustomizable==true){ addOnList = (getcustomisation.customisationDetails["data"][0]["customizedFood"]["addOns"] as List)
    .map((addOn) => AddOn.fromJson(addOn)).toList();

    // Convert customizedFoodvariants from JSON to List<AddVariant>
 variantList =  (getcustomisation.customisationDetails["data"][0]["customizedFood"]["addVariants"] as List) .map((variant) => AddVariant.fromJson(variant)).toList();}else{const SizedBox();}
 

    if (!_isExpanded) {
      setState(() {
        _isExpanded = true;
      });

      await addonsBottomSheet(
        context: context,
        customizedFoodvariants: variantList,
        addOns:addOnList,
        foodtype: widget.foodtype,
        restaurantname: widget.resname,
        itemcountNotifier: ValueNotifier<int>(1),
        foodcustomerprice:  getcustomisation.customisationDetails["data"][0]["food"]["customerPrice"],
        resid: widget.resid,
        foodid: widget.foodid,
      ).whenComplete(() {
  // 🔁 When bottom sheet closes, refresh the cart UI
  if (widget.onUpdated != null) {
    widget.onUpdated!(); // 👈 This will trigger load() and updateOrderDetails()
  }
});

      setState(() {
        _isExpanded = false; // Reset back to down arrow after sheet closes
      });
    } else {
      setState(() {
        _isExpanded = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCustomizationSheet,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "View Customisation",
            style: CustomTextStyle.mapgrey12,
          ),
          Icon(
            _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: Customcolors.DECORATION_GREY,
            size: 24,
          )
        ],
      ),
    );
  }

  Future<dynamic> addonsBottomSheet({
  required BuildContext context,
  required customizedFoodvariants,
  required addOns,
  required String foodtype,
  required restaurantname,
  required itemcountNotifier,
  required foodcustomerprice,
  required resid,
  required foodid,
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
      return CustomiseAddons(
        totalDis: "5",
        restaurantname: restaurantname,
        foodcustomerprice: foodcustomerprice,
        foodtype: foodtype,
        customizedFoodvariants: customizedFoodvariants,
        addOns: addOns,
        restaurantid: resid,
        foodid: foodid,
        itemcountNotifier: itemcountNotifier,
        isFromCartScreen: true,
      );
    },
  );
}

}
