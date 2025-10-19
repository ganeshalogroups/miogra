
// ignore_for_file: avoid_print, file_names

import 'dart:convert';
import 'package:testing/Features/Foodmodule/Data/cartprovider.dart';
import 'package:testing/Features/Foodmodule/Domain/favouritemodel.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';


class InitializeFavProvider extends ChangeNotifier {

  Future favInitiliteProvider({required BuildContext cntxtt}) async {

    var favlistProvider = Provider.of<FavoritesProvider>(cntxtt,listen: false);


    try {
      var response = await http.get(
        Uri.parse("${API.searchFoodlistbyResgetfastx}?limit=100&offset=0&latitude=$initiallat&longitude=$initiallong&subAdminType=restaurant&userId=$UserId&value="),
        headers: API().headers,
      );


      if (response.statusCode == 200) {

        var result = jsonDecode(response.body);
        var data   = result["data"]["AdminUserList"];


        for (int v = 0; v < data.length; v++) {

          final restaurant = FavoriteRestaurant(
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


