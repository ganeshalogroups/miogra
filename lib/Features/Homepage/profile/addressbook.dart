// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:testing/Features/Homepage/AddressController/Addresscontroller.dart';
import 'package:testing/map_provider/Map%20Screens/MapSearch.dart/homeadresskey.dart';
import 'package:testing/map_provider/Map%20Screens/markervaluse.dart';
import 'package:testing/Features/Homepage/profile/editmapscreen.dart';
import 'package:testing/Features/Homepage/profile/profilestyles.dart';
import 'package:testing/utils/Buttons/CustomAlertDialoug.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/Const/localvaluesmanagement.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import '../../../map_provider/Map Screens/addLocation.dart';




class AddressbookScreen extends StatefulWidget {
  const AddressbookScreen({super.key});

  @override
  State<AddressbookScreen> createState() => _AddressbookScreenState();
}

class _AddressbookScreenState extends State<AddressbookScreen> {


  
  AddressController addresscontroller = Get.put(AddressController());
  HomeadresskeyController homeaddresskey =Get.put(HomeadresskeyController());
  @override
  void initState() {
   WidgetsBinding.instance.addPostFrameCallback((_) {
     addresscontroller.getaddressapi(context: context,latitude: "",longitude: "");
      addresscontroller.getprimaryaddressapi();
   });
    super.initState();
  }


  var local;

    forrefresh() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        addresscontroller.getaddressapi(context: context,latitude: "",longitude: "");
        addresscontroller.getprimaryaddressapi();
      });
    }




