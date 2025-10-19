// ignore_for_file: prefer_typing_uninitialized_variables, unrelated_type_equality_checks, avoid_print, deprecated_member_use, file_names
import 'dart:async';
import 'dart:convert';
import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:testing/Features/Homepage/homeStyles/FoodHomedecorations.dart';
import 'package:testing/Features/OrderScreen/OrderScreenController/trackOrderController.dart';
import 'package:testing/map_provider/Map%20Screens/MapSearch.dart/apiKey.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/CustomDottedline.dart';
import 'package:testing/utils/Toast/customtoastmessage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart'; // For loading the asset
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:maps_curved_line/maps_curved_line.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class MeatTrackOrderDetails extends StatefulWidget {
  String orderId;
  LatLng userlat;
  LatLng shoplatlng;
  String orderStatus;
  MeatTrackOrderDetails(
      {super.key,
      required this.orderStatus,
      required this.orderId,
      required this.shoplatlng,
      required this.userlat});

  @override
  State<MeatTrackOrderDetails> createState() => _MeatTrackOrderDetailsState();
}





class _MeatTrackOrderDetailsState extends State<MeatTrackOrderDetails> with TickerProviderStateMixin {



  BitmapDescriptor?    homeicon;
  List<LatLng>         polylineCoordinates = [];
  Polyline?            routePolyline;
  double               _currentRotation    = 0.0;
  BitmapDescriptor?    userLocationIcon;
  BitmapDescriptor?    resturantIcon;
  AnimationController? _animationController;
  Animation<LatLng>?   _latLngAnimation;




  final Completer<GoogleMapController> _controller = Completer();

    Timer? _timer;
    int _activeIndex = 0;
    var orderState = '';


    Set<Marker>    markers         = {};
    List<LatLng>   routeCoords     = [];
    bool           isFullyExpanded = false;
    Set<Polyline>  polylines      = {};
    BitmapDescriptor? delivaryManIcon;
    BitmapDescriptor? userIcon;
    LatLng? delivaryPosition ;
    late DraggableScrollableController draggableController;
    GoogleMapController? _mapController;

    LatLng? _currentPosition  ;

    BitmapDescriptor? pinLocationIcon;


    DatabaseReference get deliveryManRef => FirebaseDatabase.instance.ref().child('deliveryManPositions');

    StreamSubscription<DatabaseEvent>? deliveryManPosition;

    Map distanceAndDurations ={};



