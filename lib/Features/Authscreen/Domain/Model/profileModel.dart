// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);



// ignore_for_file: file_names

class ProfileModel {
    int? code;
    bool? status;
    String? message;
    Data? data;

    ProfileModel({
        this.code,
        this.status,
        this.message,
        this.data,
    });

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
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
    String? id;
    String? name;
    String? email;
    dynamic parentAdminUserId;
    dynamic jobType;
    String? mobileNo;
    dynamic gstNo;
    String? uuid;
    dynamic referralCode;
    String? fcmToken;
    dynamic noOfOrdersPerMonth;
    bool? isVerified;
    bool? deleted;
    bool? status;
    String? imgUrl;
    String? secretKey;
    DateTime? lastSeen;
    Address? address;
    AdminUserKyc? adminUserKyc;
    BankDetails? bankDetails;
    String? role;
    dynamic instructions;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    List<dynamic>? referalDetails;
    List<dynamic>? ratings;
    dynamic ratingAverage;
    int? totalReferalCount;

    Data({
        this.id,
        this.name,
        this.email,
        this.parentAdminUserId,
        this.jobType,
        this.mobileNo,
        this.gstNo,
        this.uuid,
        this.referralCode,
        this.fcmToken,
        this.noOfOrdersPerMonth,
        this.isVerified,
        this.deleted,
        this.status,
        this.imgUrl,
        this.secretKey,
        this.lastSeen,
        this.address,
        this.adminUserKyc,
        this.bankDetails,
        this.role,
        this.instructions,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.referalDetails,
        this.ratings,
        this.ratingAverage,
        this.totalReferalCount,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        parentAdminUserId: json["parentAdminUserId"],
        jobType: json["jobType"],
        mobileNo: json["mobileNo"],
        gstNo: json["gstNo"],
        uuid: json["uuid"],
        referralCode: json["referralCode"],
        fcmToken: json["fcmToken"],
        noOfOrdersPerMonth: json["noOfOrdersPerMonth"],
        isVerified: json["isVerified"],
        deleted: json["deleted"],
        status: json["status"],
        imgUrl: json["imgUrl"],
        secretKey: json["secretKey"],
        lastSeen: json["lastSeen"] == null ? null : DateTime.parse(json["lastSeen"]),
        address: json["address"] == null ? null : Address.fromJson(json["address"]),
        adminUserKyc: json["adminUserKYC"] == null ? null : AdminUserKyc.fromJson(json["adminUserKYC"]),
        bankDetails: json["BankDetails"] == null ? null : BankDetails.fromJson(json["BankDetails"]),
        role: json["role"],
        instructions: json["instructions"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        referalDetails: json["referalDetails"] == null ? [] : List<dynamic>.from(json["referalDetails"]!.map((x) => x)),
        ratings: json["ratings"] == null ? [] : List<dynamic>.from(json["ratings"]!.map((x) => x)),
        ratingAverage: json["ratingAverage"],
        totalReferalCount: json["totalReferalCount"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "parentAdminUserId": parentAdminUserId,
        "jobType": jobType,
        "mobileNo": mobileNo,
        "gstNo": gstNo,
        "uuid": uuid,
        "referralCode": referralCode,
        "fcmToken": fcmToken,
        "noOfOrdersPerMonth": noOfOrdersPerMonth,
        "isVerified": isVerified,
        "deleted": deleted,
        "status": status,
        "imgUrl": imgUrl,
        "secretKey": secretKey,
        "lastSeen": lastSeen?.toIso8601String(),
        "address": address?.toJson(),
        "adminUserKYC": adminUserKyc?.toJson(),
        "BankDetails": bankDetails?.toJson(),
        "role": role,
        "instructions": instructions,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "referalDetails": referalDetails == null ? [] : List<dynamic>.from(referalDetails!.map((x) => x)),
        "ratings": ratings == null ? [] : List<dynamic>.from(ratings!.map((x) => x)),
        "ratingAverage": ratingAverage,
        "totalReferalCount": totalReferalCount,
    };
}

class Address {
    dynamic houseNo;
    dynamic district;
    dynamic companyName;
    dynamic fullAddress;
    dynamic street;
    dynamic city;
    dynamic state;
    dynamic country;
    dynamic postalCode;
    dynamic landMark;
    dynamic contactPerson;
    dynamic contactPersonNumber;
    dynamic addressType;
    dynamic latitude;
    dynamic longitude;
    dynamic region;

    Address({
        this.houseNo,
        this.district,
        this.companyName,
        this.fullAddress,
        this.street,
        this.city,
        this.state,
        this.country,
        this.postalCode,
        this.landMark,
        this.contactPerson,
        this.contactPersonNumber,
        this.addressType,
        this.latitude,
        this.longitude,
        this.region,
    });

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        houseNo: json["houseNo"],
        district: json["district"],
        companyName: json["companyName"],
        fullAddress: json["fullAddress"],
        street: json["street"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        postalCode: json["postalCode"],
        landMark: json["landMark"],
        contactPerson: json["contactPerson"],
        contactPersonNumber: json["contactPersonNumber"],
        addressType: json["addressType"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        region: json["region"],
    );

    Map<String, dynamic> toJson() => {
        "houseNo": houseNo,
        "district": district,
        "companyName": companyName,
        "fullAddress": fullAddress,
        "street": street,
        "city": city,
        "state": state,
        "country": country,
        "postalCode": postalCode,
        "landMark": landMark,
        "contactPerson": contactPerson,
        "contactPersonNumber": contactPersonNumber,
        "addressType": addressType,
        "latitude": latitude,
        "longitude": longitude,
        "region": region,
    };
}

class AdminUserKyc {
    dynamic dob;
    dynamic idProofType;
    dynamic idProofNumber;
    dynamic idProofFrontPicUrl;
    dynamic idProofBackPicUrl;
    dynamic gstInNumber;
    dynamic gstProofFrontPicUrl;
    dynamic gstProofBackPicUrl;
    dynamic profilePicUrl;
    dynamic isUserKycVerified;

    AdminUserKyc({
        this.dob,
        this.idProofType,
        this.idProofNumber,
        this.idProofFrontPicUrl,
        this.idProofBackPicUrl,
        this.gstInNumber,
        this.gstProofFrontPicUrl,
        this.gstProofBackPicUrl,
        this.profilePicUrl,
        this.isUserKycVerified,
    });

    factory AdminUserKyc.fromJson(Map<String, dynamic> json) => AdminUserKyc(
        dob: json["DOB"],
        idProofType: json["idProofType"],
        idProofNumber: json["idProofNumber"],
        idProofFrontPicUrl: json["idProofFrontPicUrl"],
        idProofBackPicUrl: json["idProofBackPicUrl"],
        gstInNumber: json["gstInNumber"],
        gstProofFrontPicUrl: json["gstProofFrontPicUrl"],
        gstProofBackPicUrl: json["gstProofBackPicUrl"],
        profilePicUrl: json["profilePicUrl"],
        isUserKycVerified: json["isUserKYCVerified"],
    );

    Map<String, dynamic> toJson() => {
        "DOB": dob,
        "idProofType": idProofType,
        "idProofNumber": idProofNumber,
        "idProofFrontPicUrl": idProofFrontPicUrl,
        "idProofBackPicUrl": idProofBackPicUrl,
        "gstInNumber": gstInNumber,
        "gstProofFrontPicUrl": gstProofFrontPicUrl,
        "gstProofBackPicUrl": gstProofBackPicUrl,
        "profilePicUrl": profilePicUrl,
        "isUserKYCVerified": isUserKycVerified,
    };
}

class BankDetails {
    dynamic bankName;
    dynamic acType;
    dynamic accountNumber;
    dynamic ifscCode;
    dynamic branchName;

    BankDetails({
        this.bankName,
        this.acType,
        this.accountNumber,
        this.ifscCode,
        this.branchName,
    });

    factory BankDetails.fromJson(Map<String, dynamic> json) => BankDetails(
        bankName: json["bankName"],
        acType: json["acType"],
        accountNumber: json["accountNumber"],
        ifscCode: json["ifscCode"],
        branchName: json["branchName"],
    );

    Map<String, dynamic> toJson() => {
        "bankName": bankName,
        "acType": acType,
        "accountNumber": accountNumber,
        "ifscCode": ifscCode,
        "branchName": branchName,
    };
}
