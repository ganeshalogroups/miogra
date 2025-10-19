// ignore_for_file: file_names

import 'package:flutter/material.dart';

class FoodSearchProvider with ChangeNotifier {
  bool _showClearButton = false;

  bool get showClearButton => _showClearButton;

  void updateClearButtonVisibility(String text) {
    _showClearButton = text.isNotEmpty;
    notifyListeners();
  }

  void clearSearch(TextEditingController controller) {
    controller.clear();
    _showClearButton = false;
    notifyListeners();
  }
}