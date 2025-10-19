import 'package:testing/map_provider/circle_marker.dart';
import 'package:testing/map_provider/denidescreen.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Const/localvaluesmanagement.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';


class LocationProvider with ChangeNotifier {

  double _currentlat = initiallat;
  double _currentlong = initiallong;

  Position? currentPosition;

    double? currentL ;
    double? currentLon ;

    String currentadd = '';
    String currentpostalcode = '';

    double get currentla => _currentlat;
    double get currentlong => _currentlong;

    double get currentLangitude => currentL!;
    double get currentLatitude  => currentLon!;



  Position _position = Position(
    longitude: 0,
    latitude: 0,
    timestamp: DateTime.now(),
    accuracy: 1,
    altitude: 1,
    heading: 1,
    speed: 1,
    speedAccuracy: 1,
    altitudeAccuracy: 1,
    headingAccuracy: 1,
  );

  bool _loading = false;
  bool get loading => _loading;

  bool _isloading = false;
  bool get isloading => _isloading;

  Position get position => _position;
  Placemark _address = const Placemark();
  Placemark get address => _address;

  final Set<Marker> _markers = {};
  Set<Marker> get markers => _markers;

  dynamic fullAddresss ;

                      
 LatLng? cameraPositionm;


    dynamic datalatlong ;
    
Future<void> loadInitialAddressFromSavedData(BuildContext context) async {
  final mapData = Provider.of<MapDataProvider>(context, listen: false).llcldta;

  final savedLat = mapData['latitude'];
  final savedLng = mapData['longitude'];

  if (savedLat != 0 && savedLng != 0) {
    await updateAddressLocation(latitude: savedLat, longitude: savedLng);
  }
}



 Future<void> requestPermission() async {

        LocationPermission permission = await Geolocator.checkPermission();

        if (permission == LocationPermission.denied) {


          permission = await Geolocator.requestPermission();

          if (permission == LocationPermission.denied) {
            Get.to(PermissionDenideScreen());
            return Future.error('Location permissions are denied');
          }
        }

        if (permission == LocationPermission.deniedForever) {

          Get.to(PermissionDenideScreen());
          return Future.error('Location permissions are permanently denied, we cannot request permissions.');
              
        }

    }






