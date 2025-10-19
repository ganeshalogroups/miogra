// ignore_for_file: file_names

import 'dart:convert';
import 'package:testing/Features/Authscreen/AuthController/Tokenupdate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'apiKey.dart';

class AddressNameController with ChangeNotifier{

TokenController tokenupdate=Get.put(TokenController());
bool isLoadinge =false;
get  isLoading => isLoadinge;
dynamic fullAddressModel;
dynamic postalcode ;
dynamic addressType;
dynamic adddetails;


Future<dynamic> getAddressFromLatLng({required double latitude, required double longitude ,BuildContext? context}) async {

    isLoadinge = true;
    notifyListeners();


    try{
        final String url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$kGoogleApiKey';
          final response = await http.get(Uri.parse(url));
          if (response.statusCode == 200) {
            final data = jsonDecode(response.body);
            if (data['status'] == 'OK') {
              // Extract the formatted address from the response
              final formattedAddress = data['results'][0]['formatted_address'];



                      fullAddressModel = formattedAddress;
            
                      adddetails = {
                            'fullAddress': fullAddressModel,
                            'postalcode': postalcode,
                            'latitude': latitude,
                            'langitude': longitude,
                            };


                      notifyListeners();


                    postalcode = data['results'].first["address_components"].last["long_name"];

                    




            return formattedAddress;        

            } else {
    
            }
          } else {

       
          }


      }catch(e){

          debugPrint('Exception $e');


    }finally{

          isLoadinge = false;
          notifyListeners();
    }


    

}
  // Method to clear the model after usage



  void clearAddressData() {
    fullAddressModel = null;
    postalcode = null;
    adddetails = null;
    notifyListeners();
  }





dynamic editscreenAddressDetail;
dynamic editFullAddressModel;
dynamic editpostalcode;


Future<void> forEditScreenPlacesSearch({required double latitude, required double longitude ,BuildContext? context}) async {

    isLoadinge = true;
    notifyListeners();


    try{
        final String url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$kGoogleApiKey';
          final response = await http.get(Uri.parse(url));
          if (response.statusCode == 200) {
            final data = jsonDecode(response.body);
            if (data['status'] == 'OK') {
              // Extract the formatted address from the response
              final formattedAddress = data['results'][0]['formatted_address'];



                      editFullAddressModel = formattedAddress;
            
                    editscreenAddressDetail = {
                          'fullAddress': editFullAddressModel,
                          'postalcode': postalcode,
                          'latitude': latitude,
                          'langitude': longitude,
                          };

                      notifyListeners();


                    editpostalcode = data['results'].first["address_components"].last["long_name"];

                    
              
                   

            } else {
            }
          } else {
          }


      }catch(e){

          debugPrint('Exception $e');


    }finally{

          isLoadinge = false;
          notifyListeners();
    }

}








}



