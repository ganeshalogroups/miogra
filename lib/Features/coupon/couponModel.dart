
// ignore_for_file: file_names

class Coupon {
  final String id;
  final String couponTitle;
  final String couponCode;
  final String? userId;
  final String parentUserId;
  final bool status;
  final List<String> availableUsersList;
  final int couponAmount;
  final int aboveValue;
  final DateTime startDate;
  final DateTime endDate;
  final int? limit;
  final List<String> limitUserList;
  final String couponType;
  final List<String> subAdminType;
  final String hashUser;
  final List<String> couponDetails;
  final bool deleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isUsed;
  final String availableStatus;

  Coupon({
    required this.id,
    required this.couponTitle,
    required this.couponCode,
    this.userId,
    required this.parentUserId,
    required this.status,
    required this.availableUsersList,
    required this.couponAmount,
    required this.aboveValue,
    required this.startDate,
    required this.endDate,
    this.limit,
    required this.limitUserList,
    required this.couponType,
    required this.subAdminType,
    required this.hashUser,
    required this.couponDetails,
    required this.deleted,
    required this.createdAt,
    required this.updatedAt,
    required this.isUsed,
    required this.availableStatus,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      id: json['_id'],
      couponTitle: json['couponTitle'],
      couponCode: json['couponCode'],
      userId: json['userId'],
      parentUserId: json['parentUserId'],
      status: json['status'],
      availableUsersList: List<String>.from(json['availableUsersList']),
      couponAmount: json['couponAmount'],
      aboveValue: json['aboveValue'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      limit: json['limit'],
      limitUserList: List<String>.from(json['limitUserList']),
      couponType: json['couponType'],
      subAdminType: List<String>.from(json['subAdminType']),
      hashUser: json['hashUser'],
      couponDetails: List<String>.from(json['couponDetails']),
      deleted: json['deleted'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      isUsed: json['isUsed'],
      availableStatus: json['availableStatus'],
    );
  }
}


class ParcelCouponResponse {
  final int code;
  final bool status;
  final String message;
  final ParcelCouponData data;

  ParcelCouponResponse({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });


  factory ParcelCouponResponse.fromJson(Map<String, dynamic> json) {
    return ParcelCouponResponse(
      code: json['code'],
      status: json['status'],
      message: json['message'],
      data: ParcelCouponData.fromJson(json['data']),
    );
  }
}

class ParcelCouponData {
  final List<ParcelCoupon> coupons;
  final int totalCount;

  ParcelCouponData({
    required this.coupons,
    required this.totalCount,
  });

  factory ParcelCouponData.fromJson(Map<String, dynamic> json) {
    var couponList = json['data'] as List;
    List<ParcelCoupon> coupons = couponList.map((c) => ParcelCoupon.fromJson(c)).toList();
    return ParcelCouponData(
      coupons: coupons,
      totalCount: json['totalCount'],
    );
  }
}




class ParcelCoupon {
  final String id;
  final String couponTitle;
  final String couponCode;
  final String? userId;
  final String parentUserId;
  final bool status;
  final List<String> availableUsersList;
  final int couponAmount;
  final int aboveValue;
  final DateTime startDate;
  final DateTime endDate;
  final int? limit;
  final List<String> limitUserList;
  final String couponType;
  final List<String> subAdminType;
  final String hashUser;
  final List<String> couponDetails;
  final bool deleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final bool isUsed;
  final String availableStatus;

  ParcelCoupon({
    required this.id,
    required this.couponTitle,
    required this.couponCode,
    this.userId,
    required this.parentUserId,
    required this.status,
    required this.availableUsersList,
    required this.couponAmount,
    required this.aboveValue,
    required this.startDate,
    required this.endDate,
    this.limit,
    required this.limitUserList,
    required this.couponType,
    required this.subAdminType,
    required this.hashUser,
    required this.couponDetails,
    required this.deleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.isUsed,
    required this.availableStatus,
  });

  factory ParcelCoupon.fromJson(Map<String, dynamic> json) {
    return ParcelCoupon(
      id: json['_id'],
      couponTitle: json['couponTitle'],
      couponCode: json['couponCode'],
      userId: json['userId'],
      parentUserId: json['parentUserId'],
      status: json['status'],
      availableUsersList: List<String>.from(json['availableUsersList']),
      couponAmount: json['couponAmount'],
      aboveValue: json['aboveValue'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      limit: json['limit'],
      limitUserList: List<String>.from(json['limitUserList']),
      couponType: json['couponType'],
      subAdminType: List<String>.from(json['subAdminType']),
      hashUser: json['hashUser'],
      couponDetails: List<String>.from(json['couponDetails']),
      deleted: json['deleted'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
      isUsed: json['isUsed'],
      availableStatus: json['availableStatus'],
    );
  }
}





/// For Round Trip 
/// 
/// 
/// 
/// 





class RountTripRoundParcelCouponResponse {
  final int code;
  final bool status;
  final String message;
  final RoundRoundParcelCouponData data;

  RountTripRoundParcelCouponResponse({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });


  factory RountTripRoundParcelCouponResponse.fromJson(Map<String, dynamic> json) {
    return RountTripRoundParcelCouponResponse(
      code: json['code'],
      status: json['status'],
      message: json['message'],
      data: RoundRoundParcelCouponData.fromJson(json['data']),
    );
  }
}

class RoundRoundParcelCouponData {
  final List<RoundParcelCoupon> coupons;
  final int totalCount;

  RoundRoundParcelCouponData({
    required this.coupons,
    required this.totalCount,
  });

  factory RoundRoundParcelCouponData.fromJson(Map<String, dynamic> json) {
    var couponList = json['data'] as List;
    List<RoundParcelCoupon> coupons = couponList.map((c) => RoundParcelCoupon.fromJson(c)).toList();
    return RoundRoundParcelCouponData(
      coupons: coupons,
      totalCount: json['totalCount'],
    );
  }
}




class RoundParcelCoupon {
  final String id;
  final String couponTitle;
  final String couponCode;
  final String? userId;
  final String parentUserId;
  final bool status;
  final List<String> availableUsersList;
  final int couponAmount;
  final int aboveValue;
  final DateTime startDate;
  final DateTime endDate;
  final int? limit;
  final List<String> limitUserList;
  final String couponType;
  final List<String> subAdminType;
  final String hashUser;
  final List<String> couponDetails;
  final bool deleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final bool isUsed;
  final String availableStatus;

  RoundParcelCoupon({
    required this.id,
    required this.couponTitle,
    required this.couponCode,
    this.userId,
    required this.parentUserId,
    required this.status,
    required this.availableUsersList,
    required this.couponAmount,
    required this.aboveValue,
    required this.startDate,
    required this.endDate,
    this.limit,
    required this.limitUserList,
    required this.couponType,
    required this.subAdminType,
    required this.hashUser,
    required this.couponDetails,
    required this.deleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.isUsed,
    required this.availableStatus,
  });

  factory RoundParcelCoupon.fromJson(Map<String, dynamic> json) {
    return RoundParcelCoupon(
      id: json['_id'],
      couponTitle: json['couponTitle'],
      couponCode: json['couponCode'],
      userId: json['userId'],
      parentUserId: json['parentUserId'],
      status: json['status'],
      availableUsersList: List<String>.from(json['availableUsersList']),
      couponAmount: json['couponAmount'],
      aboveValue: json['aboveValue'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      limit: json['limit'],
      limitUserList: List<String>.from(json['limitUserList']),
      couponType: json['couponType'],
      subAdminType: List<String>.from(json['subAdminType']),
      hashUser: json['hashUser'],
      couponDetails: List<String>.from(json['couponDetails']),
      deleted: json['deleted'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
      isUsed: json['isUsed'],
      availableStatus: json['availableStatus'],
    );
  }
}
