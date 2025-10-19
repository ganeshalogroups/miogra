// ignore_for_file: file_names

import 'package:testing/parcel/p_services_provider/p_address_provider.dart';
import 'package:flutter/material.dart';



class RoundTripLOcatDataProvider with ChangeNotifier {
  // Map<String, List<Address>> addressMap = {};

  Map<String, Address> addressMap = {};
  List<Address> totalTrips = [];
  Map<String, String> addressIdMap = {};

  dynamic dropPhonenumber;
  dynamic packageWeight;
  dynamic packagefinalWeight;
  dynamic packagecontent;
  dynamic packageImageUrl;
  dynamic basePrice;
  dynamic otherType;
  dynamic unit;
  bool isChipSelected = false;
  int selectedChipIndex = -1;
  




  bool isDulpicate = false;
  // Add a new pickup address scenario



  Future<void> addAddressList({Address? locationData, required String addressListType, required String addressid}) async {
     
    if (locationData == null) return;

    if (addressIdMap.containsValue(addressid)) {

      isDulpicate = true;
      notifyListeners();

    } else {

      addressMap[addressListType] = locationData;
      addressIdMap[addressListType] = addressid;
      notifyListeners();

      totalTrips.add(locationData);
      notifyListeners();

      isDulpicate = false;
      notifyListeners();
    }
  }




Future<void> clearAddressMapData() async {
      addressMap.clear();       
      addressIdMap.clear();        
      totalTrips.clear();       
      dropPhonenumber    = null;
      packageWeight      = null;
      packagefinalWeight = null;
      packagecontent     = null;
      packageImageUrl    = null;
      basePrice          = null;
      otherType          = null;
      unit               = null;
      selectedChipIndex  = -1;
      notifyListeners();
}



Future<void> onlyClearAddress() async{
        addressMap.clear();
        addressIdMap.clear();
        totalTrips.clear();
        notifyListeners();
    }








  String findKeyByValue({required Map<String, String> map, required String value}) {
    return map.keys.firstWhere((k) => map[k] == value, orElse: () => 'Key not found');
  }


  Future<void> addDropPhoneNumber({phonenumber}) async {
    dropPhonenumber = phonenumber;
    notifyListeners();
  }

  Future<void> addPackageWeight({weight}) async {
    packageWeight = weight;
    notifyListeners();
  }

  Future<void> addPackageContent({content}) async {
    packagecontent = content;
    notifyListeners();
  }

  Future<void> addPackageImage({imageUrl}) async {
    packageImageUrl = imageUrl;
    notifyListeners();
  }


  Future<void> addPckageUnit({packageunit}) async {
    unit = packageunit;
    notifyListeners();
  }


  Future<void> addBasePrice({addBasePric}) async {
    basePrice = addBasePric;
    notifyListeners();
  }

  Future<void> addOtherType({oterWhat}) async {
    otherType = oterWhat;
    notifyListeners();
  }



  Future<void> addchipIndex({chipIndex}) async {
    selectedChipIndex = chipIndex;
    notifyListeners();
  }


  Future<void> addPackageFinalWeight({finallWeight}) async {
    packagefinalWeight = finallWeight;
    notifyListeners();
  }




}