  Future<void> getCurrentLocation({GoogleMapController? mapController, context,isLocEnabled}) async {

    _isloading = true;
    notifyListeners();

        if(isLocEnabled ==false){

          await requestPermission();

        }else{


        }


    try {
    


        Position? newLocalData = await Geolocator.getLastKnownPosition();

        if (newLocalData == null) {
          // If last known position is null, get the current position
          newLocalData = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        }else{
          
        }



    



        datalatlong     = newLocalData;
        // initiallat      = newLocalData.latitude;
        // initiallong     = newLocalData.longitude;
        currentPosition = newLocalData;
        currentL        = newLocalData.latitude;
        currentLon      = newLocalData.longitude;

        // Provider.of<AddressNameController>(context,listen: false).getAddressFromLatLng(latitude: newLocalData.latitude, longitude: newLocalData.longitude,context: context);





      if (mapController != null) {

          moveCameraToCurrentLocation(mapcontroller: mapController,latlng: LatLng(newLocalData.latitude, newLocalData.longitude));

        List<Placemark> placemarks = await placemarkFromCoordinates(newLocalData.latitude, newLocalData.longitude);
         

        _address = placemarks.first;
      //  fullAddresss =  "${placemarks.first.street}, ${placemarks.first.subLocality}, ${placemarks.first.locality}, ${placemarks.first.administrativeArea}, ${placemarks.first.postalCode}, ${placemarks.first.country}";


            fullAddresss = [
                      placemarks.first.street,
                      placemarks.first.subLocality,
                      placemarks.first.locality,
                      placemarks.first.administrativeArea,
                      placemarks.first.postalCode,
                      placemarks.first.country
                    ].where((part) => part != null && part.isNotEmpty).join(', ');


         notifyListeners();


        // _position = newLocalData;
        // R
        //
        //emove previous marker if it exists

        _markers.removeWhere((marker) => marker.markerId == const MarkerId('current_location'));
        // Add a custom marker at the current location
        _markers.add(
          Marker(
            markerId: const MarkerId('current_location'),
            position: LatLng(newLocalData.latitude, newLocalData.longitude),
            visible: true,
            icon: await getDotMarker(),
          ),
        );

        _currentlat = _markers.first.position.latitude;
        _currentlong = _markers.first.position.longitude;
        notifyListeners();

      } else {

      List<Placemark> placemarks = await placemarkFromCoordinates(newLocalData.latitude, newLocalData.longitude);
         
         
        _address = placemarks.first;

      //  fullAddresss =  "${placemarks.first.street}, ${placemarks.first.subLocality}, ${placemarks.first.locality}, ${placemarks.first.administrativeArea}, ${placemarks.first.postalCode}, ${placemarks.first.country}";


            fullAddresss = [
                      placemarks.first.street,
                      placemarks.first.subLocality,
                      placemarks.first.locality,
                      placemarks.first.administrativeArea,
                      placemarks.first.postalCode,
                      placemarks.first.country
                    ].where((part) => part != null && part.isNotEmpty).join(', ');



        _markers.removeWhere((marker) => marker.markerId == const MarkerId('current_location'));

          // Add a custom marker at the current location
          _markers.add(
            Marker(
              markerId: const MarkerId('current_location'),
              position: LatLng(newLocalData.latitude, newLocalData.longitude),
              visible: true,
              icon: await getDotMarker(),
            ),
          );

        _position = newLocalData;
        notifyListeners();
      }

      


    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    } catch (e) {
      debugPrint("An error occurred: $e");
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }






  // Update position on location marker

  void updatePosition(CameraPosition position)  {

        _position = Position(
          latitude: position.target.latitude,
          longitude: position.target.longitude,
          timestamp: DateTime.now(),
          heading:       1,
          accuracy:      1,
          altitude:      1,
          speedAccuracy: 1,
          speed: 1,
          altitudeAccuracy: 1,
          headingAccuracy: 1,
        );

    // _loading = true;
    // notifyListeners();

  }



void updateMarker({latitude,longitude}) async{


  _markers.removeWhere((marker) => marker.markerId == const MarkerId('current_location'));
        // Add a custom marker at the current location
        _markers.add(
          Marker(
            markerId: const MarkerId('current_location'),
            position: LatLng(latitude, longitude),
            visible: true,
            icon: await getDotMarker(),
          ),
        );

}


 void onCameraMove(CameraPosition cameraPosition ) {
     cameraPositionm = cameraPosition.target;
  }

  // Update address based on new position
  Future<void> dragableAddress() async {
    _loading = true;
    notifyListeners();
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(_position.latitude, _position.longitude);
      _address = placemarks.first;


   
            fullAddresss = [
                      placemarks.first.street,
                      placemarks.first.subLocality,
                      placemarks.first.locality,
                      placemarks.first.administrativeArea,
                      placemarks.first.postalCode,
                      placemarks.first.country
                    ].where((part) => part != null && part.isNotEmpty).join(', ');

              

      notifyListeners();

    } catch (e) {

      debugPrint("An error occurred: $e");

    }
    _loading = false;
    notifyListeners();
  }




  Future<void> updateAddressLocation({latitude ,longitude}) async {
    _loading = true;
    notifyListeners();
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      _address      = placemarks.first;
      //  fullAddresss =  "${placemarks.first.street}, ${placemarks.first.subLocality}, ${placemarks.first.locality}, ${placemarks.first.administrativeArea}, ${placemarks.first.postalCode}, ${placemarks.first.country}";
       fullAddresss = [
                      placemarks.first.street,
                      placemarks.first.subLocality,
                      placemarks.first.locality,
                      placemarks.first.administrativeArea,
                      placemarks.first.postalCode,
                      placemarks.first.country
                    ].where((part) => part != null && part.isNotEmpty).join(', ');

              notifyListeners();

    } catch (e) {

      debugPrint("An error occurred: $e");

    }
    _loading = false;
    notifyListeners();
  }



  void clearAddress() {
    _address = const Placemark();
    notifyListeners();
  }


  void moveCameraToCurrentLocation({mapcontroller,latlng}) {

    if (mapcontroller != null && latlng != null) {
      LatLng target = LatLng(latlng!.latitude!, latlng!.longitude!);

      mapcontroller!.animateCamera(CameraUpdate.newCameraPosition(

        CameraPosition(target: target, zoom: 18.0), // Zoom out
      ));

      // Future.delayed(Duration(milliseconds: 500), () {
      //   mapcontroller!.animateCamera(CameraUpdate.newCameraPosition(
      //     CameraPosition(target: target, zoom: 18.0), // Zoom back in
      //   ));
      // });

      
    }

  }













}
