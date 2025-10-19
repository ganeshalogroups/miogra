
import 'dart:io';
import 'package:testing/Features/Homepage/profile/imageUploader.dart';
import 'package:testing/common/chipWidget.dart';
import 'package:testing/common/commonRedButton.dart';
import 'package:testing/common/commonloadingWidget.dart';
import 'package:testing/common/comonAddressSheet.dart';
import 'package:testing/common/curverTExtFieldContainer.dart';
import 'package:testing/common/customSvgImage.dart';
import 'package:testing/common/custom_richText.dart';
import 'package:testing/common/textFormFieldCurved.dart';
import 'package:testing/parcel/p_services_provider/p_createParcel_Provider.dart';
import 'package:testing/parcel/p_services_provider/p_distance_provider.dart';
import 'package:testing/parcel/p_services_provider/p_validation_errorProvider.dart';
import 'package:testing/parcel/parcel_controllers/chip_controller.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Decorations/boxDecoration.dart';
import 'package:testing/utils/Toast/customtoastmessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'p_services_provider/p_Round_Trip_Validation.dart';
import 'parcel_order_screen.dart';
import 'singelTrip.dart';



class RoundTripScreen extends StatefulWidget {
  const RoundTripScreen({super.key});

  @override
  State<RoundTripScreen> createState() => _RoundTripScreenState();
}



class _RoundTripScreenState extends State<RoundTripScreen> {


  final formKey = GlobalKey<FormState>();
  RoundTripChipController chicontroller    = Get.put(RoundTripChipController());
  TextEditingController textTypeController = TextEditingController();

    String pickuplocation = '';
    String droplocation = '';


                                    
      bool isclicked   = false;   
      bool isOthers    = false;      
      bool isUploading = false;

      File?  image;


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
     chicontroller.chipGetFunction();
    Provider.of<CreatePArcelProvider>(context,listen: false).packageWeightContents(content: context);
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    final picdropProvider     = Provider.of<RoundTripLOcatDataProvider>(context);
    final validationProvider  = Provider.of<RoundValidationErrorProvider>(context);
    final packagecontentdata  = Provider.of<CreatePArcelProvider>(context);
    final distanceCal         = Provider.of<CommonDistanceGetClass>(context,listen: false);
    

    Size screenSize = MediaQuery.of(context).size;

