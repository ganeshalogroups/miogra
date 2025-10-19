// To parse this JSON data, do
//
//     final otpverficationmodel = otpverficationmodelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

Otpverficationmodel otpverficationmodelFromJson(String str) => Otpverficationmodel.fromJson(json.decode(str));

String otpverficationmodelToJson(Otpverficationmodel data) => json.encode(data.toJson());

class Otpverficationmodel {
    int code;
    bool status;
    String message;
    Data data;

    Otpverficationmodel({
        required this.code,
        required this.status,
        required this.message,
        required this.data,
    });

    factory Otpverficationmodel.fromJson(Map<String, dynamic> json) => Otpverficationmodel(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    String message;
    String type;

    Data({
        required this.message,
        required this.type,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "type": type,
    };
}
