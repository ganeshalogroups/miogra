
// ignore_for_file: avoid_print, unnecessary_null_comparison, prefer_typing_uninitialized_variables
import 'dart:convert';
import 'package:testing/common/com_address_add_bottom_sheet.dart';
import 'package:testing/map_provider/Map%20Screens/MapSearch.dart/addressnameController.dart';
import 'package:testing/map_provider/Map%20Screens/MapSearch.dart/apiKey.dart';
import 'package:testing/map_provider/Map%20Screens/circleradious.dart';
import 'package:testing/map_provider/Map%20Screens/markervaluse.dart';
import 'package:testing/map_provider/circle_marker.dart';
import 'package:testing/map_provider/locationprovider.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;



// ignore: must_be_immutable
class CommonAddAddress extends StatefulWidget {
  bool isFromCartScreen;
  bool isAddressBookScreen;
  String? resturantId;
  dynamic addressId;
  
  
  CommonAddAddress({
    super.key,
    this.isAddressBookScreen = false,
    this.isFromCartScreen = false,
    this.resturantId,
    this.addressId,
  });

  @override
  State<CommonAddAddress> createState() => _CommonAddAddressState();
}




final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _CommonAddAddressState extends State<CommonAddAddress> {
     
  var latpass;
  var lngpass;

  String? fullAddress = '';
  String? country     = 'india';
  var address;

  bool isLocationDifferent = false;

  GoogleMapController? _controller;

  final List<LatLng>   polylinePoints = [];
  final Set<Polyline> _polylines      = {};
  final Set<Circle>   _circles        = {};

  Set<Marker> markersList = {};
  //final Mode _mode = Mode.fullscreen;

  bool isWithinCircle = true; // Track if the camera is within the circle



  @override
  void initState() {

    Provider.of<LocationProvider>(context, listen: false).updateMarker(latitude: initiallat, longitude: initiallong);
    super.initState();
  }




  TextEditingController searchController = TextEditingController();

  bool isClickedField = false;

  final FocusNode focusNode = FocusNode();




  @override
  void dispose() {
    // localitycontroller.dispose();
    // streetcontroller.dispose();
    // pincodecontroller.dispose();
    // statecontroller.dispose();
    searchController.dispose();
    focusNode.dispose();
    _controller?.dispose();
    super.dispose();
  }





  List<dynamic> _places = [];

  void searchPlaces() async {
    final query = searchController.text.toUpperCase();
    if (query.isNotEmpty) {
      final places = await makeRequest(input: query);

      setState(() {
        print(places);
        _places = places;
      });
    }
  }


 void animateToNewZoom() async {
    await Future.delayed(Duration(seconds: 1)); // Optional: Add a delay before the animation starts
    _controller?.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: initialLatLng,
        zoom: 18.0, // Final zoom level
      ),
    ));
  }


 final LatLng initialLatLng = LatLng(initiallat, initiallong); // Initial coordinates
  final double initialZoom = 14.0;

  // LatLng(initiallat, initiallong)

  bool isStartSearch = false;



  @override
  Widget build(BuildContext context) {

  //  var addressProvider = Provider.of<AddressNameController>(context);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {

        if (didPop) return;
        Navigator.pop(context);
      },
      child: Scaffold(
        key: homeScaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Choose Address', style: CustomTextStyle.addresstitle),
          automaticallyImplyLeading: true,
          bottom: PreferredSize(
            preferredSize: Size(0, 10),
            child: Consumer<LocationProvider>(
              builder: (context, value, child) {
                if (value.isloading) {

                  return LinearProgressIndicator(color: Customcolors.darkpurple);
                    

                } 
                   else {
                 
                        return SizedBox();

                    }
              },
            ),
          ),



        ),



        body: SizedBox(
          height: MediaQuery.of(context).size.height / 1,
          width : MediaQuery.of(context).size.width,
          child : Consumer<LocationProvider>(
            builder: (context, locationProvider, child) => Stack(
              clipBehavior: Clip.none,
              children: [
                GoogleMap(
                  // style: mapStyle,

                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: initialLatLng,
                    zoom:   initialZoom,
                  ),
                  markers: locationProvider.markers,

                  polylines: isWithinCircle ? _polylines : {},
                  myLocationButtonEnabled: false,
                  myLocationEnabled: false,
                  zoomControlsEnabled: false,
                  compassEnabled: false,
                  indoorViewEnabled: false,
                  mapToolbarEnabled: false,
                  onCameraIdle: () async {
                  locationProvider.dragableAddress();

                    dynamic dat = await Provider.of<AddressNameController>(context, listen: false).getAddressFromLatLng(latitude: locationProvider.position.latitude, longitude: locationProvider.position.longitude);
                            

                    setState(() {
                      var adde = locationProvider.address.street.toString();
                      adde += locationProvider.address.subAdministrativeArea.toString();
                      adde += locationProvider.address.locality.toString();
                      country = locationProvider.address.country;
                      address = locationProvider.address.street.toString();
                      address = dat.toString();


                      // localitycontroller.text =  locationProvider.address.locality.toString();
                      // streetcontroller.text   =  locationProvider.address.street.toString();
                      // statecontroller.text = locationProvider.address.administrativeArea.toString();
                      // pincodecontroller.text =  locationProvider.address.postalCode.toString();

                      country = locationProvider.address.country;
                      latpass = locationProvider.position.latitude;
                      lngpass = locationProvider.position.longitude;

                      // Draw circle around target location
                      _circles.add(Circle(
                        circleId: CircleId('target_location'),
                        center: LatLng(locationProvider.currentla,locationProvider.currentlong),
                        radius: 100,
                        fillColor: Colors.blue.withOpacity(0.1),
                        strokeColor: Colors.blue,
                        strokeWidth: 1,
                      ));


                    });
                  },

                  onCameraMove: (position) {
                    setState(() {
                      address = "";

                      
                      locationProvider.updatePosition(position);

               
                      double distance = calculateDistance(
                          position.target.latitude,
                          position.target.longitude,
                          initiallat,
                          initiallong);

                      if (distance <= 100) {

                        isWithinCircle      = true;
                        isLocationDifferent = false;

                        if (polylinePoints.length == 1) {

                          polylinePoints.add(position.target);

                        } else if (polylinePoints.length == 2) {

                          polylinePoints[1] = position.target;

                        } else {

                          polylinePoints.clear();
                          polylinePoints.add(LatLng(initiallat, initiallong));
                          polylinePoints.add(position.target);
                       
                        }

                        _polylines.add(
                          Polyline(
                            patterns: [
                              PatternItem.dot,
                              PatternItem.gap(10),
                            ],
                            polylineId: PolylineId('route'),
                            points: polylinePoints,
                            color: Colors.black,
                            width: 4,
                          ),
                        );


                      } else {

                        isLocationDifferent = true;
                        isWithinCircle      = false;

                      }


                    });

                   
                  },
                  onMapCreated: (GoogleMapController controller) {
                    _controller = controller;
                    animateToNewZoom();
                    Provider.of<LocationProvider>(context, listen: false).updateAddressLocation(latitude: initiallat, longitude: initiallong);
                  },
                ),


                Positioned(
                  bottom: 100,
                  right: 0,
                  left: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () async {

                          await locationProvider.getCurrentLocation(mapController: _controller, context: context, isLocEnabled: false);
                            
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          margin: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            //  borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: const Icon(
                            Icons.my_location,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.815,
                  child: Image.asset(
                    pinmarker,
                    width: 40,
                    height: 40,
                    fit: BoxFit.contain,
                    color: Colors.redAccent,
                  ),
                ),



                  Positioned(
                    top: 10,
                    left: 20,
                    right: 20,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 15,
                            decoration: BoxDecoration(
                              color: Customcolors.DECORATION_WHITE,
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


                          child: isClickedField
                              ? Center(
                                  child: TextField(
                                    focusNode: focusNode,
                                    controller: searchController,
                                    onChanged: (value) {
                                      if (value.length > 3) {
                                        if (searchController.text.isNotEmpty) {
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
                                    onSubmitted: (value) {
                                      
                                      if(value.isEmpty){


                                          searchController.clear();
                                          setState(() {
                                            isClickedField = false;
                                            _places = [];
                                            isStartSearch = false;
                                          });

                                          focusNode.unfocus();

                                      }else{

                                      }


                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      alignLabelWithHint: true,
                                      prefixIcon: Icon(
                                        Icons.circle,
                                        color: Colors.red,
                                        size: 10,
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      suffixIcon: IconButton(
                                        onPressed: () {

                                          searchController.clear();
                                          setState(() {
                                            isClickedField = false;
                                            _places = [];
                                            isStartSearch = false;
                                          });

                                          focusNode.unfocus();
                                        },
                                        icon: Icon(Icons.close),
                                      ),
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: 7,
                                        height: 7,
                                        decoration: const BoxDecoration(
                                          color: Customcolors
                                              .DECORATION_primaryGREEN, // Color of the dot
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              isClickedField = true;
                                            });
                                            Future.delayed(
                                                Duration(milliseconds: 100),
                                                () {
                                              focusNode.requestFocus();
                                            });

                                            // _handlePressButton();
                                            //   Get.off(SearchPlacesScreen());
                                          },
                                          child: Consumer<LocationProvider>(
                                            builder: (context, value, child) {
                                              if (value.loading == true) {
                                                return CupertinoActivityIndicator();
                                              } else if (value.fullAddresss ==
                                                  null) {
                                                return Text(
                                                  ' Loading ..  ',
                                                  style: CustomTextStyle
                                                      .smallblacktext,
                                                );
                                              } else {
                                                return Text(
                                                  value.fullAddresss,
                                                  maxLines: 1,
                                                  style: CustomTextStyle
                                                      .smallblacktext,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                        isStartSearch
                            ? Container(
                                  margin     : EdgeInsets.only(top: 15),
                                  decoration : BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10),
                                ),


                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _places.length,
                                  padding: EdgeInsets.only(top: 20),
                                  itemBuilder: (context, index) {
                                    final place = _places[index]["description"];
                                    final placeId = _places[index]["place_id"];

                                    return Padding(
                                      padding: EdgeInsets.all(15),
                                      child: GestureDetector(
                                        onTap: () async {
                                          await fetchPlaceDetails(placeId: placeId, context: context).whenComplete(() {
                                      
                                            setState(() {});
                                      
                                      
                                          });
                                        },
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Icon(Icons.location_on_outlined),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            SizedBox(
                                              width: 250.w,
                                              child: Text(
                                                '$place',
                                                maxLines: null,
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
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 15,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Container(

                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: CustomContainerDecoration.gradientbuttondecoration(),
                              
                          child: ElevatedButton(

                            onPressed: () {

                              // String fullAddress = [

                              //   locationProvider.address.street,
                              //   locationProvider.address.subLocality,
                              //   locationProvider.address.locality,
                              //   locationProvider.address.administrativeArea,
                              //   locationProvider.address.postalCode,
                              //   locationProvider.address.country

                              // ].where((part) => part != null && part.isNotEmpty).join(', ');



                              //   print(fullAddress);
  List<String?> fullAddress = [

                                locationProvider.address.street,
                                locationProvider.address.subLocality,
                                locationProvider.address.locality,
                                locationProvider.address.administrativeArea,
                                locationProvider.address.postalCode,
                                locationProvider.address.country];

                            //  ].where((part) => part != null && part.isNotEmpty).join(', ');
                       String address = [

                                locationProvider.address.street,
                                locationProvider.address.subLocality,
                                locationProvider.address.locality,
                                locationProvider.address.administrativeArea,
                                locationProvider.address.postalCode,
                                locationProvider.address.country

                              ].where((part) => part != null && part.isNotEmpty).join(', ');

                     



                                print(fullAddress);




                                // addAddressBottomSheet(
                                //   context   : context,
                                //   address   : fullAddress,
                                //   locality  : locationProvider.address.locality,
                                //   country   : country,
                                //   state     : locationProvider.address.administrativeArea,
                                //   pincode   : locationProvider.address.postalCode,
                                //   street    : locationProvider.address.street,
                                //   lattitude : locationProvider.position.latitude,
                                //   longitude : locationProvider.position.longitude,
                                //   isAddressAddScreen: true,
                                //   isFromCart : widget.isFromCartScreen,
                                //   resturantId : widget.resturantId,
                                //   addressId: widget.addressId
                                // );



                            showCupertinoModalBottomSheet(
                                expand: true,
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (context) {


                            return      CommonAddAddressBottomSheet(
                                        // addressType: ,
                                        // city: ,
                                        country    : country,
                                        address: address,
                                        fullAddress: fullAddress,
                                        locality  :  locationProvider.address.locality, 
                                        latitude  :  locationProvider.position.latitude, 
                                        longitude :  locationProvider.position.longitude ,
                                        pincode   :  locationProvider.address.postalCode,
                                        state     :  locationProvider.address.street,
                                        street    :  locationProvider.address.street,
                                        );
                                },
                              );

                                // showModalBottomSheet(
                                //         scrollControlDisabledMaxHeightRatio: 25,
                                //         context: context, 
                                //         showDragHandle: true,
                                //         builder: (context) {

                                //         return CommonAddAddressBottomSheet(
                                //         // addressType: ,
                                //         // city: ,
                                //         country    : country,
                                //         fullAddress: fullAddress,
                                //         locality  :  locationProvider.address.locality, 
                                //         latitude  :  locationProvider.position.latitude, 
                                //         longitude :  locationProvider.position.longitude ,
                                //         pincode   :  locationProvider.address.postalCode,
                                //         state     :  locationProvider.address.street,
                                //         street    :  locationProvider.address.street,
                                //         );
                                //       },
                                //     );
                                },


                                style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent,shadowColor: Colors.transparent),
                                child: locationProvider.loading ? LoadingAnimationWidget.horizontalRotatingDots( color: Customcolors.DECORATION_WHITE, size: 24 )
                                    : const Text('Confirm Location', style: TextStyle( color: Customcolors.DECORATION_WHITE, fontFamily: 'Poppins-Regular'),
                                    
                                  
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }








  Future<dynamic> makeRequest({input}) async {
String url =  "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$kGoogleApiKey&language=en&location=$initiallat,$initiallong";
    // String url =  "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$kGoogleApiKey&language=en&location=$initiallat,$initiallong&radius=50000&strictbounds";

    final response = await http.get(Uri.parse(url));
    final json = jsonDecode(response.body);

    if (json["error_message"] != null) {
      var error = json["error_message"];
      if (error == "This API project is not authorized to use this API.") {
        
        error += " Make sure the Places API is activated on your Google Cloud Platform";
          
      }

      throw Exception(error);
    } else {
      final predictions = json["predictions"];
      return predictions;
    }
  }

  Future<void> fetchPlaceDetails({placeId, context}) async {

    final url = Uri.parse('https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&key=$kGoogleApiKey');
      

    try {

      final response = await http.get(url);

      if (response.statusCode == 200) {

        var data = json.decode(response.body);

        final lat = data['result']['geometry']['location']['lat'];
        final lng = data['result']['geometry']['location']['lng'];

        setState(() {
            Provider.of<AddressNameController>(context, listen: false).getAddressFromLatLng(latitude: lat, longitude: lng);
            Provider.of<LocationProvider>(context, listen: false).updateAddressLocation(latitude: lat, longitude: lng);
        });


        markersList.clear();
        markersList.add(
          Marker(
            markerId: const MarkerId("0"),
            position: LatLng(lat, lng),
            icon: await getDotMarker()));


        searchController.clear();
        setState(() {
          isClickedField = false;
          _places = [];
          isStartSearch = false;
        });

        focusNode.unfocus();

        setState(() {});

        _controller ?.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 18.0));
          
      } else {
        throw Exception('Failed to load place details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load place details: $e');
    }
  }
}





