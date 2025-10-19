





import 'package:testing/utils/Const/constValue.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';



class MapDataProvider extends ChangeNotifier {

bool hasValidLocation() {
  return localAddressData['latitude'] != null &&
         localAddressData['longitude'] != null &&
         localAddressData['latitude'] != 0 &&
         localAddressData['longitude'] != 0;
}


    Map<String, dynamic> localAddressData = {
          "userType": "consumer",
          "type": "secondary",
          "houseNo": "",
          'fullAddress': '',
          "landMark": '',
          'addressType': '',
          'latitude': 0,
          'longitude': 0,
          'street': '',
          'state': '',
          "postalCode": '',
          'locality': '',
          "country": "india",
          "contactPerson": "",
          "contactPersonNumber": "",
          "instructions": "",
    };

    Map<String, dynamic> get llcldta => localAddressData;



  // Getter methods
  String get houseNo     => localAddressData["houseNo"] ?? '';
  String get fullAddress => localAddressData['fullAddress'] ?? '';
  String get landMark    => localAddressData["landMark"] ?? '';
  String get addressType => localAddressData['addressType'] ?? '';
  double get latitude    => localAddressData['latitude'] ?? 0;
  double get longitude   => localAddressData['longitude'] ?? 0;
  String get street      => localAddressData['street'] ?? '';
  String get state       => localAddressData['state'] ?? '';
  String get postalCode  => localAddressData["postalCode"] ?? '';
  String get locality    => localAddressData['locality'] ?? '';
  String get country     => localAddressData["country"] ?? '';
  String get contactPerson => localAddressData["contactPerson"] ?? '';
  String get contactPersonNumber => localAddressData["contactPersonNumber"] ?? '';
  String get instructions => localAddressData["instructions"] ?? '';



  MapDataProvider() {
    loadLocalData();
  }


  // Method to update map data and store it locally
  Future<void> updateMapData({

    String? houseno,
    String? fulladdres,
    String? landmark,
    String? addresstype,
    double? latitude,
    double? longitude,
    String? streett,
    String? statee,
    String? postalcode,
    String? localiti,
    String? contacypersion,
    String? contactpersionNo,
    String? otheristructions,

  }) async {

        localAddressData = {
          "userType"   : "consumer",
          "type"       : "secondary",
          "houseNo"    : houseno ?? '',
          'fullAddress': fulladdres ?? '',
          "landMark"   : landmark ?? '',
          'addressType': addresstype ?? '',
          'latitude'   : latitude ?? 0,
          'longitude'  : longitude ?? 0,
          'street'     : streett ?? '',
          'state'      : statee ?? '',
          "postalCode" : postalcode ?? '',
          'locality'   : localiti ?? '',
          "country"    : "india",
          "contactPerson": contacypersion ?? '',
          "contactPersonNumber": contactpersionNo ?? '',
          "instructions":otheristructions??""
        };

      initiallat  =  localAddressData['latitude'];
      initiallong =  localAddressData['longitude'];





      // Save data to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('houseNo', houseno ?? '');
      await prefs.setString('fullAddress', fulladdres ?? '');
      await prefs.setString('landMark', landmark ?? '');
      await prefs.setString('addressType', addresstype ?? '');
      await prefs.setDouble('latitude', latitude ?? 0);
      await prefs.setDouble('longitude', longitude ?? 0);
      await prefs.setString('street', streett ?? '');
      await prefs.setString('state', statee ?? '');
      await prefs.setString('postalCode', postalcode ?? '');
      await prefs.setString('locality', localiti ?? '');
      await prefs.setString('country', "india");
      await prefs.setString('type', "secondary");
      await prefs.setString('userType', "consumer");
      await prefs.setString('contactPerson', contacypersion ?? '');
      await prefs.setString('contactPersonNumber', contactpersionNo ?? '');
       await prefs.setString('instructions', otheristructions ?? '');

    notifyListeners();


  }



  // Method to load data from SharedPreferences
  Future<void> loadLocalData() async {
    final prefs = await SharedPreferences.getInstance();
    localAddressData = {
      "houseNo"     : prefs.getString('houseNo') ?? '',
      'fullAddress' : prefs.getString('fullAddress') ?? '',
      "landMark"    : prefs.getString('landMark') ?? '',
      'addressType' : prefs.getString('addressType') ?? '',
      'latitude'    : prefs.getDouble('latitude') ?? 0,
      'longitude': prefs.getDouble('longitude') ?? 0,
      'street': prefs.getString('street') ?? '',
      'state': prefs.getString('state') ?? '',
      "postalCode": prefs.getString('postalCode') ?? '',
      'locality': prefs.getString('locality') ?? '',
      "country": prefs.getString('country') ?? 'india',
      "contactPerson": prefs.getString('contactPerson') ?? '',
      "contactPersonNumber": prefs.getString('contactPersonNumber') ?? '',
      "instructions": prefs.getString('instructions') ?? '',
    };


     initiallat  =  localAddressData['latitude'].toDouble();
     initiallong =  localAddressData['longitude'].toDouble();

    notifyListeners();
  }
}