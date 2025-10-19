// ignore_for_file: file_names

import 'package:testing/common/commonRedButton.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Buttons/Customtextformfield.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/Decorations/InPutDecorations.dart';
import 'package:testing/utils/Validator/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Addusercartaddress extends StatefulWidget {
  const Addusercartaddress({super.key});

  @override
  State<Addusercartaddress> createState() => _AddusercartaddressState();
}

class _AddusercartaddressState extends State<Addusercartaddress> {
  TextEditingController someOneNameController = TextEditingController();
  TextEditingController sonmeOnePhoneNumber = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    if (orderForSomeOneName != '' && orderForSomeOnePhone != '') {
      someOneNameController.text = orderForSomeOneName;
      sonmeOnePhoneNumber.text   = orderForSomeOnePhone;
    } else {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // MediaQuery.of(context).size.height / 1.9,

    var orderForOthers = Provider.of<InstantUpdateProvider>(context);

    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 100),
      child: CustomContainer(
        decoration: CustomContainerDecoration.whitecontainerdecoration(),
        height: MediaQuery.sizeOf(context).height * 0.5,
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Are you ordering for someone else?",
                    style: CustomTextStyle.addresstitle),
                5.toHeight,
                const Text(
                  "We will directly coordinate with the receiver using this phone number",
                  style: CustomTextStyle.chipgrey,
                ),
                CustomSizedBox(height: 20.h),
                AddressFormFeild(
                  controller: someOneNameController,
                  readonly: false,
                  hintText: '',
                  validator:  NormalValidationUtils.recievernameFieldValidator(),
                  decoration: ReusableInputDecoration.getDecoration(fieldName: "Receiver’s Name"),
                  onChanged: (value) => formkey.currentState!.validate(),
                ),
                20.toHeight,
                AddressFormFeild(
                  validator: additionalPhoneValidation,
                  controller: sonmeOnePhoneNumber,
                  onChanged: (value) =>formkey.currentState!.validate(),
                  readonly: false,
                  hintText: '',
                  maxLength: 10,
                  decoration: ReusableInputDecoration.getDecoration(fieldName: "Mobile Number", prefixText: "+91 "),
                  keyboardType: TextInputType.number,
                ),
                50.toHeight,
                Center(
                  child: ReusableRedButton(
                    buttonName: 'Save Receiver Details',
                    ontap: () {
                      if (formkey.currentState!.validate()) {
                        if (someOneNameController.text.isNotEmpty &&  sonmeOnePhoneNumber.text.isNotEmpty) {  
                          
                          setState(() {
                            orderForSomeOneName = someOneNameController.text;
                            orderForSomeOnePhone = sonmeOnePhoneNumber.text;
                          });

                          orderForOthers.updateSomeOneDetaile(someOneName: someOneNameController.text, someOneNumber: sonmeOnePhoneNumber.text);
                          Get.back();


                        } else {


                          setState(() {
                            orderForSomeOneName = '';
                            orderForSomeOnePhone = '';
                          });
                          orderForOthers.updateSomeOneDetaile( someOneName: '', someOneNumber: '');
                            
                          Get.back();
                        }
                      } else {


              // someOneNameController.isBlank 



                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




class InstantUpdateProvider with ChangeNotifier {
//Order For SomeOne
  String someName = '';
  String someNumber = '';

  String get otherName => someName;
  String get otherNumber => someNumber;

// Add Delivary Instruction

  String delInstruction = '';
  String get delivaryInstruction => delInstruction;

  updateSomeOneDetaile({someOneName, someOneNumber}) {
    someName = someOneName;
    someNumber = someOneNumber;
    notifyListeners();
  }

  upDateInstruction({instruction}) {
    delInstruction = instruction;
    notifyListeners();
  }
}
