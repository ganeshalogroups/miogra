
// ignore_for_file: file_names

import 'package:flutter/material.dart';

class DistanceProvider with ChangeNotifier {

  dynamic totalDistance;

  updaeteDistance({distance}) {
    totalDistance = distance;
    notifyListeners();
  }

}
