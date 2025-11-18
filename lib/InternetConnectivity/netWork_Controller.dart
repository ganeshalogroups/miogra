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



// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:get/get.dart';

// class NetworkController extends GetxController {
//   var isOnline = true.obs;

//   @override
//   void onInit() {
//     super.onInit();

//     // Check current status once at startup
//     checkConnection();

//     // Listen for real-time connection updates
//     Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
//       // "result" is now a list in latest versions
//       if (result.contains(ConnectivityResult.none)) {
//         isOnline.value = false;
//       } else {
//         isOnline.value = true;
//       }
//     });
//   }

//   Future<void> checkConnection() async {
//     final List<ConnectivityResult> result = await Connectivity().checkConnectivity();
//     if (result.contains(ConnectivityResult.none)) {
//       isOnline.value = false;
//     } else {
//       isOnline.value = true;
//     }
//   }
// }




import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NetworkConnectivity extends GetxController {
  final Connectivity _connectivity = Connectivity();
  RxBool isOnline = true.obs;

  @override
  void onInit() {
    super.onInit();
    _checkInitialConnection();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _checkInitialConnection() async {
    final result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    if (result.contains(ConnectivityResult.none)) {
      isOnline.value = false;
    } else {
      isOnline.value = true;
    }
  }
}

