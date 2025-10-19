// ignore_for_file: must_be_immutable, file_names

import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class UnavailableFoodItem extends StatelessWidget {
  final VoidCallback onTap;

  const UnavailableFoodItem({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Unavailable text
         Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: Colors.red[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.red,
                width: 0.5,
              ),
            ),
            child: const Text(
              "Unavailable",
              style: CustomTextStyle.notetext,
              textAlign: TextAlign.center,
            ),
          ),
        // SizedBox(width: 10), // Space between "Unavailable" and icon
        // Delete icon button
        IconButton(
          icon: Icon(MdiIcons.trashCanOutline),
          onPressed: onTap,
        ),
      ],
    );
  }
}
