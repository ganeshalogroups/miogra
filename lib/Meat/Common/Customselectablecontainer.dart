// ignore_for_file: file_names

import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Decorations/ContainerDecorations.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart'; // For responsive design

class CustomSelectableContainer extends StatelessWidget {
  final String text; // Text to display
  final bool isSelected; // Whether the container is selected
  final TextStyle textStyle; // Text style to use
  final EdgeInsetsGeometry padding; // Padding for the content inside the container
   final VoidCallback? onTap;
    final VoidCallback? onCancelTap; // Function to execute when the cancel icon is tapped

  const CustomSelectableContainer({
    super.key,
    required this.text,
    this.isSelected = false,
    required this.textStyle,
    required this.onTap,
       required this.onCancelTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 8.0), // Default padding
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius:const BorderRadius.all( Radius.circular(20)) ,
      onTap: onTap,
      child: Container(
        // height: 25.h, 
        decoration: CustomBoxDecoration().isBoxCheckedDecoration(isSelected: isSelected), // Custom decoration based on selection
        padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 8), // Padding around the content
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, // Aligns text to the left
          children: [
            Flexible(
              child: Text(
                text, // The text content
                style:isSelected? CustomTextStyle
                                .midwhitetext: textStyle,
                                textAlign: TextAlign.center, 
                                  softWrap: true,
              ),
            ),
            if (isSelected) ...[
              GestureDetector(
                onTap: onCancelTap,
                child: Icon(
                  MdiIcons.close,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
