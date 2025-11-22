// ignore_for_file: file_names

import 'package:testing/utils/Const/ApiConstvariables.dart';

class API {
 
  //  static String baseUrl = "https://dev.miogra.com/";
  //  static String microservicedev = "https://dev.miogra.com/";

   static String baseUrl = "https://backend.miogra.com/";
   static String microservicedev = "https://backend.miogra.com/";

   
static String vendorbasedcash ="${microservicedev}api/user/adminUser/finduserById";
  static String loginfastx = '${microservicedev}api/user/requestOtp';
  static String otpverifyfastx = '${microservicedev}api/user/verifyOtp';
  static String registerfastx = '${microservicedev}api/user/authUser/register';
  static String tokenfastx = '${microservicedev}api/user/authlist/token';

  //microservicedev profileApi
  static String updateLastSeen = '${microservicedev}api/user/authUser/';
  static String profileupdate = '${microservicedev}api/user/authUser';
  static String profileget = '${microservicedev}api/user/authUser';

  // Category Api
  static String categoryfastx = '${microservicedev}api/user/productCate';

  //microservicedev Address Api
  static String addressfastx = '${microservicedev}api/user/address/';
  static String getaddressfastx = '${microservicedev}api/user/address';

  // Key for Home address
  static String findhomeaddress =
      '${microservicedev}api/user/address/findAddress/byUserId';

  //microservicedev Food category
  static String foodcategetfastx = '${microservicedev}api/utility/hashtag';

  //microservicedev Banner,recent/popular Search
  static String bannergetfastx =
      '${microservicedev}api/utility/banner/mobileAppBanner';
   static String banner = '${microservicedev}api/sense/bannerMigrate/getBannerList';
  static String bannerParcelfastx = '${microservicedev}api/utility/banner';
  static String bottombanner = '${microservicedev}api/utility/banner';
  static String createrecentsearchfastx =
      '${microservicedev}api/utility/hashtag/recentsearch';

  //microservicedev restaurant->searchFoodlistbyRes
  static String searchFoodlistbyResgetfastx =
                                            '${microservicedev}api/user/subAdmin/searchFoodListByRes';
  static String nearestresapi =
                                '${microservicedev}api/sense/restaurantMigrate/list';

  //food->food list api->get category and food list by res id

  static String getFoodlistbyResgetfastx =
                                             '${microservicedev}api/food/foodlist/foodDetails';
  static String searchList =
                                  '${microservicedev}api/sense/foodMigrate/list/search';
  static String dishessearch =
                            '${microservicedev}api/sense/foodMigrate/detailView/list/search';
  static String particularcustomisation =
                                             '${microservicedev}api/food/foodlist/';

  //food->food category->food category count mobile app api
  static String menucount =
      '${microservicedev}api/food/foodCategory/getCateCount';

  //microservicedev common->favourite-.add favourite (add restaurant to favourites)
  static String addfavresfastx = '${microservicedev}api/order/favourite';

  //remove favourite
  static String removefavresfastx =
      '${microservicedev}api/order/favourite/delete';
      
  static String updatefavourite =
      '${microservicedev}api/order/favourite/update';

  //Add food to cart
  static String addfoodfastx = '${microservicedev}api/food/foodCart';
  static String updatefoodfastx = '${microservicedev}api/food/foodCart/update';
  static String getrestaurantCommission = '${microservicedev}api/user/';

  // get resturant by Id
  static String getResturantDetailsById =
      '${baseUrl}api/foodlist/foodlist?value=&';

  //delete FoodCart
  static String deletefoodfastx = '${microservicedev}api/food/foodCart/delete';

  // clear cart
  static String clearfoodfastx =
      '${microservicedev}api/food/foodCart/clearCart';

  //microservicedev Restaurant favourite Get Api
  static String restaurantfavget =
      '${microservicedev}api/order/favourite/getFavoriteRestaurantList';

  //  order
  static String ordercreate = '${microservicedev}api/order/order';
  static String cancelorder = '${microservicedev}api/order/order';
  static String couponApi = '${microservicedev}api/order/coupons/findParcelCoupons?';
//Coupon for User,from Restaurant,From vendor,using Coupon code
  static String overallcouponApi =
      '${microservicedev}api/order/coupons/findUserCoupons?';