  @override
  void initState() {
    draggableController = DraggableScrollableController();
    
    _currentPosition = widget.shoplatlng;
 
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      
          orderState = widget.orderStatus;
          orderState = await Provider.of<TrackOrderController>(context, listen: false).getOrders(orderId: widget.orderId);
          _updateStepper(orderStatus: orderState);

            setdelivaryManIconMarker();
            _initializeMarkers();
            startFirebaseUpdates();   
          
            // getDirections();
            orderState = widget.orderStatus;
            startTimerfun();

            if(_activeIndex >=3){

                  removeCurvedPolyline();
              
            }else{

                prepareCurvedPolylines();

            }

        });


    super.initState();
  }



  Future<void> _initializeMarkers() async {

    await setdelivaryManIconMarker(); // Wait for the markers to be loaded 
     _addMarkers(); // Now it's safe to add markers

  }


  void _addMarkers() async {

    markers.add(Marker(
      markerId: const MarkerId('resturant_marker'),
      position: widget.shoplatlng,
      icon: resturantIcon!,
      infoWindow: const InfoWindow(title: 'Resturant Location'),
    ));

    markers.add(Marker(
      markerId: const MarkerId('drop_location_marker'),
      position: widget.userlat,
      icon: userIcon!,
      infoWindow: const InfoWindow(title: 'Drop Location'),
    ));


    setState(() {}); // Trigger a rebuild to display the markers
  }






  void startFirebaseUpdates() {
    deliveryManPosition = deliveryManRef.child(widget.orderId).onValue.listen(
      (event) {

        final vehicleData = event.snapshot.value as Map?;

        if (vehicleData != null) {

          if (vehicleData['latitude'] != null && vehicleData['longitude'] != null && vehicleData['heading'] != null) {
             
            double latitude  = double.parse(vehicleData['latitude'].toString());
            double longitude = double.parse(vehicleData['longitude'].toString());
            double bearing   = double.parse(vehicleData['heading'].toString());



            WidgetsBinding.instance.addPostFrameCallback((_) {
              _animateMarkerToPosition(LatLng(latitude, longitude));
              //  updateMarkerPosition(latitude: latitude, longitude: longitude);
            });


            if (mounted) {

              setState(() {
                _currentRotation = bearing;
              });
            }



            if(_activeIndex >=3){

                    getDirections(delivaryPersionnn: LatLng(latitude, longitude));


            }else{






            }

       

          } else {



          }
        } else {
        }
      },
    );
  }



  // Function to update marker position
  void updateMarkerPosition({required double latitude, required double longitude}) {
     
          LatLng newPosition = LatLng(latitude, longitude);

          setState(() {

            delivaryPosition = newPosition;
            // Update the marker's position
            markers.removeWhere((m) => m.markerId == const MarkerId('moving_marker')); // Remove the old marker
                

            markers.add(Marker(
                markerId: const MarkerId('moving_marker'),
                position: newPosition,
                rotation: _currentRotation,
                draggable: false,
                onTap: () {
                  AppUtils.showToast('Hey i am driving Bike Do not distrub me..');
                },
                icon: delivaryManIcon!,
                infoWindow: const InfoWindow(title: 'DelivaryMan')));

       });

  }



    @override
    void dispose() {
      _timer!.cancel();
      draggableController.dispose();
      _animationController?.dispose();
      super.dispose();
    }


  void _animateMarkerToPosition(LatLng newPosition) {
      // Dispose previous animation controller if exists
      _animationController?.dispose();

        // Create an animation controller for smooth transition
      _animationController = AnimationController(
        duration: const Duration(seconds: 1), // Adjust for smoothness
        vsync: this,
      );

      // Animate the marker's movement smoothly from current position to new position
      _latLngAnimation = LatLngTween(
        begin: _currentPosition!,
        end: newPosition,
      ).animate(CurvedAnimation(
        parent: _animationController!,
        curve: Curves.easeInOut,
      ));

      // Listen to animation updates
      _animationController?.addListener(() {
        setState(() {
          _currentPosition = _latLngAnimation!.value;
          // Update the marker's position
          markers.removeWhere((m) => m.markerId == const MarkerId('moving_marker'));
          markers.add(Marker(
            markerId: const MarkerId('moving_marker'),
            position: _currentPosition!,
            icon: delivaryManIcon!,
            rotation: _currentRotation,
            infoWindow: const InfoWindow(title: 'Delivery Man'),
          ));
        });
      });

    _animationController?.forward(); // Start the animation
  }


  Future<void> makePhoneCall({ required String phoneNumber}) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

    Future<void> makeSms({required String phoneNumber, required String message}) async {

      final Uri launchUri = Uri(
        scheme: 'sms',
        path: phoneNumber,

        query: 'body=${Uri.encodeComponent(message)}',

        // queryParameters: <String, String>{
        //   // 'body': message,
        // },
      );

      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        throw 'Could not launch SMS';
      }
      
    }


