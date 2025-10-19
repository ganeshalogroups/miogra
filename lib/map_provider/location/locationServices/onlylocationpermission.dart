import 'package:testing/utils/Buttons/CustomAlertDialoug.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as handler;

// class OnlyLocationPermission {
//   OnlyLocationPermission.init();
//   static OnlyLocationPermission instance = OnlyLocationPermission.init();

//   final Location _location = Location();

//   Future<bool> checkForPermission() async {

//     PermissionStatus status = await _location.hasPermission();

//     if (status == PermissionStatus.denied) {
//       status = await _location.requestPermission();
//       if (status == PermissionStatus.granted) {
//         return true;
//       }
//       return false;
//     }

//     if (status == PermissionStatus.deniedForever) {
//       Get.snackbar(
//         "Permission Needed",
//         "We need permission to access your location in order to provide our service.",
//         onTap: (snack) async {
//           await handler.openAppSettings();
//         },
//       );
//       return false;
//     }

//     return true;
//   }
// }

class OnlyLocationPermission {
  OnlyLocationPermission.init();
  static OnlyLocationPermission instance = OnlyLocationPermission.init();

  final Location _location = Location();

  Future<bool> checkAndRequestLocationPermission(BuildContext context) async {
    PermissionStatus status = await _location.hasPermission();

    if (status == PermissionStatus.denied) {
      status = await _location.requestPermission();

      if (status == PermissionStatus.granted) {
        return true;
      }

      if (status == PermissionStatus.denied) {
        // Show dialog after denial
        await _showPermissionDialog(context);
        return false;
      }
    }

    if (status == PermissionStatus.deniedForever) {
      // Directly show dialog
      await _showPermissionDialog(context);
      return false;
    }

    return true;
  }

  Future<void> _showPermissionDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (_) {
        return CustomLogoutDialog(
          title: "Turn on Location Permission",
          content: "Go to Settings and turn on Location permission to proceed.",
          onConfirm: () async {
            Navigator.of(context).pop(); // Close dialog
            await handler.openAppSettings(); // Open settings
          },
          buttonname: "Allow",
          oncancel: () {
            Navigator.of(context).pop(); // Close dialog
          },
        );
      },
    );
  }
}
