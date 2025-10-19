 
import 'dart:convert';
import 'package:testing/map_provider/Map%20Screens/MapSearch.dart/apiKey.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;




class CommonDistanceGetClass extends ChangeNotifier{


  String totalDis  = '';
  String totalDur  = '';
  double totalDist = 0;


  dynamic finaldistance = 0;

  String get totalDistance => totalDis;
  String get totalDuration => totalDur;



  Future<dynamic> getDistance({ required double orginlat, required double orginlang , required double destLat, required double destLng }) async {
      
    final url = Uri.parse('https://maps.googleapis.com/maps/api/directions/json?origin=$orginlat,$orginlang&destination=$destLat,$destLng&mode=driving&key=$kGoogleApiKey');
   
    final response = await http.get(url);

    if (response.statusCode == 200) {


            final data = json.decode(response.body);





        final routes = data['routes'] as List;

        if (routes.isNotEmpty) {

              final route = routes[0];
              final legs  = route['legs'] as List;

              if (legs.isNotEmpty) {

                  final leg = legs[0];
                  totalDis  = leg['distance']['text'];
                  totalDur  = leg['duration']['text'];
                  notifyListeners();
double totalDistance = double.parse(totalDis.split(' ').first);
int roundedKm = totalDistance.ceil();
  finaldistance = roundedKm.toDouble(); // 2.0, still okay for calculations


                  // double totalDistance = double.parse(totalDis.split(' ').first.toString());

                  // finaldistance = totalDistance;
                  notifyListeners();

              }


        } else {

          debugPrint('check....Api Routs Are Empty');

        }



            var totaldist =  processDirectionsResponse(data);

            totaldist = double.parse(totalDis.split(' ').first.toString());
            notifyListeners();


          return totaldist;


    } 

    else {

          throw Exception('Failed to load directions');
    }
  }



     processDirectionsResponse(Map<String, dynamic> data) {

        final routes = data['routes'] as List;

        if (routes.isNotEmpty) {

              final route = routes[0];
              final legs  = route['legs'] as List;

              if (legs.isNotEmpty) {

                  final leg = legs[0];
                  totalDis  = leg['distance']['text'];
                  totalDur  = leg['duration']['text'];
                  notifyListeners();


                 double totalDistance = double.parse(totalDis.split(' ').first.toString());

                  
                  notifyListeners();

                  return totalDis;
              

              }


        } else {

          debugPrint('check....Api Routs Are Empty');

        }
      }
    }