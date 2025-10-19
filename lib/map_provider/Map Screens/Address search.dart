// ignore_for_file: file_names, prefer_is_empty

import 'dart:convert';
import 'package:testing/Features/Authscreen/AuthController/controllerForFavAdd.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodhomepage.dart';
import 'package:testing/Features/Foodmodule/getFoodCartProvider.dart';
import 'package:testing/Features/Homepage/AddressController/Addresscontroller.dart';
import 'package:testing/map_provider/Map%20Screens/Pickupscreen.dart';
import 'package:testing/map_provider/Map%20Screens/addLocation.dart';
import 'package:testing/map_provider/Map%20Screens/markervaluse.dart';
import 'package:testing/Features/Homepage/homepage.dart';
import 'package:testing/Features/Homepage/profile/profilestyles.dart';
import 'package:testing/map_provider/location/locationServices/onlylocationpermission.dart';
import 'package:testing/map_provider/locationprovider.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Const/localvaluesmanagement.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'MapSearch.dart/apiKey.dart';
import 'package:http/http.dart' as http;



// ignore: must_be_immutable
class AddressSearchScreen extends StatefulWidget {

  dynamic addressType;
  dynamic houseno;
  dynamic locality;
  dynamic district;
  dynamic fullAddress;

  AddressSearchScreen({
      super.key,
      this.addressType,
      this.fullAddress,
      this.houseno,
      this.locality,
      this.district,
      });


  @override
  State<AddressSearchScreen> createState() => _AddressSearchScreenState();
}


class _AddressSearchScreenState extends State<AddressSearchScreen> {


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