    return PopScope(

        onPopInvoked: (didPop) {

            picdropProvider.clearAddressMapData();  

        },

      child: Scaffold(
      
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Container(
                  // height: screenSize.height / 4,
                  // decoration: BoxDecorationsFun.greyBoderDecoraton(),
             decoration:     BoxDecorationsFun.whiteCircelRadiusDecoration(radious: 10.0),
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Address Info', style: CustomTextStyle.darkgrey ),
                      20.toHeight,
                      Consumer<RoundTripLOcatDataProvider>(
      
                        builder: (context, value, child) {
      
                          // Check if addressMap is null or empty or doesn't contain the 'pickUpLocation' key
                          if ( value.addressMap.isEmpty ||  !value.addressMap.containsKey('pickUpLocation') ?? true) {


                            return TextFieldContainers(
                                   locationType: 'Pickup Location',
                                   onTap: () {

                                     showModalBottomSheet(
                                       context: context,
                                       isDismissible: true,
                                       showDragHandle: true,
                                       enableDrag: true,
                                       builder: (context) =>  CommonAddressSheet(ispickupAddress: true,isFromSingleTrip: false),     
                                    );
                                    
          
                                  },
                                );
      
      
      
                          } else {


                             parcelpick = LatLng(value.addressMap['pickUpLocation']!.latitude, value.addressMap['pickUpLocation']!.longitude);


                              // loge.i('Its From The pickup[]  $parcelpick 2');

      
                              return TextFieldContainers(
                                locationType: 'Pickup Location',
                                fontstyle: CustomTextStyle.black14,
                                ithaveAddress: true,
                                fullAddress: value.addressMap['pickUpLocation']?.fullAddress,
                                onTap: () {

                                  showModalBottomSheet(
                                    context: context,
                                    isDismissible: true,
                                    showDragHandle: true,
                                    enableDrag: true,
                                    builder: (context) => CommonAddressSheet(ispickupAddress: true,isFromSingleTrip: false),
                                       
                                  ).then((value) {


                                  parceldrop = LatLng(value.addressMap['pickUpLocation']!.latitude, value.addressMap['pickUpLocation']!.longitude);


                                  });
                                },
                              );
      
      
      
                          }
                        },
                      ),
      
      
      
                      5.toHeight,
                      Text(validationProvider.pickuperror,style: CustomTextStyle.red12),
                      15.toHeight,
      

                      Consumer<RoundTripLOcatDataProvider>(

                        builder: (context, value, child) {

                          // Check if addressMap is null, empty, or missing 'dropLocation' key
                          if ( value.addressMap.isEmpty || !value.addressMap.containsKey('dropLocation') ??  true) {
                                  
                            
                                  return  TextFieldContainers(
                                          locationType: 'Drop Location',
                                          onTap: () {

                                            showModalBottomSheet(
                                              context: context,
                                              isDismissible: true,
                                              showDragHandle: true,
                                              enableDrag: true,
                                              builder: (context) => CommonAddressSheet(isDropAddress: true,isFromSingleTrip: false),
                                            ).then((fvfv) {



                                      // parceldrop = LatLng(value.addressMap['dropLocation']!.latitude, value.addressMap['dropLocation']!.longitude);



                                              if (value.addressMap['dropLocation'] != null) {
                                                parceldrop = LatLng(
                                                  value.addressMap['dropLocation']!.latitude,
                                                  value.addressMap['dropLocation']!.longitude,
                                                );
                                              } else {
                                                // Handle the null case here, e.g., setting parceldrop to a default location or showing an error
                                                print('Drop location is null');
                                                // parceldrop = LatLng(0.0, 0.0); // Or some default location
                                              }



                                            });
                                          },
                                        );
      
      
                          } else {



                  
                                    // loge.i('Its From The parceldrop[]  $parceldrop 2');

      
      
                              return TextFieldContainers(
                                      locationType: 'Drop Location',
                                      ithaveAddress: true,
                                      fullAddress: value.addressMap['dropLocation']?.fullAddress,
                                      fontstyle: CustomTextStyle.black14,
                                      onTap: () {

                                              showModalBottomSheet(
                                                context       : context,
                                                isDismissible : true,
                                                showDragHandle: true,
                                                enableDrag    : true,
                                                builder       : (context) => CommonAddressSheet(isDropAddress: true,isFromSingleTrip: false),

                                                ).then((fvfv) {

                                                  parceldrop = LatLng(value.addressMap['dropLocation']!.latitude, value.addressMap['dropLocation']!.longitude);


                                               }
                                            );
                                           },
                                        );
                                      }
                                    },
                                  ),

                                  5.toHeight,
                                  Text(validationProvider.droperror,style: CustomTextStyle.red12),


                   // 15.toHeight,
                    // Consumer<RoundTripLOcatDataProvider>(
      
                    //     builder: (context, value, child) {
      
                    //       // Check if addressMap is null or empty or doesn't contain the 'pickUpLocation' key
                    //       if ( value.addressMap.isEmpty ||  !value.addressMap.containsKey('pickUpLocation') ?? true) {





          
      
                    //         return TextFieldContainers(
                    //                locationType: 'Drop Location 2'
                                   
                    //             );
      
      
      
                    //       } else {


                    //         parcelpick = LatLng(value.addressMap['pickUpLocation']!.latitude, value.addressMap['pickUpLocation']!.longitude);


             


                    //           // loge.i('Its From The pickup[]  $parcelpick 2');

      
                    //           return TextFieldContainers(
                    //             locationType: 'Drop Location 2',
                    //             fontstyle: CustomTextStyle.black14,
                    //             ithaveAddress: true,
                    //             fullAddress: value.addressMap['pickUpLocation']?.fullAddress,
                    //             onTap: () {

        
                    //             },
                    //           );
                    //         }
                    //       },
                    //     ),
                    ],
                  ),
                ),
      
