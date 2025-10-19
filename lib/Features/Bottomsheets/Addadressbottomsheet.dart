

// ignore_for_file: file_names

import 'package:testing/Features/Foodmodule/getFoodCartProvider.dart';
import 'package:testing/Features/Homepage/profile/profilestyles.dart';
import 'package:testing/Features/OrderScreen/OrderScreenController/resturantIdController.dart';
import 'package:testing/map_provider/Map%20Screens/addLocation.dart';
import 'package:testing/map_provider/Map%20Screens/markervaluse.dart';
import 'package:testing/map_provider/locationprovider.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/localvaluesmanagement.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Toast/customtoastmessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Addfoodcontroller.dart';
import 'package:testing/Features/Foodmodule/Foodviewscreen/AddButtonFunctions/Buttonfunctionalities.dart';
import 'package:testing/Features/Homepage/AddressController/Addresscontroller.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/CustomDottedline.dart';

// ignore: must_be_immutable
class Addcartaddress extends StatefulWidget {
  dynamic totalDis;
  dynamic restaurantId;
  dynamic addresserror;
  dynamic appconfigkm;
  bool isFromCartScreen;
  Addcartaddress({this.totalDis, this.restaurantId, this.addresserror,this.appconfigkm,super.key,    this.isFromCartScreen = false,});


  @override
  State<Addcartaddress> createState() => _AddcartaddressState();
}



class _AddcartaddressState extends State<Addcartaddress> {

  AddressController addresscontroller = Get.put(AddressController());
  final Foodcartcontroller foodcart   = Get.put(Foodcartcontroller());
  ButtonController  buttonController  = ButtonController();
  List<dynamic>     restaurants       = [];


@override
void dispose() {
  if (context.loaderOverlay.visible) {
    context.loaderOverlay.hide();
  }
  super.dispose();
}


