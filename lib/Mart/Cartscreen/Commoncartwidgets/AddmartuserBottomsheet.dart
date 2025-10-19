// ignore_for_file: file_names

import 'package:testing/Mart/Cartscreen/Commoncartwidgets/Martadditionalinfo.dart';
import 'package:testing/common/commonRedButton.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Buttons/Customtextformfield.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/Decorations/InPutDecorations.dart';
import 'package:testing/utils/Validator/validations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AddmartuserBottomsheet extends StatefulWidget {
  const AddmartuserBottomsheet({super.key});

  @override
  State<AddmartuserBottomsheet> createState() => _AddmartuserBottomsheetState();
}

class _AddmartuserBottomsheetState extends State<AddmartuserBottomsheet> {
 TextEditingController someOneNameController = TextEditingController();
  TextEditingController sonmeOnePhoneNumber = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    if (martorderForSomeOneName != '' && martorderForSomeOnePhone != '') {
      someOneNameController.text = martorderForSomeOneName;
      sonmeOnePhoneNumber.text   = martorderForSomeOnePhone;
    } else {}
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   var orderForOthers = Provider.of<MartInstantUpdateProvider>(context);

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
                  validator:  NormalValidationUtils.requirednameFieldValidator(fieldName: 'Name'),
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
                            martorderForSomeOneName = someOneNameController.text;
                            martorderForSomeOnePhone = sonmeOnePhoneNumber.text;
                          });

                          orderForOthers.martupdateSomeOneDetails(someOneName: someOneNameController.text, someOneNumber: sonmeOnePhoneNumber.text);
                          Get.back();


                        } else {


                          setState(() {
                            martorderForSomeOneName = '';
                            martorderForSomeOnePhone = '';
                          });
                          orderForOthers.martupdateSomeOneDetails( someOneName: '', someOneNumber: '');
                            
                          Get.back();
                        }
                      } else {
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