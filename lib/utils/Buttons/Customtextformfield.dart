
// ignore_for_file: file_names

import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final Widget? hintStyle;
  final String? labelText;
  final double fontSize;
  final String? initialValue;
  final bool autoFocus;
  final bool mask;
  final TextInputType keyboardType;
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String value)? onChanged;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? labelStyle;
  final Widget? prefixIcon;
  final Widget? decoration;
  final Widget? prefixStyle;
  final Widget? prefixIconColor;
  final Widget? prefixIconConstraints;
  final int? maxLines;
  final int? maxLength;
  final bool isNormal;
  final bool? enabled;
  const CustomTextFormField(
      {super.key,
      required this.hintText,
      this.onChanged,
      this.initialValue,
      this.hintStyle,
      this.prefixIconColor,
      this.decoration,
      this.labelStyle,
      this.prefixIconConstraints,
      this.fontSize = 16,
      this.autoFocus = false,
      this.mask = false,
      this.keyboardType = TextInputType.text,
      this.textCapitalization,
      this.inputFormatters,
      this.validator,
      this.prefixIcon,
      this.prefixStyle,
      this.suffixIcon,
      this.controller,
      this.maxLines,
      this.labelText,
      this.maxLength,
      this.isNormal = false,
      this.enabled,});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        expands: false,
        autofocus: autoFocus,
        obscureText: mask,
        validator: validator,
        // maxLines: maxLines,
        maxLength: maxLength,
        controller: controller,
        autocorrect: false,
        enabled: enabled,
        keyboardType: keyboardType,
        cursorColor: Colors.black,
        textAlign: TextAlign.start,
        initialValue: initialValue,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          contentPadding: hasText
              ? const EdgeInsets.fromLTRB(0, 0, 0, 0)
              : const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
          errorStyle:CustomTextStyle.notetext,
          isDense: false,
          isCollapsed: false,
          counterText: "",
          labelText: hasText ? 'Enter Mobile Number' : null,
          border: const OutlineInputBorder(),
          errorMaxLines: 2,
          fillColor: Colors.transparent,
          filled: true,
          hintText: hintText,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          hintStyle: CustomTextStyle.regulargrey,
          prefixStyle: const TextStyle(
            color: Customcolors.DECORATION_BLACK,
          ),
          labelStyle: const TextStyle(color: Customcolors.DECORATION_GREY),
          prefixIconColor: Customcolors.DECORATION_BLACK,
          prefixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Customcolors.DECORATION_RED),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Customcolors.DECORATION_RED),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              )),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Customcolors.DECORATION_GREY),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Customcolors.DECORATION_GREY),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
class AddressFormFeild extends StatelessWidget {
  final String hintText;
  final Widget? hintStyle;
  final String? labelText;
  final String? label;
  final double fontSize;
  final InputDecoration? decoration;
  final String? initialValue;
  final bool autoFocus;
  final bool mask;
  final bool readonly;
  final TextInputType keyboardType;
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String value)? onChanged;
  final Function(String value)? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? prefixStyle;
  final Widget? prefixIconColor;
  final Widget? prefixIconConstraints;
  final int? maxLines;
  final int? maxLength;
  final bool isNormal; final FocusNode? focusNode;

  final bool? enabled;
   const AddressFormFeild(
      {super.key,
      required this.hintText,
      this.onChanged,
      this.initialValue,
      this.hintStyle,
      this.label,
      this.prefixIconColor,
      this.prefixIconConstraints,
      this.fontSize = 16,
      this.autoFocus = false,
      this.mask = false,
      this.onFieldSubmitted,
      this.keyboardType = TextInputType.text,
      this.textCapitalization,
      this.inputFormatters,
      this.validator,
      this.prefixIcon,
      this.prefixStyle,
     this.readonly = false,
      this.suffixIcon,
      this.controller,
      this.maxLines,
      this.labelText,
      this.maxLength,
      this.isNormal = false,
      this.enabled,  this.decoration,  this.focusNode,});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            expands: false,
            autofocus: autoFocus,
            onFieldSubmitted: onFieldSubmitted,
            obscureText: mask,
            validator: validator,
            maxLines: maxLines,
            maxLength: maxLength,
            controller: controller,
            decoration: decoration,
            autocorrect: false,
            enabled: enabled,
            readOnly: readonly,
            keyboardType: keyboardType,
            cursorColor: Colors.black,
            textAlign: TextAlign.start,
            initialValue: initialValue,
            inputFormatters: inputFormatters,
            onChanged: onChanged, focusNode: focusNode,
          ),
        ),
      ],
    );
  }
}

class RequiredTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;

  const RequiredTextFormField({super.key, this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              border: const UnderlineInputBorder(),
            ),
          ),
        ),
        const Text(
          '*',
          style: TextStyle(color: Colors.red, fontSize: 16.0),
        ),
      ],
    );
  }
}
