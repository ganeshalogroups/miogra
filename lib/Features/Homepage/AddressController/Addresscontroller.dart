// ignore_for_file: avoid_print, use_build_context_synchronously, file_names

import 'dart:convert';
import 'package:testing/Features/Authscreen/AuthController/Tokenupdate.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodhomepage.dart';
import 'package:testing/Meat/Homepage/Meathomepage.dart';
import 'package:testing/map_provider/Map%20Screens/MapSearch.dart/homeadresskey.dart';
import 'package:testing/map_provider/locationprovider.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Const/localvaluesmanagement.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Toast/customtoastmessage.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';






class AddressController extends GetxController {



TokenController tokenupdate  =  Get.put(TokenController());
HomeadresskeyController homeaddresskey =Get.put(HomeadresskeyController());

  var addressLoading = false.obs;
  dynamic addressdetails;
    


 Future<dynamic>  addaddressapi({ addressData,  cntxt , ishome, isCartScreen, isAddressBook, addressId, isfrommeat}) async {

    try {

      addressLoading(true);
      var response = await http.post(
        Uri.parse(API.addressfastx),
        headers: API().headers,
        body: jsonEncode(
          <String, dynamic>{
            "userType": "consumer",
            "houseNo": addressData['houseNo'],
            "locality": addressData['locality'],
            "landMark": addressData['landMark'],
            "fullAddress": addressData['fullAddress'],
            "street": addressData['street'],
            // "city": addressData['city'],
            // "district": addressData['district'],
            "state": addressData['state'],
            "country": addressData['country'],
            "postalCode": addressData['postalCode'],
            "contactType": "myself",
            "contactPerson": addressData['contactPerson'],
            "contactPersonNumber": addressData['contactPersonNumber'],
            "addressType": addressData['addressType'],
            "latitude": addressData['latitude'],
            "longitude": addressData['longitude'],
            "userId": UserId,
            'instructions': addressData['instructions'],
          },
        ),
      );




      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
        
                  var result = jsonDecode(response.body);
                  addressdetails = result;



                    Provider.of<MapDataProvider>(cntxt,listen: false).updateMapData(
                        addresstype      : addressData['addressType'].toString(),
                        fulladdres       : addressData['fullAddress'].toString(),
                        localiti         : addressData['locality'].toString(),
                        houseno          : addressData['houseNo'].toString(),
                        contactpersionNo : addressData['contactPersonNumber'].toString(),
                        contacypersion   : username.toString(),
                        landmark         : addressData['landMark'].toString(),
                        postalcode       : addressData['postalCode'].toString(),
                        statee           : addressData['state'].toString(),
                        streett          : addressData['street'].toString(),
                        latitude         : addressData['latitude'],
                        longitude        : addressData['longitude'],
                        otheristructions : addressData['instructions'],
                    );

          
                  Provider.of<LocationProvider>(cntxt,listen: false).updateMarker(latitude:addressData['latitude'],longitude: addressData['longitude'] );

  
                  if(isCartScreen ==true){


            
                  updateaddressapi(addressid: result['data']['_id']);


                  Get.back(result: 'Yes');
                  Get.back(result: 'Yes');

            }else if(ishome==true){


              Get.back();

            }else if(isAddressBook==true){


                  print('Its Executing...');

                Get.back();
                // Get.off(AddressbookScreen(),transition: Transition.leftToRight);
                Get.back();


            }else if(isfrommeat==true){
             Get.back();
              Get.off(Meathomepage(meatproductcategoryid: meatproductCateId,),transition: Transition.leftToRight);
            }else{

              Get.back();
              Get.off(const Foodscreen(fromPickupscreen: true,),transition: Transition.leftToRight);


      }

if (isCartScreen ==true) {
  getaddressapi(context: cntxt, latitude: initiallat, longitude: initiallong);
} else {
  getaddressapi(context: cntxt, latitude: "", longitude: "");
}
update();
homeaddresskey.gethomeadresskeyDetails();



        //  getaddressapi(context: cntxt,latitude: "",longitude: "");
        // update();


          Get.snackbar(
            'Find your favourite locations by tapping the search bar',
            'and easily select them next time.',
            colorText: Colors.white,
            backgroundColor: const Color.fromARGB(255, 45, 195, 4),
            snackPosition: SnackPosition.TOP,
            snackStyle: SnackStyle.FLOATING,
            margin: const EdgeInsets.all(15),
            borderRadius: 10,
            boxShadows: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
            duration: const Duration(seconds: 2),
          );

          return response.statusCode;


      } else {


        var result = jsonDecode(response.body);


            if(ishome==true){

                  Get.back();

            }else{



            }



        Get.snackbar(
          backgroundColor: Customcolors.DECORATION_RED,
          '', '',
          titleText: const Text("Something went wrong"),
          messageText: Text(result["message"]),
            
          
        );

           addressdetails = null;

        }


    } catch (e) {

        print(e.toString());
     
     } finally {

      addressLoading(false);

    }
  }










  var     getaddressLoading = false.obs;
  dynamic getaddressdetails;


  void getaddressapi( {context,latitude,longitude}) async {

    try {
        getaddressLoading(true);
         update();

        var response = await http.get(
          Uri.parse("${API.getaddressfastx}?userId=$UserId&latitude=$latitude&longitude=$longitude&limit=20&offset=0"),
          headers: API().headers,
        );


        if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
           
          var result = jsonDecode(response.body);
            getaddressdetails = result;
            homeaddresskey.gethomeadresskeyDetails();
             update();


          if (result["data"] != null && result["data"].isNotEmpty) {

                getaddressdetails = result;
                update();

              } else {

                getaddressdetails = null;
                update();

              }

      } else {

        getaddressdetails = null;
         update();

      }
      
    } catch (e) {
      print(e.toString());
    } finally {
      getaddressLoading(false);
       update();
    }
  }