void removeCurvedPolyline() {
  polylines.removeWhere((polyline) => polyline.polylineId.value == "line 1");
}


  @override
  Widget build(BuildContext context) {

      var orderProvider = Provider.of<TrackOrderController>(context).orderModel;
  

    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Order', style: CustomTextStyle.darkgrey),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: GoogleMap(
                    polylines: polylines,
                    markers: markers,
                    // style: mapStyle,
                    initialCameraPosition: CameraPosition(

                      target: LatLng((widget.userlat.latitude + widget.shoplatlng.latitude) / 2, (widget.userlat.longitude + widget.shoplatlng.longitude) / 2),
                      zoom: 14,
                    ),
                    onMapCreated: (controller) {

                    _mapController = controller;
                    _controller.complete(controller);

                  },

                  onCameraMove: (position) {

                
          

                        },
                  ),
                  
                )
            ],
          ),



       DraggableScrollableSheet(
            initialChildSize : 0.20,
            minChildSize     : 0.20,
            maxChildSize     : 0.80,
            expand: true,
            controller: draggableController,
            builder: (context, scrollController) { 
              return NotificationListener<DraggableScrollableNotification>(
                  onNotification: (notification) {
                    setState(() {
                      isFullyExpanded = notification.extent == 8.0;
                    });
                    return true;
                  },
                  child: Container(
                    color: Colors.white,
                    child: CustomScrollView(
                      // physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      controller: scrollController,
                      slivers: [
                        SliverList(

                   delegate: SliverChildListDelegate([
                    
                   Padding(
                     padding: const EdgeInsets.all(16),
                     child: Column(
                       children: [

                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: FoodDecorations().delivarymanDecoraion,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          // Display delivery partner's image
                                    
                                            orderProvider != null &&   orderProvider['assigneeDetails'] != null &&  orderProvider['assigneeDetails']['imgUrl'] != null
                                                  ?  CircleAvatar(backgroundImage: NetworkImage(orderProvider['assigneeDetails']['imgUrl'].toString()),radius: 25,)
                                              : Container(
                                                  margin: const EdgeInsets.only(right: 10),
                                                  child: Image.asset(
                                                    "assets/images/Profile.png",
                                                    height: 45,
                                                    width: 45,
                                                  ),
                                                ),



                                          const SizedBox(width: 10),
                                          // Display delivery partner's name
                                          Consumer<TrackOrderController>(

                                            builder: (context, value, child) {

                                              if (value.orderModel == null) {
                                                return const Text('Waiting for delivery partner...');
                                              } else if (value.orderModel['assigneeDetails'] == null) {
                                                return const Text('No delivery partner assigned yet.',   style: CustomTextStyle.smallgrey,);
                                              } else {
                                                return Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          value.orderModel['assigneeDetails']['name'] ?? 'No name',
                                                          style: CustomTextStyle.boldblack2,
                                                        ),
                                                        const SizedBox(height: 5),
                                                        const Text(
                                                          "Delivery Partner",
                                                          style: CustomTextStyle.smallgrey,
                                                        ),
                                                    
                                                  
                                                    
                                                          ],
                                                        ),
                                                      ],
                                                    );
                                                  }
                                                },
                                              ),
                                            ],
                                          ),

                                      // Call button and mail icon
                                        orderProvider != null &&   orderProvider['assigneeDetails'] != null && orderProvider['assigneeDetails']['mobileNo'] != null ?            Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () async {


                                      if( orderProvider != null &&   orderProvider['assigneeDetails'] != null && orderProvider['assigneeDetails']['mobileNo'] != null ){


                                              String mobileno = orderProvider['assigneeDetails']['mobileNo'].toString();

                                                await makePhoneCall(phoneNumber: mobileno);

                                          }
                                            
                                            },
                                            child: Image.asset(
                                              height: 40,
                                              width: 30,
                                              "assets/images/Fill call.png",
                                            ),
                                          ),
                                          SizedBox(width: 15.w),
                                          InkWell(
                                            onTap: () {


                                          if( orderProvider != null &&   orderProvider['assigneeDetails'] != null && orderProvider['assigneeDetails']['mobileNo'] != null ){


                                            String mobileno = orderProvider['assigneeDetails']['mobileNo'].toString();
                                                                          
                                             makeSms(phoneNumber: mobileno,message: 'When Will I Get My Order');  


                                            }else{


                                              
                                            }

                                              // makeSms(phoneNumber: '9751460125');
                                            },
                                            child: Image.asset(
                                              height: 40,
                                              width: 30,
                                              "assets/images/Fill mail.png",
                                            ),
                                          ),
                                        ],
                                      ) :  const SizedBox(),


                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                                        const SizedBox(height: 10),
                                                            Container(
                                                            width: MediaQuery.of(context).size.width,
                                                            decoration: FoodDecorations().stepperBoxDecoraion,
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(16.0),
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                     
                                                                      Text(
                                                                        "${orderSts.toString().capitalizeFirst}",
                                                                        style: CustomTextStyle.yellowtext,
                                                                      ),
                                                                    ],
                                                                  ),


                                                                  const Padding(
                                                                    padding: EdgeInsets.symmetric(vertical: 10),
                                                                    child: CustomDottedContainer(),
                                                                  ),
                                                                Padding(
                                                              padding: const EdgeInsets.symmetric(horizontal: 16),
                                                              child: orderSts == 'rejected' || orderSts == 'cancelled' ?
                                                              
                                                              AnotherStepper(
                                                                stepperList:  rejectedSteperData(statuss: orderSts ),
                                                                stepperDirection: Axis.vertical,
                                                                iconWidth: 20,
                                                                iconHeight: 20,
                                                                activeBarColor: Customcolors.darkpurple,
                                                                inActiveBarColor: Customcolors.DECORATION_GREY,
                                                                inverted: false,
                                                                verticalGap: 12,
                                                                activeIndex: _activeIndex,
                                                                barThickness: 1,
                                                              )
                                                              
                                                              : AnotherStepper(
                                                                stepperList:  buildStepperData(),
                                                                stepperDirection: Axis.vertical,
                                                                iconWidth: 20,
                                                                iconHeight: 20,
                                                                activeBarColor: Customcolors.darkpurple,
                                                                inActiveBarColor: Customcolors.DECORATION_GREY,
                                                                inverted: false,
                                                                verticalGap: 12,
                                                                activeIndex: _activeIndex,
                                                                barThickness: 1,
                                                              ),
                                                            ),
                                                                  const Padding(
                                                                    padding: EdgeInsets.only(bottom: 10),
                                                                    child: CustomDottedContainer(),
                                                                  ),
                                                          orderState == 'initiated' ||  orderState == 'rejected' ||  orderState == 'new' ?  const SizedBox() :    Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children:  [

                                                              const Image(
                                                                image: AssetImage("assets/images/Timer.png"),
                                                                height: 20,
                                                                width: 24,
                                                              ),


                                                    _activeIndex >= 3  ?

                                                                      Text(
                                                                        "Your order coming within ${distanceAndDurations['Duration'] }",
                                                                        style: CustomTextStyle.carttblack
                                                                      ) 

                                                                        : 
                                                                      
                                                                        const Text("Your order coming within 30 minuts",style: CustomTextStyle.carttblack) ,
                                                                            
                                                                      
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            )),
                                  ],
                                ),
                              ),
                           ]             
                        )
                        )
                      ],
                    ),
                  ));
            },
          ),
        ],
      ),
    );
  }





  void prepareCurvedPolylines() {
    polylines.add(
        Polyline(
          polylineId: const PolylineId("line 1"),
          visible: true,
          width: 2,
          //latlng is List<LatLng>
          patterns: [PatternItem.dash(30), PatternItem.gap(10)],
          points: MapsCurvedLines.getPointsOnCurve(widget.userlat, widget.shoplatlng),
          color: Colors.black,
        )
    );
  }





