import 'dart:convert';
import 'package:testing/Features/Homepage/AddressController/Addresscontroller.dart';
import 'package:testing/map_provider/Map%20Screens/MapSearch.dart/homeadresskey.dart';
import 'package:testing/map_provider/Map%20Screens/map_property_Decorations/addressbtmsheet_blueBox.dart';
import 'package:testing/map_provider/Map%20Screens/markervaluse.dart';
import 'package:testing/utils/Buttons/CustomButton.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Buttons/Customtextformfield.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Decorations/InPutDecorations.dart';
import 'package:testing/utils/Toast/customtoastmessage.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:testing/utils/Validator/phonenumformate.dart';
import 'package:testing/utils/Validator/validations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;





// ignore: must_be_immutable
class CommonAddAddressBottomSheet extends StatefulWidget {

  dynamic locality;
   dynamic address;
   List<String?> fullAddress;
  dynamic street;
  dynamic state;
  dynamic country;
  dynamic city;
  dynamic pincode;
  dynamic latitude;
  dynamic longitude;




  CommonAddAddressBottomSheet(
      {super.key,
      this.locality,
      this.address,
      required this.fullAddress,
      this.street,
      this.state,
      this.city,
      this.country,
      this.pincode,
      this.latitude,
      this.longitude,

      });

  @override
  State<CommonAddAddressBottomSheet> createState() => _CommonAddAddressBottomSheetState();
}

class _CommonAddAddressBottomSheetState extends State<CommonAddAddressBottomSheet>  with WidgetsBindingObserver {
  

  TextEditingController nameController              = TextEditingController();
  TextEditingController housenocontroller           = TextEditingController();
  TextEditingController localitycontroller          = TextEditingController();
  TextEditingController landMarkcontroller          = TextEditingController();
  TextEditingController localitytextFieldController = TextEditingController();
  TextEditingController typeController              = TextEditingController();
  TextEditingController mobilenoController          = TextEditingController();
  TextEditingController pincodeController          = TextEditingController();
  AddressController     addresscontroller           = Get.put(AddressController());
  HomeadresskeyController  homeaddress              =Get.put(HomeadresskeyController());

  int? _selectedValue;

bool isAddressTypeError = false;
  final formkey = GlobalKey<FormState>();




  @override
  void initState() {

    localitytextFieldController = TextEditingController(text: widget.locality.toString() == "null"  ? ""   : widget.locality.toString());
    
    super.initState();
  }

  void _handleRadioValueChange(int? value) {
    setState(() {
      _selectedValue = value!;
       isAddressTypeError = false; // clear error once selected
    });
  }

  final _formatter = FourDigitFormatter();

  List<String> radioLabels = ["Home", "Work", "Other"];

