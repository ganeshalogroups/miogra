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



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class NoInternetScreen extends StatelessWidget {
//   const NoInternetScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(Icons.wifi_off, size: 100, color: Colors.redAccent),
//               const SizedBox(height: 20),
//               const Text(
//                 "No Internet Connection",
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 "Please check your network settings and try again.",
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 30),
//               ElevatedButton(
//                 onPressed: () {
//                   Get.back(); // Try to return when network restored
//                 },
//                 child: const Text("Retry"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off, size: 80, color: Colors.redAccent),
            const SizedBox(height: 20),
            const Text(
              "No Internet Connection",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Please check your Wi-Fi or mobile data",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
