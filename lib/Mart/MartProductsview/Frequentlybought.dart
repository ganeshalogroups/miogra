// ignore_for_file: file_names

import 'package:testing/Mart/Homepage/MartAddbutton.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class FrequentlyboughtTogether extends StatefulWidget {
  const FrequentlyboughtTogether({super.key});

  @override
  State<FrequentlyboughtTogether> createState() => _FrequentlyboughtTogetherState();
}

class _FrequentlyboughtTogetherState extends State<FrequentlyboughtTogether> {
  @override
  Widget build(BuildContext context) {
  List<Map<String, dynamic>> bestDeals = [
    {
      "name": "Indian Tomato",
      "weight": "500g",
      "description": "Thakkali",
      "price": "₹120.00",
      "oldPrice": "₹150.00",
      "image": "assets/mart_images/Tomato.png"
    },
    {
      "name": "Fresh Potato",
      "weight": "1kg",
      "description": "Urulai Kizhangu",
      "price": "₹60.00",
      "oldPrice": "₹80.00",
      "image": "assets/mart_images/Tomato.png"
    },
    {
      "name": "Indian Tomato",
      "weight": "500g",
      "description": "Thakkali",
      "price": "₹120.00",
      "oldPrice": "₹150.00",
      "image": "assets/mart_images/Tomato.png"
    },
    {
      "name": "Fresh Potato",
      "weight": "1kg",
      "description": "Urulai Kizhangu",
      "price": "₹60.00",
      "oldPrice": "₹80.00",
      "image": "assets/mart_images/Tomato.png"
    },
  ];
      return Column(mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        const Text("Frequently bought together",style: CustomTextStyle.smallboldblack,),
        const SizedBox(height: 15,),
          ResponsiveGridList(
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
              return Container(
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
                          color: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              item["image"],
                              height: 100,
                              width: double.infinity,
                              fit: BoxFit.fitHeight,
                            ),
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
                          Text(
                            item["oldPrice"] ?? "",
                            style: CustomTextStyle.redstrikered,
                            maxLines: 1,
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  item["price"],
                                  style: CustomTextStyle.meatbold,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Martaddbutton(itemcountNotifier: itemCountNotifier,),
                            ],
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      );
  
  }
}