var getprimaryaddressLoading = false.obs;
dynamic getprimaryaddressdetails;

Future<void> getprimaryaddressapi() async {
  try {
    getprimaryaddressLoading(true);
    var response = await http.get(
      Uri.parse("${API.getaddressfastx}?type=primary&userId=$UserId"),
      headers: API().headers,
    );


    if (response.statusCode == 200 || response.statusCode == 201 ||  response.statusCode == 202) {
       
      var result = jsonDecode(response.body);

     homeaddresskey.gethomeadresskeyDetails();
      if (result["data"] != null && result["data"].isNotEmpty) {

        getprimaryaddressdetails = result;
        

      } else {

        getprimaryaddressdetails = null;
        print('No data available');

      }

   

    } else {

      getprimaryaddressdetails = null;  // Corrected assignment  
      print('Failed to fetch address details');
      print(response.body.toString());
    
    }

  } catch (e) {

    print(e.toString());
    getprimaryaddressdetails = null;  // Set to null in case of error

  } finally {
    getprimaryaddressLoading(false);
  }
}

  var updateaddressLoading = false.obs;
  dynamic updateaddress;

  void updateaddressapi({String? addressid}) async {
    try {
      updateaddressLoading(true);
      var response = await http.put(
          Uri.parse("${API.getaddressfastx}/$addressid"),
          headers: API().headers,
          body: jsonEncode(<String, dynamic>{
            "userType": "consumer",
            "userId": UserId,
            "type": "primary"
          }));
      // statusCode.value=response.statusCode;
      if (response.statusCode == 200 ||   response.statusCode == 201 ||  response.statusCode == 202) {
        
        var result = jsonDecode(response.body);
        updateaddress = result;


        getprimaryaddressapi();



      } else {
        updateaddress = null;
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      updateaddressLoading(false);
    }
  }

  var deleteaddressloading = false.obs;
  dynamic deleteaddress;

  deleteaddressapi({String? addressid, required BuildContext context}) async {
    try {
      deleteaddressloading(true);
      var response = await http.delete(
          Uri.parse("${API.getaddressfastx}/$addressid"),
          headers: API().headers);

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        var result = jsonDecode(response.body);
        deleteaddress = result;

        AppUtils.showToast(result['message']);

        if (result["data"] == null || result["data"].isEmpty) {
          deleteaddress = null;
        }

        print(result["data"]["AdminUserList"].length);
        print('Address deleted successfully');

        // Refresh address lists
        getaddressapi(context: context,latitude: "",longitude: "");
        getprimaryaddressapi();
        homeaddresskey.gethomeadresskeyDetails();

        print('delete address ------$result');
      } else {
        deleteaddress = null;
        AppUtils.showToast(response.statusCode.toString());
        // getaddressapi(context);
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      deleteaddressloading(false);
    }
  }

// search address api

  var searchaddressisloading = false.obs;
  dynamic searchaddressdataModel;

  void searchAddress({required String value}) async {
    try {
      searchaddressisloading(true);

      var response = await http.get(
        Uri.parse("${API.getaddressfastx}?value=$value&userId=$UserId"),
        headers: API().headers,
      );

      var result = jsonDecode(response.body);

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        // Handle successful response
        searchaddressdataModel = result["data"]["AdminUserList"];

        // If the API returns an empty list or null
        if (searchaddressdataModel == null || searchaddressdataModel.isEmpty) {
          searchaddressdataModel = []; // Set it to an empty list
        }
      } else {
        // Handle error response
        print('Error: ${result['message']}');
        searchaddressdataModel = []; // Set it to an empty list
      }
    } catch (e) {
      print(e.toString());
      searchaddressdataModel = []; // Set it to an empty list
    } finally {
      searchaddressisloading(false);
    }
  }