                20.toHeight,
                
                Container(
                  width: screenSize.width / 1,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.white),
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                        CustomRichText(fieldName: 'Package content'),
                        20.toHeight,
      
                        Obx(() {

                            if (chicontroller.isLoading.isTrue) {
      
                              return const Center(child:  CupertinoActivityIndicator());
      
                            } else if (chicontroller.chipData == null || chicontroller.chipData.isEmpty) {
                              
                              return const Text('No Data Available');
                              
                            } else {
                    
      
                              Map<String, List<String>> mapofCat = {};
      
                              for (int index = 0; index < chicontroller.chipData['data'].length; index++) {
      
                                String name   =  chicontroller.chipData['data'][index]['name'];
                                String imgUrl =  chicontroller.chipData['data'][index]['imgUrl'];
                                  
                                // If the name is already a key in mapofCat, add the imgUrl to the existing list
                                if (mapofCat.containsKey(name)) {
                                  mapofCat[name]?.add(imgUrl);
                                } else {
                                  // If the name is not already a key, create a new list with the imgUrl
                                  mapofCat[name] = [imgUrl];
                                }
      
                
                              }
      
      
                          return ChipSelector(
                                 mapofCat: mapofCat,
                                 isRound: true,
                                 onChipTapped: (value) {
      
  
                                if (value == null) {

                                      picdropProvider.addPackageContent(content: null);
                                      picdropProvider.addPackageWeight(weight: null);
                                      validationProvider.addContentError(content: 'Please select Package Type');
      
                                      setState(() {
                                        isOthers = false;
                                      });
      
      
                                } else {   
      
      
                                  if (value == 'Others') {
      
                                    picdropProvider.addPackageContent(content: value);
                                    packagecontentdata.packageWeightContents(content: value);

                                    setState(() {
                                      isOthers = true;
                                    });
      
    
                                  } else {
      
                                    picdropProvider.addPackageContent(content: value);
                                    packagecontentdata.packageWeightContents(content: value);
                                    setState(() {
                                      isOthers = false;
                                    });
      
                                  }
      
      
                                  validationProvider.addContentError(content: '');
      
                                  print('Selected  Lable is $value');
      
                                  }
                              },
                            );
                          }
                        }
                      ),
      
      
                      5.toHeight,
                      Text(validationProvider.contenterror,style: CustomTextStyle.red12),
      
      
                      isOthers ?
                       Form( 
                          key: formKey, 
                          child: CurvedTextFormField(typeController: textTypeController),
                          onChanged: () {

                    if (formKey.currentState != null) {
                    formKey.currentState!.validate();
                  }
                            picdropProvider.addOtherType(oterWhat:  textTypeController.text.toString() );
                         
                            
      
                        },
                      )  : const SizedBox.shrink(),
                       
                     
                      20.toHeight,
      
      
                      TextFieldContainers(
                        locationType  : 'Package Weight',
                        ithaveAddress : picdropProvider.packageWeight != null,
                        isNeedIcon    : true,
                        fullAddress   : picdropProvider.packagefinalWeight.toString(),
                        fontstyle     : CustomTextStyle.black14,
                        onTap: () {


                             showModalBottomSheet(
                                showDragHandle: true,
                                context: context,
                                builder: (context) {
                                  return weightMeasurementSheet(context: context, weightOptions: packagecontentdata.meshurmentMapDatas);
                                },
                              );

                          },
                        ),

                        5.toHeight,
                        Text(validationProvider.weighterror,style: const TextStyle(color: Colors.red,fontSize: 12)),
                        20.toHeight,
      
