// ignore_for_file: must_be_immutable

import 'package:testing/Features/Foodmodule/getFoodCartProvider.dart';
import 'package:testing/Features/Homepage/AddressController/Addresscontroller.dart';
import 'package:testing/Meat/Common/Searchshopcontroller.dart';
import 'package:testing/map_provider/Map%20Screens/map_property_Decorations/addressbtmsheet_blueBox.dart';
import 'package:testing/map_provider/Map%20Screens/markervaluse.dart';
import 'package:testing/utils/Buttons/CustomButton.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Buttons/Customtextformfield.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Decorations/InPutDecorations.dart';
import 'package:testing/utils/Toast/customtoastmessage.dart';
import 'package:testing/utils/Validator/phonenumformate.dart';
import 'package:testing/utils/Validator/validations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AddMeatAddressBottomsheet extends StatefulWidget {
    dynamic locality;
  bool?   itseditscreen;
  bool?   isAddressAddScreen;
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
  dynamic ishomescreen;
  bool    isFromAddressBook;
  bool    isFromAddressSearch;
  bool    isFromCartScreen;
  dynamic shopid;
   AddMeatAddressBottomsheet({
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
      this.ishomescreen,
      this.isAddressAddScreen,
      this.longitude,
      this.isFromAddressBook   = false,
      this.isFromAddressSearch = false,
      this.isFromCartScreen    = false,
      this.shopid,
      super.key});

  @override
  State<AddMeatAddressBottomsheet> createState() => _AddMeatAddressBottomsheetState();
}

class _AddMeatAddressBottomsheetState extends State<AddMeatAddressBottomsheet>  with WidgetsBindingObserver {
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
    @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    localitytextFieldController = TextEditingController(text: widget.locality.toString() == "null"  ? ""   : widget.locality.toString());
      

    setState(() {
      if (widget.addressType == 'Home') {
        _selectedValue = 0;
      } else if (widget.addressType == 'Work') {
        _selectedValue = 1;
      } else if (widget.addressType == 'Other') {
        _selectedValue = 2;
      }
    });

