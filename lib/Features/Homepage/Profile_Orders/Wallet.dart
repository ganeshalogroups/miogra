// import 'dart:ui';
// import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/walletcontroller.dart';
// import 'package:testing/utils/Containerdecoration.dart';
// import 'package:testing/utils/CustomColors/Customcolors.dart';
// import 'package:testing/utils/Buttons/CustomTextstyle.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';


// class WalletScreen extends StatefulWidget {
//   const WalletScreen({super.key});

//   @override
//   State<WalletScreen> createState() => _WalletScreenState();
// }

// class _WalletScreenState extends State<WalletScreen> {
// Walletcontroller walletget = Get.put(Walletcontroller());
//  @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//     walletget.getwalletDetails();  
//     });
//   }

 
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//     appBar: AppBar(
//     automaticallyImplyLeading: false,
//      backgroundColor: Color.fromARGB(255, 249, 137, 68),
//     actions: [InkWell(
//     onTap: () {
//       Get.back();
//     },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Container(
//                                           width: 40, // Size of the close button
//                                           height: 40,
//                                           decoration: BoxDecoration(
//                                             shape: BoxShape.circle,
//                                             color: Color.fromARGB(60, 19, 1, 1),
//                                           ),
//                                           child: const Icon(
//                                             Icons.close,
//                                             color: Customcolors.DECORATION_WHITE,
//                                           ),
//                                         ),
//       ),
//     )],),
//   backgroundColor: Color.fromARGB(255, 249, 137, 68),
//   body: SingleChildScrollView(
//     child: Padding(
//       padding: EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Three words at the top
//           //  SizedBox(height: 30),
//           RichText(
//   text: TextSpan(
//     style: TextStyle(
//       fontSize: 28,
//       fontWeight: FontWeight.bold,
//       color: Colors.black,
//     ),
//     children: [
//       TextSpan(text: "Cashback in Your Wallet\nInstant " ,style: CustomTextStyle.wallettext,),
//       WidgetSpan(
//         alignment: PlaceholderAlignment.middle,
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//           decoration: BoxDecoration(
//             color: Customcolors.DECORATION_BLACK,
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: Text(
//             "Access",
//             style: CustomTextStyle.walleorangettext,
//           ),
//         ),
//       ),
//     ],
//   ),
// ),

//           SizedBox(height: 20),

//           // Catchy sentence below
//           Text(
//             "Manage your cash with ease and speed!",
//             style: CustomTextStyle.foodpricetext,
//           ),
//           SizedBox(height: 40),

//           // Rectangular GIF Container with Border Radius and Text inside
//           Center(
//             child: Container(
//               width: double.infinity,
//               padding: EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20), // Border radius for the container
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 10,
//                     offset: Offset(0, 4), // Shadow effect
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     flex: 2,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(20),
//                       child: Image.asset(
//                         'assets/images/original-755c5255de8f7e2cca4339e9e2b69681.gif',
//                         fit: BoxFit.cover,
//                         height: 150, // Set height of the GIF container
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 12),
//                   // Text inside the GIF container on the right side
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'Your Wallet\nIn Action!',
//                           style: CustomTextStyle.addbtn,
//                         ),
//                         SizedBox(height: 8),
//                         Text(
//                           'Track your orders and balance',
//                          style: CustomTextStyle.mapgrey12,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(height: 60),
// Stack(
//   clipBehavior: Clip.none,  // To allow the GIF to extend outside the container
//   children: [
//     // Your Container with other content
//     Container(
//       padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 10,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // SizedBox(height: 80),  // Space for the floating GIF

//           // Wallet Amount
//           // Obx(() {
//           //   if (walletget.isLoading.isTrue) {
//           //     return CircularProgressIndicator(color: Colors.deepOrangeAccent);
//           //   } else if (walletget.walletdetails == null ||
//           //       walletget.walletdetails["data"] == null) {
//           //     return Text(
//           //       "₹0.00",
//           //        style: CustomTextStyle.boldblack32
//           //     );
//           //   } else {
//           //     return Text(
//           //       "₹${walletget.walletdetails["data"]["walletTotalAmount"].toStringAsFixed(2)}",
//           //       style: CustomTextStyle.boldblack32
//           //     );
//           //   }
//           // }),
// Column(
//   children: [
//     Text(
//       "Available Wallet Amount",
//       style: CustomTextStyle.googlebuttontext.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
//     ),
//     SizedBox(height: 8),
//     Obx(() {
//       if (walletget.isLoading.isTrue) {
//         return CircularProgressIndicator(color: Colors.white,);
//       } else if (walletget.walletdetails == null ||
//           walletget.walletdetails["data"] == null) {
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               'assets/images/rupee.gif',
//               height: 30,
//               width: 30,
//             ),
//             SizedBox(width: 8),
//             Text(
//               "₹0.00",
//               style: CustomTextStyle.boldblack32,
//             ),
//           ],
//         );
//       } else {
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               'assets/images/rupee.gif',
//               height: 40,
//               width: 40,
//             ),
//             SizedBox(width: 8),
//             Text(
//               "₹${walletget.walletdetails["data"]["walletTotalAmount"].toStringAsFixed(2)}",
//               style: CustomTextStyle.boldblack32,
//             ),
//           ],
//         );
//       }
//     }),
//   ],
// ),


