// ignore_for_file: file_names

import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:flutter/material.dart';

class MartItemdetails extends StatefulWidget {
  const MartItemdetails({super.key});

  @override
  State<MartItemdetails> createState() => _MartItemdetailsState();
}

class _MartItemdetailsState extends State<MartItemdetails> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(148, 255, 255, 255),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "assets/mart_images/Tomato.png",
                  height: 60,
                  width: 70,
                  fit: BoxFit.fill,
                )),
          ),
        ),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            const SizedBox(
              width: 140,
              child: Text(
                "Indian Tomato",
                style: CustomTextStyle.carttblack,
                overflow: TextOverflow.clip,
              ),
            ),2.toHeight,
            const Text(
                "250g",
                style: CustomTextStyle.midboldsmall,
                overflow: TextOverflow.clip,
              ),2.toHeight,
            Row(
              children: [
                const Text(
                  "₹180",style: CustomTextStyle.redstrikeredsmall,
                ),2.toWidth,
                const Text(
                  "₹150.00",style: CustomTextStyle.foodDescription,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
