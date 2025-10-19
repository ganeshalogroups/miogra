// To parse this JSON data, do
//
//     final tokenmodel = tokenmodelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

Tokenmodel tokenmodelFromJson(String str) => Tokenmodel.fromJson(json.decode(str));

String tokenmodelToJson(Tokenmodel data) => json.encode(data.toJson());

class Tokenmodel {
    int code;
    bool status;
    String message;
    TokenmodelData data;

    Tokenmodel({
        required this.code,
        required this.status,
        required this.message,
        required this.data,
    });

    factory Tokenmodel.fromJson(Map<String, dynamic> json) => Tokenmodel(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: TokenmodelData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class TokenmodelData {
    String token;
    DataData data;

    TokenmodelData({
        required this.token,
        required this.data,
    });

    factory TokenmodelData.fromJson(Map<String, dynamic> json) => TokenmodelData(
        token: json["token"],
        data: DataData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "data": data.toJson(),
    };
}

class DataData {
    String userName;
    String email;
    String userId;
    String mobileNo;
    String role;
    String uuid;

    DataData({
        required this.userName,
        required this.email,
        required this.userId,
        required this.mobileNo,
        required this.role,
        required this.uuid,
    });

    factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        userName: json["userName"],
        email: json["email"],
        userId: json["userId"],
        mobileNo: json["mobileNo"],
        role: json["role"],
        uuid: json["uuid"],
    );

    Map<String, dynamic> toJson() => {
        "userName": userName,
        "email": email,
        "userId": userId,
        "mobileNo": mobileNo,
        "role": role,
        "uuid": uuid,
    };
}