Future<void> getDirections({required LatLng delivaryPersionnn}) async {
  final String url = 'https://maps.googleapis.com/maps/api/directions/json?origin=${delivaryPersionnn.latitude},${delivaryPersionnn.longitude}&destination=${widget.userlat.latitude},${widget.userlat.longitude}&key=$kGoogleApiKey';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    if (data['routes'].isNotEmpty) {
      final points = data['routes'][0]['overview_polyline']['points'];
      final distance = data['routes'][0]['legs'][0]['distance']['text'];
      final duration = data['routes'][0]['legs'][0]['duration']['text'];

      routeCoords = _decodePolyline(points);

      distanceAndDurations = {'Distance': distance, 'Duration': duration};

if(mounted){

      setState(() {
        polylines.add(
          Polyline(
            polylineId: const PolylineId('route'),
            color: Colors.blue,
            width: 3,
            points: routeCoords,
          ),
        );
      });


}


if(_activeIndex >=3){

  // Create LatLngBounds between the delivery person and user location
      LatLngBounds bounds = LatLngBounds(

        southwest: LatLng(
          min(delivaryPersionnn.latitude, widget.userlat.latitude),
          min(delivaryPersionnn.longitude, widget.userlat.longitude),
        ),

        northeast: LatLng(
          max(delivaryPersionnn.latitude, widget.userlat.latitude),
          max(delivaryPersionnn.longitude, widget.userlat.longitude),
        ),

      );

      _mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50), // 50 is padding
           
      );

    }else{



    }

    }
  } else {
    throw Exception('Failed to load directions');
  }
}

      double min(double a, double b) => (a < b) ? a : b;
      double max(double a, double b) => (a > b) ? a : b;

        List<LatLng> _decodePolyline(String encoded) {
          List<LatLng> points = [];
          int index = 0, len = encoded.length;
          int lat = 0, lng = 0;

          while (index < len) {
            int b, shift = 0, result = 0;
            do {
              b = encoded.codeUnitAt(index++) - 63;
              result |= (b & 0x1F) << shift;
              shift += 5;
            } while (b >= 0x20);
            int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
            lat += dlat;

            shift = 0;
            result = 0;
            do {
              b = encoded.codeUnitAt(index++) - 63;
              result |= (b & 0x1F) << shift;
              shift += 5;
            } while (b >= 0x20);
            int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
            lng += dlng;

            points.add(LatLng(lat / 1E5, lng / 1E5));
          }

          return points;
        }





            Future<void> setdelivaryManIconMarker() async {
                // assets/mapmarkers/restaurant.png
                // final ByteData batchingPlantBytes  = await rootBundle.load('assets/mapmarkers/restaurant.png');

                final ByteData batchingPlantBytes  = await rootBundle.load('assets/images/resTaurant.png');
                final Uint8List batchingPlantImage = batchingPlantBytes.buffer.asUint8List();
                img.Image batbytes = img.decodeImage(batchingPlantImage)!;
                img.Image resizedbatchImage = img.copyResize(batbytes, width: 100);
                Uint8List resizedbatImageBytes = Uint8List.fromList(img.encodePng(resizedbatchImage));
                resturantIcon = BitmapDescriptor.fromBytes(resizedbatImageBytes);

// assets/images/fast-x-delevaryMan.png


                final ByteData constructionBuildingBytes  = await rootBundle.load('assets/images/userLocation.png');
                final Uint8List constructionBuildingImage =  constructionBuildingBytes.buffer.asUint8List();
                img.Image imagebyte = img.decodeImage(constructionBuildingImage)!;
                img.Image resizedconImage = img.copyResize(imagebyte, width: 100);
                Uint8List resizedconImageBytes =  Uint8List.fromList(img.encodePng(resizedconImage));
                userIcon  = BitmapDescriptor.fromBytes(resizedconImageBytes);


                // final ByteData byteData    = await rootBundle.load('assets/images/bikee.png');
                final ByteData byteData    = await rootBundle.load('assets/images/fast-x-delevaryMan.png');
                final Uint8List imageBytes = byteData.buffer.asUint8List();
                img.Image image = img.decodeImage(imageBytes)!;
                img.Image resizedImage = img.copyResize(image, width: 75);
                Uint8List resizedImageBytes =  Uint8List.fromList(img.encodePng(resizedImage));
                delivaryManIcon = BitmapDescriptor.fromBytes(resizedImageBytes);
             
        }





