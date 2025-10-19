// ignore_for_file: file_names, prefer_is_empty

import 'dart:convert';
import 'package:testing/Features/Homepage/AddressController/Addresscontroller.dart';
import 'package:testing/map_provider/Map%20Screens/MapSearch.dart/apiKey.dart';
import 'package:testing/map_provider/Map%20Screens/Pickupscreen.dart';
import 'package:testing/map_provider/locationprovider.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Const/localvaluesmanagement.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;



// ignore: must_be_immutable
class BottomsheetSearchScreen extends StatefulWidget {

  dynamic addressType;
  dynamic houseno;
  dynamic locality;
  dynamic district;
  dynamic fullAddress;

  BottomsheetSearchScreen({
      super.key,
      this.addressType,
      this.fullAddress,
      this.houseno,
      this.locality,
      this.district,
      });


  @override
  State<BottomsheetSearchScreen> createState() => _BottomsheetSearchScreenState();
}


class _BottomsheetSearchScreenState extends State<BottomsheetSearchScreen> {


  TextEditingController    controller = TextEditingController();
  AddressController addresscontroller = Get.put(AddressController());
  String? selectvalue;


  // String _currentValue = '';


  int currentHintIndex = 0;

  final List<String> hints = ['PostalCode', 'Locality', 'Address Type'];



  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((_) {
       addresscontroller.getaddressapi(context: context,latitude: "",longitude: "");
      addresscontroller.getprimaryaddressapi();
    });

    super.initState();
  }



  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  List<dynamic> _places = [];

  void searchPlaces() async {
    final query = controller.text.toUpperCase();
    if (query.isNotEmpty) {

      final places  =  await  makeRequest(input: query);



      setState(() {
        _places = places;
      });
    }
  }

  bool isStartSearch = false;



  @override
  Widget build(BuildContext context) {

     var locationProvider  =  Provider.of<LocationProvider>(context, listen: false);
     var  mapDataProvider  =  Provider.of<MapDataProvider>(context, listen: false);

    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSizedBox(
              height: 10.h,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 13.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(17),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: Colors.green, // Color of the dot
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          // onSaved: (newValue) {
                         cursorColor: Customcolors.DECORATION_GREY,
                         cursorWidth: 2.0,                           // Set the cursor width
                         cursorRadius: Radius.circular(5.0), 
                          onChanged: (value) {
                            if (value.length > 3) {
                              if (controller.text.isNotEmpty) {
                                setState(() {
                                  isStartSearch = true;

                                  searchPlaces();
                                  // addresscontroller.searchAddress(value: controller.text);
                                });
                              } else {
                                setState(() {
                                  isStartSearch = false;
                                });
                              }
                            } else {
                              if (value.length == 0) {
                                setState(() {
                                  isStartSearch = false;
                                });
                              }
                            }
                          },

                          controller: controller,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              suffixIcon: isStartSearch
                                  ? InkWell(
                                      onTap: () {
                                        setState(() {
                                          controller.clear();
                                          // searchPlaces();
                                          _places =[];
                                          isStartSearch = false;
                                        });
                                      },
                                      child: Icon(Icons.close),
                                    )
                                  : null,
                              hintText: 'Search Places'),
                          style: const TextStyle(
                              fontSize: 13, fontFamily: 'Poppins-Regular'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            CustomSizedBox(
              height: 10.h,
            ),
            isStartSearch? 
            SizedBox(
                    height: MediaQuery.of(context).size.height / 1,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _places.length,
                      itemBuilder: (context, index)  {


                        final place = _places[index]["description"];
                        final placeId =_places[index]["place_id"];

                    
                        return Padding(
                          padding: EdgeInsets.all(15),
                          child: GestureDetector(
                            onTap: ()async {
                             Navigator.pop(context); // ✅ Close Bottomsheet
                              await fetchPlaceDetails(placeId: placeId,isfrommanualsearchaddress: true);
                      
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.location_on_outlined),
                                SizedBox(width: 5,),
                                SizedBox(
                                  width: 280.w,
                                  child: Text(
                                    '$place',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'Poppins-Regular',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ):SizedBox.shrink()
          ],
        ),
      );
   


  }








  Future<dynamic> makeRequest({input}) async {
  
    // String url = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$kGoogleApiKey&language=en&location=$initiallat,$initiallong&radius=50000&strictbounds";
    String url = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$kGoogleApiKey&language=en&location=$initiallat,$initiallong";
    final response = await http.get(Uri.parse(url));
    final json = jsonDecode(response.body);

    if (json["error_message"] != null) {
      var error = json["error_message"];
      if (error == "This API project is not authorized to use this API.") {
        error +=  " Make sure the Places API is activated on your Google Cloud Platform";
      }
           
      throw Exception(error);
    } else {
      final predictions = json["predictions"];
      return predictions;
    }
  }






Future<void> fetchPlaceDetails({ placeId,bool isfrommanualsearchaddress=false}) async {

      final url = Uri.parse('https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&key=$kGoogleApiKey');

      try {
        
        final response = await http.get(url);

        if (response.statusCode == 200) {

                var data = json.decode(response.body);

                final lat = data['result']['geometry']['location']['lat'];
                final lng = data['result']['geometry']['location']['lng'];

              Get.to(Locationpickupscreen(lang: lng,lat: lat,isfrommanualsearchaddress: isfrommanualsearchaddress,),transition: Transition.leftToRight);


        } else {
          throw Exception('Failed to load place details: ${response.statusCode}');
        }
      } catch (e) {
        throw Exception('Failed to load place details: $e');
      }
    }


}






class AppadressLoader {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CupertinoActivityIndicator(radius: 16),
      ),
    );
  }

  static void hide(BuildContext context) {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}

