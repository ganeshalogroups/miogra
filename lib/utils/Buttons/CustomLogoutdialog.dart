// ignore_for_file: file_names

import 'package:testing/Features/Authscreen/Loginscreen.dart';
import 'package:testing/utils/Buttons/CustomButton.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginRequiredDialog extends StatelessWidget {
  final String title;
  final String content;
  final String cancelText;
  final String confirmText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const LoginRequiredDialog({
    super.key,
    this.title = "Login Required",
    this.content = "Please login to add this item to your cart.",
    this.cancelText = "No",
    this.confirmText = "Login",
    this.onConfirm,
    this.onCancel,
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
      content: Text(
        content,
        textAlign: TextAlign.center,
        style: CustomTextStyle.grey12,
      ),
      buttonPadding: const EdgeInsets.symmetric(horizontal: 10),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: onCancel ??
              () {
                Navigator.of(context).pop();
              },
          child: Container(
            height: 44,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Customcolors.DECORATION_GREY),
            ),
            child: Center(
              child: Text(
                cancelText,
                style: CustomTextStyle.grey12,
              ),
            ),
          ),
        ),
        CustomButton(
          borderRadius: BorderRadius.circular(30),
          width: 100,
          onPressed: () {
            Navigator.of(context).pop();
            if (onConfirm != null) {
              onConfirm!();
            } else {
              Get.offAll(() => const Loginscreen());
            }
          },
          child: Text(
            confirmText,
            style: CustomTextStyle.alertbutton,
          ),
        ),
      ],
    );
  }
}