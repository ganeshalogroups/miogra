// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Oderlistshimmer extends StatelessWidget {
  const Oderlistshimmer({super.key});

  @override
  Widget build(BuildContext context) {
     return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: 3,
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                          
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Container(
                              width: 100,
                              height: 20,
                              color: Colors.white,
                            ), // Placeholder for shimmer
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 150,
                                height: 20,
                                color: Colors.white,
                              ),
                              Container(
                                width: 100,
                                height: 20,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            height: 2,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 20),

                              ListView.builder(
                                itemCount: 3, // Placeholder for 3 items in shimmer state
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [

                                      Container(
                                        width: 20,
                                        height: 20,
                                        color: Colors.white ),
                                    
                                      Padding(
                                        padding : const EdgeInsets.symmetric( horizontal: 8, vertical: 6),
                                        child   : Container(
                                          width : 200,
                                          height: 20,
                                          color : Colors.white),
                                       
                                      ),
                                    ],
                                  );
                                },
                              ),


                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            height: 2,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 100,
                                height: 20,
                                color: Colors.white,
                              ),
                              Container(
                                width: 100,
                                height: 20,
                                color: Colors.white,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );       
  }
}