// ignore_for_file: must_be_immutable, file_names

import 'package:testing/Features/Foodmodule/SubAdmincontroller/Getnearbyrescontroller.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/Getrestaurantcontroller.dart';
import 'package:testing/Features/Homepage/AddressController/Addresscontroller.dart';
import 'package:testing/common/CommonlocationAdd.dart';
import 'package:testing/map_provider/Map%20Screens/markervaluse.dart';
import 'package:testing/parcel/p_services_provider/p_Round_Trip_Validation.dart';
import 'package:testing/parcel/p_services_provider/p_address_provider.dart';
import 'package:testing/parcel/p_services_provider/p_regon_provider.dart';
import 'package:testing/parcel/p_services_provider/p_validation_errorProvider.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomDottedline.dart';
import 'package:testing/utils/Toast/customtoastmessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';






class CommonAddressSheet extends StatefulWidget {

    bool ispickupAddress;
    bool isDropAddress;
    bool isFromOrderPickupLocation;
    bool isFromOrderDropLocation;
    bool isFromSingleTrip;

   CommonAddressSheet({
    super.key, 
    this.isDropAddress             = false, 
    this.ispickupAddress           = false,
    this.isFromOrderDropLocation   = false,
    this.isFromOrderPickupLocation = false,
    required this.isFromSingleTrip,
    });

  @override
  State<CommonAddressSheet> createState() => _CommonAddressSheetState();
}



class _CommonAddressSheetState extends State<CommonAddressSheet> {


  AddressController addresscontroller  = Get.put(AddressController());
  Restaurantcontroller  restaurantget  = Get.put(Restaurantcontroller());
  Nearbyrescontroller     nearbyreget  = Get.put(Nearbyrescontroller());


  String?   selectvalue;
  Position? currentPosition;



  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((_) {
        
         addresscontroller.getaddressapi(context: context,latitude: "",longitude: "");
    });