                        isUploading ? const CupertinoActivityIndicator() : Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [


                          // InkWell(
                          //   onTap: () {
                          
                          //       pickImage(context: context);
                          
                          //   },
                          //   child: Container(
                          //     height: 40,
                          //     width: screenSize.width / 1.8,
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(10),
                          //       border: Border.all(color: Colors.grey),
                          //     ),


                          //     child: Row(
                          //       children: [
      
      
                          //           picdropProvider.packageImageUrl == null ? SvgPicture.asset(
                          //                   'assets/parcel_images/gallerry.svg',
                          //                   height : 30, 
                          //                   width  : 30,
                          //                 )  :  IconButton(
      
                          //                     onPressed: () {
      
                          //                     picdropProvider.addPackageImage(imageUrl: null).then((value) => AppUtils.showToast('Image Cleared Successfully.'));
      
                          //                   }, icon: Icon(Icons.close)),
                                    
                          //         Text(
                          //           picdropProvider.packageImageUrl == null ?  'Upload Package Image' :  replaceFileName(url: picdropProvider.packageImageUrl.toString()),
                          //           style: CustomTextStyle.hinttextstyl,
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // ),



                            Container(
                            height:picdropProvider.packageImageUrl != null ? 40 : 50,
                            width: screenSize.width / 1.7,
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            decoration: BoxDecorationsFun.greyBoderDecoraton(),
                            child: picdropProvider.packageImageUrl != null ? 
                            

                             InkWell(
                          
                                onTap: () =>  picdropProvider.addPackageImage(imageUrl: null).then((value) => AppUtils.showToast('Image Cleared Successfully.')),
                          
                              child: Row(
                                children: [
                                    
                                  const Icon(Icons.close),
                                     
                                   Text(
                                     replaceFileName(url: picdropProvider.packageImageUrl.toString()),
                                     style: CustomTextStyle.hinttextstyl,
                                   ),
                                ],
                              ),

                            )  :  InkWell(
                          
                          
                              onTap: () => pickImage(context: context),

                              child: Row(
                                    children: [

                                      CustomSvgAsset.customSvgAsset(svgImage: galleryIconSvg),

                                      Flexible(child: CustomRichText(fieldName: 'Upload Package Image' ))
                                       
                                     
                                      
                                    ],
                                  ),
                            ),
                          ),
                        ],
                      ),
      



      
                      5.toHeight,
                      Text(validationProvider.imageerror,style: const TextStyle(color: Colors.red,fontSize: 12)),
                      20.toHeight,
      
              !packagecontentdata.isLoading ? 
              
              
              ReusableRedButton(
                
                buttonName: 'Continue',
                ontap: () {
                


                    if (picdropProvider.addressMap.isNotEmpty  &&  (picdropProvider.packagecontent != null || picdropProvider.packagecontent == 'Others') &&  ( formKey.currentState==null || formKey.currentState!.validate() ) &&  validatesingleTrip() ) {

 
                                          validatePackageDetails();


                                        Map<String, dynamic>  dropAddress  =  createAddressDetails(
                                                              name         : username,
                                                              city         : "", 
                                                              contactPerson: picdropProvider.addressMap['dropLocation']!.contactPerson, 
                                                              contactPersonNumber: picdropProvider.addressMap['dropLocation']!.contactPersonNumber, 
                                                              country      : country, 
                                                              delivered    : false, 
                                                              fullAddress  : picdropProvider.addressMap['dropLocation']!.fullAddress, 
                                                              houseNo      : picdropProvider.addressMap['dropLocation']!.houseNo, 
                                                              locality     : picdropProvider.addressMap['dropLocation']!.locality, 
                                                              addressType  : picdropProvider.addressMap['dropLocation']!.addressType, 
                                                              contactType  : contactType, 
                                                              district     : null, 
                                                              landMark     : picdropProvider.addressMap['dropLocation']!.landMark, 
                                                              latitude     : picdropProvider.addressMap['dropLocation']!.latitude, 
                                                              longitude    : picdropProvider.addressMap['dropLocation']!.longitude, 
                                                              postalCode   : picdropProvider.addressMap['dropLocation']!.postalCode, 
                                                              state        : picdropProvider.addressMap['dropLocation']!.state, 
                                                              street       : picdropProvider.addressMap['dropLocation']!.street, 
                                                              userType     : picdropProvider.addressMap['dropLocation']!.userType,
                                                              addressId    : picdropProvider.addressMap['dropLocation']!.addressId,
                                                            );
      
      
      
                                          Map<String, dynamic>  pickupAddress  =  createAddressDetails(
                                                                  name         : username,
                                                                  city         : "", 
                                                                  contactPerson: picdropProvider.addressMap['pickUpLocation']!.contactPerson, 
                                                                  contactPersonNumber: picdropProvider.addressMap['pickUpLocation']!.contactPersonNumber, 
                                                                  country      : country, 
                                                                  delivered    : false, 
                                                                  fullAddress  : picdropProvider.addressMap['pickUpLocation']!.fullAddress, 
                                                                  houseNo      : picdropProvider.addressMap['pickUpLocation']!.houseNo, 
                                                                  locality     : picdropProvider.addressMap['pickUpLocation']!.locality, 
                                                                  addressType  : picdropProvider.addressMap['pickUpLocation']!.addressType, 
                                                                  contactType  : contactType, 
                                                                  district     : null, 
                                                                  landMark     : picdropProvider.addressMap['pickUpLocation']!.landMark, 
                                                                  latitude     : picdropProvider.addressMap['pickUpLocation']!.latitude, 
                                                                  longitude    : picdropProvider.addressMap['pickUpLocation']!.longitude, 
                                                                  postalCode   : picdropProvider.addressMap['pickUpLocation']!.postalCode, 
                                                                  state        : picdropProvider.addressMap['pickUpLocation']!.state, 
                                                                  street       : picdropProvider.addressMap['pickUpLocation']!.street, 
                                                                  userType     : picdropProvider.addressMap['pickUpLocation']!.userType,
                                                                  addressId    : picdropProvider.addressMap['pickUpLocation']!.addressId,
                                                                );
      
      
                                                              print('==========fmfm=============');
                                                              print(picdropProvider.basePrice); 
                                                              print(picdropProvider.otherType?? '');
                                                              print(picdropProvider.packageImageUrl);
                                                              print(picdropProvider.packagecontent);
                                                              print(picdropProvider.unit);
                                                              print(picdropProvider.packageWeight);


                                                        
                              distanceCal.getDistance(orginlat: picdropProvider.addressMap['pickUpLocation']!.latitude, orginlang: picdropProvider.addressMap['pickUpLocation']!.longitude, destLat: picdropProvider.addressMap['dropLocation']!.latitude, destLng: picdropProvider.addressMap['dropLocation']!.longitude).then((value) async {


                                  Future.delayed(Duration.zero,() {

                                    print('==============ssfsfsfs=============');

                                    print('${distanceCal.finaldistance * 2} -  ${distanceCal.finaldistance.runtimeType}  ');

                      
                                            var finalcreateData = createParcelCaerData(
                                                            userId       : UserId,
                                                            basePrice    : picdropProvider.basePrice,
                                                            // km           : distanceCal.finaldistance,
                                                            km           : distanceCal.finaldistance * 2,
                                                            otherType    : picdropProvider.otherType ?? '',
                                                            packageImage : picdropProvider.packageImageUrl,
                                                            packageType  : picdropProvider.packagecontent,
                                                            unit         : picdropProvider.unit,
                                                            value        : picdropProvider.packageWeight,
                                                            dropDetails  : [dropAddress],
                                                            pickupDetails: [pickupAddress],
                                                          );  


                                                        print('${distanceCal.finaldistance * 2} -  ${distanceCal.finaldistance.runtimeType}  ');
                                                        
                                                        packagecontentdata.createParcelCart(cartdata: finalcreateData).then((value) {

                                                                Get.to(ParcelOrderScreen(isfromMultiTrip: true,isFromSingleTrip: false),transition: Transition.leftToRight);

                                                          });


                                                      },
                                                  );

                                  });



                                                  } else {



                                                    
      
                                                        validatePackageDetails();
                                                        AppUtils.showToast('Please Fill All Fields..');
                                                  }







              },)
              
              
                // InkWell(


                //           onTap: () {


                //                  },



      
                //               child: Container(
                //                 height: 45,
                //                 width: MediaQuery.of(context).size.width * 0.9,
                //                 decoration: CustomContainerDecoration.gradientbuttondecoration(),
                //                   child:  Center(
                //                       child: Text(
                //                         'Continue',
                //                         style: CustomTextStyle.smallwhitetext,
                //                         ),
                //                       ),
                //                   ),
                                  
                //                 )
                                
                                 : ReusableLoadingDummyButton(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }







  void validatePackageDetails() {

       final picdropProvider     = Provider.of<RoundTripLOcatDataProvider>(context, listen: false);
       final validationProvider  = Provider.of<RoundValidationErrorProvider>(context,listen: false);
        formKey.currentState==null || formKey.currentState!.validate();

      setState(() {

        picdropProvider.packagecontent == null ? validationProvider.addContentError(content: packagecontentQuot) : validationProvider.addContentError(content: '');
        // Check if pickup address is selected
        // pickuperror = (!picdropProvider.addressMap.containsKey('pickUpLocation') || picdropProvider.addressMap['pickUpLocation'] == null) ? 'Please select Pickup Address'  : '' ;  
         (!picdropProvider.addressMap.containsKey('pickUpLocation') || picdropProvider.addressMap['pickUpLocation'] == null) ?  validationProvider.addpicupError(pickupcontent: pickupvalidationquot)  : validationProvider.addpicupError(pickupcontent: '' );     

        // Check if package weight is selected
        // weighterror = picdropProvider.packageWeight == null  ? 'Please select Package Weight'  : '';
        picdropProvider.packageWeight == null  ? validationProvider.addweightError(weightcontent: packageweightQuot  ) : validationProvider.addweightError(weightcontent: '');


        // Check if drop address is selected
        // droperror = (!picdropProvider.addressMap.containsKey('dropLocation') ||  picdropProvider.addressMap['dropLocation'] == null) ? 'Please select Drop Address'  : '';      
        (!picdropProvider.addressMap.containsKey('dropLocation') ||  picdropProvider.addressMap['dropLocation'] == null) ? validationProvider.adddropError(dropcontent: dropvalidationquot ) : validationProvider.adddropError(dropcontent: '');

        picdropProvider.packageImageUrl == null ? validationProvider.addimageError(imageError: imageErrorQuot) :  validationProvider.addimageError(imageError: '');


      });

  }


          bool validatesingleTrip() {
            var parcelPro = Provider.of<RoundTripLOcatDataProvider>(context, listen: false);
            return parcelPro.packagecontent != null && parcelPro.packageWeight != null && parcelPro.packageImageUrl !=null;
          }




  // Future<void> pickImage({context}) async {

  //   var parcelProvider = Provider.of<RoundTripLOcatDataProvider>(context,listen: false);
  //   var validateProvider = Provider.of<RoundValidationErrorProvider>(context,listen: false);


  //   try {

  //     final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

  //     if (pickedFile != null) {


  //         setState(() {
  //              isUploading = true;
  //            });




  //       Provider.of<RoundTripImageUploaderProvider>(context,listen: false).uploadImage(contexxt: context,image: XFile(pickedFile.path),pickFile: pickedFile ).then((value) {
                 
  //               // RoundTripLOcatDataProvider

  //               print('=------------=');
  //               print(parcelProvider.packageImageUrl);


  //               if( parcelProvider.packageImageUrl != null ){

  //                 validateProvider.addimageError(imageError: '');

  //               }

  //                 setState(() {
  //                 isUploading = false;
  //               });

  //       });




  //     }else{


  //     }

  //   } catch (e) {

  //         print("Error picking and cropping image: $e");
  //   } 
  // }


