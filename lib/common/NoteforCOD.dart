// ignore_for_file: file_names

import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:flutter/material.dart';

class PaymentNote extends StatelessWidget {
final dynamic totalAmount;
  const PaymentNote({super.key,this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.lightGreen[100], // Light green background color
        borderRadius: BorderRadius.circular(8), // Rounded corners
        border: Border.all(color: Colors.lightGreen), // Border color
      ),
      child: Text(
        'Big orders, big perks! For purchases over ₹${totalAmount.toStringAsFixed(2)}, use online payment for a smooth checkout.',
        style: CustomTextStyle.notegreentext,
        textAlign: TextAlign.center,
      ),
    );
  }
}