      super.initState();
  }



  @override
  Widget build(BuildContext context) {


     final  picdropProvider     =  Provider.of<ParcelAddressProvider>(context);  
     final  roundTripProvider   =  Provider.of<RoundTripLOcatDataProvider>(context);    
     final  validationProvider  =  Provider.of<ValidationErrorProvider>(context);
     final  regonProvider       =  Provider.of<ParcelRegonProvider>(context);
 
    // AddressController

    return Stack(
      children: [

        SizedBox(
          height: MediaQuery.of(context).size.height / 1.5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment :  CrossAxisAlignment.start,
                  children: [


                    const Text("Favourites",style: CustomTextStyle.smallboldblack),
                    SizedBox(height: 10.h),


                    GetBuilder<AddressController>(builder:  (controller) {
                      
                        if (controller.getaddressLoading.isTrue) {

                            return const Center(child:  CupertinoActivityIndicator());

                          } else if (controller.getaddressdetails == null) {

                            return const Center( child: Text('No Data Available Please add Address '));

                          } else if (controller.getaddressdetails["data"]["AdminUserList"].isEmpty) {

                            return const Center(child: Text("No data Available !"));

                          } else {   

                            return ListView.separated(
                                  separatorBuilder: (context, index) => Column(
                                      children:  [
                                        10.toHeight,
                                        const CustomDottedContainer(),
                                        10.toHeight,
                                      ],
                                  ),

                            shrinkWrap  : true,
                            physics     : const NeverScrollableScrollPhysics(),
                            itemCount   : controller.getaddressdetails["data"]["AdminUserList"].length,
                            itemBuilder : (context, index) {
                            var addresstype  =  controller.getaddressdetails["data"]["AdminUserList"][index]["addressType"];



                            return InkWell(

                              onTap: ()  {


                                setState(() {

                                  String currentPostalCode  =  controller.getaddressdetails["data"]["AdminUserList"][index]["postalCode"]??"";
                                  String currentAddressType =  controller.getaddressdetails["data"]["AdminUserList"][index]["addressType"];                        
                                  double currentlatitude    =  double.parse(controller.getaddressdetails['data']["AdminUserList"][index]["latitude"].toString());   
                                  double currentlongitude   =  double.parse(controller.getaddressdetails['data']["AdminUserList"][index]["longitude"].toString());                                        
                                  var state                 =  controller.getaddressdetails['data']["AdminUserList"][index]["state"];
                                  var houseNo               =  controller.getaddressdetails['data']["AdminUserList"][index]["houseNo"]??"";
                                  var landmarkk             =  controller.getaddressdetails['data']["AdminUserList"][index]["landMark"]??"";
                                  var localitiy             =  controller.getaddressdetails['data']["AdminUserList"][index]["locality"];
                                  var street                =  controller.getaddressdetails['data']["AdminUserList"][index]["street"]??"";
                                  var addressid             =  controller.getaddressdetails['data']["AdminUserList"][index]['_id'];
                                  var fullAddRess           =  "${addresstype == 'Other' ? '${controller.getaddressdetails["data"]["AdminUserList"][index]["instructions"].toString()}, ' : ''}${controller.getaddressdetails["data"]["AdminUserList"][index]["landMark"].toString()} , ${controller.getaddressdetails["data"]["AdminUserList"][index]["houseNo"].toString()} , ${controller.getaddressdetails["data"]["AdminUserList"][index]["fullAddress"].toString()}.";
                                  var contactPersionName    =  controller.getaddressdetails['data']["AdminUserList"][index]['contactPerson'];
                                  var contactPersonNumber   =  controller.getaddressdetails['data']["AdminUserList"][index]['contactPersonNumber']; 




                            if(widget.isFromSingleTrip){

                                  if(widget.ispickupAddress) {

                                    regonProvider.getRegonApi(pincode: currentPostalCode).then((value) async {

                                    bool checck = await regonProvider.checkregonData(postcode: currentPostalCode);

                              if(checck){

                              WidgetsBinding.instance.addPostFrameCallback((_) async {  
                                
                                              Address pickupAddress = Address(
                                                      name                : username,
                                                      addressType         : currentAddressType,
                                                      contactPerson       : contactPersionName,
                                                      contactPersonNumber : contactPersonNumber,
                                                      country             : 'India',
                                                      fullAddress         : fullAddRess,
                                                      houseNo             : houseNo,
                                                      landMark            : landmarkk,
                                                      latitude            : currentlatitude,
                                                      locality            : localitiy,
                                                      longitude           : currentlongitude,
                                                      postalCode          : currentPostalCode,
                                                      state               : state,
                                                      street              : street,
                                                      userType            : 'consumer',
                                                      addressId           :  addressid,
                                                     );


                                                picdropProvider.onlyClearAddress().then((value) {
                                                    picdropProvider.addAddressList(locationData: pickupAddress,addressListType: 'pickUpLocation',addressid: addressid).then((value) {
                                                                validationProvider.addpicupError(pickupcontent: '');
                                                                 if(!picdropProvider.isDulpicate){
                                                                        Navigator.pop(context);
                                                                    }else{
                                                                        AppUtils.showToast('The Address Is Already Selected===>');
                                                                  }
                                                              });
                                                          });
                                                      }
                                                  );




                                                  }else{


                                                              AppUtils.showToast('You have selected an area outside the deliverable region.');



                                                                loge.i('No  It Does Not Hase PinzCode');


                                                            }



                                              });



             



                         
                                              } else {
                                              
                                              
                                              



                                    if(picdropProvider.addressMap.containsKey('pickUpLocation')){


                                      bool dropCheck =  regonProvider.checkregonData(postcode: currentPostalCode);




                                  if(dropCheck){




                                                    WidgetsBinding.instance.addPostFrameCallback((_) async {  
                                          
                                                            Address pickupAddress = Address(
                                                                    name: username,
                                                                    addressType: currentAddressType,
                                                                    contactPerson: contactPersionName,
                                                                    contactPersonNumber: contactPersonNumber,
                                                                    country: 'India',
                                                                    fullAddress: fullAddRess,
                                                                    houseNo: houseNo,
                                                                    landMark: landmarkk,
                                                                    latitude: currentlatitude,
                                                                    locality: localitiy,
                                                                    longitude: currentlongitude,
                                                                    postalCode: currentPostalCode,
                                                                    state         : state,
                                                                    street        : street,
                                                                    userType      : 'consumer',
                                                                    addressId     :  addressid,
                                                                    );
                                                            


                                                                  picdropProvider.addAddressList(locationData: pickupAddress,addressListType: 'dropLocation', addressid: addressid).then((value) {
                                                                  validationProvider.adddropError(dropcontent: '');


                                                                  if(!picdropProvider.isDulpicate){

                                                                    Navigator.pop(context);

                                                                  }else{

                                                                    AppUtils.showToast('The Address Is Already Selected===>');
                                                                    
                                                                  }
                                                                }
                                                             );
                                                           }
                                                         );



                                                          } else {

                                                                AppUtils.showToast('You have selected an area outside the deliverable region.');

                                                          }



                                                      } else {


                                                              Navigator.pop(context);
                                                              AppUtils.showToast('please Fill Pickup Address First');


                                                    }

                                                }







                  
                } else {








                                  if(widget.ispickupAddress) {




                                    regonProvider.getRegonApi(pincode: currentPostalCode).then((value) async {


                                    bool checck = await regonProvider.checkregonData(postcode: currentPostalCode);



                          if(checck){





                            WidgetsBinding.instance.addPostFrameCallback((_) async {  
                                
                                              Address pickupAddress = Address(
                                                      name                : username,
                                                      addressType         : currentAddressType,
                                                      contactPerson       : contactPersionName,
                                                      contactPersonNumber : contactPersonNumber,
                                                      country             : 'India',
                                                      fullAddress         : fullAddRess,
                                                      houseNo             : houseNo,
                                                      landMark            : landmarkk,
                                                      latitude            : currentlatitude,
                                                      locality            : localitiy,
                                                      longitude           : currentlongitude,
                                                      postalCode          : currentPostalCode,
                                                      state               : state,
                                                      street              : street,
                                                      userType            : 'consumer',
                                                      addressId           :  addressid,
                                                     );


                                                roundTripProvider.onlyClearAddress().then((value) {

                                                    roundTripProvider.addAddressList(locationData: pickupAddress,addressListType: 'pickUpLocation',addressid: addressid).then((value) {
                                                           
                                                                validationProvider.addpicupError(pickupcontent: '');

                                                                 if(!roundTripProvider.isDulpicate){

                                                                        Navigator.pop(context);

                                                                    }else{

                                                                        AppUtils.showToast('The Address Is Already Selected===>');

                                                                  }
                                                              });
                                                          });
                                                      }
                                                  );

                                        
                                             } else {


                                                              AppUtils.showToast('You have selected an area outside the deliverable region.');
                                                                loge.i('No  It Does Not Hase PinzCode');


                                                            }
                                                            
                                              });



            


                                 } else {
                                              
                                              
                                              

                                if(roundTripProvider.addressMap.containsKey('pickUpLocation')){


                                  bool dropCheck =  regonProvider.checkregonData(postcode: currentPostalCode);




                                  if(dropCheck){




                                                    WidgetsBinding.instance.addPostFrameCallback((_) async {  
                                          
                                                            Address pickupAddress = Address(
                                                                    name          : username,
                                                                    addressType   : currentAddressType,
                                                                    contactPerson : contactPersionName,
                                                                    contactPersonNumber: contactPersonNumber,
                                                                    country       : 'India',
                                                                    fullAddress   : fullAddRess,
                                                                    houseNo       : houseNo,
                                                                    landMark      : landmarkk,
                                                                    latitude      : currentlatitude,
                                                                    locality      : localitiy,
                                                                    longitude     : currentlongitude,
                                                                    postalCode    : currentPostalCode,
                                                                    state         : state,
                                                                    street        : street,
                                                                    userType      : 'consumer',
                                                                    addressId     :  addressid,
                                                                    );
                                                            


                                                                  roundTripProvider.addAddressList(locationData: pickupAddress,addressListType: 'dropLocation', addressid: addressid).then((value) {
                                                                  validationProvider.adddropError(dropcontent: '');


                                                                  if(!roundTripProvider.isDulpicate){

                                                                    Navigator.pop(context);

                                                                  }else{

                                                                    AppUtils.showToast('The Address Is Already Selected===>');
                                                                    
                                                                  }

                                                              }
                                                          );
                                                        }
                                                      );



                                                          }else{


                                                                AppUtils.showToast('You have selected an area outside the deliverable region.');

                                                          }

                                                    }else{


                                                                Navigator.pop(context);
                                                              AppUtils.showToast('please Fill Pickup Address First');


                                                    }



                                                                  }








}

                          

                                
                                      
                                                          loge.i('Yes It Hase PinzCode');


                                                        //  });





                                                      }
                                                    );

                                              },


                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                      addresstype == 'Home'
                                          ? homeicon
                                          : addresstype == 'Other'  ? othersicon  : workicon, height: 20,width: 20),
                                            
                                            
                                  
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Text("${addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["addressType"]}",style: CustomTextStyle.blackbold14),

                                      CustomSizedBox(height: 4.h),
                                      
                                      SizedBox(
                                        width: 280.w,
                                        child: Text(
                                          "${addresstype == 'Other' ? '${addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["instructions"].toString()}, ' : ''}${addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["landMark"].toString()} , ${addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["houseNo"].toString()} , ${addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["fullAddress"].toString()}.",
                                          style: CustomTextStyle.darkgrey12,
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
                    },
                  ),


                    CustomSizedBox(height: 10.h),
                    const CustomDottedContainer(),

                    InkWell(
                      
                      onTap: () {
          
          
                        if (addresscontroller.getaddressdetails == null || addresscontroller.getaddressdetails["data"]["AdminUserList"].isEmpty) {
                            
                          // Navigator.pop(context);
                          Get.to(CommonAddAddress(),transition: Transition.rightToLeft);

          
                        } else {
          
                          // if (addresscontroller.getaddressdetails["data"]["AdminUserList"].length > 9) {

                          //   AppUtils.showToast('You have already added 10 Address ');
          
                          // } else {


                            // Get.to(CommonAddAddress(),transition: Transition.rightToLeft);

                            Navigator.push(context,MaterialPageRoute(builder: (context) => CommonAddAddress() ));

                          // }
                        }
                      },

                      child: Row(
                        children:  [
                          const Icon(
                            Icons.add,
                            color: Color.fromARGB(255, 249, 131, 34),
                          ),
                          const SizedBox(width: 8),
                          Text( "Add Address",
                            style: CustomTextStyle.decorationORANGEtext22
                          ),
                        ],
                      ),
                    ),

                    20.toHeight,

                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
