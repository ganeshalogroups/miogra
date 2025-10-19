// String? validatepPhone(String? value) {

//   if(value!.isEmpty){
//      return 'Mobile number is required';
//   }
//   if (value.length != 11) {
//     return 'Please enter valid mobile number';
//   }
//   if (RegExp(r'^[0-5]').hasMatch(value)) {
//     return 'Invalid format';
//   } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
//     return 'Special characters not allowed';
//   }
//   return null;
// }

String? validatepPhone(String? value) {
  if (value == null || value.isEmpty) {
    return 'Mobile number is required';
  }

  // Check if the phone number matches the pattern "XXXXX XXXXX"
  final RegExp phoneRegExp = RegExp(r'^\d{5} \d{5}$');
  if (!phoneRegExp.hasMatch(value)) {
    return 'Please enter a valid mobile number ';
  }
  if (RegExp(r'^[0-5]').hasMatch(value)) {
    return 'Invalid format';
  }
  //  else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
  //   return 'Special characters not allowed';
  // }
  return null;
}

String? updatePhoneValidation(String? value) {
  if (value == null || value.isEmpty) {
    return 'Mobile number is required';
  }

  // Remove any spaces
  String cleanedValue = value.replaceAll(' ', '');

  // Check if the cleaned value is exactly 10 digits
  if (cleanedValue.length != 10) {
    return 'Mobile number must be exactly 10 digits';
  }

  // Check if the cleaned value contains only digits
  if (!RegExp(r'^\d{10}$').hasMatch(cleanedValue)) {
    return 'Mobile number must contain only digits';
  }

  return null;
}

String? additionalPhoneValidation(String? value) {
  if (value == null || value.isEmpty) {
    return "Reciever's Mobile Number is Required";
  }

  // Remove any spaces
  String cleanedValue = value.replaceAll(' ', '');

 if (RegExp(r'^[0-5]').hasMatch(value)) {
    return 'Invalid format';
  }
  // Check if the cleaned value is exactly 10 digits
  if (cleanedValue.length != 10) {
    return 'Mobile number must be exactly 10 digits';
  }

  // Check if the cleaned value contains only digits
  if (!RegExp(r'^\d{10}$').hasMatch(cleanedValue)) {
    return 'Mobile number must contain only digits';
  }




  return null;
}

String? additionalName(String? value) {
  if (value == null || value.isEmpty) {
    return null;
  }
  if (!RegExp(r'^(?=.*[A-Za-z])[A-Za-z0-9 ]+$').hasMatch(value)) {
    return 'Enter Valid Name format';
  }
  return null;
}

String? validateEmail(String? value) {
  if (value!.isEmpty) {
    return 'Email is required';
  }

  if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value)) {
    return 'Enter a valid email address';
  }

  return null;
}

String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Name is required';
  }
  if (value.length > 25) {
    return 'Name must be less than or equal to 25 characters';
  }
  if (!RegExp(r'^(?=.*[A-Za-z])[A-Za-z0-9 ]+$').hasMatch(value)) {
    return 'Enter Valid Name format';
  }
  return null;
}
// String? profilevalidateName(String? value) {
//   if (value == null || value.isEmpty) {
//     return 'Name is required';
//   }
//   if (value.length > 25) {
//     return 'Name must be less than or equal to 25 characters';
//   }
//   return null;
// }

String? profilevalidateName(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Name is required';
  }

  // Check for starting with empty space
  if (value.startsWith(' ')) {
    return 'Name should not start with a space';
  }

  // Check for special characters
  final validNameRegex = RegExp(r'^[a-zA-Z\s]+$');
  if (!validNameRegex.hasMatch(value)) {
    return 'Name must contain only letters and spaces';
  }

  // Check for maximum length
  if (value.length > 25) {
    return 'Name must be less than or equal to 25 characters';
  }

  return null;
}


typedef ValidatorFunction = String? Function(String? value);

class ValidationUtils {
  static ValidatorFunction houseNumberValidator({required String fieldName}) {
    return (value) {
      if (value == null || value.isEmpty) {
        // return 'Please enter the $fieldName';
         return '$fieldName is required';
      }
      // final bool hasDigits = value.contains(RegExp(r'\d'));
      // final bool hasLetters = value.contains(RegExp(r'[a-zA-Z]'));

      // if (!hasDigits || !hasLetters) {
      //   return 'Must contain both letters and numbers(e.g., A12, 7/358G, Flat 7C)';
      // }

      return null;
    };
  }
}



typedef NormalValidation = String? Function(String? value);

class NormalValidationUtils {
  /// Validator for required fields
  static NormalValidation requiredFieldValidator({required String fieldName}) {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter $fieldName';
      }
      return null;
    };
  }
 static NormalValidation recievernameFieldValidator() {
    return (value) {
      if (value == null || value.isEmpty) {
        return "Receiver's Name is Required";
      }
       if (value.startsWith(' ')) {
    return 'Name should not start with a space';
  }

  // Check for special characters
  final validNameRegex = RegExp(r'^[a-zA-Z\s]+$');
  if (!validNameRegex.hasMatch(value)) {
    return 'Name must contain only letters and spaces';
  }
      return null;
    };
  }
  static NormalValidation requirednameFieldValidator({required String fieldName}) {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter $fieldName';
      }
       if (value.startsWith(' ')) {
    return 'Name should not start with a space';
  }

  // Check for special characters
  final validNameRegex = RegExp(r'^[a-zA-Z\s]+$');
  if (!validNameRegex.hasMatch(value)) {
    return 'Name must contain only letters and spaces';
  }
      return null;
    };
  }
}
