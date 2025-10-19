// ignore_for_file: file_names

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Billshimmer extends StatelessWidget {
  const Billshimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    height: 20,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[300],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 20,
                    width: 75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Container(
                      height: 20,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 20,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    height: 20,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[300],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 20,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    height: 20,
                    width: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[300],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 20,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DottedLine(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.center,
                  lineLength: double.infinity,
                  lineThickness: 1.0,
                  dashLength: 7.0,
                  dashColor: Colors.black,
                  dashGradient: const [
                    Color.fromARGB(255, 169, 169, 169),
                    Color.fromARGB(255, 185, 187, 188)
                  ],
                  dashRadius: 4,
                  dashGapLength: 6,
                  dashGapColor: Colors.white,
                  dashGapRadius: 5,
                ),
              ),
              Row(
                children: [
                  Container(
                    height: 20,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[300],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 20,
                    width: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