    super.initState();
  }

  void _handleRadioValueChange(int? value) {
    setState(() {
      _selectedValue = value!;
    });
  }

  final _formatter = FourDigitFormatter();

  List<String> radioLabels = ["Home", "Work", "Other"];

  Widget radioButtons() {
    List<Widget> radios = [];
    for (int i = 0; i < radioLabels.length; i++) {

            radios.add(
              Row(
                children: [
                  Radio(
                    activeColor: Customcolors.darkpurple,
                    value: i,
                    groupValue: _selectedValue,
                    onChanged: _handleRadioValueChange,
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
  Widget build(BuildContext context) {
   var searchresProvider = Provider.of<SearchShop>(context,listen: false);
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
                child: Text(
                  "Save as favourite",
                  style: CustomTextStyle.addresstitle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: Row(
                  children: [
                    Image.asset(othersicon,height: 20,width: 20),
                    5.toWidth,
                    Expanded(
                      child: Text(
                        widget.fullAddress == 'null'
                            ? "Loading... "
                            : widget.fullAddress,
                        style: CustomTextStyle.addressfetch,
                        maxLines: null,
                      ),
                    ),
                  ],
                ),
              ),
              5.toHeight,
              const BlueBoxForBottomSheet(),
              5.toHeight,
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

                AddressFormFeild(
                  controller: nameController,
                  readonly: false,
                  hintText: '',
                  validator:   NormalValidationUtils.requirednameFieldValidator(fieldName: 'Name'), 
                  decoration:  ReusableInputDecoration.getDecoration(fieldName: "Name"),
                ),

                15.toHeight,
                AddressFormFeild(
                  validator    : validatepPhone,
                  controller   : mobilenoController,
                  inputFormatters: [_formatter],
                  readonly     : false,
                  hintText     : '',
                  maxLength    : 11,
                  decoration   : ReusableInputDecoration.getDecoration(fieldName: "Mobile Number",prefixText: "+91 "),
                  keyboardType : TextInputType.number,
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
                  controller: localitytextFieldController,
                  readonly: false,
                  hintText: '',
                  validator:  NormalValidationUtils.requiredFieldValidator(fieldName: 'Area / Sector / Locality'),
                  decoration:  ReusableInputDecoration.getDecoration(fieldName: "Area / Sector / Locality"),
                  enabled: false, 
                ),
              20.toHeight,
                AddressFormFeild(
                  controller: landMarkcontroller,
                  readonly: false,
                  validator: NormalValidationUtils.requiredFieldValidator(fieldName: 'landmark'),
                  decoration:  ReusableInputDecoration.getDecoration(fieldName: "Nearby landmark"),
                  hintText: '',
                ),
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
        
        
                            String selectedAddressType = radioLabels[_selectedValue];
                                
        
                            if (formkey.currentState!.validate()) {
        
                                   setState(() {
                                    isclicked = true;
                                  });
        
                              addressData = {
        
                                'houseNo' : housenocontroller.text,
                                'locality': localitytextFieldController.text,
                                'landMark': landMarkcontroller.text,
                                'fullAddress': widget.fullAddress,
                                'street'  : widget.street,
                                'state'   : widget.state,
                                'country' : widget.country,
                                'postalCode': widget.pincode,
                                'contactPerson': nameController.text,
                                'contactPersonNumber': mobilenoController.text.removeAllWhitespace,
                                'latitude': widget.latitude,
                                'longitude': widget.longitude,
                                'addressType': selectedAddressType,
                                'instructions': typeController.text,
        
                              };
        


                            loge.i('is from cart screen         = ${widget.isFromCartScreen}');
                            loge.i('is from AddressBook screen  = ${widget.isFromAddressBook}');
                            loge.i('is from AddressAdd screen   = ${widget.isAddressAddScreen}');
                            loge.i('is from cart screen          = ${widget.ishomescreen}');
        
        
        
        
                          if(widget.isFromCartScreen){
        
        
        
                              List<dynamic> datttta = await searchresProvider.searchShopbyshopId( shopId: widget.shopid, latitude: widget.latitude, longitude: widget.longitude);
                                                    
        
                               loge.i(datttta);
        
        
        
        
        
                               if(datttta.isEmpty){
        
                                   AppUtils.showToast('The Shop is not available at this location.');
        
        
                                    setState(() {
                                      isclicked = false;
                                      });
        
        
        
        
                                    } else {
        
      
                                        WidgetsBinding.instance.addPostFrameCallback((_) {
        
                                            addresscontroller.addaddressapi(addressData: addressData,
                                            cntxt         : context,
                                            ishome        : false,
                                            isAddressBook : false,
                                            isCartScreen  : true ).whenComplete(() {
        
                                                    setState(() {
                                                      isclicked = false;
                                                    });
        
                                                }).then((value) => addressCheckFunction());
        
                                          });
                  
                          }
        
                        } else if (widget.ishomescreen){
        
        
        
                            addresscontroller.addaddressapi(
                              addressData: addressData,
                              cntxt: context, 
                              ishome: true,
                              isAddressBook: false,
                              isCartScreen: false).whenComplete(() {
        
                                     setState(() {
                                      isclicked = false;
                                      });
        
                              }).then((value) => addressCheckFunction());
        
        
        
                          } else if(widget.isFromAddressBook){
        
        
                            addresscontroller.addaddressapi(
        
                              addressData: addressData,
                              cntxt: context,
                              ishome: false,
                              isAddressBook: true,
                              isCartScreen: false).whenComplete(() {
                                setState(() {
                                  isclicked = false;
                                 });
                              }).then((value) => addressCheckFunction());
        
        
        
        
                              }else{
        
                                  addresscontroller.addaddressapi(addressData: addressData,
                                  cntxt: context,
                                  ishome: false,
                                  isAddressBook: false,
                                  isCartScreen: false).whenComplete(() {
        
                                     setState(() {
                                     isclicked = false;
                                      });
        
                                   }
        
                                 ).then((value) => addressCheckFunction());
        
        
                                }
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

       50.toHeight
            ],
          ),
        ),
      ),
    );
 
  }



  
  addressCheckFunction(){
        if(widget.shopid != null){
              WidgetsBinding.instance.addPostFrameCallback((_) {
                  Provider.of<FoodCartProvider>(context,listen: false).searchShop(shopId: widget.shopid!);  
              });


            }else{

                            
            Future.delayed(Duration.zero,() {

                  Provider.of<FoodCartProvider>(context,listen: false).getmeatcartProvider(km: 0);

              },
            );

         }
         
  }


  bool isclicked = false;

}