  Widget radioButtons() {
    // List<Widget> radios = [];
    // for (int i = 0; i < radioLabels.length; i++) {

    //         radios.add(
    //           Row(
    //             children: [
    //               Radio(
    //                 activeColor: Customcolors.darkpurple,
    //                 value: i,
    //                 groupValue: _selectedValue,
    //                 onChanged: _handleRadioValueChange,
    //               ),
    //               Text(
    //                 radioLabels[i],
    //                 style: const TextStyle(fontFamily: 'Poppins-Regular'),
    //               ),
    //             ],
    //           ),
    //         );


    // }
    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //   children: radios,
    // );
     return Obx(() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(radioLabels.length, (i) {
            bool isHomeDisabled = i == 0 && homeaddress.isHomeDisabled.value;
            bool isWorkDisabled = i == 1 && homeaddress.isWorkDisabled.value;
            bool isDisabled = isHomeDisabled || isWorkDisabled;

            return GestureDetector(
              onTap: () {
                if (isHomeDisabled) {
                  AppUtils.showToast('You have already added Home');
                } else if (isWorkDisabled) {
                  AppUtils.showToast('You have already added Work');
                }
              },
              child: Row(
                children: [
                  Radio(
                    activeColor: Customcolors.darkpurple,
                    value: i,
                    groupValue: _selectedValue,
                    onChanged: isDisabled ? null : _handleRadioValueChange,
                  ),
                  Text(
                    radioLabels[i],
                    style: TextStyle(
                      fontFamily: 'Poppins-Regular',
                      color: isDisabled ? Colors.grey : Colors.black,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
        if (isAddressTypeError)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "Address Type is required",
              style:  TextStyle(
                fontSize: 12,
                color: Colors.red,
                fontFamily: 'Poppins-Regular',
              ),
            ),
          ),
      ],
    );
  });
  }





  @override
  Widget build(BuildContext context) {




    return Scaffold(
      body: Form(
        key: formkey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
         
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 15),
                child: Text( "Save as favourite", style: CustomTextStyle.addresstitle),
              ),
            
            
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: Row(
                  children: [
                    Image.asset(othersicon,height: 20,width: 20),
                    5.toWidth,
                    Expanded(
                      child: Text(
                        // widget.fullAddress == 'null'
                        //     ? "Loading... "
                        //     : widget.fullAddress,
                           widget.address == 'null'
                       
                            ? "Loading... "
                            : widget.address,
                        style: CustomTextStyle.addressfetch,
                        maxLines: null,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
             const BlueBoxForBottomSheet(),
              10.toHeight,
              radioButtons(),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17.0),
                child: Column(
                  children: [
                          _selectedValue == 2
                          
                            ?  AddressFormFeild(
                                    controller : typeController,
                                    readonly   : false,
                                    hintText   : '',
                                    validator  : NormalValidationUtils.requiredFieldValidator(fieldName: 'Additional Address Details'),
                                    decoration : ReusableInputDecoration.getDecoration(fieldName: "Additional Address Details"),
                                  )
                                : const SizedBox(),
                                AddressFormFeild(
                                controller: nameController,
                                readonly: false,
                                hintText: '',
                                validator  :  NormalValidationUtils.requirednameFieldValidator(fieldName: 'Name'),
                                decoration :  ReusableInputDecoration.getDecoration(fieldName: "Name"),
                                ),
                              15.toHeight,
                              AddressFormFeild(
                                validator: validatepPhone,
                                controller: mobilenoController,
                                inputFormatters: [_formatter],
                                readonly: false,
                                hintText: '',
                                maxLength: 11,
                                decoration: ReusableInputDecoration.getDecoration(fieldName: "Mobile Number",prefixText: "+91 "),
                                keyboardType: TextInputType.number,
                              ),
                              18.toHeight,
                              AddressFormFeild(
                                controller: housenocontroller,
                                readonly: false,
                                hintText: '',
                                validator:  ValidationUtils.houseNumberValidator(fieldName: 'Flat / House no / Floor / Building'),
                                decoration: ReusableInputDecoration.getDecoration(fieldName: "Flat / House no / Floor / Building"),
                              ),
                              18.toHeight,
                              AddressFormFeild(
                                controller : localitytextFieldController,
                                readonly   : false,
                                hintText   : '',
                                validator  :  NormalValidationUtils.requiredFieldValidator(fieldName: 'Area / Sector / Locality'),
                                decoration :  ReusableInputDecoration.getDecoration(fieldName: "Area / Sector / Locality"),
                                enabled: false, 
                              ),
                              20.toHeight,
                              AddressFormFeild(
                                controller : landMarkcontroller,
                                readonly   : false,
                                validator  : NormalValidationUtils.requiredFieldValidator(fieldName: 'landmark'),
                                decoration :  ReusableInputDecoration.getDecoration(fieldName: "Nearby landmark"),
                                hintText   : '',
                              ),
                               20.toHeight,
                              widget.pincode.isEmpty?
                               AddressFormFeild(
                                controller : pincodeController,
                                readonly   : false,
                                validator  : NormalValidationUtils.requiredFieldValidator(fieldName: 'Pincode'),
                                decoration :  ReusableInputDecoration.getDecoration(fieldName: "Pincode"),
                                hintText   : '',
                                 keyboardType: TextInputType.number,
                              ):SizedBox(),

                              CustomSizedBox(height: 20.h),

                  ],
                ),
              ),


 


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DisableButton(
                    borderRadius: BorderRadius.circular(30),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    width: 120,
                    height: 40,
                    child: const Text(
                      "Cancel",
                      style: CustomTextStyle.addressfeildbutton,
                    ),
                  ),
            
            
                  isclicked == false     
                      ? CustomButton(     
                          borderRadius: BorderRadius.circular(30),
                          onPressed: () async{
             setState(() {
                              isAddressTypeError = _selectedValue == null;
                            });
                            
                             if (_selectedValue == null) return;
                            String selectedAddressType = radioLabels[_selectedValue!];
                                
            
                          //  String selectedAddressType = radioLabels[_selectedValue];
                                
              String pin = (widget.pincode?.trim().isEmpty ?? true)
    ? pincodeController.text
    : widget.pincode!;
    
 List<String> processedAddressParts = List.generate(widget.fullAddress.length, (index) {
  String? part = widget.fullAddress[index];
      if (index == 4 && (part == null || part.isEmpty)) {
        // Replace postalCode if null or empty
        return  pincodeController.text;
      } else {
        return widget.fullAddress[index] ?? "";
      }
    });

    String fullAddress = processedAddressParts.where((part) => part.isNotEmpty).join(', ');
                            if (formkey.currentState!.validate()) {
            
                                   setState(() {
                                    isclicked = true;
                                  });
            
            
                                    addressData = {
                                      'houseNo'      : housenocontroller.text,
                                      'locality'     : localitytextFieldController.text,
                                      'landMark'     : landMarkcontroller.text,
                                      'fullAddress'  : fullAddress,
                                      'street'       : widget.street,
                                      'state'        : widget.state,
                                      'country'      : widget.country,
                                      'postalCode'   : pin,
                                      'contactPerson': nameController.text,
                                      'contactPersonNumber': mobilenoController.text.removeAllWhitespace,
                                      'latitude'     : widget.latitude,
                                      'longitude'    : widget.longitude,
                                      'addressType'  : selectedAddressType,
                                      'instructions' : typeController.text,
                                    };
            
                            
                                    addaddressapi(addressData: addressData).then((value) {
            
                                            setState(() {
                                                isclicked = false;
                                            });
            
                                           
                                          addresscontroller.getaddressapi(context: context,latitude: "",longitude: "");
                                          
                                          Navigator.pop(context);           
                                          Navigator.pop(context);        
            
            
                                  
                                    }) ;
            
            
                          
                               }
            
                          },
                          width: 120,
                          height: 40,
                          child: const Text("Save", style: CustomTextStyle.addressfeildbutton))
                             
                        : DisableButton(
                              width: 120,
                              height: 40,
                              borderRadius: BorderRadius.circular(30),
                              onPressed: () {},
                              child: const CupertinoActivityIndicator()),
                ],
              ),
            
              30.toHeight
            ],
          ),
        ),
      ),
    );
  }





  var addressLoading = false.obs;
  dynamic addressdetails;

 Future<dynamic>  addaddressapi({ addressData}) async {

    try {

      addressLoading(true);
      var response = await http.post(
        Uri.parse(API.addressfastx),
        headers: API().headers,
        body: jsonEncode(
          <String, dynamic>{
            "userType" : "consumer",
            "houseNo"  : addressData['houseNo'],
            "locality" : addressData['locality'],
            "landMark" : addressData['landMark'],
            "fullAddress": addressData['fullAddress'],
            "street"   : addressData['street'],
            // "city": addressData['city'],
            // "district": addressData['district'],
            "state"    : addressData['state'],
            "country"  : addressData['country'],
            "postalCode": addressData['postalCode'],
            "contactType": "myself",
            "contactPerson": addressData['contactPerson'],
            "contactPersonNumber": addressData['contactPersonNumber'],
            "addressType": addressData['addressType'],
            "latitude": addressData['latitude'],
            "longitude": addressData['longitude'],
            "userId": UserId,
            'instructions': addressData['instructions'],
          },
        ),
      );




      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
        
                  var result = jsonDecode(response.body);
                  addressdetails = result;

                  AppUtils.showToast('Address Saved');



          return response.statusCode;


      } else {


        var result = jsonDecode(response.body);

        Get.snackbar(
          backgroundColor: Customcolors.DECORATION_RED,
          '', '',
          titleText: const Text("Something went wrong"),
          messageText: Text(result["message"]),
            
          
        );

           addressdetails = null;

        }


    } catch (e) {

        print(e.toString());
     
     } finally {

      addressLoading(false);

    }
  }


  bool isclicked = false;
}