Future<void> pickImage({required BuildContext context}) async {
   var parcelProvider = Provider.of<RoundTripLOcatDataProvider>(context,listen: false);
   var validateProvider = Provider.of<RoundValidationErrorProvider>(context,listen: false);

  try {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
       setState(() {
              isUploading = true;
                  });
      // Original file
      final originalFile = File(pickedFile.path);
      final originalSize = await originalFile.length();

      // Compress the image
      var result = await FlutterImageCompress.compressAndGetFile(
        originalFile.path,
        '${originalFile.path}compressed.jpg',
        quality: 80,
      );

      if (result == null) {
        print("Image compression failed.");
        return;
      }

      // Get compressed size
      int compressedSize = await File(result.path).length();

      // Log sizes for debugging
      print('Image size before compression: $originalSize bytes');
      print('Image size after compression: $compressedSize bytes');

      // Now, upload the image using the ImageUploaderProvider
      Provider.of<RoundTripImageUploaderProvider>(context, listen: false).uploadImage(
        contexxt: context,
        image: XFile(result.path), // Use compressed image
        pickFile: pickedFile, // Original picked file (used for the file name)
      ).then((value) {
         setState(() {
          isUploading = false; // Set uploading to false once done
        });

        if (parcelProvider.packageImageUrl != null) {
          validateProvider.addimageError(imageError: '');
        }
      });

    }
  } catch (e) {
    print("Error picking and compressing image: $e");
  }
}







  var data =    {
        "userId": "671b64c535abd7d99ac49860",
        "unit": "kg",
        "km": 50,
        "value": 6,
        "otherType" : "vkjbsdk",
        "packageType":"food",
        "packageImage": "kjsbdsbsbk",
        "basePrice":200,
        "dropDetails": [
            {
                "userType": null,
                "houseNo": "776",
                "locality": "ngl",
                "landMark": null,
                "fullAddress": "tytht rghyrhtn ghhtg",
                "street": null,
                "city": "Nagercoil",
                "district": null,
                "state": null,
                "country": "india",
                "postalCode": null,
                "contactType": null,
                "contactPerson": "arun",
                "contactPersonNumber": "9976756454",
                "addressType": null,
                "latitude": null,
                "longitude": null,
                "delivered": false
            }
        ],


        "pickupDetails": [
            {
                "userType": null,
                "houseNo": "776",
                "locality": "ngl",
                "landMark": null,
                "fullAddress": "tytht rghyrhtn ghhtg",
                "street": null,
                "city": "Nagercoil",
                "district": null,
                "state": null,
                "country": "india",
                "postalCode": null,
                "contactType": null,
                "contactPerson": "arun",
                "contactPersonNumber": "9976756454",
                "addressType": null,
                "latitude": null,
                "longitude": null,
                "delivered": false
            }
        ]
    };




