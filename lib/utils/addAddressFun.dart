// ignore_for_file: file_names

import 'package:testing/map_provider/Map%20Screens/addressAddBottomSheet.dart';
import 'package:testing/map_provider/Map%20Screens/editAddressBottmSheet.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future<dynamic> addAddressBottomSheet(
        {required BuildContext context,
        required dynamic address,
        dynamic addresstype,
        dynamic locality,
        dynamic addressId,
        dynamic street,
        dynamic state,
        dynamic country,
        dynamic pincode,
        dynamic district,
        dynamic city,
        dynamic lattitude,
        dynamic longitude,
        dynamic mobilenumber,
        dynamic housenumber,
        dynamic landmark,
        dynamic typefield,
        dynamic resturantId,
        bool isFromCart = false,
        bool ishomescreen = false,
        bool itseditscreen = false,
        bool isAddressAddScreen = false,
        bool isAddresAddFromEditScreen = false,
        bool isFrommeathomepage  = false,
        dynamic name,


    }) {




                      // return showModalBottomSheet(
                      //   backgroundColor: Colors.white,
                      //   shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))),
                      
                      //   context: context,
                      //   isScrollControlled: true,
                      //   builder: (context) {


                      return showCupertinoModalBottomSheet(
                                expand: true,
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (context) {






        loge.i('Is From Edit Screen  $isAddresAddFromEditScreen');
        loge.i('Is From Edit Screen  $itseditscreen');




      return itseditscreen == true ? 

        EditAddressBottomSheet(
            itseditscreen  : itseditscreen,
            locality       : locality,
            fullAddress    : address,
            street         : street,
            state          : state,
            country        : country,
            pincode        : pincode,
            latitude       : lattitude,
            longitude      : longitude,
            city           : city,
            addressType    : addresstype,
            addressId      : addressId,
            district       : district,
            housenumber    : housenumber,
            landmark       : landmark,
            mobilenumber   : mobilenumber,
            typefield      : typefield,
            name           : name,

      ) :  AddAddressBottomSheet(

              itseditscreen      : itseditscreen,
              locality           : locality,
              fullAddress        : address,
              street             : street,
              state              : state,
              country            : country,
              pincode            : pincode,
              latitude           : lattitude,
              longitude          : longitude,
              city               : city,
              addressType        : addresstype,
              addressId          : addressId,
              district           : district,
              ishomescreen       : ishomescreen,
              isAddressAddScreen : isAddressAddScreen,
              isFromCartScreen   : isFromCart,
              isFromAddressBook  : isAddresAddFromEditScreen,
              restaurantid       : resturantId,
              isFrommeathomepage: isFrommeathomepage,


      );


    },
  );
}



