// ignore_for_file: file_names, must_be_immutable

import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';

class MartVariants extends StatefulWidget {
dynamic fetcheddatas;
MartVariants({super.key,required this.fetcheddatas});

  @override
  State<MartVariants> createState() => _MartVariantsState();
}

class _MartVariantsState extends State<MartVariants> {
  String? selectedVariant; // Stores the selected radio button value

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> variants = [
      {"name": "Indian Tomato", "price": "₹150.00", "offerprice": "(Thakkali)" ,"kg": "1kg",},
      {"name": "Organic Onion", "price": "₹120.00", "offerprice": "(Pyaz)","kg": "2kg"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Variants",
          style: CustomTextStyle.smallboldblack,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: variants.length,
          itemBuilder: (context, i) {
            String variantName = variants[i]["name"]!;
            String subName = variants[i]["offerprice"]!; // Sub-name
            String price = variants[i]["price"]!;
            String kg = variants[i]["kg"]!;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  // Radio Button
                  Radio<String>(
                    activeColor: Customcolors.darkpurple,
                    value: variantName,
                    groupValue: selectedVariant,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedVariant = newValue;
                      });
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  
                  // Variant Name and Sub-name
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          variantName,
                          overflow: TextOverflow.ellipsis,
                          style: CustomTextStyle.black13B,
                        ),
                        Text(
                          subName,
                          overflow: TextOverflow.ellipsis,
                          style: CustomTextStyle.subblack, // Use a smaller font
                        ),
                        Text(
                          kg,
                          overflow: TextOverflow.ellipsis,
                          style: CustomTextStyle.midbold, // Use a smaller font
                        ),
                      ],
                    ),
                  ),

                  // Price
                  Column(
                    children: [
                    const Text(
                        "₹250.00",
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyle.redstrikeredsmall,
                      ),
                      Text(
                        price,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyle.black13B,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