Map<String, dynamic> createParcelCaerData({
  required String userId,
  required String unit,
  required double km,
  required int value,
  required String otherType,
  required String packageType,
  required String packageImage,
  required dynamic basePrice,
  required List<Map<String, dynamic>> dropDetails,
  required List<Map<String, dynamic>> pickupDetails,
}) {
  return {
    "userId": userId,
    "unit": unit,
    "km": km,
    "value": value,
    "otherType": otherType,
    "packageType": packageType,
    "packageImage": packageImage,
    "basePrice": basePrice,
    "dropDetails": dropDetails,
    "pickupDetails": pickupDetails,
  };
}


 



Map<String, dynamic> createAddressDetails({
      String? name,
      String? addressId,
      String? userType,
      required String houseNo,
      required String locality,
      String? landMark,
      required String fullAddress,
      String? street,
      required String city,
      String? district,
      String? state,
      required String country,
      String? postalCode,
      String? contactType,
      required String contactPerson,
      required String contactPersonNumber,
      String? addressType,
      double? latitude,
      double? longitude,
      required bool delivered }) {
 
      return {
        'name'     : name,
        'addressId': addressId,
        "userType" : userType,
        "houseNo"  : houseNo,
        "locality" : locality,
        "landMark" : landMark,
        "fullAddress": fullAddress,
        "street"   : street,
        "city"     : city,
        "district" : district,
        "state"    : state,
        "country"  : country,
        "postalCode": postalCode,
        "contactType": contactType,
        "contactPerson": contactPerson,
        "contactPersonNumber": contactPersonNumber,
        "addressType": addressType,
        "latitude": latitude,
        "longitude": longitude,
        "delivered": delivered,
      };
    }


}