String orderSts = '';



void startTimerfun() {

  _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) async {


    try {

      var newOrderState = await Provider.of<TrackOrderController>(context, listen: false).getOrders(orderId: widget.orderId);
         
      
        if(mounted){

              setState(() {
                orderState = newOrderState;  // Update state only if mounted
                orderSts = orderState.toString();
              });
      
              _updateStepper(orderStatus: orderSts);




if(_activeIndex < 3 ){

  // Create LatLngBounds between the delivery person and user location
      LatLngBounds bounds = LatLngBounds(

        southwest: LatLng(
          min(widget.shoplatlng.latitude, widget.userlat.latitude),
          min(widget.shoplatlng.longitude, widget.userlat.longitude),
        ),

        northeast: LatLng(
          max(widget.shoplatlng.latitude, widget.userlat.latitude),
          max(widget.shoplatlng.longitude, widget.userlat.longitude),
        ),

      );

      _mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
           
    

    }else{



    }



              
            if(orderSts == 'delivered' || orderSts == 'cancelled') {


                _timer?.cancel(); // Stop the timer
                
              }
            
            }

        else {
            


          }


    } catch (e) {
      print('Error fetching order status: $e');
    }
  });
}






  void _updateStepper({required String orderStatus}) {
    int newIndex = _getActiveIndex(status: orderStatus);
    if (newIndex != _activeIndex) {
      setState(() {
        _activeIndex = newIndex;
      });
        if(newIndex >= 3){
          removeCurvedPolyline();
        }else{

          
        }
    
    }
  }




  List<StepperData> rejectedSteperData({statuss}) {
    return [
      StepperData(
        title: StepperText(
          "Restaurant Initialized",
          textStyle: _activeIndex >= 1 ? CustomTextStyle.DECORATION_regulartext : CustomTextStyle.chipgrey,
            
        ),
           iconWidget: Container(
          decoration: const BoxDecoration(
            color: Customcolors.darkpurple ,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child:  const Icon(Icons.check, size: 13, color: Colors.white) ,

        ),
      ),
      StepperData(
        title: StepperText(
        statuss== 'rejected' ?  "Order rejected By Resturant" : 'Order Canceled',
          textStyle: _activeIndex >= 2 ? CustomTextStyle.DECORATION_regulartext : CustomTextStyle.chipgrey,
        ),

        iconWidget: Container(
          decoration: const BoxDecoration(
            color: Customcolors.darkpurple ,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child:  const Icon(Icons.check, size: 13, color: Colors.white) ,

        ),
      ),



    ];
  }






  List<StepperData> buildStepperData() {
          return [
            StepperData(
              title: StepperText(
                "Shop accepted the order",
                textStyle: _activeIndex >= 1 ? CustomTextStyle.DECORATION_regulartext : CustomTextStyle.chipgrey,
                  
              ),
              iconWidget: Container(
                // padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _activeIndex >= 1 ? Customcolors.darkpurple  : Customcolors.DECORATION_GREY,
                                  
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                ),
                child: _activeIndex >= 1
                    ? const Center(child: Icon(Icons.check, size: 13, color: Colors.white)) : null,
              ),
            ),


              StepperData(
                title: StepperText(
                  "Order assigned to delivery partner",
                  textStyle: _activeIndex >= 2 ? CustomTextStyle.DECORATION_regulartext : CustomTextStyle.chipgrey,
                ),
                iconWidget: Container(
                  decoration: BoxDecoration(
                    color: _activeIndex >= 2  ? Customcolors.darkpurple : Customcolors.DECORATION_GREY,
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  child: _activeIndex >= 2   ? const Icon(Icons.check, size: 13, color: Colors.white) : null,
                ),
              ),


              StepperData(
                title: StepperText(
                  "Order picked up",
                  textStyle: _activeIndex >= 3 ? CustomTextStyle.DECORATION_regulartext  : CustomTextStyle.chipgrey,
                ),
                iconWidget: Container(
                  // padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _activeIndex >= 3  ? Customcolors.darkpurple : Customcolors.DECORATION_GREY,
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  child: _activeIndex >= 3  ? const Icon(Icons.check, size: 13, color: Colors.white) : null,
                ),
              ),


              StepperData(
                title: StepperText(
                  "Delivery partner reached door",
                  textStyle: _activeIndex >= 4  ? CustomTextStyle.DECORATION_regulartext  : CustomTextStyle.chipgrey,  
                ),
                iconWidget: Container(
                  decoration: BoxDecoration(
                    color: _activeIndex >= 4  ? Customcolors.darkpurple  : Customcolors.DECORATION_GREY,
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  child: _activeIndex >= 4  ? const Icon(Icons.check, size: 13, color: Colors.white) : null,  
                ),
              ),


              StepperData(
                title: StepperText(
                  "Order delivered",
                  textStyle: _activeIndex >= 5 ? CustomTextStyle.DECORATION_regulartext : CustomTextStyle.chipgrey),
                iconWidget: Container(
                  decoration: BoxDecoration(
                    color: _activeIndex >= 5   ? Customcolors.darkpurple : Customcolors.DECORATION_GREY,
                    borderRadius: const BorderRadius.all(Radius.circular(30))),

                  child: _activeIndex >= 5 ? const Icon(Icons.check, size: 13, color: Colors.white) : null,
  
                ),
              ),

            ];
          }



        int _getActiveIndex({status}) {
          switch (status) {
            case "new":      
              return 1;            
            case "orderAssigned":
              return 2;          
            case "orderPickedUped":
              return 3;                
            case "deliverymanReachedDoor":
              return 4;                         
            case "delivered":                  
              return 5;                            
            default:                               
              return 0;                            
          }
        }

  }




class LatLngTween extends Tween<LatLng> {
  LatLngTween({required LatLng begin, required LatLng end})  : super(begin: begin, end: end);
  
  @override
  LatLng lerp(double t) => LatLng(
    lerpDouble(begin!.latitude, end!.latitude, t), 
    lerpDouble(begin!.longitude, end!.longitude, t));
       
  double lerpDouble(num a, num b, double t) => a + (b - a) * t;
}


