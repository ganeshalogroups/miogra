// ignore_for_file: file_names

import 'package:testing/utils/Buttons/CustomButton.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';

class CustomLogoutDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
    final VoidCallback oncancel;
  final String buttonname;

  const CustomLogoutDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    required this.buttonname,
    required this.oncancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
       surfaceTintColor: Customcolors.DECORATION_WHITE,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Center(
        child: Text(
          title,
          style: CustomTextStyle.boldblack18,
        ),
      ),
      buttonPadding: const EdgeInsets.symmetric(horizontal: 10),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: oncancel,
          child: Container(
            height: 44,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Customcolors.DECORATION_GREY),
            ),
            child: const Center(
              child: Text(
                'No',
                style: CustomTextStyle.grey12,
              ),
            ),
          ),
        ),
        CustomButton(
          borderRadius: BorderRadius.circular(5),
          width: 100,
          onPressed: onConfirm,
          child: Text(
            buttonname,
            style: CustomTextStyle.alertbutton,
          ),
        ),
      ],
      content: Text(
        content,
        style: CustomTextStyle.grey12,
      ),
    );
  }





  static void show({
    required BuildContext context,
    required String title,
    required String content,
    required VoidCallback onConfirm,
    required VoidCallback oncancel,
    required String buttonname,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomLogoutDialog(
          title: title,
          content: content,
          onConfirm: onConfirm,
          buttonname: buttonname,
          oncancel:oncancel,
        );
      },
    );
  }
}



class CustomcartLogoutDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
  final String buttonname;

  const CustomcartLogoutDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    required this.buttonname,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
       surfaceTintColor: Customcolors.DECORATION_WHITE,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Center(
        child: Text(
          title,
          style: CustomTextStyle.boldblack18,
        ),
      ),
      buttonPadding: const EdgeInsets.symmetric(horizontal: 10),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        CustomButton(
          borderRadius: BorderRadius.circular(30),
          width: 120,
          onPressed: onConfirm,
          child: Text(
            buttonname,
            style: CustomTextStyle.alertbutton,
          ),
        ),
      ],
      content: Text(
        content,
        style: CustomTextStyle.grey12,
      ),
    );
  }





  static void show({
    required BuildContext context,
    required String title,
    required String content,
    required VoidCallback onConfirm,
    required String buttonname,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomcartLogoutDialog(
          title: title,
          content: content,
          onConfirm: onConfirm,
          buttonname: buttonname,
        );
      },
    );
  }
}





// Cart Dialog



class CustomclearcartDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
  final String buttonname;

  const CustomclearcartDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    required this.buttonname,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
       surfaceTintColor: Customcolors.DECORATION_WHITE,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Center(
        child: Text(
          title,
          style: CustomTextStyle.boldblack18,
        ),
      ),
      buttonPadding: const EdgeInsets.symmetric(horizontal: 10),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        CustomButton(
          borderRadius: BorderRadius.circular(30),
          width: 120,
          onPressed: onConfirm,
          child: Text(
            buttonname,
            style: CustomTextStyle.alertbutton,
          ),
        ),
      ],
      content: Text(
        content,
        style: CustomTextStyle.grey12,
      ),
    );
  }





  static void show({
    required BuildContext context,
    required String title,
    required String content,
    required VoidCallback onConfirm,
    required String buttonname,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomclearcartDialog(
          title: title,
          content: content,
          onConfirm: onConfirm,
          buttonname: buttonname,
        );
      },
    );
  }
}
