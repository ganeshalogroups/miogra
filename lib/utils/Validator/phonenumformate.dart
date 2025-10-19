import 'package:flutter/services.dart';


class FourDigitFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text.replaceAll(RegExp(r'\s'), '');
    final buffer = StringBuffer();

    for (int i = 0; i < newText.length; i += 5) {
      final end = i + 5;
      if (end >= newText.length) {
        buffer.write(newText.substring(i));
      } else {
        buffer.write('${newText.substring(i, end)} ');
      }
    }

    var formattedText = buffer.toString();

    if (formattedText.length > 12) {
      formattedText = formattedText.substring(0, 12);
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}