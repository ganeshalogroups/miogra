// To parse this JSON data, do
//
//     final categorymodel = categorymodelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

Categorymodel categorymodelFromJson(String str) => Categorymodel.fromJson(json.decode(str));

String categorymodelToJson(Categorymodel data) => json.encode(data.toJson());

class Categorymodel {
    int? code;
    bool? status;
    String? message;
    Data? data;

    Categorymodel({
        this.code,
        this.status,
        this.message,
        this.data,
    });

    factory Categorymodel.fromJson(Map<String, dynamic> json) => Categorymodel(
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
    int? totalCount;
    int? fetchCount;
    List<Datum>? data;

    Data({
        this.totalCount,
        this.fetchCount,
        this.data,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalCount: json["totalCount"],
        fetchCount: json["fetchCount"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "fetchCount": fetchCount,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? id;
    String? foodCateName;
    String? foodCateImage;
    List<String>? foodCateAdditionalImg;
    String? productCateId;
    String? foodCateTitle;
    String? foodCateDescription;
    String? foodCateType;
    String? restaurantId;
    bool? defaultStatus;
    bool? status;
    bool? deleted;
    String? foodCategoryCode;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    Datum({
        this.id,
        this.foodCateName,
        this.foodCateImage,
        this.foodCateAdditionalImg,
        this.productCateId,
        this.foodCateTitle,
        this.foodCateDescription,
        this.foodCateType,
        this.restaurantId,
        this.defaultStatus,
        this.status,
        this.deleted,
        this.foodCategoryCode,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        foodCateName: json["foodCateName"],
        foodCateImage: json["foodCateImage"],
        foodCateAdditionalImg: json["foodCateAdditionalImg"] == null ? [] : List<String>.from(json["foodCateAdditionalImg"]!.map((x) => x)),
        productCateId: json["productCateId"],
        foodCateTitle: json["foodCateTitle"],
        foodCateDescription: json["foodCateDescription"],
        foodCateType: json["foodCateType"],
        restaurantId: json["restaurantId"],
        defaultStatus: json["defaultStatus"],
        status: json["status"],
        deleted: json["deleted"],
        foodCategoryCode: json["foodCategoryCode"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "foodCateName": foodCateName,
        "foodCateImage": foodCateImage,
        "foodCateAdditionalImg": foodCateAdditionalImg == null ? [] : List<dynamic>.from(foodCateAdditionalImg!.map((x) => x)),
        "productCateId": productCateId,
        "foodCateTitle": foodCateTitle,
        "foodCateDescription": foodCateDescription,
        "foodCateType": foodCateType,
        "restaurantId": restaurantId,
        "defaultStatus": defaultStatus,
        "status": status,
        "deleted": deleted,
        "foodCategoryCode": foodCategoryCode,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}
