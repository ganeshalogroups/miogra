// ignore_for_file: avoid_print, unnecessary_null_comparison, prefer_typing_uninitialized_variables
import 'package:testing/map_provider/Map%20Screens/MapSearch.dart/addressnameController.dart';
import 'package:testing/map_provider/Map%20Screens/markervaluse.dart';
import 'package:testing/Features/Homepage/profile/addressbook.dart';
import 'package:testing/map_provider/circle_marker.dart';
import 'package:testing/map_provider/locationprovider.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/addAddressFun.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EditLocationMapScreen extends StatefulWidget {
  double? lattitude;
  double? longitude;
  String? addressId;
  String? addresstype;
  String? fullAddress;
  dynamic typefield;
  String persionName;
  String mobilenumber;
  String housenumber;
  String landmark;
  String locality;

  EditLocationMapScreen(
      {super.key,
      this.lattitude,
      this.longitude,
      this.addressId,
      this.addresstype,
      this.fullAddress,
      required this.locality,
      required this.persionName,
      required this.housenumber,
      required this.landmark,
      required this.mobilenumber,
      required this.typefield});

  @override
  State<EditLocationMapScreen> createState() => _EditLocationMapScreenState();
}

class _EditLocationMapScreenState extends State<EditLocationMapScreen> {





  TextEditingController localityController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController stateController = TextEditingController();

  var latpass;
  var lngpass;

  String? fullAddress = '';
  String? country = 'India';

  var address;

  bool isLocationDifferent = false;

  GoogleMapController? _controller;
  final List<LatLng> polylinePoints = [];
  final Set<Polyline> _polylines = {};
  Set<Marker> markersList = {};

  @override
  void initState() {
    address = widget.fullAddress;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<LocationProvider>(context, listen: false).clearAddress();
      Provider.of<AddressNameController>(context, listen: false).forEditScreenPlacesSearch(latitude: widget.lattitude!, longitude: widget.longitude!);
          
          
      _updatePositionAndAddress();
      _updateMarker();
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _updatePositionAndAddress() async {
    final locationProvider =  Provider.of<LocationProvider>(context, listen: false);
  

    // await locationProvider.getCurrentLocation(mapController: _controller);

    setState(() {
      // address = widget.fullAddress;
      address = locationProvider.address;
      latpass = locationProvider.position.latitude;
      lngpass = locationProvider.position.longitude;
      print("State Updated: $latpass, $lngpass, $address");

      localityController.text = locationProvider.address.locality ?? widget.locality;
      streetController.text   = locationProvider.address.street ?? "";
      stateController.text    = locationProvider.address.administrativeArea ?? "";
      pincodeController.text  = locationProvider.address.postalCode ?? "";
    });
  }


  void _updateMarker() async {
    markersList.clear();

    markersList.add(
      Marker(
        markerId: const MarkerId('current_location'),
        position: LatLng(latpass!, lngpass!),
        visible: true,
        icon: await getDotMarker(),
      ),
    );

    print( "Markers Updated: ${markersList.first.position.latitude}, ${markersList.first.position.longitude}");
       
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Update Address', style: CustomTextStyle.addresstitle),
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: () {
              Get.off(const AddressbookScreen());
            },
            child:
                const Icon(Icons.arrow_back, color: Customcolors.DECORATION_BLACK)),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height / 1,
        width: MediaQuery.of(context).size.width,
        child: Consumer<LocationProvider>(
          builder: (context, locationProvider, child) => Stack(
            clipBehavior: Clip.none,
            children: [
              GoogleMap(
                // style: mapStyle,
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                      widget.lattitude ?? locationProvider.currentL!,
                      widget.longitude ?? locationProvider.currentLon!),
                  zoom: 18,
                ),
                trafficEnabled: false,
                markers: locationProvider.markers,
                polylines: _polylines,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: false,
                compassEnabled: false,
                indoorViewEnabled: false,
                mapToolbarEnabled: false,
    
                onCameraIdle: () async {
                  locationProvider.dragableAddress();
    
                  double latitude = locationProvider.position.latitude;
                  double longitude = locationProvider.position.longitude;
    
                  await Provider.of<AddressNameController>(context,
                          listen: false)
                      .forEditScreenPlacesSearch(
                          latitude: latitude, longitude: longitude)
                      .whenComplete(() {
                    // Check if the widget is still mounted before calling setState
                    if (mounted) {
                      setState(() {
                        country = locationProvider.address.country;
    
                        address = Provider.of<AddressNameController>(context,
                                listen: false)
                            .editFullAddressModel
                            .toString();
    
                        localityController = TextEditingController(
                            text: locationProvider.address.locality ??
                                widget.locality);
                        streetController = TextEditingController(
                            text: locationProvider.address.street);
                        country = locationProvider.address.country;
                        stateController = TextEditingController(  text:  locationProvider.address.administrativeArea);  
                          
                              
                        pincodeController = TextEditingController(text: locationProvider.address.postalCode);
                          
                        latpass = locationProvider.position.latitude;
                        lngpass = locationProvider.position.longitude;
                      });
                    }
                  });
                },
    
        
    
                onCameraMove: (position) {
                  locationProvider.updatePosition(position);
                },
    
                onMapCreated: (GoogleMapController controller) {
                  _controller = controller;
                  _updateMarker();
                  _updatePositionAndAddress();
                  //  Provider.of<AddressNameController>(context,listen: false).forEditScreenPlacesSearch(latitude: locationProvider.position.latitude, longitude: locationProvider.position.longitude);
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
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: LatLng( widget.lattitude!, widget.longitude!),
                                zoom: 16,
                              ),
                            ),
                          );
    
                        // locationProvider.getCurrentLocation(mapController: _controller);
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
                height: MediaQuery.of(context).size.height / 1.18,
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
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 15.5,
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                // Get.off(AddressSearchScreen(),transition: Transition.leftToRight,);
                              },
    
                              // child: locationProvider.isloading==true || address.toString().split(',').contains('null')?  Text("Fetching Current Address....",style: CustomTextStyle.smallblacktext,) : Text(  address,maxLines: 1,overflow: TextOverflow.ellipsis,style: CustomTextStyle.smallblacktext,) ,
    
                              child: Consumer<AddressNameController>(
                                builder: (context, value, child) {
                                  if (value.isLoadinge) {
                                    return const Center(
                                        child: CupertinoActivityIndicator());
                                  } else if (value.editFullAddressModel ==
                                      null) {
                                    return const Text('Loading..',
                                        style: CustomTextStyle.blacktext);
                                  } else {
                                    return Text(
                                      value.editFullAddressModel,
                                      style: CustomTextStyle.blacktext,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
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
                            addAddressBottomSheet(
                              name    : widget.persionName,
                              itseditscreen: true,
                              context : context,
                              address : address,
                              locality: localityController.text,
                              country : country,
                              state   :   streetController.text,
                              pincode : pincodeController.text,
                              street:  localityController.text,
                              lattitude: latpass,
                              longitude: lngpass,
                              addressId: widget.addressId,
                              addresstype: widget.addresstype,
                              housenumber: widget.housenumber,
                              landmark: widget.landmark,
                              mobilenumber: widget.mobilenumber,
                              typefield: widget.typefield,
                            ).whenComplete(() {
                              locationProvider.clearAddress(); //imprtant
                            });
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
    );
  }
}
