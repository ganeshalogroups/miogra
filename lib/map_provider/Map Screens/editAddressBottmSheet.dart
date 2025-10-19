// ignore_for_file: file_names

import 'package:testing/Features/Homepage/AddressController/Addresscontroller.dart';
import 'package:testing/map_provider/Map%20Screens/MapSearch.dart/addressnameController.dart';
import 'package:testing/map_provider/Map%20Screens/map_property_Decorations/addressbtmsheet_blueBox.dart';
import 'package:testing/map_provider/locationprovider.dart';
import 'package:testing/utils/Buttons/CustomButton.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Buttons/Customtextformfield.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Decorations/InPutDecorations.dart';
import 'package:testing/utils/Validator/validations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EditAddressBottomSheet extends StatefulWidget {

  dynamic locality;
  bool?   itseditscreen;
  dynamic fullAddress;
  dynamic street;
  dynamic state;
  dynamic country;
  dynamic city;
  dynamic pincode;
  dynamic latitude;
  dynamic longitude;
  dynamic district;
  dynamic addressId;
  dynamic addressType;
  dynamic mobilenumber;
  dynamic housenumber;
  dynamic landmark;
  dynamic typefield;
  dynamic name;

  EditAddressBottomSheet({
    super.key,
    this.locality,
    this.addressType,
    this.fullAddress,
    this.street,
    this.itseditscreen,
    this.state,
    this.city,
    this.country,
    this.district,
    this.pincode,
    this.latitude,
    this.addressId,
    this.longitude,
    this.housenumber,
    this.landmark,
    this.mobilenumber,
    this.typefield,
    this.name,
  });

  @override
  State<EditAddressBottomSheet> createState() => _EditAddressBottomSheetState();
}




class _EditAddressBottomSheetState extends State<EditAddressBottomSheet> with WidgetsBindingObserver {
  

  TextEditingController nameController              = TextEditingController();
  TextEditingController housenocontroller           = TextEditingController();
  TextEditingController localitycontroller          = TextEditingController();
  TextEditingController landMarkcontroller          = TextEditingController();
  TextEditingController localitytextFieldController = TextEditingController();
  TextEditingController typeController              = TextEditingController();
  TextEditingController mobilenoController          = TextEditingController();
  AddressController     addresscontroller           = Get.put(AddressController());

  int _selectedValue = 0;

  final formkey = GlobalKey<FormState>();



  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    localitytextFieldController = TextEditingController(

        text: widget.locality.toString() == "null"  ? ""   : widget.locality.toString());
      setState(() {
        if (widget.addressType == 'Home') {
          _selectedValue = 0;
        } else if (widget.addressType == 'Work') {
          _selectedValue = 1;
        } else if (widget.addressType == 'Other') {
          _selectedValue = 2;
        }

        nameController.text     = widget.name;
        mobilenoController.text = widget.mobilenumber;
        housenocontroller.text  = widget.housenumber;
        landMarkcontroller.text = widget.landmark;
        typeController.text     = widget.typefield;
        localitycontroller.text = widget.locality;
      });

    super.initState();
  }



  void _handleRadioValueChange(int? value) {
    setState(() {
      // _selectedValue = value!;
    });
  }



  // final _formatter = FourDigitFormatter();

  List<String> radioLabels = ["Home", "Work", "Other"];

  // Widget radioButtons() {

  //   List<Widget> radios = [];
  //   for (int i = 0; i < radioLabels.length; i++) {

  //     radios.add(
  //       Row(
  //         children: [
  //           Radio(
  //             activeColor: Customcolors.darkpurple,
  //             value: i,
  //             groupValue: _selectedValue,
  //             onChanged: _handleRadioValueChange,
  //           ),
  //           Text(
  //             radioLabels[i],
  //             style: const TextStyle(fontFamily: 'Poppins-Regular'),
  //           ),
  //         ],
  //       ),
  //     );

  //   }
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //     children: radios,
  //   );
  // }




