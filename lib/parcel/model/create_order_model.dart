import 'dart:convert';

import '../p_services_provider/p_address_provider.dart';

// class OrderData {
//   String deliveryType;
//   List<String> shareUserIds;
//   String productCategoryId;
//   String userId;
//   String subAdminId;
//   String subAdminType;
//   String vendorAdminId;
//   List<Address> dropAddress;
//   List<Address> pickupAddress;
//   ParcelDetails parcelDetails;
//   String type;
//   AmountDetails amountDetails;
//   String orderStatus;
//   double discountAmount;
//   String totalKms;
//   String baseKm;
//   String additionalInstructions;

//   OrderData({
//     required this.deliveryType,
//     required this.shareUserIds,
//     required this.productCategoryId,
//     required this.userId,
//     required this.subAdminId,
//     required this.subAdminType,
//     required this.vendorAdminId,
//     required this.dropAddress,
//     required this.pickupAddress,
//     required this.parcelDetails,
//     required this.type,
//     required this.amountDetails,
//     required this.orderStatus,
//     required this.discountAmount,
//     required this.totalKms,
//     required this.baseKm,
//     required this.additionalInstructions,
//   });

//   factory OrderData.fromJson(Map<String, dynamic> json) {
//     return OrderData(
//       deliveryType: json['deliveryType'] ?? '',
//       shareUserIds: List<String>.from(json['shareUserIds'] ?? []),
//       productCategoryId: json['productCategoryId'] ?? '',
//       userId: json['userId'] ?? '',
//       subAdminId: json['subAdminId'] ?? '',
//       subAdminType: json['subAdminType'] ?? '',
//       vendorAdminId: json['vendorAdminId'] ?? '',
//       dropAddress: (json['dropAddress'] as List).map((e) => Address.fromJson(e)).toList(),
//       pickupAddress: (json['pickupAddress'] as List).map((e) => Address.fromJson(e)).toList(),
//       parcelDetails : ParcelDetails.fromJson(json['parcelDetails']),
//       type          : json['type'] ?? '',
//       amountDetails : AmountDetails.fromJson(json['amountDetails']),
//       orderStatus   : json['orderStatus'] ?? '',
//       discountAmount: (json['discountAmount'] ?? 0).toDouble(),
//       totalKms : json['totalKms'] ?? '',
//       baseKm   : json['baseKm'] ?? '',
//       additionalInstructions: json['additionalInstructions'] ?? '',
//     );
//   }
// }

class OrderData {
  // String name;
  String deliveryType;
  List<String> shareUserIds;
  String productCategoryId;
  String userId;
  // String subAdminId;
  String subAdminType;
  String vendorAdminId;
  List<dynamic> dropAddress;
  List<dynamic> pickupAddress;
  ParcelDetails parcelDetails;
  String type;
  AmountDetails amountDetails;
  String orderStatus;
  double discountAmount;
  int platformCharge;

  String totalKms;
  String baseKm;
  String additionalInstructions;
  String paymentMethod;

  OrderData(
      {
      // required this.name,
      required this.deliveryType,
      required this.shareUserIds,
      required this.productCategoryId,
      required this.userId,
      required this.platformCharge,
      // required this.subAdminId,
      required this.subAdminType,
      required this.vendorAdminId,
      required this.dropAddress,
      required this.pickupAddress,
      required this.parcelDetails,
      required this.type,
      required this.amountDetails,
      required this.orderStatus,
      required this.discountAmount,
      required this.totalKms,
      required this.baseKm,
      required this.additionalInstructions,
      required this.paymentMethod});

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      // name: json['name'] ?? '',
      deliveryType: json['deliveryType'] ?? '',
      shareUserIds: List<String>.from(json['shareUserIds'] ?? []),
      productCategoryId: json['productCategoryId'] ?? '',
      userId: json['userId'] ?? '',
      // subAdminId: json['subAdminId'] ?? '',
      subAdminType: json['subAdminType'] ?? '',
      vendorAdminId: json['vendorAdminId'] ?? '',
      dropAddress: (json['dropAddress'] as List<dynamic>)
          .map((e) => Address.fromJson(e))
          .toList(),
      pickupAddress: (json['pickupAddress'] as List<dynamic>)
          .map((e) => Address.fromJson(e))
          .toList(),
      parcelDetails: ParcelDetails.fromJson(json['parcelDetails']),
      type: json['type'] ?? '',
      amountDetails: AmountDetails.fromJson(json['amountDetails']),
      orderStatus: json['orderStatus'] ?? '',
      discountAmount: (json['discountAmount'] ?? 0).toDouble(),
      totalKms: json['totalKms'] ?? '',
      baseKm: json['baseKm'] ?? '',
      additionalInstructions: json['additionalInstructions'] ?? '',
      paymentMethod: json['paymentMethod'] ?? '',
      platformCharge: (json['platformCharge'] ?? 0).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'name':name,
      'deliveryType': deliveryType,
      'shareUserIds': shareUserIds,
      'productCategoryId': productCategoryId,