//update all fields api in address...

 dynamic addressAllUpdateModel ;

 var alladdressupdate = false.obs;

  updateAllAddressFieldsApi({required String addressId,required Map<String, dynamic> addressData,required BuildContext context}) async {


    try {
      updateaddressLoading(true);

      var response = await http.put(
          Uri.parse("${API.getaddressfastx}/$addressId"),
          headers: API().headers,
          body: jsonEncode(<String, dynamic>{
            "userType": "consumer",
            "userId"   : UserId,
            "houseNo"  : addressData['houseNo'],
            "locality" : addressData['locality'],
            "landMark" : addressData['landMark'],
            "fullAddress": addressData['fullAddress'],
            "street"  : addressData['street'],
            "state"   : addressData['state'],
            "country" : addressData['country'],
            "postalCode"   : addressData['postalCode'],
            "contactType"  : "myself",
            "contactPerson": addressData['contactPerson'],
            "contactPersonNumber": addressData['contactPersonNumber'],
            "addressType"  : addressData['addressType'],
            "latitude"     : addressData['latitude'],
            "longitude"    : addressData['longitude'],
            'instructions' : addressData['instructions'],
          }));



      // statusCode.value=response.statusCode;
      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
         


        var result = jsonDecode(response.body);
        addressAllUpdateModel = result;

          print('----------Address Update Area-----------');
          print(addressAllUpdateModel['message']);




          WidgetsBinding.instance.addPostFrameCallback((_) {
      
                  Provider.of<MapDataProvider>(context,listen: false).updateMapData(
                                addresstype      : addressData['addressType'].toString(),
                                fulladdres       : addressData['fullAddress'].toString(),
                                localiti         : addressData['locality'].toString(),
                                houseno          : addressData['houseNo'].toString(),
                                contactpersionNo : addressData['contactPersonNumber'].toString(),
                                contacypersion   : username.toString(),
                                landmark         : addressData['landMark'].toString(),
                                postalcode       : addressData['postalCode'].toString(),
                                statee           : addressData['state'].toString(),
                                streett          : addressData['street'].toString(),
                                latitude         : addressData['latitude'],
                                longitude        : addressData['longitude'],
                                otheristructions : addressData['instructions'],
                      );
                          
                });

                  AppUtils.showToast(addressAllUpdateModel['message']);

                  getaddressapi(context: context,latitude: "",longitude: ""); 
                  getprimaryaddressapi(); 



      } else {

        print('------------------Address Not Updated --------------');

        addressAllUpdateModel = null;

        print(response.statusCode);
        
      }


    } catch (e) {
      print(e.toString());
    } finally {
      updateaddressLoading(false);
    }


  }






  void logout() {
    getaddressdetails = null; 
    // Perform other logout actions (e.g., clear user session, navigate to login screen)
  }



}





