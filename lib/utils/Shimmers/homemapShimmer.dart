
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';



class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: MediaQuery.of(context).size.height /2.2,
                color: Colors.grey[300],
              ),
            ),
          
            const CategoryShimmer()
        
          ],
        ),
      ),
    );
  }
}




class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(5, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(28),
                          ),
                          width: 70,
                          height: 35,
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 60,
                          height: 10,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 30),
                 
          
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
      
      
          Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        // borderRadius: BorderRadius.circular(28),
                      ),
                      width: 150,
                      height: 35,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 60,
                      height: 10,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(height: 25),
                    Container(
                        width: MediaQuery.of(context).size.width/1,
                        height: 50,
                        color: Colors.grey[300],
                      ),
                    const SizedBox(height: 10),
                      const SizedBox(height: 30),
                      Container(
                      width: MediaQuery.of(context).size.width/1,
                      height: 50,
                    
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(28),  color: Colors.grey[300],),
                    ),
                    const SizedBox(height: 10),
             
                  ],
                ),
              ),
        ],
      ),
    );
  }
}