//           SizedBox(height: 30),

//           // Go to Your Bag Row
//           Row(
//             children: [
//               Icon(Icons.shopping_bag_outlined, color: Customcolors.darkpurple),
//               SizedBox(width: 10),
//               Expanded(
//                 child: Text(
//                   "Go to your bag",
//                   style: CustomTextStyle.googlebuttontext,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16),

//           // Use FastX Cashback Row
//           Row(
//             children: [
//               Icon(Icons.local_offer_outlined, color: Customcolors.darkpurple),
//               SizedBox(width: 10),
//               Expanded(
//                 child: Text(
//                   "Use your FastX wallet for your next order",
//                    style: CustomTextStyle.googlebuttontext,
//                 ),
//               ),
//             ],
//           ),

//           SizedBox(height: 24),

//          Center(
//                                   child: Container(
//                                     padding: const EdgeInsets.symmetric(vertical: 16),
//                                     width: MediaQuery.of(context).size.width * 0.9, // Adjust width to screen size
//                                     decoration: CustomContainerDecoration.gradientbuttondecoration(),
//                                     child: Center(
//                                       child: Text(
//                                         "Go back to your Orders",
//                                         style: CustomTextStyle.loginbuttontext, // Button text style
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//         ],
//       ),
//     ),
//   ],
// )

// //      Container(
// //       width: double.infinity,
// //     //  margin: EdgeInsets.symmetric(horizontal: 12),
// //   padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
// //   decoration: BoxDecoration(
// //     color: Colors.white,
// //     borderRadius: BorderRadius.circular(20),
// //     boxShadow: [
// //       BoxShadow(
// //         color: Colors.black12,
// //         blurRadius: 10,
// //         offset: Offset(0, 4),
// //       ),
// //     ],
// //   ),
// //   child: Column(
// //     mainAxisSize: MainAxisSize.min,
// //     children: [
// //       // Align the GIF at the top center of the container's border
// //       Container(
// //         width: double.infinity,  // Ensures the GIF stays centered across the container width
// //         padding: EdgeInsets.only(top: 10),  // Optional: adjust to give some space between the border and the GIF
// //         child: Align(
// //           alignment: Alignment.topCenter,  // Position it at the top center
// //           child: Image.asset(
// //             'assets/images/savings.gif',
// //             height: 80,
// //           ),
// //         ),
// //       ),
// //       SizedBox(height: 20),

// //       // Wallet Amount
// //       Obx(() {
// //         if (walletget.isLoading.isTrue) {
// //           return CircularProgressIndicator(color: Colors.deepOrangeAccent);
// //         } else if (walletget.walletdetails == null ||
// //             walletget.walletdetails["data"] == null) {
// //           return Text(
// //             "₹0.00",
// //             style: TextStyle(
// //               fontSize: 32,
// //               fontWeight: FontWeight.bold,
// //               color: Colors.black,
// //             ),
// //           );
// //         } else {
// //           return Text(
// //             "₹${walletget.walletdetails["data"]["walletTotalAmount"].toStringAsFixed(2)}",
// //             style: TextStyle(
// //               fontSize: 32,
// //               fontWeight: FontWeight.bold,
// //               color: Colors.black,
// //             ),
// //           );
// //         }
// //       }),

// //       SizedBox(height: 30),

// //       // Go to Your Bag Row
// //       Row(
// //         children: [
// //           Icon(Icons.shopping_bag_outlined, color: Colors.deepOrange),
// //           SizedBox(width: 10),
// //           Expanded(
// //             child: Text(
// //               "Go to your bag",
// //               style: TextStyle(
// //                 fontSize: 15,
// //                 color: Colors.black87,
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //       SizedBox(height: 16),

// //       // Use FastX Cashback Row
// //       Row(
// //         children: [
// //           Icon(Icons.local_offer_outlined, color: Colors.orangeAccent),
// //           SizedBox(width: 10),
// //           Expanded(
// //             child: Text(
// //               "Use your FastX cashback for your next order",
// //               style: TextStyle(
// //                 fontSize: 15,
// //                 color: Colors.black87,
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),

// //       SizedBox(height: 24),

// //       // Bottom Button
// //       OutlinedButton(
// //         style: OutlinedButton.styleFrom(
// //           padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
// //           shape: RoundedRectangleBorder(
// //             borderRadius: BorderRadius.circular(12),
// //           ),
// //           side: BorderSide(color: Colors.deepOrangeAccent),
// //         ),
// //         onPressed: () {
// //           // Go to bag logic
// //         },
// //         child: Text(
// //           "Go to Bag",
// //           style: TextStyle(
// //             fontSize: 16,
// //             fontWeight: FontWeight.w600,
// //             color: Colors.deepOrangeAccent,
// //           ),
// //         ),
// //       ),
// //     ],
// //   ),
// // )

//       ],
//       ),
//     ),
//   ),
// );

//   }
// }


