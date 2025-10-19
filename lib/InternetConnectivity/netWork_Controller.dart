// // ignore_for_file: file_names

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:get/get.dart';

// import 'noInternetPage.dart';

// class NetworkConnectivity extends GetxController {
//   Connectivity connectivity = Connectivity();

//   final RxString connectionStatus = ''.obs;

//   @override
//   void onInit() {
//     connectivity.onConnectivityChanged.listen(updateConnectionStatus);
//     super.onInit();
//   }



//   updateConnectionStatus(List<ConnectivityResult> connectivityresultList) {
//     if (connectivityresultList.contains(ConnectivityResult.mobile)) {
//       connectionStatus.value = 'Its An Mobile InterNet';
//     } else if (connectivityresultList.contains(ConnectivityResult.wifi)) {
//       connectionStatus.value = 'Its An Wifi Data';
//     } else if (connectivityresultList.contains(ConnectivityResult.vpn)) {
//       connectionStatus.value = 'Its An VPN Data';
//     } else if (connectivityresultList.contains(ConnectivityResult.none)) {
//       connectionStatus.value = 'Now Offline';
//        Get.to(const NoInterNetPage(),transition: Transition.leftToRight);
//     } else if (connectivityresultList.contains(ConnectivityResult.other)) {
//       connectionStatus.value = 'Now Other';
//     } else {
//       connectionStatus.value = 'Something Was Wrong..';

//       Get.to(const NoInterNetPage());
//     }
//   }


// }
