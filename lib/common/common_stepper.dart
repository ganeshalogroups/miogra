import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomStepperWid extends StatelessWidget {
  int activeindex;
  dynamic status;
  bool isParcelflow;
  CustomStepperWid({super.key, required this.activeindex, this.status,this.isParcelflow = false});

  List<StepperData> buildStepperData({required int activeIndex}) {
    final titles = isParcelflow ?  [
      "Your Order Has Been Received",
      "Delivery Man Assigned",
      "Your package has been picked up for delivery.",
      "Delivery partner reached door",
      "Package delivered",
    ] : [
      "Restaurant accepted the order",
      "Order assigned to delivery partner",
      "Order picked up",
      "Delivery partner reached door",
      "Order delivered"
    ];

    const TextStyle activeTextStyle = CustomTextStyle.DECORATION_regulartext;
    const TextStyle inactiveTextStyle = CustomTextStyle.chipgrey;
    const Color activeColor = Customcolors.darkpurple;
    const Color inactiveColor = Customcolors.DECORATION_GREY;

    return List.generate(
      titles.length,
      (index) {
        final isActive = activeIndex >= index + 1;
        return StepperData(
          title: StepperText(
            titles[index],
            textStyle: isActive ? activeTextStyle : inactiveTextStyle,
          ),
          iconWidget: Container(
            decoration: BoxDecoration(
              color: isActive ? activeColor : inactiveColor,
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
            child: isActive ? const Center(child: Icon(Icons.check, size: 13, color: Colors.white)) : null ,
               
          ),
        );
      },
    );
  }




  @override
  Widget build(BuildContext context) {
    return AnotherStepper(
      stepperList: buildStepperData(activeIndex: activeindex),
      stepperDirection: Axis.vertical,
      iconWidth: 20,
      iconHeight: 20,
      activeBarColor: Customcolors.darkpurple,
      inActiveBarColor: Customcolors.DECORATION_GREY,
      inverted: false,
      verticalGap: 12,
      activeIndex: activeindex,
      barThickness: 1,
    );
  }
}
