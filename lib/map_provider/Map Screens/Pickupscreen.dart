// ignore_for_file: avoid_print, unnecessary_null_comparison, prefer_typing_uninitialized_variables, file_names, prefer_is_empty
import 'dart:convert';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/Getnearbyrescontroller.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodhomepage.dart';
import 'package:testing/Features/Foodmodule/getFoodCartProvider.dart';
import 'package:testing/map_provider/Map%20Screens/MapSearch.dart/addressnameController.dart';
import 'package:testing/map_provider/Map%20Screens/circleradious.dart';
import 'package:testing/Features/Homepage/homepage.dart';
import 'package:testing/map_provider/circle_marker.dart';
import 'package:testing/map_provider/locationprovider.dart';
import 'package:testing/map_provider/request_permission_page.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Const/localvaluesmanagement.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'MapSearch.dart/apiKey.dart';
import 'markervaluse.dart';
import 'package:http/http.dart' as http;




class Locationpickupscreen extends StatefulWidget {
  final double? lat;
  final double? lang;
  final bool isfrommanualsearchaddress;
  const Locationpickupscreen({super.key, this.lang, this.lat,this.isfrommanualsearchaddress=false});

  @override
  State<Locationpickupscreen> createState() => _LocationpickupscreenState();
}

final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _LocationpickupscreenState extends State<Locationpickupscreen> with AutomaticKeepAliveClientMixin {
  
  @override
  bool get wantKeepAlive => true;

  TextEditingController localitycontroller = TextEditingController();
  TextEditingController streetcontroller = TextEditingController();
  TextEditingController pincodecontroller = TextEditingController();
  TextEditingController statecontroller = TextEditingController();

  var latpass;
  var lngpass;
  String? fullAddress = '';
  String? country = 'india';
  var address;
  bool isLocationDifferent = false;

  GoogleMapController? _controller;
  final List<LatLng>   polylinePoints = [];
  final Set<Polyline> _polylines      = {};
  final Set<Circle>   _circles        = {};

  Set<Marker> markersList = {};

  bool isWithinCircle = true; // Track if the camera is within the circle

  TextEditingController searchController = TextEditingController();
 Nearbyrescontroller nearbyreget = Get.put(Nearbyrescontroller());


  @override
  void initState() {
    print('initial knksjfnvjo');
    print(widget.lat);
    print(widget.lang);
    _controller?.animateCamera(
        CameraUpdate.newLatLngZoom(LatLng(widget.lat!, widget.lang!), 18.0));
    super.initState();
  }

  bool isClickedField = false;
  final FocusNode focusNode = FocusNode();



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

  bool isStartSearch = false;




  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Provider.of<LocationProvider>(context, listen: false).markers.clear();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
          
    var mapdataProvider = Provider.of<MapDataProvider>(context,listen: false);
    final foodcartprovider  = Provider.of<FoodCartProvider>(context); 


    return Scaffold(
      key: homeScaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Select Delivery Location',
            style: CustomTextStyle.addresstitle),
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap:widget.isfrommanualsearchaddress?
            (){ Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>  RequestPermissionPage(isEnabled: false,)));}
            : () { Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Foodscreen(categoryFilter: "restaurant",)));},
            child:const Icon(Icons.arrow_back, color: Customcolors.DECORATION_BLACK)),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height / 1,
        width: MediaQuery.of(context).size.width,
        child: Consumer<LocationProvider>(
          builder: (context, locationProvider, child) => Stack(
            clipBehavior: Clip.none,
            children: [
              GoogleMap(
               mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(widget.lat ?? locationProvider.currentL!,
                      widget.lang ?? locationProvider.currentLon!),
                  zoom: 18.0,
                ),

                markers: markersList,
                //   markers: locationProvider.markers,
                polylines: isWithinCircle ? _polylines : {},
                // circles: isWithinCircle ? _circles : {},
                myLocationButtonEnabled: false,
                myLocationEnabled: true,
                // zoomGesturesEnabled: false,
                zoomControlsEnabled: false,
                compassEnabled: false,
                indoorViewEnabled: false,
                mapToolbarEnabled: false,
                onCameraIdle: () {
                  locationProvider.dragableAddress();

                  print('----------------dd-c-dd-dd-d-');
       
             String fullAddress  =  "${locationProvider.address.street}, ${locationProvider.address.subLocality}, ${locationProvider.address.locality}, ${locationProvider.address.administrativeArea}, ${locationProvider.address.postalCode}, ${locationProvider.address.country}";

                         

                  setState(() {
                    country            = locationProvider.address.country;
                    address            = fullAddress;
                    localitycontroller = TextEditingController(text: '${locationProvider.address.locality}');
                    streetcontroller   = TextEditingController(text: locationProvider.address.street);
                    country            = locationProvider.address.country;
                    statecontroller    = TextEditingController(text: locationProvider.address.administrativeArea);
                    pincodecontroller  = TextEditingController(text: locationProvider.address.postalCode);
                        
                    latpass = locationProvider.position.latitude;
                    lngpass = locationProvider.position.longitude;

                    // Draw circle around target location
                    _circles.add(Circle(
                      circleId: const CircleId('target_location'),
                      center: LatLng(locationProvider.currentL!,
                          locationProvider.currentLon!),
                      radius: 100,
                      fillColor: Colors.blue.withOpacity(0.1),
                      strokeColor: Colors.blue,
                      strokeWidth: 1,
                    ));
                  });
                },

                onCameraMove: (position) {
                  locationProvider.updatePosition(position);

                  setState(() {
                    address = "";

                    print(
                        'Camera position  : ${position.target.latitude}, ${position.target.longitude}');

                    print('.............$latpass..$lngpass................');

                    // Check if the point is within the circle
                    double distance = calculateDistance(
                      position.target.latitude,
                      position.target.longitude,
                      locationProvider.currentL,
                      locationProvider.currentLon,
                    );

                    if (distance <= 100) {
                      isWithinCircle = true;
                      isLocationDifferent = false;

                      if (polylinePoints.length == 1) {
                        polylinePoints.add(position.target);
                      } else if (polylinePoints.length == 2) {
                        polylinePoints[1] = position.target;
                      } else {
                        polylinePoints.clear();
                        polylinePoints.add(LatLng(locationProvider.currentL!,
                            locationProvider.currentLon!));
                        polylinePoints.add(position.target);
                      }

                      _polylines.add(
                        Polyline(
                          patterns: [
                            PatternItem.dot,
                            PatternItem.gap(10),
                          ],
                          polylineId: const PolylineId('route'),
                          points: polylinePoints,
                          color: Colors.black,
                          width: 4,
                        ),
                      );
                    } else {
                      isLocationDifferent = true;
                      isWithinCircle = false;
                    }
                  });
                },
                onMapCreated: (GoogleMapController controller) {
                  _controller = controller;
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
                      onTap: () {
                        _controller?.animateCamera(
                          CameraUpdate.newLatLng(
                            LatLng(locationProvider.currentL!,locationProvider.currentLon!),
                          ),
                        );
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        margin: const EdgeInsets.only(right: 20),
                        decoration: const BoxDecoration(
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
                height: MediaQuery.of(context).size.height *0.825,
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
                                            searchPlaces(); });
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
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        alignLabelWithHint: true,
                                        prefixIcon: const Icon(
                                          Icons.circle,
                                          color: Colors.red,
                                          size: 10,
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(
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
                                            icon: const Icon(Icons.close))),
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
                                          color: Customcolors.DECORATION_primaryGREEN, // Color of the dot
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
                                            Future.delayed(const Duration(milliseconds: 100),() {focusNode.requestFocus();});   },
                                          child:
                                              Consumer<LocationProvider>(
                                            builder: (context, value, child) {
                                              if (value.loading == true) {
                                                return const CupertinoActivityIndicator();
                                              } else if (value.fullAddresss == null) {
                                                return const Text(
                                                  'Locating..',
                                                  style: CustomTextStyle.smallblacktext,
                                                );
                                              } else {
                                                return Text(
                                                  value.fullAddresss,
                                                  maxLines: 1,
                                                  overflow:TextOverflow.ellipsis,
                                                  style: CustomTextStyle.smallblacktext,
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
                            ? SizedBox(
                                height: MediaQuery.of(context).size.height / 1,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _places.length,
                                  padding: const EdgeInsets.only(top: 20),
                                  itemBuilder: (context, index) {
                                    final place = _places[index]["description"];
                                    final placeId = _places[index]["place_id"];

                                    return Container(
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: GestureDetector(
                                          onTap: () async {
                                            await fetchPlaceDetails(placeId: placeId,context: context).whenComplete(() {
                                              setState(() {});
                                            });
                                          },
                                          child: Row(
                                            crossAxisAlignment:CrossAxisAlignment.start,
                                            children: [
                                              const Icon(Icons.location_on_outlined),
                                              const SizedBox(width: 5,),
                                              SizedBox(
                                                width: 250.w,
                                                child: Text(
                                                  '$place',
                                                  maxLines: null,
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    fontFamily:
                                                        'Poppins-Regular',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
          
              Positioned(
                left: 0,
                right: 0,
                bottom:15,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration:locationProvider.loading||locationProvider.fullAddresss==null?
                        CustomContainerDecoration.lightgreybuttondecoration():
                         CustomContainerDecoration.gradientbuttondecoration(),
                        child: ElevatedButton(
                          onPressed:locationProvider.loading||locationProvider.fullAddresss==null
              ? null // Disables the button when loading
              : () {
                                          String fullAddress = [
                                            locationProvider.address.street,
                                            locationProvider.address.subLocality,
                                            locationProvider.address.locality,
                                            locationProvider.address.administrativeArea,
                                            locationProvider.address.postalCode,
                                            locationProvider.address.country
                                          ].where((part) => part != null && part.isNotEmpty).join(', ');

                                          print('=========vj============');
                                          print(fullAddress);

                                        mapdataProvider.updateMapData(

                                                                addresstype      : 'Current',
                                                                statee           :  locationProvider.address.subLocality, 
                                                                contactpersionNo :  mobilenumb,
                                                                contacypersion   :  username,
                                                                fulladdres       :  fullAddress,
                                                                houseno          :  locationProvider.address.street,
                                                                landmark         :  locationProvider.address.subLocality,
                                                                localiti         :  locationProvider.address.locality,
                                                                postalcode       :  locationProvider.address.postalCode,
                                                                streett          :  locationProvider.address.street,
                                                                latitude         :  locationProvider.position.latitude,
                                                                longitude        :  locationProvider.position.longitude,

                                                      );
                                         locationProvider.updateMarker(latitude: locationProvider.position.latitude,longitude: locationProvider.position.longitude );
                                        
                              foodcartprovider.getfoodcartProvider(km: '5');
                              print("ASASASA");
                            // Get.off(const Foodscreen(fromPickupscreen: true,),transition: Transition.leftToRight);
                               if(widget.isfrommanualsearchaddress){
                             // Get.off(const HomeScreenPage());
                             
Navigator.push(
  context,
  PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>  
     Foodscreen(
                                                                      categoryFilter: nearbyreget.selectedIndex.value ==
                                                                              0
                                                                          ? "restaurant"
                                                                          : "shop"),));
                              }else{
                            Get.off(const Foodscreen(fromPickupscreen: true,),transition: Transition.leftToRight);}
                                
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                          child: locationProvider.loading
                              ? LoadingAnimationWidget.horizontalRotatingDots(
                                  color: Customcolors.DECORATION_WHITE,
                                  size: 24,
                                )
                              : const Text(
                                  'Confirm Location',
                                  style: TextStyle(
                                      color: Customcolors.DECORATION_WHITE,
                                      fontFamily: 'Poppins-Regular'),
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
    ); }


 

  Future<dynamic> makeRequest({input}) async {
    // String url = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$kGoogleApiKey&language=en&location=$initiallat,$initiallong&radius=50000&strictbounds";
          String url = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$kGoogleApiKey&language=en&location=$initiallat,$initiallong";
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
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&key=$kGoogleApiKey');

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
            markersList.add(Marker(
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