Widget weightMeasurementSheet({context , weightOptions }) { 


  return Container(
    width: MediaQuery.of(context).size.width,
    padding: const EdgeInsets.all(15),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text('Package Weight', style: CustomTextStyle.smallboldblack),
        
        10.toHeight,
       const Text(
          '   Specify the weight of the package accurately.\nIt helps ensure proper pricing and handling.',
          style: CustomTextStyle.black12Normal,
        ),


        RoundWeightSelectionBottomSheet(

          onWeightSelected: (selectedValue) {


             var packagee = Provider.of<RoundTripLOcatDataProvider>(context,listen: false);

              for( int index =0; index < weightOptions.length; index++ ){


                if(weightOptions[index]['value'] == selectedValue){

                  print('selected weight in kgg ${weightOptions[index]['label']}');

                  packagee.addchipIndex(chipIndex: index);
                  packagee.addPackageFinalWeight(finallWeight: weightOptions[index]['label']);
                  packagee.addPackageWeight(weight   : weightOptions[index]['maxWeight']);
                  packagee.addBasePrice(addBasePric  : weightOptions[index]['basePrice']);
                  packagee.addPckageUnit(packageunit : weightOptions[index]['unit']);
                  Provider.of<RoundValidationErrorProvider>(context,listen: false).addweightError(weightcontent: '');
                  Navigator.pop(context);

                }
              }
          },

          weightOptions         : weightOptions,
          activeColor           : Customcolors.darkpurple,
          selectedWeightOption  : Provider.of<RoundTripLOcatDataProvider>(context,listen: false).selectedChipIndex,
   
          ),
        ],
      ),
    );
  }









  bool groupValue = false;




