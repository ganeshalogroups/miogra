// // ignore_for_file: file_names

// import 'package:testing/utils/Buttons/CustomTextstyle.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';

// import 'netWork_Controller.dart';

// class NoInterNetPage extends StatefulWidget {
//   const NoInterNetPage({super.key});

//   @override
//   State<NoInterNetPage> createState() => _NoInterNetPageState();
// }

// class _NoInterNetPageState extends State<NoInterNetPage> {

//   NetworkConnectivity networkController = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       child: Scaffold(body: Obx(() {
//         if (networkController.connectionStatus.value != 'Now Offline') {
//           WidgetsBinding.instance.addPostFrameCallback(
//             (_) {
//               Get.back();
//             },
//           );
//           return const SizedBox();
//         } else {
//           return Center(

//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   LottieBuilder.asset(
//                     'assets/animations/no_internet.json',
//                     height: MediaQuery.of(context).size.height / 2,
//                   ),
//                   const Text("Failed to connect. Please check your internet connection."
//                   ,style: CustomTextStyle.boldblack,
//                   textAlign: TextAlign.center,
//                   )
//                 ],
//               ),
//             ),
//           );
//         }
//       })),
//     );
//   }
// }
