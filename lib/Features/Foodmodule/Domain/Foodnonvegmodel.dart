
// ignore_for_file: file_names

import 'dart:convert';

Foodlist foodlistFromJson(String str) => Foodlist.fromJson(json.decode(str));

String foodlistToJson(Foodlist data) => json.encode(data.toJson());

class Foodlist {
  int? code;
  bool? status;
  String? message;
  Data? data;

  Foodlist({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  factory Foodlist.fromJson(Map<String, dynamic> json) => Foodlist(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  dynamic totalCount;
  dynamic fetchCount;
  RestaurantDetails? restaurantDetails;
  List<CategoryList>? categoryList;

  Data({
    this.totalCount,
    this.fetchCount,
    this.restaurantDetails,
    this.categoryList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalCount: json["totalCount"],
        fetchCount: json["fetchCount"],
        restaurantDetails: json["restaurantDetails"] == null
            ? null
            : RestaurantDetails.fromJson(json["restaurantDetails"]),
        categoryList: json["categoryList"] == null
            ? []
            : List<CategoryList>.from(
                json["categoryList"]!.map((x) => CategoryList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "fetchCount": fetchCount,
        "restaurantDetails": restaurantDetails?.toJson(),
        "categoryList": categoryList == null
            ? []
            : List<dynamic>.from(categoryList!.map((x) => x.toJson())),
      };
}

class CategoryList {
  dynamic id;
  dynamic foodCateName;
  dynamic foodCateImage;
  List<dynamic>? foodCateAdditionalImg;
  dynamic productCateId;
  dynamic foodCateTitle;
  dynamic foodCateDescription;
  dynamic foodCateType;
  dynamic restaurantId;
  bool? status;
  List<FoodElement>? foods;

  CategoryList({
    this.id,
    this.foodCateName,
    this.foodCateImage,
    this.foodCateAdditionalImg,
    this.productCateId,
    this.foodCateTitle,
    this.foodCateDescription,
    this.foodCateType,
    this.restaurantId,
    this.status,
    this.foods,
  });

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
        id: json["_id"],
        foodCateName: json["foodCateName"],
        foodCateImage: json["foodCateImage"],
        foodCateAdditionalImg: json["foodCateAdditionalImg"] == null
            ? []
            : List<dynamic>.from(json["foodCateAdditionalImg"]!.map((x) => x)),
        productCateId: json["productCateId"],
        foodCateTitle: json["foodCateTitle"],
        foodCateDescription: json["foodCateDescription"],
        foodCateType: json["foodCateType"],
        restaurantId: json["restaurantId"],
        status: json["status"],
        foods: json["foods"] == null
            ? []
            : List<FoodElement>.from(
                json["foods"]!.map((x) => FoodElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "foodCateName": foodCateName,
        "foodCateImage": foodCateImage,
        "foodCateAdditionalImg": foodCateAdditionalImg == null
            ? []
            : List<dynamic>.from(foodCateAdditionalImg!.map((x) => x)),
        "productCateId": productCateId,
        "foodCateTitle": foodCateTitle,
        "foodCateDescription": foodCateDescription,
        "foodCateType": foodCateType,
        "restaurantId": restaurantId,
        "status": status,
        "foods": foods == null
            ? []
            : List<dynamic>.from(foods!.map((x) => x.toJson())),
      };
}

class FoodElement {
  dynamic id;
  dynamic foodName;
  dynamic foodImgUrl;
  List<String>? additionalImage;
  dynamic foodType;
  dynamic foodTitle;
  dynamic foodDiscription;
  dynamic foodCategoryId;
  dynamic foodCusineTypeId;
  dynamic restaurantId;
  List<String>? ingredients;
  bool? status;
  bool? iscustomizable;
  List<AvailableTiming>? availableTimings;
  dynamic preparationTime;
  FoodFood? food;
  CustomizedFood? customizedFood;
  dynamic offerAmount;
  dynamic offerName;
  dynamic notes;
  bool? deleted;
  bool? isRecommended;
  int? commission;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  bool? availableStatus;

  FoodElement({
    this.id,
    this.foodName,
    this.foodImgUrl,
    this.additionalImage,
    this.foodType,
    this.foodTitle,
    this.foodDiscription,
    this.foodCategoryId,
    this.foodCusineTypeId,
    this.restaurantId,
    this.ingredients,
    this.status,
    this.iscustomizable,
    this.availableTimings,
    this.preparationTime,
    this.food,
    this.customizedFood,
    this.offerAmount,
    this.offerName,
    this.notes,
    this.deleted,
    this.isRecommended,
    this.commission,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.availableStatus,
  });

  factory FoodElement.fromJson(Map<String, dynamic> json) => FoodElement(
        id: json["_id"],
        foodName: json["foodName"],
        foodImgUrl: json["foodImgUrl"],
        additionalImage: json["additionalImage"] == null
            ? []
            : List<String>.from(json["additionalImage"]!.map((x) => x)),
        foodType: json["foodType"],
        foodTitle: json["foodTitle"],
        foodDiscription: json["foodDiscription"],
        foodCategoryId: json["foodCategoryId"],
        foodCusineTypeId: json["foodCusineTypeId"],
        restaurantId: json["restaurantId"],
        ingredients: json["ingredients"] == null
            ? []
            : List<String>.from(json["ingredients"]!.map((x) => x)),
        status: json["status"],
        iscustomizable: json["iscustomizable"],
        availableTimings: json["availableTimings"] == null
            ? []
            : List<AvailableTiming>.from(json["availableTimings"]!
                .map((x) => AvailableTiming.fromJson(x))),
        preparationTime: json["preparationTime"],
        food: json["food"] == null ? null : FoodFood.fromJson(json["food"]),
        customizedFood: json["customizedFood"] == null
            ? null
            : CustomizedFood.fromJson(json["customizedFood"]),
        offerAmount: json["offerAmount"],
        offerName: json["offerName"],
        notes: json["notes"],
        deleted: json["deleted"],
        isRecommended: json["isRecommended"],
        commission: json["commission"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        availableStatus: json["availableStatus"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "foodName": foodName,
        "foodImgUrl": foodImgUrl,
        "additionalImage": additionalImage == null
            ? []
            : List<dynamic>.from(additionalImage!.map((x) => x)),
        "foodType": foodType,
        "foodTitle": foodTitle,
        "foodDiscription": foodDiscription,
        "foodCategoryId": foodCategoryId,
        "foodCusineTypeId": foodCusineTypeId,
        "restaurantId": restaurantId,
        "ingredients": ingredients == null
            ? []
            : List<dynamic>.from(ingredients!.map((x) => x)),
        "status": status,
        "iscustomizable": iscustomizable,
        "availableTimings": availableTimings == null
            ? []
            : List<dynamic>.from(availableTimings!.map((x) => x.toJson())),
        "preparationTime": preparationTime,
        "food": food?.toJson(),
        "customizedFood": customizedFood?.toJson(),
        "offerAmount": offerAmount,
        "offerName": offerName,
        "notes": notes,
        "deleted": deleted,
        "isRecommended": isRecommended,
        "commission":commission,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "availableStatus": availableStatus,
      };
}

class AvailableTiming {
  dynamic type;
  dynamic from;
  dynamic to;
  bool? checked;

  AvailableTiming({
    this.type,
    this.from,
    this.to,
    this.checked,
  });

  factory AvailableTiming.fromJson(Map<String, dynamic> json) =>
      AvailableTiming(
        type: json["type"]!,
        from: json["from"]!,
        to: json["to"]!,
        checked: json["checked"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "from": from,
        "to": to,
        "checked": checked,
      };
}

// enum From {
//     THE_1100,
//     THE_1600,
//     THE_600
// }

// final fromValues = EnumValues({
//     "11:00": From.THE_1100,
//     "16:00": From.THE_1600,
//     "6:00": From.THE_600
// });

// enum To {
//     THE_1100,
//     THE_1600,
//     THE_2200
// }

// final toValues = EnumValues({
//     "11:00": To.THE_1100,
//     "16:00": To.THE_1600,
//     "22:00": To.THE_2200
// });

// enum TypeEnum {
//     BREAKFAST,
//     DINNER,
//     LUNCH
// }

// final typeEnumValues = EnumValues({
//     "breakfast": TypeEnum.BREAKFAST,
//     "dinner": TypeEnum.DINNER,
//     "lunch": TypeEnum.LUNCH
// });

class CustomizedFood {
  List<AddVariant>? addVariants;
  List<AddOn>? addOns;

  CustomizedFood({
    this.addVariants,
    this.addOns,
  });

  factory CustomizedFood.fromJson(Map<String, dynamic> json) => CustomizedFood(
        addVariants: json["addVariants"] == null
            ? []
            : List<AddVariant>.from(
                json["addVariants"]!.map((x) => AddVariant.fromJson(x))),
        addOns: json["addOns"] == null
            ? []
            : List<AddOn>.from(json["addOns"]!.map((x) => AddOn.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "addVariants": addVariants == null
            ? []
            : List<dynamic>.from(addVariants!.map((x) => x.toJson())),
        "addOns": addOns == null
            ? []
            : List<dynamic>.from(addOns!.map((x) => x.toJson())),
      };
}

class AddOn {
  dynamic addOnsGroupName;
  List<Type>? addOnsType;
  dynamic id;

  AddOn({
    this.addOnsGroupName,
    this.addOnsType,
    this.id,
  });

  factory AddOn.fromJson(Map<String, dynamic> json) => AddOn(
        addOnsGroupName: json["addOnsGroupName"],
        addOnsType: json["addOnsType"] == null
            ? []
            : List<Type>.from(json["addOnsType"]!.map((x) => Type.fromJson(x))),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "addOnsGroupName": addOnsGroupName,
        "addOnsType": addOnsType == null
            ? []
            : List<dynamic>.from(addOnsType!.map((x) => x.toJson())),
        "_id": id,
      };
}

class Type {
  dynamic variantName;
  dynamic variantImage;
  List<dynamic>? additionalImage;
  dynamic type;
  dynamic basePrice;
  dynamic customerPrice;
  dynamic totalPrice;
  bool? deleted;
  bool? status;
  dynamic id;

  Type({
    this.variantName,
    this.variantImage,
    this.additionalImage,
    this.type,
    this.basePrice,
    this.customerPrice,
    this.totalPrice,
    this.deleted,
    this.status,
    this.id,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        variantName: json["variantName"],
        variantImage: json["variantImage"],
        additionalImage: json["additionalImage"] == null
            ? []
            : List<dynamic>.from(json["additionalImage"]!.map((x) => x)),
        type: json["type"],
        basePrice: json["basePrice"],
        customerPrice: json["customerPrice"],
        totalPrice: json["totalPrice"],
        deleted: json["deleted"],
        status: json["status"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "variantName": variantName,
        "variantImage": variantImage,
        "additionalImage": additionalImage == null
            ? []
            : List<dynamic>.from(additionalImage!.map((x) => x)),
        "type": type,
        "basePrice": basePrice,
        "customerPrice": customerPrice,
        "totalPrice": totalPrice,
        "deleted": deleted,
        "status": status,
        "_id": id,
      };
}

class AddVariant {
  dynamic variantGroupName;
  List<Type>? variantType;
  dynamic id;

  AddVariant({
    this.variantGroupName,
    this.variantType,
    this.id,
  });

  factory AddVariant.fromJson(Map<String, dynamic> json) => AddVariant(
        variantGroupName: json["variantGroupName"],
        variantType: json["variantType"] == null
            ? []
            : List<Type>.from(
                json["variantType"]!.map((x) => Type.fromJson(x))),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "variantGroupName": variantGroupName,
        "variantType": variantType == null
            ? []
            : List<dynamic>.from(variantType!.map((x) => x.toJson())),
        "_id": id,
      };
}

class FoodFood {
  dynamic basePrice;
  dynamic customerPrice;
  dynamic packagingCharge;
  dynamic totalPrice;
  dynamic discount;
  dynamic gst;
  dynamic unit;
  dynamic sgst;
  dynamic cgst;

  FoodFood({
    this.basePrice,
    this.customerPrice,
    this.packagingCharge,
    this.totalPrice,
    this.discount,
    this.gst,
    this.unit,
    this.sgst,
    this.cgst,
  });

  factory FoodFood.fromJson(Map<String, dynamic> json) => FoodFood(
        basePrice: json["basePrice"],
        customerPrice: json["customerPrice"],
        packagingCharge: json["packagingCharge"],
        totalPrice: json["totalPrice"],
        discount: json["discount"],
        gst: json["GST"],
        unit: json["unit"],
        sgst: json["SGST"],
        cgst: json["CGST"],
      );

  Map<String, dynamic> toJson() => {
        "basePrice": basePrice,
        "customerPrice": customerPrice,
        "packagingCharge": packagingCharge,
        "totalPrice": totalPrice,
        "discount": discount,
        "GST": gst,
        "unit": unit,
        "SGST": sgst,
        "CGST": cgst,
      };
}

class RestaurantDetails {
  dynamic id;
  dynamic name;
  dynamic lastName;
  dynamic email;
  dynamic mobileNo;
  dynamic adminProfile;
  dynamic uuid;
  bool? status;
  dynamic imgUrl;
  dynamic fssaiCertificate;
  dynamic fssaiNumber;
  dynamic aditionalContactNumber;
  Address? address;
  dynamic instructions;
  dynamic ratingAverage;
  bool? isFavourite;

  RestaurantDetails({
    this.id,
    this.name,
    this.lastName,
    this.email,
    this.mobileNo,
    this.adminProfile,
    this.uuid,
    this.status,
    this.imgUrl,
    this.fssaiNumber,
    this.fssaiCertificate,
    this.aditionalContactNumber,
    this.address,
    this.instructions,
    this.ratingAverage,
    this.isFavourite,
  });

  factory RestaurantDetails.fromJson(Map<String, dynamic> json) =>
      RestaurantDetails(
        id: json["_id"],
        name: json["name"],
        lastName: json["lastName"],
        email: json["email"],
        mobileNo: json["mobileNo"],
        adminProfile: json["adminProfile"],
        uuid: json["uuid"],
        status: json["status"],
        imgUrl: json["imgUrl"],
        fssaiNumber: json["fssaiNumber"],
        fssaiCertificate: json["fssaiCertificate"],
        aditionalContactNumber: json["aditionalContactNumber"],
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        instructions: json["instructions"],
        ratingAverage: json["ratingAverage"],
        isFavourite: json["isFavourite"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "lastName": lastName,
        "email": email,
        "mobileNo": mobileNo,
        "adminProfile": adminProfile,
        "uuid": uuid,
        "status": status,
        "imgUrl": imgUrl,
        "fssaiNumber":fssaiNumber,
        "fssaiCertificate":fssaiCertificate,
        "aditionalContactNumber": aditionalContactNumber,
        "address": address?.toJson(),
        "instructions": instructions,
        "ratingAverage": ratingAverage,
        "isFavourite": isFavourite,
      };
}

class Address {
  dynamic street;
  dynamic region;
  dynamic city;
  dynamic state;
  dynamic country;
  dynamic postalCode;
  dynamic latitude;
  dynamic longitude;

  Address({
    this.street,
    this.region,
    this.city,
    this.state,
    this.country,
    this.postalCode,
    this.latitude,
    this.longitude,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        street: json["street"],
        region: json["region"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        postalCode: json["postalCode"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "street": street,
        "region": region,
        "city": city,
        "state": state,
        "country": country,
        "postalCode": postalCode,
        "latitude": latitude,
        "longitude": longitude,
      };
}