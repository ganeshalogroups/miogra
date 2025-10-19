// ignore_for_file: file_names

import 'package:testing/Mart/Homepage/MartAddbutton.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import '../MartProductsview/Martproductsidebar.dart';

class Snacks extends StatefulWidget {
  const Snacks({super.key});

  @override
  State<Snacks> createState() => _SnacksState();
}

class _SnacksState extends State<Snacks> {

List<Map<String, dynamic>> bestDeals = [
    {"name": "Nabati", "weight": "200g", "description": "Fresh Spicy", "price": "₹120.00"},
    {"name": "Lays classic", "weight": "1kg", "description": "Urulai Kizhangu", "price": "₹60.00"},
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
      child: ResponsiveGridList(
        shrinkWrap: true,
        horizontalGridSpacing: 10,
        verticalGridSpacing: 10,
        minItemWidth: 150,
        minItemsPerRow: 2,
        maxItemsPerRow: 2,
        listViewBuilderOptions: ListViewBuilderOptions(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
        ),
        children: List.generate(bestDeals.length, (index) {
          final item = bestDeals[index];

 ValueNotifier<int> itemCountNotifier = ValueNotifier<int>(0);
          return GestureDetector(
          onTap: () {
             Get.to(Productsidebar());
          },
            child: Container(
              decoration: BoxDecoration(
                color: Customcolors.DECORATION_CONTAINERGREY,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        color: Colors.white, // White background
                        child: Image.asset(
                          "assets/mart_images/Nabati.png",
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.contain, // Adjust fit if needed
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                item["name"],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: CustomTextStyle.meatbold,
                              ),
                            ),
                            Text(
                              item["weight"],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: CustomTextStyle.midbold,
                            ),
                          ],
                        ),
                        Text(
                          "(${item["description"]})",
                          style: CustomTextStyle.midbold,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "₹30.00",
                          style: CustomTextStyle.redstrikered,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item["price"],
                              style: CustomTextStyle.meatbold,
                              maxLines: 1,
                            ),
                            Martaddbutton(itemcountNotifier: itemCountNotifier,)
                          ],
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
