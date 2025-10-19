// // ignore_for_file: file_names

// ignore_for_file: file_names

import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Redirectcontroller.dart';
import 'package:testing/common/commonRedButton.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/CustomDottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'Adduserbottomsheet.dart';

class Additioninfo extends StatefulWidget {
  const Additioninfo({super.key});

  @override
  State<Additioninfo> createState() => AdditioninfoState();
}


class CheckboxController extends GetxController {
  var selectedCheckboxText = RxString('');

  void setSelectedCheckboxText(String text) {
    selectedCheckboxText.value = text;
  }

  void clearSelectedCheckboxText() {
    selectedCheckboxText.value = ''; // Reset to an empty string
  }
}




class AdditioninfoState extends State<Additioninfo> {
  CheckboxController checkboxController = Get.put(CheckboxController());
  RedirectController redirect =Get.put(RedirectController());
  String? pendingInstruction; // Hold the instruction temporarily

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // checkIFAlreadyCecked();
    });
    super.initState();
  }

  void _updateInstruction() {
    if (pendingInstruction != null) {
      Provider.of<InstantUpdateProvider>(context, listen: false).upDateInstruction(instruction: pendingInstruction!);
      Get.back(); // Close the modal or page if needed
    } else {
      Provider.of<InstantUpdateProvider>(context, listen: false).upDateInstruction(instruction: '');
      Get.back(); // Close the modal or page if needed

    }
  }


  @override
 
@override
Widget build(BuildContext context) {
  return Obx(() {
    if (redirect.isredirectLoading.value) {
      return const Center(child:  CupertinoActivityIndicator()); // or any custom loader
    }

    return CustomContainer(
      decoration: CustomContainerDecoration.whitecontainerdecoration(),
      height: 300.h,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Instructions for delivery partner",
              style: CustomTextStyle.googlebuttontext,
            ),
            const CustomSizedBox(height: 5),
            CustomSizedBox(height: 10.h),
            DotLine(),
            ..._buildRadioOptions(), // dynamically loaded options
            const CustomSizedBox(height: 10),
            const Divider(endIndent: 10, indent: 10),
            const CustomSizedBox(height: 10),
            Center(
              child: ReusableRedButton(
                height: 37,
                buttonName: 'Continue',
                ontap: _updateInstruction,
              ),
            ),
          ],
        ),
      ),
    );
  });
  
}


   // Method to build the radio options dynamically
  List<Widget> _buildRadioOptions() {
    List<Widget> radioWidgets = [];

    // Check if `deliveryinstructions` exists in redirect data
    if (redirect.redirectLoadingDetails["data"] != null) {
      var data = redirect.redirectLoadingDetails["data"];
      for (var item in data) {
        if (item['key'] == 'deliveryinstructions') {
          var instruction = item['value']; // This contains the instructions text
          radioWidgets.add(_buildRadioOption(instruction));
        }
      }
    }

    return radioWidgets;
  }

  // Create a single radio option widget
  Widget _buildRadioOption(String title) {
    return Obx(() => Transform.scale(
          scale: 1.1,
          child: RadioListTile<String>(
            activeColor: Customcolors.darkpurple,
            title: Text(
              title.capitalizeFirst.toString(),
              style: CustomTextStyle.profile,
            ),
            value: title,
            groupValue: checkboxController.selectedCheckboxText.value,
            onChanged: (value) {
              checkboxController.setSelectedCheckboxText(value!);
              pendingInstruction = value;
            },
          ),
        ));
  }
}