  @override
  Widget build(BuildContext context) {

    var searchresProvider = Provider.of<SearchResturant>(context,listen: false);
    var mapProvider       = Provider.of<MapDataProvider>(context,listen: false);
    var locationProvider  = Provider.of<LocationProvider>(context,listen: false);
    // final foodcartprovider  = Provider.of<FoodCartProvider>(context);


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
                                  Get.to(AddAddressScreen(isFromCartScreen: true,  resturantId: widget.restaurantId), transition: Transition.rightToLeft);
                                 
                                  
                              }
                               else {
                
                                // if (addresscontroller.getaddressdetails["data"]["AdminUserList"].length > 9) {

                                        
                                //     AppUtils.showToast('You have already added 10 Address  ');

                
                                // }
                                //  else {

                                  Navigator.pop(context);
                                  Get.to(AddAddressScreen(isFromCartScreen: true,resturantId: widget.restaurantId),transition: Transition.rightToLeft);
                                        
                            // }
                          }
                      },

                      child: Row(
                        children:  [
                          const Icon(
                            Icons.add,
                            //color: Color.fromARGB(255, 249, 131, 34),
                            color: Customcolors.darkpurple,

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


                return const Center(child: Text('No Address Available. Please add one!',style: CustomTextStyle.chipgrey,));
                 
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


          
//                         onTap: () async {
// if (!mounted) return; // Safe check


//   try {
//     // context.loaderOverlay.show();
//     AppLoader.show(context);
//     var address = addresscontroller.getaddressdetails["data"]["AdminUserList"][index];

//     String currentPostalCode = address["postalCode"];
//     String currentAddressType = address["addressType"];
//     var currentLatitude = address["latitude"];
//     var currentLongitude = address["longitude"];
//     var fullAddress = address["fullAddress"].toString();
//     var state = address["state"];
//     var houseNo = address["houseNo"];
//     var landmark = address["landMark"];
//     var locality = address["locality"];
//     var street = address["street"];
// final totalDis = double.tryParse(widget.totalDis.toString().replaceAll(',', ''));
// final appConfigKm = double.tryParse(widget.appconfigkm.toString().replaceAll(',', ''));

// print("dummy Distance:${totalDis}");
// print("App config distance:${appConfigKm}");


//     List<dynamic> datttta = await searchresProvider.searchResById(
//       restaurantId: widget.restaurantId,
//       latitude: currentLatitude,
//       longitude: currentLongitude,
//     );

//     if (!mounted) return;

//     setState(() {
//       restaurants = datttta;
//     });

//     if (restaurants.isEmpty) {
//       AppUtils.showToast('This restaurant is not available at the selected location.');
//     }else if (totalDis != null && appConfigKm != null && totalDis > appConfigKm) {
//      AppUtils.showToast(widget.addresserror);
//      return;
//      }else {
//       await mapProvider.updateMapData(
//         addresstype: currentAddressType,
//         statee: state,
//         contactpersionNo: mobilenumb,
//         contacypersion: username,
//         fulladdres: fullAddress,
//         houseno: houseNo,
//         landmark: landmark,
//         localiti: locality,
//         postalcode: currentPostalCode,
//         streett: street,
//         latitude: currentLatitude,
//         longitude: currentLongitude,
//       );

//       if (!mounted) return;

//       await Provider.of<FoodCartProvider>(context, listen: false).searchRes(
//         restaurantId: widget.restaurantId,
//       );

//       AppUtils.showToast('Address Changed');
//       locationProvider.updateMarker(
//         latitude: currentLatitude,
//         longitude: currentLongitude,
//       );
// WidgetsBinding.instance.addPostFrameCallback((_) {
//        Get.back();});
//     }

//     addresscontroller.updateaddressapi(addressid: address["_id"]);
//   } catch (e) {
//     print("Error in address tap: $e");
//     Get.snackbar("Erron", e.toString(),backgroundColor: Colors.red);
//   } finally {
//     if (mounted) AppLoader.hide(context);
//   }

//                               // addresscontroller.updateaddressapi(addressid:addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["_id"]);
                                                      

//                           },
onTap: () async {
  if (!mounted) return;

  try {
    AppLoader.show(context);
    var address = addresscontroller.getaddressdetails["data"]["AdminUserList"][index];

    // Extract new lat/lng from selected address
    String currentPostalCode = address["postalCode"];
    String currentAddressType = address["addressType"];
    var currentLatitude = address["latitude"];
    var currentLongitude = address["longitude"];
    var fullAddress = address["fullAddress"].toString();
    var state = address["state"];
    var houseNo = address["houseNo"];
    var landmark = address["landMark"];
    var locality = address["locality"];
    var street = address["street"];
    var otherinstructions =  address["instructions"];
                                                                 

    // ✅ Step 1: Update new address in mapProvider
    await mapProvider.updateMapData(
      addresstype: currentAddressType,
      statee: state,
      contactpersionNo: mobilenumb,
      contacypersion: username,
      fulladdres: fullAddress,
      houseno: houseNo,
      landmark: landmark,
      localiti: locality,
      postalcode: currentPostalCode,
      streett: street,
      latitude: currentLatitude,
      longitude: currentLongitude,
      otheristructions: otherinstructions
    );

    // ✅ Step 2: Recalculate distance with updated lat/lng
    final foodcartProvider = Provider.of<FoodCartProvider>(context, listen: false);
    await foodcartProvider.searchRes(restaurantId: widget.restaurantId); // triggers new distance

    // ✅ Step 3: Now get fresh updated distance
    // final totalDis = foodcartProvider.totalDis;
    // final appConfigKm = widget.appconfigkm;
String? rawTotalDis = foodcartProvider.totalDis.toString();
String cleanedTotalDis = rawTotalDis?.replaceAll(RegExp(r'[^0-9.]'), '') ?? '';
double? totalDis = double.tryParse(cleanedTotalDis);

double? appConfigKm = double.tryParse(widget.appconfigkm.toString());

print("🔍 totalDis: $totalDis, appConfigKm: $appConfigKm");

if (totalDis != null && appConfigKm != null && totalDis > appConfigKm) {
  AppUtils.showToast(widget.addresserror);
  return;
}

    print("✅ Updated distance after dis update: $totalDis");
    print("✅ App config distance: $appConfigKm");

    // ✅ Step 4: Validate
    if (totalDis != null && appConfigKm != null && totalDis > appConfigKm) {
      AppUtils.showToast(widget.addresserror);
      return;
    }

    // ✅ Step 5: Check availability and update UI
    List<dynamic> datttta = await searchresProvider.searchResById(
      restaurantId: widget.restaurantId,
      latitude: currentLatitude,
      longitude: currentLongitude,
    );

    if (!mounted) return;
    setState(() => restaurants = datttta);

    if (restaurants.isEmpty) {
      AppUtils.showToast('This restaurant is not available at the selected location.');
    } else {
      AppUtils.showToast('Address Changed');
      locationProvider.updateMarker(
        latitude: currentLatitude,
        longitude: currentLongitude,
      );
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.back();
      });
    }

    // ✅ Final step: update selected address ID
    addresscontroller.updateaddressapi(addressid: address["_id"]);
  } catch (e) {
    print("❌ Error in address tap: $e");
    Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
  } finally {
    if (mounted) AppLoader.hide(context);
  }
}
,



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
                               widget.isFromCartScreen==true&&addresstype == 'Other' ? 
                                 SizedBox(
                                    width: 250.w,
                                   child:RichText(
                                   text:  TextSpan(
                                  children:  [
                                    const TextSpan(text: "Reciever Info",style: CustomTextStyle.black12),
                                    const TextSpan(text: " : ",style: CustomTextStyle.black12),
                                  TextSpan(text:addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["instructions"].toString(),style: ProfileStyles().addressstyle)
                                  ],
                                ),)):const SizedBox.shrink(),
                                 widget.isFromCartScreen==true&&addresstype == 'Other' ?  CustomSizedBox(height: 4.h):const SizedBox.shrink(),
                                  SizedBox(
                                    width: 280.w,
                                    child: Text(
                                      "${addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["houseNo"]} ,${addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["landMark"]} ,${addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["fullAddress"]}.",
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



class AppLoader {
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