@override
  void dispose() {

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {


    var mapDataProvider      =  Provider.of<MapDataProvider>(context, listen: false);


    return Scaffold(
     backgroundColor: Customcolors.DECORATION_CONTAINERGREY,
      // backgroundColor: Color(0xffFAFAFA),
      appBar: AppBar(
       backgroundColor: Customcolors.DECORATION_CONTAINERGREY,
        title: const Text(
          'Address Book',
          style: CustomTextStyle.googlebuttontext,
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
       color: Customcolors.darkpurple,
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
             onRefresh: () async {
                await Future.delayed(const Duration(seconds: 2), () {
                  return forrefresh();
                },
              );
            },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row(
                //   children: [
                //     Expanded(child: Divider()),
                //     SizedBox(width: 10),
                //     Text('Favourites', style: ProfileStyles().savedAddress),
                //     SizedBox(width: 10),
                //     Expanded(child: Divider()),
                //   ],
                // ),
                // SizedBox(height: 15),
                Obx(() {

                  if (addresscontroller.getaddressLoading.isTrue) {

                    return const Center( child: CupertinoActivityIndicator() );
                     
                   
                  } else if (addresscontroller.getaddressdetails == null) {


                    return Center(child: Text('No Address Available, Please add Address. ',style:  ProfileStyles() .addressstyle));
                        
                  } else if (addresscontroller.getaddressdetails["data"]["AdminUserList"].isEmpty) {
          
                    return Center(child: Text("No Address Available !",style:  ProfileStyles() .addressstyle));
                      
                 
                  } else {
                    return AnimationLimiter(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(height: 10),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: addresscontroller.getaddressdetails["data"]["AdminUserList"].length,
                            
                        itemBuilder: (context, index) {
          
                            var addressType  = addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["addressType"];
                            double editLat   = addresscontroller.getaddressdetails["data"] ["AdminUserList"][index]["latitude"];         
                            double editlong  = addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["longitude"];
                            String addressId = addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["_id"];
          
            
                          
          
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 750),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: GestureDetector(
                                  onTap: () {
          
                                    // addresscontroller.updateaddressapi(
                                    //     addressid: addresscontroller
                                    //                 .getaddressdetails[
                                    //             "data"]["AdminUserList"][index]["_id"]);
          
          
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                       boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 4),
                        blurRadius: 1,
                      ),
                    ],
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                       
                             Image.asset(addressType == 'Home'? homeicon : addressType == 'Other'? othersicon : workicon,height: 25,width: 25,color:  Color(0xFF623089), ),
          
                                        const SizedBox(width: 8),
          
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
          
          
                                            Text("${addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["addressType"]}", style: ProfileStyles().addressType),
                                               
          
                                                
                                            CustomSizedBox(
                                              height: 4.h,
                                            ),
                                           addressType == 'Other' ? SizedBox(
                                              width: 250.w,
                                              child:RichText(
                                              text:  TextSpan(
                                  children:  [
                                    const TextSpan(text: "Reciever Info",style: CustomTextStyle.black12),
                                    const TextSpan(text: " : ",style: CustomTextStyle.black12),
                                  TextSpan(text:addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["instructions"].toString(),style: ProfileStyles().addressstyle)
                                  ],
                                ),)
                                                      
                                            ):const SizedBox.shrink(),
                                           addressType == 'Other' ?  CustomSizedBox(
                                              height: 4.h,
                                            ):const SizedBox.shrink(),
                                            SizedBox(
                                              width: 250.w,
                                              child: Text(
                                                  "${addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["houseNo"].toString()} , ${addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["landMark"].toString()}, ${addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["fullAddress"].toString()}.",
                                                  style: ProfileStyles().addressstyle),
                                                      
                                            ),
                                            CustomSizedBox(
                                              height: 4.h,
                                            ),
                                            Text(
                                              '${addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["contactPersonNumber"]}',
                                              style: ProfileStyles().phonenumberstyle,
                                            ),

                                            CustomSizedBox(height: 5.h),
                                            
                                            Row(
                                              children: [

                                                InkWell(

                                                    onTap: () {
          


                                                                print('=========c s======== ${addresscontroller.getprimaryaddressdetails}=');



                                                            



                                                    if(addresscontroller.getprimaryaddressdetails !=null ){

                                                                var selectedAddressID       =  addresscontroller.getprimaryaddressdetails['data']['AdminUserList'].first['_id'];
                                                                var choosedAddressID        =  addresscontroller.getaddressdetails["data"]["AdminUserList"][index]['_id'];
                                                                String currentPostalCode    =  addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["postalCode"];
                                                                double currentlatitude      =  double.parse(addresscontroller.getaddressdetails['data']["AdminUserList"][index]["latitude"].toString());
                                                                double currentlongitude     =  double.parse(addresscontroller.getaddressdetails['data']["AdminUserList"][index]["longitude"].toString());
                                                                var fulladd                 =  addresscontroller.getaddressdetails['data']["AdminUserList"][index]["fullAddress"].toString();
                                                                var state                   =  addresscontroller.getaddressdetails['data']["AdminUserList"][index]["state"];
                                                                var houseNo                 =  addresscontroller.getaddressdetails['data']["AdminUserList"][index]["houseNo"];
                                                                var landmarkk               =  addresscontroller.getaddressdetails['data']["AdminUserList"][index]["landMark"];
                                                                var localitiy               =  addresscontroller.getaddressdetails['data']["AdminUserList"][index]["locality"];
                                                                var street                  =  addresscontroller.getaddressdetails['data']["AdminUserList"][index]["street"];
                                                                var contactPersionNumber    =  addresscontroller.getaddressdetails['data']["AdminUserList"][index]["contactPersonNumber"];
                                                                var otherinstructions        =addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["instructions"];
                                                                    

                                                            showDialog(context: context, builder: (context)  {
                                                                    
                                                                      return CustomLogoutDialog(title: 'Alert !!', content: 'Do You Want to Delete This Address ?', onConfirm: () {


                                                                            if(selectedAddressID == choosedAddressID) {

                                                                                        mapDataProvider.updateMapData(
                                                                                        addresstype     : 'Current',
                                                                                        fulladdres       : fulladd,
                                                                                        localiti         : localitiy,
                                                                                        houseno          : houseNo,
                                                                                        contactpersionNo : contactPersionNumber,
                                                                                        contacypersion   : username.toString(),
                                                                                        landmark         : landmarkk,
                                                                                        postalcode       : currentPostalCode,
                                                                                        statee           : state,
                                                                                        streett          : street,
                                                                                        latitude         : currentlatitude,
                                                                                        longitude        : currentlongitude,
                                                                                        otheristructions : otherinstructions
                                                                                        );
                            
                            
                                                                                }else{

                                                                                  // AppUtils.showToast('This is Not That  Selected Address.. !');


                                                                                }





                                                                                      HapticFeedback.vibrate();
                                                                                                                    
                                                                                    addresscontroller.deleteaddressapi(addressid: addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["_id"],context: context).whenComplete(() {
                                                                                   addresscontroller.getaddressapi(context: context,latitude: "",longitude: "");
                                                                                    addresscontroller.getprimaryaddressapi();
                                                                                    Get.back();    

                                                                                    });



                                                                             
                                  


                                  
                                                                        }, 
                                                                        buttonname: 'Delete', oncancel: () { Navigator.pop(context); },);
                                                        
                                                        
                                                                      },
                                                  );








                                  
                                }else{







                                                               var choosedAddressID        =  addresscontroller.getaddressdetails["data"]["AdminUserList"][index]['_id'];
                                                                String currentPostalCode    =  addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["postalCode"];
                                                                double currentlatitude      =  double.parse(addresscontroller.getaddressdetails['data']["AdminUserList"][index]["latitude"].toString());
                                                                double currentlongitude     =  double.parse(addresscontroller.getaddressdetails['data']["AdminUserList"][index]["longitude"].toString());
                                                                var fulladd                 =  addresscontroller.getaddressdetails['data']["AdminUserList"][index]["fullAddress"].toString();
                                                                var state                   =  addresscontroller.getaddressdetails['data']["AdminUserList"][index]["state"];
                                                                var houseNo                 =  addresscontroller.getaddressdetails['data']["AdminUserList"][index]["houseNo"];
                                                                var landmarkk               =  addresscontroller.getaddressdetails['data']["AdminUserList"][index]["landMark"];
                                                                var localitiy               =  addresscontroller.getaddressdetails['data']["AdminUserList"][index]["locality"];
                                                                var street                  =  addresscontroller.getaddressdetails['data']["AdminUserList"][index]["street"];
                                                                var contactPersionNumber    =  addresscontroller.getaddressdetails['data']["AdminUserList"][index]["contactPersonNumber"];
                                                                var otherinstructions       =  addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["instructions"];
                                                                    

                                                            showDialog(context: context, builder: (context)  {
                                                                    
                                                                      return CustomLogoutDialog(title: 'Alert !!', content: 'Do You Want to Delete This Address ?', onConfirm: () {


                                                                            // if(selectedAddressID == choosedAddressID) {

                                                                                  
                            
                                                                            //     }else{

                                                                            //       AppUtils.showToast('This is Not That  Selected Address.. !');


                                                                            //     }

                                                                                      mapDataProvider.updateMapData(
                                                                                        addresstype     : 'Current',
                                                                                        fulladdres       : fulladd,
                                                                                        localiti         : localitiy,
                                                                                        houseno          : houseNo,
                                                                                        contactpersionNo : contactPersionNumber,
                                                                                        contacypersion   : username.toString(),
                                                                                        landmark         : landmarkk,
                                                                                        postalcode       : currentPostalCode,
                                                                                        statee           : state,
                                                                                        streett          : street,
                                                                                        latitude         : currentlatitude,
                                                                                        longitude        : currentlongitude,
                                                                                        otheristructions : otherinstructions
                                                                                        );



                                                                                      HapticFeedback.vibrate();
                                                                                                                    
                                                                                    addresscontroller.deleteaddressapi(addressid: addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["_id"],context: context).whenComplete(() {
                                                                                    addresscontroller.getaddressapi(context: context,latitude: "",longitude: "");
                                                                                    addresscontroller.getprimaryaddressapi();
                                                                                    Get.back();    

                                                                                    });



                                                                             
                                  


                                  
                                                                        }, 
                                                                        buttonname: 'Delete', oncancel: () { Navigator.pop(context); },);
                                                        
                                                        
                                                                      },
                                                  );









                                }

                                                       


                              
          
                                                   


          
                                                    },
                                                    child:Icon(MdiIcons.deleteOutline,
                                                    color: Customcolors.darkpurple,

                                                   // color: Colors.red,
                                                    )
                                                    //  Image.asset(
                                                    //     'assets/images/Trash_light.png',
                                                    //     height: 28,
                                                    //     scale: 1.3)
                                                        
                                                        ),
                                                const SizedBox(width: 10),
                                                InkWell(
                                                    onTap: () {

print('=============acad==============');
                                                 print('${addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["contactPerson"]}');

                                                      HapticFeedback.vibrate();
          
                                                      local ='';
                                                      local = addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["locality"];
                                                                              
                                                      Get.to(
                                                          EditLocationMapScreen(
                                                            persionName: addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["contactPerson"],
                                                            housenumber: addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["houseNo"] ,
                                                            landmark: addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["landMark"] ,
                                                            mobilenumber: addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["contactPersonNumber"] ,
                                                            fullAddress: addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["fullAddress"],
                                                            typefield: addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["instructions"],
                                                            lattitude: editLat,
                                                            longitude: editlong,
                                                            addressId: addressId,
                                                            locality    : local,
                                                            addresstype : addresscontroller.getaddressdetails["data"]["AdminUserList"][index]["addressType"].toString()),
                                                            transition  : Transition.downToUp,
                                                            duration    : const Duration(milliseconds:350));
                                                             
                                                                  
                                                    },
                                                    child: Image.asset(
                                                      editpencilIcon,
                                                      scale: 3,
                                                      color: Colors.black,
                                                    )),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
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
                const SizedBox(height: 15),
                InkWell(
                  onTap: () {
          
                    Get.to(AddAddressScreen(isAddresAddFromEditScreen: true,),transition: Transition.downToUp,duration: const Duration(milliseconds: 350));

                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/images/Add_square_light@3x.png', scale: 2.8,color:  Color(0xFF623089),),
                      const SizedBox(width: 10),
                      Text("Add Address",style: ProfileStyles().addaddressstyle),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