class RoundWeightSelectionBottomSheet extends StatefulWidget {
  final dynamic weightOptions;
  final int selectedWeightOption;
  final Color activeColor;
  final ValueChanged<int> onWeightSelected;

  const RoundWeightSelectionBottomSheet({
    super.key,
    required this.weightOptions,
    this.selectedWeightOption = 0,
    required this.onWeightSelected,
    this.activeColor = Colors.orange,
  });

  @override
  _RoundWeightSelectionBottomSheetState createState() => _RoundWeightSelectionBottomSheetState();
}

class _RoundWeightSelectionBottomSheetState extends State<RoundWeightSelectionBottomSheet> {
  late int _selectedWeightOption;
  @override
  void initState() {
    super.initState();
    _selectedWeightOption = widget.selectedWeightOption;
  }


  Widget _weightContainer({required String text, required int value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: CustomTextStyle.blackB14,
        ),
        Radio<int>(
          activeColor: widget.activeColor,
          value: value,
          groupValue: _selectedWeightOption,
          onChanged: (newValue) {

            setState(() {
            _selectedWeightOption = newValue!;
            });
            widget.onWeightSelected(newValue!);

          },
        ),
      ],
    );
  }




  @override
  Widget build(BuildContext context) {


    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: widget.weightOptions.map<Widget>((option) {
            return _weightContainer(
              text:  option['label'],
              value: option['value'],
            );
          }).toList(),
        ),
      ),
    );

  }
}




String replaceFileName({url}) {

  Uri uri = Uri.parse(url);
  String path = uri.path;

  String immg = 'Image - ${path.toString().split('.').last}';
  return immg;

}




  // final List<Map<String, dynamic>> weightOptions = [
  //   {'label': '<1 kg'      , 'value': 0},
  //   {'label': '1 kg - 3 kg', 'value': 1},
  //   {'label': '3 kg - 5 kg', 'value': 2},
  //   {'label': '5 kg - 7 kg', 'value': 3},
  //   {'label': '>7 kg'      , 'value': 4},
  // ];












// LatLng? parcelpick;

// LatLng? parceldrop;