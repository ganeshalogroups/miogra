import 'dart:io';

import 'package:flutter/cupertino.dart';

class TripImageProvider with ChangeNotifier {
  File? _image;

  File? get image => _image;

  void setImage(File file) {
    _image = file;
    notifyListeners();
  }

  void clearImage() {
    _image = null;
    notifyListeners();
  }
}

class TipsProvider with ChangeNotifier {
 String tipAmount = "";

  String get tipamount => tipAmount;

  void setTips(tips) {
   tipAmount = tips.replaceAll("₹", "").trim();
    notifyListeners();
  }
  
  void cleaTips() {
   tipAmount = '0.0';
    notifyListeners();
   // update(); // Notifies listeners (if using GetBuilder)
  }
}
