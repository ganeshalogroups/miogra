// ignore_for_file: must_be_immutable
import 'package:testing/Features/Foodmodule/getFoodCartProvider.dart';
import 'package:testing/Features/Homepage/AddressController/Addresscontroller.dart';
import 'package:testing/Meat/Common/Searchshopcontroller.dart';
import 'package:testing/Meat/Common/addmeatLocation.dart';
import 'package:testing/Meat/MeatButtonFunctionalities/MeatAddproductController.dart/AddmeatController.dart';
import 'package:testing/Meat/MeatButtonFunctionalities/TotalitemcountButton.dart';
import 'package:testing/map_provider/Map%20Screens/markervaluse.dart';
import 'package:testing/map_provider/locationprovider.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/localvaluesmanagement.dart';
import 'package:testing/utils/CustomDottedline.dart';
import 'package:testing/utils/Toast/customtoastmessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class Addmeataddress extends StatefulWidget {
  dynamic totalDis;
  dynamic shopid;
  Addmeataddress({this.totalDis,
  required this.shopid,super.key});

  @override
  State<Addmeataddress> createState() => _AddmeataddressState();
}

class _AddmeataddressState extends State<Addmeataddress> {
  AddressController addresscontroller = Get.put(AddressController());
  final MeatAddcontroller meatcart   = Get.put(MeatAddcontroller());
  MeatButtonController  buttonController  = MeatButtonController();
  List<dynamic>     shops       = [];
  @override
  Widget build(BuildContext context) {
    var searchresProvider = Provider.of<SearchShop>(context,listen: false);
    var mapProvider       = Provider.of<MapDataProvider>(context,listen: false);
    var locationProvider  = Provider.of<LocationProvider>(context,listen: false);
    
     return CustomContainer(

      // decoration: CustomContainerDecoration.whitecontainerdecoration(),
      // height: MediaQuery.of(context).size.height / 1.7,


      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


       
                Padding(
                   padding: const EdgeInsets.all(15),
                      child: InkWell(
                         onTap: () {
                
                              if (addresscontroller.getaddressdetails == null || addresscontroller.getaddressdetails["data"]["AdminUserList"].isEmpty) {


                                  Navigator.pop(context);
                                  Get.to(AddMeatAddressScreen(isFromCartScreen: true,  shopId: widget.shopid), transition: Transition.rightToLeft);
                                 
                                  
                              } else {
                
                                // if (addresscontroller.getaddressdetails["data"]["AdminUserList"].length > 9) {

                                        
                                //     AppUtils.showToast('You have already added 10 Address  ');

                
                                // } else {

                                  Navigator.pop(context);
                                  Get.to(AddMeatAddressScreen(isFromCartScreen: true,shopId: widget.shopid),transition: Transition.rightToLeft);
                                        
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
                          Text(
                            "Add Address",
                             style: CustomTextStyle.decorationORANGEtext22
                          ),
                        ],
                      ),
                    ),
                  ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Select an address",
                style: CustomTextStyle.smallboldblack,
              ),
            ),



            const CustomSizedBox(height: 10),
            Obx(() {


              if (addresscontroller.getaddressLoading.isTrue) {


                return const Center(child: CupertinoActivityIndicator());


              } else if (addresscontroller.getaddressdetails == null) {


                return const Center(child: Text('No Data Available. Please add Address.'));
                 
              } else if (addresscontroller.getaddressdetails["data"]["AdminUserList"].isEmpty) {
                  
                return const Center(child: Text("No data Available!"));

              } else {
                return ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: addresscontroller.getaddressdetails["data"]["AdminUserList"].length,
                      
                  itemBuilder: (context, index) {


                    var addresstype = addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["addressType"];
                        
                          
                    return InkWell(


          
                        onTap: () async {

                                context.loaderOverlay.show();

                                String currentPostalCode  = addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["postalCode"];             
                                String currentAddressType = addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["addressType"];            
                                var currentLatitude       = addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["latitude"];               
                                var currentLongitude      = addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["longitude"];              
                                var fullAddress           = addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["fullAddress"].toString();  
                                var state                 = addresscontroller.getaddressdetails['data']["AdminUserList"][index]["state"];
                                var houseNo               = addresscontroller.getaddressdetails['data']["AdminUserList"][index]["houseNo"];
                                var landmark              = addresscontroller.getaddressdetails['data']["AdminUserList"][index]["landMark"];
                                var locality              = addresscontroller.getaddressdetails['data']["AdminUserList"][index]["locality"];
                                var street                = addresscontroller.getaddressdetails['data']["AdminUserList"][index]["street"];
                                var otherinstructions     =  addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["instructions"];
                                                                
                                List<dynamic> datttta = await searchresProvider.searchShopbyshopId(shopId: widget.shopid, latitude: currentLatitude, longitude: currentLongitude);

                                      setState(() {
                                        shops =  datttta;
                                      });
                                  if(shops.isEmpty){

                                      AppUtils.showToast('This cart shop does not service your area. Please try a different location');
                                      Future.delayed(Duration.zero,() {
                                        context.loaderOverlay.hide();
                                      },);

                                  }else{


                                  mapProvider.updateMapData(
                                  addresstype : currentAddressType,
                                  statee      : state,
                                  contactpersionNo: mobilenumb,
                                  contacypersion: username,
                                  fulladdres  : fullAddress,
                                  houseno     : houseNo,
                                  landmark    : landmark,
                                  localiti    : locality,
                                  postalcode  : currentPostalCode,
                                  streett     : street,
                                  latitude    : currentLatitude,
                                  longitude   : currentLongitude,
                                  otheristructions: otherinstructions

                                ).then((value) {


                                    Provider.of<FoodCartProvider>(context,listen: false).searchShop(shopId: widget.shopid).then((value){

                                      AppUtils.showToast('Address Changed');
                                      locationProvider.updateMarker(latitude: currentLatitude,longitude: currentLongitude);
                                      Get.back();
                                      context.loaderOverlay.hide();
                                      
                                  }
                                );
                              }
                            );
                          }


                              addresscontroller.updateaddressapi(addressid:addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["_id"]);
                                                      

                          },




                      child: Column(
                                         
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                  addresstype == 'Home'
                                      ? homeicon
                                      : addresstype == 'Other'
                                          ? othersicon : workicon, height: 20,width: 20,color:  Color(0xFF623089),),
                                         
                                         
                                        
                                  
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                      
                                  Text(addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["addressType"],
                                    style: CustomTextStyle.blackbold14,
                                   
                                  ),
                                  CustomSizedBox(height: 4.h),
                                  SizedBox(
                                    width: 280.w,
                                    child: Text(
                                      "${addresstype == 'Other' ? '${addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["instructions"].toString()} ,' : ''}${addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["landMark"]} , ${addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["houseNo"]} , ${addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["fullAddress"]}.",
                                      style: CustomTextStyle.mapgrey12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const CustomSizedBox(height: 10),
                          const CustomDottedContainer(),
                        ],
                      ),
                    );
                  },
                );
              }
            }),



                const SizedBox(height: 10),

    
              ],
            ),
          ),
        );
     
  }
}