Widget radioButtons() {
  List<Widget> radios = [];

  for (int i = 0; i < radioLabels.length; i++) {
    radios.add(
      Row(
        children: [
          Radio<int>(
            value: i,
            groupValue: _selectedValue,
            onChanged: _selectedValue == i ? _handleRadioValueChange : null, // disable unselected
            activeColor: Customcolors.darkpurple,
          ),
          Text(
            radioLabels[i],
            style: const TextStyle(fontFamily: 'Poppins-Regular'),
          ),
        ],
      ),
    );
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: radios,
  );
}


  @override
  void dispose() {
    localitycontroller.clear();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {

    var locationProvider =  Provider.of<LocationProvider>(context, listen: false);


    return Scaffold(
      body: Form(
        key: formkey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 160, vertical: 10),
                child: Divider(
                  color: Customcolors.DECORATION_GREY,
                  thickness: 4,
                ),
              ),
            
            
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child:   Text( "Edit Address Details", style: CustomTextStyle.addresstitle),
                ),
            
            
              Padding(
            
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    
                child: Consumer<AddressNameController>(
            
                  builder: (context, value, child) {
            
                    if (value.isLoadinge) {
            
                      return const Center(child: CupertinoActivityIndicator());
            
                    } else if (value.editFullAddressModel == null) {
            
                      return const Text('Loading..', style: CustomTextStyle.blacktext);
                         
                    } else {
            
                      return Text(value.editFullAddressModel,  style: CustomTextStyle.blacktext);
                        
                    }
                  },
                ),
              ),
              const SizedBox(height: 10),
              const BlueBoxForBottomSheet(),
              radioButtons(),




      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17.0),
        child: Column(
          children: [
  
                _selectedValue == 2
                    ? AddressFormFeild(
                    controller : typeController,
                    readonly   : false,
                    hintText   : '',
                    validator  : NormalValidationUtils.requiredFieldValidator(fieldName: 'Additional Address Details'),
                    decoration : ReusableInputDecoration.getDecoration(fieldName: "Additional Address Details"),
                    )
                    : const SizedBox(),

                CustomSizedBox(height: 15.h),
                
                  AddressFormFeild(
                    controller: nameController,
                    readonly: false,
                    hintText: '',
                    validator:  NormalValidationUtils.requirednameFieldValidator(fieldName: 'Name'), 
                    decoration:  ReusableInputDecoration.getDecoration(fieldName: "Name"),
                  ),
                15.toHeight,
                AddressFormFeild(
                  validator  : updatePhoneValidation,
                  controller : mobilenoController,
                  readonly   : false,
                  hintText: '',
                  maxLength: 11,
                  decoration: ReusableInputDecoration.getDecoration(fieldName: "Mobile Number",prefixText: "+91 "),
                  keyboardType: TextInputType.number,
                ),
                18.toHeight,
                AddressFormFeild(
                    controller : housenocontroller,
                    readonly   : false,
                    hintText   : '',
                    validator  :  ValidationUtils.houseNumberValidator(fieldName: 'Flat / House no / Floor / Building'),
                    decoration : ReusableInputDecoration.getDecoration(fieldName: "Flat / House no / Floor / Building"),
                  ),
                 18.toHeight,

  
                    AddressFormFeild(
                    controller : localitytextFieldController,
                    readonly   : false,
                    hintText   : '',
                    validator  :  NormalValidationUtils.requiredFieldValidator(fieldName: 'Area / Sector / Locality'),
                    decoration : ReusableInputDecoration.getDecoration(fieldName: "Area / Sector / Locality"),
                    enabled: false, 
                  ),
                20.toHeight,

                  AddressFormFeild(
                    controller : landMarkcontroller,
                    readonly   : false,
                    validator  : NormalValidationUtils.requiredFieldValidator(fieldName: 'landmark'),
                    decoration : ReusableInputDecoration.getDecoration(fieldName: "Nearby landmark"),
                    hintText   : '',
                  ),
  
  
    
  
  
              ],
            ),
          ),
            
              CustomSizedBox(height: 20.h),
              
            
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
                            onPressed: () {
            
                              String selectedAddressType = radioLabels[_selectedValue];
                                 
                              if (formkey.currentState!.validate()) {
            
                                setState(() {
                                  isclicked = true;
                                });
            
                                addressData = {
            
                                  'houseNo'  : housenocontroller.text,
                                  'locality' : localitytextFieldController.text,
                                  'landMark' : landMarkcontroller.text,
                                  'fullAddress': widget.fullAddress,
                                  'street'   : widget.street,
                                  'state'    : widget.state,
                                  'country'  : widget.country,
                                  'postalCode': widget.pincode,
                                  'contactPerson': nameController.text,
                                  'contactPersonNumber': mobilenoController.text.removeAllWhitespace,
                                  'latitude' : widget.latitude,
                                  'longitude': widget.longitude,
                                  'addressType' : selectedAddressType,
                                  'instructions': typeController.text,
            
                                };
            
            
                                  addresscontroller.updateAllAddressFieldsApi(addressId: widget.addressId, addressData: addressData,context: context).then((value) {
                                  locationProvider.updateMarker(latitude: currentlatitude,longitude: currentlongitude);
            
                                  Get.back();
                                  Get.back();
            
                                });
                              }
                            },
                            width: 120,
                            height: 40,
                            child: const Text("Save",style: CustomTextStyle.addressfeildbutton))
                                
                        : DisableButton(
                            width: 120,
                            height: 40,
                            borderRadius: BorderRadius.circular(30),
                            onPressed: () {},
                            child: const CupertinoActivityIndicator()),
                  ]),

                 50.toHeight

            ],
          ),
        ),
      ),
    );
  }

  bool isclicked = false;
}