    return Scaffold(
      backgroundColor: Customcolors.DECORATION_CONTAINERGREY,
      appBar: AppBar(
        title: const Row(
          children: [
            Text('Pick Up', style: CustomTextStyle.addresstitle),
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(

            onTap: () {
             // Get.to(const HomeScreenPage(),transition: Transition.leftToRight);
            },

            child:const Icon(Icons.arrow_back, color: Customcolors.DECORATION_BLACK)),
      ),




      body: SingleChildScrollView(
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
                         cursorRadius: const Radius.circular(5.0), 
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
                                      child: const Icon(Icons.close),
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
            isStartSearch
                ? SizedBox(
                    height: MediaQuery.of(context).size.height / 1,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _places.length,
                      itemBuilder: (context, index)  {


                        final place = _places[index]["description"];
                        final placeId =_places[index]["place_id"];

                    
                        return Padding(
                          padding: const EdgeInsets.all(15),
                          child: GestureDetector(
                            onTap: ()async {

                              await fetchPlaceDetails(placeId: placeId);
                      
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.location_on_outlined),
                                const SizedBox(width: 5,),
                                SizedBox(
                                  width: 280.w,
                                  child: Text(
                                    '$place',
                                    style: const TextStyle(
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
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Align the column to the start
                        
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white,),
                          child: InkWell(
                       
                       
                        // onTap: () {

                        // // context.loaderOverlay.show();
                        // AppadressLoader.show(context);

                        // // getCurrentLocation().whenComplete(() => Get.off(Foodscreen(),transition: Transition.upToDown));

                        // locationProvider.getCurrentLocation(context: context, isLocEnabled: false).then((value) {
                              
                            
                        // //  String fullAddress = "${locationProvider.address.street}, ${locationProvider.address.subLocality}, ${locationProvider.address.locality}, ${locationProvider.address.administrativeArea}, ${locationProvider.address.postalCode}, ${locationProvider.address.country}";



                        //   String fullAddress = [
                        //     locationProvider.address.street,
                        //     locationProvider.address.subLocality,
                        //     locationProvider.address.locality,
                        //     locationProvider.address.administrativeArea,
                        //     locationProvider.address.postalCode,
                        //     locationProvider.address.country
                        //   ].where((part) => part != null && part.isNotEmpty).join(', ');

                       

                      
                        //       mapDataProvider.updateMapData(
                        //             addresstype : 'Current',
                        //             statee      : locationProvider.address.subLocality,
                        //             contactpersionNo: mobilenumb,
                        //             contacypersion: username,
                        //             fulladdres : fullAddress,
                        //             houseno    : locationProvider.address.street,
                        //             landmark   : locationProvider.address.subLocality,
                        //             localiti   : locationProvider.address.locality,
                        //             postalcode : locationProvider.address.postalCode,
                        //             streett    : locationProvider.address.street,
                        //             latitude   : locationProvider.position.latitude,
                        //             longitude: locationProvider.position.longitude,
                        //           ).whenComplete(() {
                          
                        //         // context.loaderOverlay.hide();
                        //          AppadressLoader.hide(context);
                            
                        //     });
                        //   });
                        //             Provider.of<FoodCartProvider>(context,listen: false).getfoodcartProvider(km: 0 );
                        //             InitializeFavProvider().favInitiliteProvider(cntxtt: context);


                        //    },
     onTap: () async {
  bool permissionGranted = await OnlyLocationPermission.instance.checkAndRequestLocationPermission(context);

  if (permissionGranted) {
   AppadressLoader.show(context);
    locationProvider.getCurrentLocation(context: context, isLocEnabled: true).then((value) {
      // 🔁 your existing full address generation & updateMapData logic
      String fullAddress = [
        locationProvider.address.street,
        locationProvider.address.subLocality,
        locationProvider.address.locality,
        locationProvider.address.administrativeArea,
        locationProvider.address.postalCode,
        locationProvider.address.country
      ].where((part) => part != null && part.isNotEmpty).join(', ');

      mapDataProvider.updateMapData(
        addresstype: 'Current',
        statee: locationProvider.address.subLocality,
        contactpersionNo: mobilenumb,
        contacypersion: username,
        fulladdres: fullAddress,
        houseno: locationProvider.address.street,
        landmark: locationProvider.address.subLocality,
        localiti: locationProvider.address.locality,
        postalcode: locationProvider.address.postalCode,
        streett: locationProvider.address.street,
        latitude: locationProvider.position.latitude,
        longitude: locationProvider.position.longitude,
      ).whenComplete(() {
             AppadressLoader.hide(context);
      });
    });

    InitializeFavProvider().favInitiliteProvider(cntxtt: context);
  }
},

                            child: Column(
                              children: [

                                    
                                
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.gps_fixed,
                                      color:  Color(0xFF623089),
                                    ),
                                    SizedBox(width: 10,),
                                    Text(
                                      "Use Current Location",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:  Color(0xFF623089),
                                        fontSize: 16,
                                        fontFamily: 'Poppins-Regular',
                                      ),
                                    ),
                                  ],
                                ),
                            
                            
                                    SizedBox(height: 5.h),
                            
                                //  Text(context.watch<AddressNameController>().fullAddressModel ?? 'fw'),


                              Consumer<LocationProvider>(builder: (context, value, child) {
                                                    
                                                    if (value.isloading) {

                                        
                                       

                                        return const SizedBox();
                                      } else {
                                        return Padding(
                                          // padding: const EdgeInsets.symmetric(horizontal: 15),
                                          padding: const EdgeInsets.only(left: 25),
                                          child: Text(
                                              mapDataProvider.localAddressData['fullAddress'],
                                              style: CustomTextStyle.font12blackregular),
                                        );
                                      }
                                    }),

              
                            
                              ],
                            ),
                          ),
                        ),
                        
                          SizedBox(height: 20.h),


                          const Text(
                            "Address List",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: 'Poppins-Regular',
                            ),
                          ),


                        SizedBox(height: 5.h),
                        Obx(() {
                          if (addresscontroller.getaddressLoading.isTrue) {
                            return const Center(
                              child: CupertinoActivityIndicator(),
                            );
                          } else if (addresscontroller.getaddressdetails == null) {
                             
                            return const Center(child: Text('No Data Available Please add Address '));
                                
                                    
                          } else if (addresscontroller.getaddressdetails["data"]["AdminUserList"].isEmpty) {
                          
                            return const Center(
                              child: Text("No data Available !"),
                            );


                          } else {
                            return AnimationLimiter(
                              child: ListView.separated(
                                separatorBuilder: (context, index) =>const SizedBox(height: 10),
                                    
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: addresscontroller.getaddressdetails["data"]["AdminUserList"].length,
                                   
                                   
                                itemBuilder: (context, index) {
                                  var addresstype = addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["addressType"];
                                  // var postalcod =  addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["postalCode"];
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 750),
                                    child: SlideAnimation(
                                      verticalOffset: 50.0,
                                      child: FadeInAnimation(
                                        child: InkWell(
                                          onTap: () {
                                        
                                        
                                        
                                         selectedAddress = {
                                              "userType" : "consumer",
                                              "houseNo"  : addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["houseNo"].toString(),
                                              "locality" : addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["locality"].toString(),
                                              "landMark" : addresscontroller .getaddressdetails["data"]["AdminUserList"][index]["landMark"].toString(),
                                              "fullAddress": widget.fullAddress,
                                              "street"   : addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["street"].toString(),
                                              "city"     : addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["street"].toString(),
                                              "district" : addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["district"].toString(),
                                              "state"    : addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["state"].toString(),
                                              "country"  : addresscontroller.getaddressdetails["data"]["AdminUserList"][index] ["country"].toString(),
                                              "postalCode"   : addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["postalCode"].toString(),
                                              "contactType"  : addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["contactType"].toString(),
                                              "contactPerson": addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["contactPerson"].toString(),
                                              "contactPersonNumber": addresscontroller.getaddressdetails["data"]["AdminUserList"][index][ "contactPersonNumber"].toString(),
                                              "addressType"  : addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["addressType"].toString(), 
                                              "latitude"     : addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["latitude"].toString(),
                                              "longitude"    : addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["longitude"].toString(), 
                                              "type"         : "secondary"
                                            };
                                        
                                        
                                        
                                        
                                          setState(() {
                                        
                                          String  currentPostalCode  = addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["postalCode"];
                                          String  currentAddressType = addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["addressType"];
                                          double  currentlatitude    = addresscontroller.getaddressdetails['data']["AdminUserList"][index]["latitude"];
                                          double  currentlongitude   = addresscontroller.getaddressdetails['data']["AdminUserList"][index]["longitude"];
                                          var     fulladd            = addresscontroller.getaddressdetails['data']["AdminUserList"][index]["fullAddress"].toString();
                                                                        
                                        
                                      
                                          var state     =  addresscontroller.getaddressdetails['data']["AdminUserList"][index]["state"];
                                          var houseNo   =  addresscontroller.getaddressdetails['data']["AdminUserList"][index]["houseNo"];
                                          var landmarkk =  addresscontroller.getaddressdetails['data']["AdminUserList"][index]["landMark"];
                                          var localitiy =  addresscontroller.getaddressdetails['data']["AdminUserList"][index]["locality"];
                                          var street    =  addresscontroller.getaddressdetails['data']["AdminUserList"][index]["street"];
                                          var otherinstructions       =  addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["instructions"];
                                                                 
                                                                          
                                                                        

                                                                        
                                            mapDataProvider.updateMapData(
                                        
                                                        addresstype      :  currentAddressType,
                                                        statee           :  state, 
                                                        contactpersionNo :  mobilenumb,
                                                        contacypersion   :  username,
                                                        fulladdres       :  fulladd,
                                                        houseno          :  houseNo,
                                                        landmark         :  landmarkk,
                                                        localiti         :  localitiy,
                                                        postalcode       :  currentPostalCode,
                                                        streett          :  street,
                                                        latitude         :  currentlatitude,
                                                        longitude        :  currentlongitude,
                                                        otheristructions: otherinstructions
                                        
                                             );
                                        
                                        
                                           Provider.of<FoodCartProvider>(context,listen: false).getfoodcartProvider(km: 0 );

                  
                                                   
                                            addresscontroller.updateaddressapi(addressid: addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["_id"]);
                                            locationProvider.updateMarker(latitude: currentlatitude,longitude: currentlongitude );
                                            InitializeFavProvider().favInitiliteProvider(cntxtt: context);
                                        
                                        
                                                Get.off(const Foodscreen(fromPickupscreen: true,),transition: Transition.leftToRight);
                                        
                                            });
                                        
                                        
                                        
                                         
                                          },
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                        
                                            children: [
                                                                              
                                              Image.asset(addresstype == 'Home'? homeicon : addresstype == 'Other'? othersicon : workicon,  height: 25,width: 25,color:  Color(0xFF623089), ),
                                        
                                              const SizedBox(width: 8),
                                        
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["addressType"]}",
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      fontFamily:
                                                          'Poppins-Regular',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  
                                                  CustomSizedBox(height: 4.h),
                                                    
                                                  SizedBox(
                                                    width: 250.w,
                                                    child: Text(
                                                      "${addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["houseNo"].toString()} , ${addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["landMark"].toString()}, ${addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["fullAddress"].toString()}.",
                                                      style: ProfileStyles().listaddressstyle,
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                        }),
                        CustomSizedBox(
                          height: 10.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (addresscontroller.getaddressdetails == null || addresscontroller.getaddressdetails["data"]["AdminUserList"].isEmpty){

                             Get.to(AddAddressScreen(),transition: Transition.rightToLeft);
                            } else {
                              // if (addresscontroller.getaddressdetails["data"]["AdminUserList"].length >  9) {
                                     
                              
                              //   AppUtils.showToast('You have already added 10 Address ');
                                   
                              // } else {

                                    Get.to(AddAddressScreen(),transition: Transition.rightToLeft);
                              // }
                            }
                          },
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.add_box_outlined,
                                color:  Color(0xFF623089)
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Add Address",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'Poppins-Regular',
                                    color:  Color(0xFF623089)),
                              ),
                            ],
                          ),
                        ),
                        CustomSizedBox(
                          height: 10.h,
                        ),
                        const Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Color.fromRGBO(232, 230, 230, 1),
                                thickness: 2, // Adjust thickness as needed
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                "Recent Locations",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins-Regular',
                                  color: Color.fromARGB(255, 154, 154, 154),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Color.fromRGBO(232, 230, 230, 1),
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                        CustomSizedBox(
                          height: 10.h,
                        ),


                        
Obx(() {
  if (addresscontroller.getprimaryaddressLoading.isTrue) {
    return const Center(
      child: CupertinoActivityIndicator(),
    );
  } else if (addresscontroller.getprimaryaddressdetails == null) {
    return const SizedBox(
      height: 100,
      child: Center(
        child: Text(" no data available."),
      ),
    );
  } else if (addresscontroller.getprimaryaddressdetails["data"]["AdminUserList"] == null ||
             addresscontroller.getprimaryaddressdetails["data"]["AdminUserList"].isEmpty) {
    return const Center(
      child: Text("No data Available !"),
    );
  } else {
    return AnimationLimiter(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: addresscontroller.getprimaryaddressdetails["data"]["AdminUserList"].length,
        itemBuilder: (context, index) {
          var adminUserList = addresscontroller.getprimaryaddressdetails["data"]["AdminUserList"];
          var addressType = adminUserList[index]["addressType"];
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 1000),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Image.asset(addressType == 'Home'? homeicon : addressType == 'Other'? othersicon : workicon,height: 25,width: 25,color:  Color(0xFF623089),),
                
                    // Icon(
                    //   addressType == 'Home'
                    //       ? Icons.home_outlined
                    //       : addressType == 'Other'
                    //           ? Icons.business_outlined
                    //           : Icons.home_work_outlined,
                    //   color: Colors.red,
                    //   size: 24,
                    // ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$addressType",
                          style: ProfileStyles().addressType,
                        ),
                        CustomSizedBox(
                          height: 4.h,
                        ),
                        SizedBox(
                          width: 280.w,
                          child: Text(
                            "${adminUserList[index]["houseNo"]?.toString() ?? ''}, ${adminUserList[index]["landMark"]?.toString() ?? ''}, ${adminUserList[index]["fullAddress"]?.toString() ?? ''}",
                            style: ProfileStyles().addressstyle,
                          ),
                        ),
                        CustomSizedBox(
                          height: 4.h,
                        ),
                        Text(
                          '${adminUserList[index]["contactPersonNumber"] ?? ''}',
                          style: ProfileStyles().phonenumberstyle,
                        ),
                        CustomSizedBox(
                          height: 5.h,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}),

                     
                      ],
                    ),
                  ),
          ],
        ),
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






Future<void> fetchPlaceDetails({ placeId}) async {

      final url = Uri.parse('https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&key=$kGoogleApiKey');

      try {
        
        final response = await http.get(url);

        if (response.statusCode == 200) {

                var data = json.decode(response.body);

                final lat = data['result']['geometry']['location']['lat'];
                final lng = data['result']['geometry']['location']['lng'];

              Get.to(Locationpickupscreen(lang: lng,lat: lat),transition: Transition.leftToRight);


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

