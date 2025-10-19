import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class ParcelAddressProvider with ChangeNotifier {
  // Map<String, List<Address>> addressMap = {};

  Map<String, Address> addressMap  = {};
  List<Address> totalTrips         = [];
  Map<String, String> addressIdMap = {};
  dynamic dropPhonenumber;
  dynamic packageWeight;
  dynamic packagefinalWeight;
  dynamic packagecontent;
  // dynamic packageImageUrl = 'https://fastxlivebucket.s3.ap-south-1.amazonaws.com/68f726f9-e31a-4e11-be78-55bb10dd068d1089200553747252834.jpg';
  dynamic packageImageUrl;
  dynamic basePrice;
  dynamic otherType;
  dynamic unit;
  bool    isChipSelected = false;


  int selectedChipIndex = -1;




  dynamic orderType;



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




  Future<void> clearAddressMapData() async{
        addressMap.clear();
        addressIdMap.clear();
        totalTrips.clear();
        dropPhonenumber    = null;
        packageWeight      = null;
        packagecontent     = null;
        packageImageUrl    = null;
        basePrice          = null;
        otherType          = null;
        unit               = null;
        packagefinalWeight = null;
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


  Future<void> addOrderType ({addOrderType}) async {
    orderType = addOrderType;
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
  
    //validations dcsdsdsvsdv dfdff svsvs

}






class Address {
  String name;
  String userType;
  String addressType;
  String houseNo;
  String fullAddress;
  String landMark;
  double latitude;
  double longitude;
  String street;
  String state;
  String postalCode;
  String locality;
  String country;
  String contactPerson;
  String contactPersonNumber;
  String addressId;

  // Constructor
  Address({
    this.name      = "",
    this.userType  = "consumer",
    this.addressType = "secondary",
    this.houseNo   = "",
    this.fullAddress = "",
    this.landMark  = "",
    this.latitude  = 0.0,
    this.longitude = 0.0,
    this.street    = "",
    this.state     = "",
    this.postalCode = "",
    this.locality  = "",
    this.country   = "India",
    this.contactPerson = "",
    this.contactPersonNumber = "",
    this.addressId = '',
  });

  // Method to convert JSON to Address object
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      userType: json['userType'],
      addressType: json['addressType'],
      houseNo: json['houseNo'],
      fullAddress: json['fullAddress'],
      landMark: json['landMark'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      street: json['street'],
      state: json['state'],
      postalCode: json['postalCode'],
      locality: json['locality'],
      country: json['country'],
      contactPerson: json['contactPerson'],
      contactPersonNumber: json['contactPersonNumber'],
      addressId: json['addressId'],
    );
  }

  // Method to convert Address object to JSON

  Map<String, dynamic> toJson() {
    return {
      'userType': userType,
      'addressType': addressType,
      'houseNo': houseNo,
      'fullAddress': fullAddress,
      'landMark': landMark,
      'latitude': latitude,
      'longitude': longitude,
      'street': street,
      'state': state,
      'postalCode': postalCode,
      'locality': locality,
      'country': country,
      'contactPerson': contactPerson,
      'contactPersonNumber': contactPersonNumber,
      'addressId': addressId
    };
  }
}
