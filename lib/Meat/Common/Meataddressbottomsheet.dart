// ignore_for_file: file_names

import 'package:testing/Features/Homepage/AddressController/Addresscontroller.dart';
import 'package:testing/Meat/Common/addmeatLocation.dart';
import 'package:testing/map_provider/Map%20Screens/markervaluse.dart';
import 'package:testing/Features/Homepage/profile/profilestyles.dart';
import 'package:testing/map_provider/locationprovider.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/localvaluesmanagement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

Future<dynamic> addressbottomsheet(BuildContext context) {


return     showModalBottomSheet(
           context        : context,
           isDismissible  : true,
           showDragHandle : true,
           enableDrag: true,
           builder: (context) =>  MeatAddressBottomsheet());


}

class MeatAddressBottomsheet extends StatefulWidget {
  const MeatAddressBottomsheet({super.key});

  @override
  State<MeatAddressBottomsheet> createState() => _MeatAddressBottomsheetState();
}

class _MeatAddressBottomsheetState extends State<MeatAddressBottomsheet> {
    AddressController addresscontroller  = Get.put(AddressController());
  @override
  Widget build(BuildContext context) {
    var locationProvider     =  Provider.of<LocationProvider>(context, listen: false);
    var mapDataProvider      =  Provider.of<MapDataProvider>(context, listen: false);

      return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 1.5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment :  CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: InkWell(
                      onTap: () {
        
        
        
        
                        locationProvider.getCurrentLocation(context: context, isLocEnabled: false).then((value) {
                            
                                
                        //  String fullAddress = "${locationProvider.address.street}, ${locationProvider.address.subLocality}, ${locationProvider.address.locality}, ${locationProvider.address.administrativeArea}, ${locationProvider.address.postalCode}, ${locationProvider.address.country}";
        
        
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
                              
                                    context.loaderOverlay.hide();
                                    Get.back();
                                });
                              });
        
                        //  InitializeFavProvider().favInitiliteProvider(cntxtt: context);
        
                                    // getCurrentLocation().whenComplete(() => Get.back());
        
        
                      },
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.gps_fixed,
                                color: Colors.red,
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),

                              Text(
                                "Use Current Location",
                                style: CustomTextStyle.smallboldblack
                              ),

                            ],
                          ),
        
                          SizedBox(height: 5.h),
        
                          //  Text(context.watch<AddressNameController>().fullAddressModel ?? 'fw'),
        
                          Consumer<LocationProvider>(
                            
                            builder: (context, value, child) {
                              
                            if (value.isloading) {

                              context.loaderOverlay.show();
        
                              return SizedBox();
                            } else {
                              return Padding(
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
                  SizedBox(height: 15),
                  Text("Favourites", style: CustomTextStyle.smallboldblack),
                  SizedBox(height: 5.h),
                  Obx(() {
                    if (addresscontroller.getaddressLoading.isTrue) {


                      return Center(child: CupertinoActivityIndicator());
                        
                    
                    } else if (addresscontroller.getaddressdetails == null) {
        
        
                      return Center( child: Text('No Data Available Please add Address '));
                         
        
                    } else if (addresscontroller.getaddressdetails["data"]["AdminUserList"].isEmpty) {
                        
                      return Center(child: Text("No data Available !"));

                    } else {

                      return ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(height: 10),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        itemCount: addresscontroller.getaddressdetails["data"]["AdminUserList"].length,
                            
                        itemBuilder: (context, index) {
        
                          var addresstype =  addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["addressType"];
                             
                          return InkWell(

                            onTap: () {
                              setState(() {
        
                                String currentPostalCode  = addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["postalCode"];
                                String currentAddressType = addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["addressType"];
                                double currentlatitude    = double.parse(addresscontroller.getaddressdetails['data']["AdminUserList"][index]["latitude"].toString());
                                double currentlongitude   = double.parse(addresscontroller.getaddressdetails['data']["AdminUserList"][index]["longitude"].toString());
                                    
                                            
        
                                var fulladd   =  addresscontroller.getaddressdetails['data']["AdminUserList"][index]["fullAddress"].toString();
                                var state     =  addresscontroller.getaddressdetails['data']["AdminUserList"][index]["state"];
                                var houseNo   =  addresscontroller.getaddressdetails['data']["AdminUserList"][index]["houseNo"];
                                var landmarkk =  addresscontroller.getaddressdetails['data']["AdminUserList"][index]["landMark"];
                                var localitiy =  addresscontroller.getaddressdetails['data']["AdminUserList"][index]["locality"];
                                var street    =  addresscontroller.getaddressdetails['data']["AdminUserList"][index]["street"];
                                var otherinstructions     =  addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["instructions"];
                                   
                                        
        
        
                                          // Provider.of<LocalDataProvider>(context,listen: false).updateValues(
                                          //   postalCode: currentPostalCode,
                                          //   addressType: currentAddressType,
                                          //   latitude: currentlatitude,
                                          //   longitude: currentlongitude,
                                          //   fullAddress: fulladd,
                                          // );


                                    mapDataProvider.updateMapData(
                                            addresstype: currentAddressType,
                                            statee: state,
                                            contactpersionNo: mobilenumb,
                                            contacypersion: username,
                                            fulladdres: fulladd,
                                            houseno:  houseNo,
                                            landmark: landmarkk,
                                            localiti: localitiy,
                                            postalcode: currentPostalCode,
                                            streett: street,
                                            latitude: currentlatitude,
                                            longitude: currentlongitude,
                                            otheristructions: otherinstructions
                                       );
        
                                // InitializeFavProvider().favInitiliteProvider(cntxtt: context);
                                addresscontroller.updateaddressapi(addressid:addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["_id"]);
                                locationProvider.updateMarker(latitude: currentlatitude,longitude: currentlongitude);
                                            
                              });
        
                              Navigator.pop(context);
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                    addresstype == 'Home'
                                        ? homeicon
                                        : addresstype == 'Other'
                                            ? othersicon
                                            : workicon,
                                    height: 20,width: 20),
                                SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text(
                                      "${addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["addressType"]}",
                                       style: CustomTextStyle.blackbold14
                                    ),

                                    CustomSizedBox(height: 4.h),
                                     
                                    SizedBox(
                                      width: 280.w,
                                      child: Text(
                                        "${addresstype == 'Other' ? '${addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["instructions"].toString()}, ' : ''}${addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["landMark"].toString()} , ${addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["houseNo"].toString()} , ${addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["fullAddress"].toString()}.",
                                        style: CustomTextStyle.blackB12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  }),
        
                  CustomSizedBox(height: 10.h),
                   
                  
                  InkWell(
                    
                    onTap: () {
        
        
                      if (addresscontroller.getaddressdetails == null || addresscontroller.getaddressdetails["data"]["AdminUserList"].isEmpty) {
                          


                        Navigator.pop(context);
                        Get.to(AddMeatAddressScreen(),transition: Transition.rightToLeft);
        
        
                      } else {
        
                        // if (addresscontroller.getaddressdetails["data"]["AdminUserList"].length > 9) {
                                
                        //   AppUtils.showToast('You have already added 10 Address ');
        
                        // } else {
        
                          Navigator.pop(context);
                          Get.to(AddMeatAddressScreen(),transition: Transition.rightToLeft);
                              
                        // }
                      }
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.add_box_outlined,
                          color: Color.fromARGB(255, 249, 131, 34),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Add Address",
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Poppins-Regular',
                              color: Color.fromARGB(255, 249, 131, 34)),
                        ),
                      ],
                    ),
                  ),
                  CustomSizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: const [
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
                      return Center(
                        child: CupertinoActivityIndicator(),
                      );
                    } else if (addresscontroller.getprimaryaddressdetails == null) {
                      return SizedBox(
                        height: 100,
                        child: Center(
                          child: Text(" no data available."),
                        ),
                      );
                    } else if (addresscontroller.getprimaryaddressdetails["data"]
                                ["AdminUserList"] ==
                            null ||
                        addresscontroller
                            .getprimaryaddressdetails["data"]["AdminUserList"]
                            .isEmpty) {
                      return Center(
                        child: Text("No data Available !"),
                      );
                    } else {
                      return AnimationLimiter(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: addresscontroller.getprimaryaddressdetails["data"]["AdminUserList"].length,
                              
                          itemBuilder: (context, index) {
                            var adminUserList = addresscontroller
                                .getprimaryaddressdetails["data"]["AdminUserList"];
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
                                      Image.asset(
                                          addressType == 'Home'
                                              ? homeicon
                                              : addressType == 'Other'
                                                  ? othersicon
                                                  : workicon, 
                                                    height : 20,
                                                    width  : 20
                                         ),

                                          SizedBox(width: 8),

                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "$addressType",
                                            style: CustomTextStyle.blackbold14,
                                          ),
                                          CustomSizedBox(
                                            height: 4.h,
                                          ),

                                            SizedBox(
                                      width: 280.w,
                                      child: Text(
                                        "${addressType == 'Other' ? '${addresscontroller.getprimaryaddressdetails["data"]["AdminUserList"][index]["instructions"].toString()}, ' : ''}${addresscontroller.getprimaryaddressdetails["data"]["AdminUserList"][index]["landMark"].toString()} , ${addresscontroller.getprimaryaddressdetails["data"]["AdminUserList"][index]["houseNo"].toString()} , ${addresscontroller.getprimaryaddressdetails["data"]["AdminUserList"][index]["fullAddress"].toString()}.",
                                        style: CustomTextStyle.grey12lite,
                                      ),
                                    ),
                                          CustomSizedBox(height: 4.h),

                                          Text(
                                            '+91 ${adminUserList[index]["contactPersonNumber"] ?? ''}',
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
                  }
                ),
        
        
                ],
              ),
            ),
          ),
        ),
         ],
    );
 
  }
}