  //wallet
  static String wallet = '${microservicedev}api/payment/wallet';

  // ratings

  static String ratingforrestaurant = '${microservicedev}api/order/ratings';

  //  create Order using razorpay , cashAndDelivery
  static String razorpayordercreate =
      '${microservicedev}api/payment/razorPay/createOrder';
  static String razorpayPayment = '${microservicedev}api/payment';

  //advertisement get
  static String advertisement = '${microservicedev}api/order/rewards';
  static String addimagelink = '${microservicedev}api/utility/appConfig/getByKey/imageUrlLink';

  //Chat health check
  static String chathealthcheck =
      "https://chat.aloinfotech.in/api/conversation/health/mobile";

  //FAQ
  static String faq = '${microservicedev}api/sense/faq/listFetch';

  //  Refund
  static String refund = '${microservicedev}api/payment/refund';
  static String refundstatus = '${microservicedev}api/payment/refundStatus';

  //microservicedev Help

  static String redirecturl = '${microservicedev}api/utility/appConfig';

  //  Invoice

  static String invoice =
      '${microservicedev}api/order/invoice/generateInVoiceForUser';

  static String imageuploadurl =
      '${microservicedev}api/utility/file/bannerUpload';

  // Reorder---->Orders-->order-->order-->reorder food cart list

  static String reorderfood = '${microservicedev}api/order/order/foodReorder';
  static String reordercart =
      '${microservicedev}api/food/foodCart/reorderCartListUpdate';

  //header
  Map<String, String> headers = {
    "Accept": "/",
    "Content-Type": "application/json",
    "userid": "$UserId",
    "Authorization": "Bearer $Usertoken"
  };

  Map<String, String> headersWithoutToken = {
    "Accept": "/",
    "Content-Type": "application/json",
  };

////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////// Parcel Services //////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
// Its For PArcel Services <=>

  static String getchipCate = '${baseUrl}api/parcel/packageCate/';
  static String createcartApi = '${baseUrl}api/parcel/package/cart';
  static String mesurmentsApi =
      '${baseUrl}api/parcel/measurements/?parcelType=others';

  static String getRegonApi = '${baseUrl}api/user/region?pincode=';
  static String getParcelCart =
      '${baseUrl}api/parcel/package/cart/userBased?userId=$UserId';

  static String createParcelOrder = '${baseUrl}api/order/order/createOrderParcel';
  static String clearParcelCart = '${baseUrl}api/package/cart/clearCart';

////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////// Meat Flow //////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
// Its For Meat Flow <=>

  static String meatgetcategorylist = '${baseUrl}api/foodcuisines';
  static String meatsearchlist = '${baseUrl}api/subAdmin/searchMeatList';
  static String createmeatrecentsearch = '${baseUrl}api/hashtag';
  static String shopviewproducts = '${baseUrl}api/meatlist/meatlist';
  static String meattypefilter = '${baseUrl}api/foodcuisines';
  static String addmeat = '${baseUrl}api/meatCart';
  static String updatemeat = '${baseUrl}api/meatCart/update';
  static String getmeat = '${baseUrl}api/meatCart';
  static String deletemeatcart = '${baseUrl}api/meatCart/delete';
  static String clearmeatcart = '${baseUrl}api/meatCart/clearCart';
  //create order
  static String createorderformeat = '${baseUrl}api/order/createOrderMeat';
  //Fav get
  static String favgetformeat =
      '${baseUrl}api/favourite/getFavoriteMeatShopList';

////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////// Mart Flow //////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
// Its For Mart Flow <=>

  static String martcategory = '${baseUrl}api/meatCategory/pagination';
  static String martsubcategory = '${baseUrl}api/subCategory';
  static String martproductget = '${baseUrl}api/productList/pagination';
}

// static String getchipCate = '${baseUrl}api/packageCate/';
//   static String createcartApi = '${baseUrl}api/package/cart';
//   static String mesurmentsApi =
//       '${baseUrl}api/parcel/measurements/?parcelType=others';

//   static String getRegonApi = '${baseUrl}api/region?pincode=';
//   static String getParcelCart =
//       '${baseUrl}api/package/cart/userBased?userId=$UserId';

//   static String createParcelOrder = '${baseUrl}api/order/createOrderParcel';
//   static String clearParcelCart = '${baseUrl}api/package/cart/clearCart';
