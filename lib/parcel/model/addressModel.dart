

// ignore_for_file: file_names

class AddressModel {
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

  // Constructor
  AddressModel({
    this.userType = "consumer",
    this.addressType = "secondary",
    this.houseNo = "",
    this.fullAddress = "",
    this.landMark = "",
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.street = "",
    this.state = "",
    this.postalCode = "",
    this.locality = "",
    this.country = "India",
    this.contactPerson = "",
    this.contactPersonNumber = "",
  });

  // Method to convert JSON to Address object
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
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
    };
  }
}
