
// ignore: must_be_immutable


// ignore_for_file: file_names

import 'package:testing/utils/Buttons/Customtextformfield.dart';
import 'package:testing/utils/Decorations/InPutDecorations.dart';
import 'package:testing/utils/Validator/validations.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CurvedTextFormField extends StatelessWidget {

    String? Function(String value)? onChanged;
    String? Function(String value)? onFieldSubmited;
    TextEditingController typeController;

   CurvedTextFormField({super.key,required this.typeController,this.onChanged,this.onFieldSubmited});



  @override
  Widget build(BuildContext context) {

    return AddressFormFeild(
        hintText   : '',
        readonly   : false,
        controller : typeController,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmited,
        validator  : NormalValidationUtils.requiredFieldValidator(fieldName: 'Type'),
        decoration : ReusableInputDecoration.getDecoration(fieldName: "Name of Package content"),
      );

  }
}