


// ignore_for_file: file_names

class ResturantByIdModel {
    int? code;
    bool? status;
    String? message;
    Data? data;

    ResturantByIdModel({
        this.code,
        this.status,
        this.message,
        this.data,
    });

    factory ResturantByIdModel.fromJson(Map<String, dynamic> json) => ResturantByIdModel(
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
        restaurantDetails: json["restaurantDetails"] == null ? null : RestaurantDetails.fromJson(json["restaurantDetails"]),
        categoryList: json["categoryList"] == null ? [] : List<CategoryList>.from(json["categoryList"]!.map((x) => CategoryList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "fetchCount": fetchCount,
        "restaurantDetails": restaurantDetails?.toJson(),
        "categoryList": categoryList == null ? [] : List<dynamic>.from(categoryList!.map((x) => x.toJson())),
    };
}

class CategoryList {
    String? id;
    String? foodCateName;
    String? foodCateImage;
    List<dynamic>? foodCateAdditionalImg;
    String? productCateId;
    dynamic foodCateTitle;
    dynamic foodCateDescription;
    String? foodCateType;
    String? restaurantId;
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
        foodCateAdditionalImg: json["foodCateAdditionalImg"] == null ? [] : List<dynamic>.from(json["foodCateAdditionalImg"]!.map((x) => x)),
        productCateId: json["productCateId"],
        foodCateTitle: json["foodCateTitle"],
        foodCateDescription: json["foodCateDescription"],
        foodCateType: json["foodCateType"],
        restaurantId: json["restaurantId"],
        status: json["status"],
        foods: json["foods"] == null ? [] : List<FoodElement>.from(json["foods"]!.map((x) => FoodElement.fromJson(x))),
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
        "status": status,
        "foods": foods == null ? [] : List<dynamic>.from(foods!.map((x) => x.toJson())),
    };
}

class FoodElement {
    String? id;
    String? foodName;
    String? foodImgUrl;
    List<String?>? additionalImage;
    String? foodType;
    dynamic foodTitle;
    String? foodDiscription;
    String? foodCategoryId;
    String? foodCusineTypeId;
    String? restaurantId;
    List<String>? ingredients;
    bool? status;
    bool? iscustomizable;
    List<AvailableTiming>? availableTimings;
    String? preparationTime;
    FoodFood? food;
    CustomizedFood? customizedFood;
    dynamic offerAmount;
    dynamic offerName;
    dynamic notes;
    bool? deleted;
    bool? isRecommended;
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
        this.createdAt,
        this.updatedAt,
        this.v,
        this.availableStatus,
    });

    factory FoodElement.fromJson(Map<String, dynamic> json) => FoodElement(
        id: json["_id"],
        foodName: json["foodName"],
        foodImgUrl: json["foodImgUrl"],
        additionalImage: json["additionalImage"] == null ? [] : List<String?>.from(json["additionalImage"]!.map((x) => x)),
        foodType: json["foodType"],
        foodTitle: json["foodTitle"],
        foodDiscription: json["foodDiscription"],
        foodCategoryId: json["foodCategoryId"],
        foodCusineTypeId: json["foodCusineTypeId"],
        restaurantId: json["restaurantId"],
        ingredients: json["ingredients"] == null ? [] : List<String>.from(json["ingredients"]!.map((x) => x)),
        status: json["status"],
        iscustomizable: json["iscustomizable"],
        availableTimings: json["availableTimings"] == null ? [] : List<AvailableTiming>.from(json["availableTimings"]!.map((x) => AvailableTiming.fromJson(x))),
        preparationTime: json["preparationTime"],
        food: json["food"] == null ? null : FoodFood.fromJson(json["food"]),
        customizedFood: json["customizedFood"] == null ? null : CustomizedFood.fromJson(json["customizedFood"]),
        offerAmount: json["offerAmount"],
        offerName: json["offerName"],
        notes: json["notes"],
        deleted: json["deleted"],
        isRecommended: json["isRecommended"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        availableStatus: json["availableStatus"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "foodName": foodName,
        "foodImgUrl": foodImgUrl,
        "additionalImage": additionalImage == null ? [] : List<dynamic>.from(additionalImage!.map((x) => x)),
        "foodType": foodType,
        "foodTitle": foodTitle,
        "foodDiscription": foodDiscription,
        "foodCategoryId": foodCategoryId,
        "foodCusineTypeId": foodCusineTypeId,
        "restaurantId": restaurantId,
        "ingredients": ingredients == null ? [] : List<dynamic>.from(ingredients!.map((x) => x)),
        "status": status,
        "iscustomizable": iscustomizable,
        "availableTimings": availableTimings == null ? [] : List<dynamic>.from(availableTimings!.map((x) => x.toJson())),
        "preparationTime": preparationTime,
        "food": food?.toJson(),
        "customizedFood": customizedFood?.toJson(),
        "offerAmount": offerAmount,
        "offerName": offerName,
        "notes": notes,
        "deleted": deleted,
        "isRecommended": isRecommended,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "availableStatus": availableStatus,
    };
}

class AvailableTiming {
    String? type;
    String? from;
    String? to;
    bool? checked;

    AvailableTiming({
        this.type,
        this.from,
        this.to,
        this.checked,
    });

    factory AvailableTiming.fromJson(Map<String, dynamic> json) => AvailableTiming(
        type: json["type"],
        from: json["from"],
        to: json["to"],
        checked: json["checked"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "from": from,
        "to": to,
        "checked": checked,
    };
}

class CustomizedFood {
    List<dynamic>? addVariants;
    List<dynamic>? addOns;

    CustomizedFood({
        this.addVariants,
        this.addOns,
    });

    factory CustomizedFood.fromJson(Map<String, dynamic> json) => CustomizedFood(
        addVariants: json["addVariants"] == null ? [] : List<dynamic>.from(json["addVariants"]!.map((x) => x)),
        addOns: json["addOns"] == null ? [] : List<dynamic>.from(json["addOns"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "addVariants": addVariants == null ? [] : List<dynamic>.from(addVariants!.map((x) => x)),
        "addOns": addOns == null ? [] : List<dynamic>.from(addOns!.map((x) => x)),
    };
}

class FoodFood {
    int? basePrice;
    int? customerPrice;
    dynamic packagingCharge;
    int? totalPrice;
    String? discount;
    String? gst;
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
    String? id;
    String? name;
    String? lastName;
    String? email;
    String? mobileNo;
    String? adminProfile;
    String? uuid;
    bool? status;
    String? imgUrl;
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
        this.aditionalContactNumber,
        this.address,
        this.instructions,
        this.ratingAverage,
        this.isFavourite,
    });

    factory RestaurantDetails.fromJson(Map<String, dynamic> json) => RestaurantDetails(
        id: json["_id"],
        name: json["name"],
        lastName: json["lastName"],
        email: json["email"],
        mobileNo: json["mobileNo"],
        adminProfile: json["adminProfile"],
        uuid: json["uuid"],
        status: json["status"],
        imgUrl: json["imgUrl"],
        aditionalContactNumber: json["aditionalContactNumber"],
        address: json["address"] == null ? null : Address.fromJson(json["address"]),
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
        "aditionalContactNumber": aditionalContactNumber,
        "address": address?.toJson(),
        "instructions": instructions,
        "ratingAverage": ratingAverage,
        "isFavourite": isFavourite,
    };
}

class Address {
    String? street;
    String? region;
    String? city;
    String? state;
    String? country;
    String? postalCode;

    Address({
        this.street,
        this.region,
        this.city,
        this.state,
        this.country,
        this.postalCode,
    });

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        street: json["street"],
        region: json["region"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        postalCode: json["postalCode"],
    );

    Map<String, dynamic> toJson() => {
        "street": street,
        "region": region,
        "city": city,
        "state": state,
        "country": country,
        "postalCode": postalCode,
    };
}
