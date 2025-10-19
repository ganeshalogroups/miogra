import 'package:testing/common/commonRedButton.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/CustomDottedline.dart';
import 'package:testing/utils/Decorations/boxDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MeatAdditioninfo extends StatefulWidget {
  const MeatAdditioninfo({super.key});

  @override
  State<MeatAdditioninfo> createState() => _MeatAdditioninfoState();
}


class AdditionalinfocheckboxController extends GetxController {
  var selectedCheckboxText = RxString('');

  void setSelectedCheckboxText(String text) {
    selectedCheckboxText.value = text;
  }

  void clearSelectedCheckboxText() {
    selectedCheckboxText.value = ''; // Reset to an empty string
  }
}


class MeatAddDeliveryInstructions extends StatelessWidget {
  
  final VoidCallback onTapp;
  const MeatAddDeliveryInstructions({super.key,required this.onTapp});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapp,
      child: Container(
        height: 40,
        decoration: BoxDecorationsFun.whiteCircelRadiusDecoration(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Consumer<MeatInstantUpdateProvider>(
                builder: (context, value, child) {
                  if (value.meatdelInstruction != '') {
                    return Text(value.meatdelInstruction,
                        style: CustomTextStyle.carttblack);
                  } else {
                    return const Text('Add Delivery Instructions',
                        style: CustomTextStyle.carttblack);
                  }
                },
              ),
              const Icon(Icons.keyboard_arrow_right,
                  color: Customcolors.DECORATION_GREY),
            ],
          ),
        ),
      ),
    );
  }
}

class _MeatAdditioninfoState extends State<MeatAdditioninfo> {
  AdditionalinfocheckboxController checkboxController = Get.put(AdditionalinfocheckboxController());
  String? pendingInstruction; // Hold the instruction temporarily

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkIFAlreadyCecked();
    });
    super.initState();
  }

  void checkIFAlreadyCecked() {
    var upDates = Provider.of<MeatInstantUpdateProvider>(context, listen: false);
    if (upDates.meatdelInstruction != '') {
      if (upDates.meatdelInstruction == "Don’t Ring the Bell") {
        _onCheckboxChanged(2, true, "Don’t Ring the Bell");
      } else if (upDates.meatdelInstruction == "Avoid Calling") {
        _onCheckboxChanged(1, true, "Avoid Calling");
      } else {
        _onCheckboxChanged(3, true, "Leave at Door");
      }
    }
  }

  void _onCheckboxChanged(int checkboxIndex, bool? value, String text) {
    setState(() {
      if (value == true) {
        checkboxController.setSelectedCheckboxText(text);
        pendingInstruction = text; // Save locally
      } else {
        checkboxController.setSelectedCheckboxText('');
        pendingInstruction = null; // Reset if unchecked
      }
    });
  }

  void _updateInstruction() {
    if (pendingInstruction != null) {
      Provider.of<MeatInstantUpdateProvider>(context, listen: false).meatupDateInstruction(instruction: pendingInstruction!);
      Get.back(); // Close the modal or page if needed
    } else {
      Provider.of<MeatInstantUpdateProvider>(context, listen: false).meatupDateInstruction(instruction: '');
      Get.back(); // Close the modal or page if needed

    }
  }


  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      decoration: CustomContainerDecoration.whitecontainerdecoration(),
      height: 280.h,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Instructions for delivery partner",
              style: CustomTextStyle.googlebuttontext,
            ),
            const CustomSizedBox(height: 5),
            CustomSizedBox(height: 10.h),
            DotLine(),
            Column(
              children: [
                _buildCheckboxRow(
                  title: "Avoid Calling",
                  isSelected: checkboxController.selectedCheckboxText.value == "Avoid Calling",
                  onChanged: (value) => _onCheckboxChanged(1, value, "Avoid Calling"),
                ),
                _buildCheckboxRow(
                  title: "Don’t Ring the Bell",
                  isSelected: checkboxController.selectedCheckboxText.value == "Don’t Ring the Bell",
                  onChanged: (value) => _onCheckboxChanged(2, value, "Don’t Ring the Bell"),
                ),
                _buildCheckboxRow(
                  title: "Leave at Door",
                  isSelected: checkboxController.selectedCheckboxText.value == "Leave at Door",
                  onChanged: (value) => _onCheckboxChanged(3, value, "Leave at Door"),
                ),
              ],
            ),
            const CustomSizedBox(height: 10),
            const Divider(endIndent: 10, indent: 10),
            const CustomSizedBox(height: 10),
            Center(
              child: ReusableRedButton(
                buttonName: 'Continue',
                ontap: _updateInstruction,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckboxRow(
      {required String title, required bool isSelected, required ValueChanged<bool?> onChanged}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: CustomTextStyle.profile,
          ),
        ),
        Checkbox(
          activeColor: Customcolors.darkpurple,
          value: isSelected,
          onChanged: onChanged,
        ),
      ],
    );
  }
}




class MeatInstantUpdateProvider with ChangeNotifier {
//Order For SomeOne
  String meatsomeName = '';
  String meatsomeNumber = '';

  String get otherName => meatsomeName;
  String get otherNumber => meatsomeNumber;

// Add Delivary Instruction

  String meatdelInstruction = '';
  String get delivaryInstruction => meatdelInstruction;

  meatupdateSomeOneDetaile({someOneName, someOneNumber}) {
    meatsomeName = someOneName;
    meatsomeNumber = someOneNumber;
    notifyListeners();
  }

  meatupDateInstruction({instruction}) {
    meatdelInstruction = instruction;
    notifyListeners();
  }
}
