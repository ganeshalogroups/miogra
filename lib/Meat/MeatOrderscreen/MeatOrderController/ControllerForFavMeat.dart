
// ignore_for_file: avoid_print, file_names

import 'dart:convert';

import 'package:testing/Meat/MeatData/Meatfavprovider.dart';
import 'package:testing/Meat/MeatDomain/Meatfavmodel.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:http/http.dart' as http;

class MeatInitializeFavProvider extends ChangeNotifier {

  Future favInitiliteProvider({required BuildContext cntxtt}) async {

    var favlistProvider = Provider.of<MeatFavoritesProvider>(cntxtt,listen: false);


    try {
      var response = await http.get(
        Uri.parse("${API.meatsearchlist}?limit=100&offset=0&latitude=$initiallat&longitude=$initiallong&subAdminType=meat&userId=$UserId&value="),
        headers: API().headers,
      );


      if (response.statusCode == 200) {

        var result = jsonDecode(response.body);
        var data   = result["data"]["AdminUserList"];


        for (int v = 0; v < data.length; v++) {

          final restaurant = MeatFavoriteShop(
            id      : data[v]["_id"],
            name    : data[v]["name"],
            city    : data[v]["address"]["city"].toString(),
            region  : data[v]["address"]["region"].toString(),
            imageUrl: data[v]["imgUrl"].toString(),
            rating  : data[v]["ratingAverage"].toString(),

          );


 
          if (data[v]['isFavourite'] == true) {

            await favlistProvider.addFavorite(restaurant);

          } else {
          }
        }
      }
    } catch (e) {
       print('The Error IS in the $e');
    }
  }
}


