// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressProvider with ChangeNotifier {
  double _latitude = 0.0;
  double _longitude = 0.0;
  String _postalcode = '';
  String _fullAddress = '';
  String _addressType = 'Selected'; // Default value

  AddressProvider() {
    _loadAddressDetails();
  }

  double get latitude => _latitude;
  double get longitude => _longitude;
  String get postalcode => _postalcode;
  String get fullAddress => _fullAddress;
  String get addressType => _addressType;

  Future<void> _loadAddressDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _latitude = prefs.getDouble('latitude') ?? 0.0;
    _longitude = prefs.getDouble('longitude') ?? 0.0;
    _postalcode = prefs.getString('postalcode') ?? '';
    _fullAddress = prefs.getString('fullAddress') ?? '';
    _addressType = prefs.getString('addressType') ?? 'Selected';
    notifyListeners();
  }

  Future<void> updateAddressDetails(Map<String, dynamic> addressDetails) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('latitude', addressDetails['latitude']);
    await prefs.setDouble('longitude', addressDetails['longitude']);
    await prefs.setString('postalcode', addressDetails['postalcode']);
    await prefs.setString('fullAddress', addressDetails['fullAddress']);
    await prefs.setString('addressType', 'Selected');
    _latitude = addressDetails['latitude'];
    _longitude = addressDetails['longitude'];
    _postalcode = addressDetails['postalcode'];
    _fullAddress = addressDetails['fullAddress'];
    notifyListeners();
  }
}