      'userId': userId,
      // 'subAdminId': subAdminId,
      'subAdminType': subAdminType,
      'vendorAdminId': vendorAdminId,
      'dropAddress': dropAddress,
      'pickupAddress': pickupAddress,
      'parcelDetails': parcelDetails.toJson(),
      'type': type,
      'amountDetails': amountDetails.toJson(),
      'orderStatus': orderStatus,
      'discountAmount': discountAmount,
      'totalKms': totalKms,
      'baseKm': baseKm,
      'additionalInstructions': additionalInstructions,
      'paymentMethod': paymentMethod, 'platformCharge': platformCharge
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}

class ParcelDetails {
  dynamic unit;
  dynamic value;
  dynamic packageType;
  dynamic otherType;
  dynamic packageImage;
  dynamic parcelTripType;

  ParcelDetails({
    required this.unit,
    required this.value,
    required this.packageType,
    required this.otherType,
    required this.packageImage,
    required this.parcelTripType,
  });

  factory ParcelDetails.fromJson(Map<String, dynamic> json) {
    return ParcelDetails(
      unit: json['unit'] ?? '',
      value: (json['value'] ?? 0).toDouble(),
      packageType: json['packageType'] ?? '',
      otherType: json['otherType'] ?? '',
      packageImage: json['packageImage'] ?? '',
      parcelTripType: json['parcelTripType'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unit': unit,
      'value': value,
      'packageType': packageType,
      'otherType': otherType,
      'packageImage': packageImage,
      'parcelTripType': parcelTripType,
    };
  }
}

//  "parcelDetails": {
//           "unit": "kg",
//           "value": 5,
//           "packageType": "food",
//           "otherType": "",
//           "packageImage": "",
//           "parcelTripType": "single"
//   },

class AmountDetails {
  dynamic tips;
  dynamic couponsAmount;
  dynamic cartFoodAmountWithoutCoupon;
  dynamic orderBasicAmount;
  dynamic finalAmount;
  dynamic deliveryCharges;
  dynamic tax;
  dynamic packingCharges;
    dynamic platformCharge;

  dynamic couponType;

  AmountDetails({
    required this.tips,
    required this.cartFoodAmountWithoutCoupon,
    required this.couponsAmount,
    required this.orderBasicAmount,
    required this.finalAmount,
    required this.deliveryCharges,
    required this.platformCharge,

    required this.tax,
    required this.packingCharges,
    required this.couponType,
  });

  factory AmountDetails.fromJson(Map<String, dynamic> json) {
    return AmountDetails(
        tips: (json['tips'] ?? 0).toDouble(),
        cartFoodAmountWithoutCoupon:
            (json['cartFoodAmountWithoutCoupon'] ?? 0).toDouble(),
        couponsAmount: (json['couponsAmount'] ?? 0).toDouble(),
        orderBasicAmount: (json['orderBasicAmount'] ?? 0).toDouble(),
        finalAmount: (json['finalAmount'] ?? 0).toDouble(),
        deliveryCharges: (json['deliveryCharges'] ?? 0).toDouble(),
        tax: (json['tax'] ?? 0).toDouble(),
        packingCharges: (json['packingCharges'] ?? 0).toDouble(),
        platformCharge: (json['platformFee'] ?? 0).toDouble(),
        couponType: json['couponType'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'tips': tips,
      'cartFoodAmountWithoutCoupon': cartFoodAmountWithoutCoupon,
      'couponsAmount': couponsAmount,
      'orderBasicAmount': orderBasicAmount,
      'finalAmount': finalAmount,
      'deliveryCharges': deliveryCharges,
      'tax': tax,
      'packingCharges': packingCharges,
      'platformFee': platformCharge,
      'couponType': couponType
    };
  }
}
