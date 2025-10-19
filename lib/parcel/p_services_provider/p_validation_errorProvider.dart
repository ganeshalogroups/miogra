// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';

class ValidationErrorProvider with ChangeNotifier {


  
  String pickuperror = '';
  String droperror = '';
  String contenterror = '';
  String weighterror = '';
  String errormessage = '';
  String imageerror = '';

  addpicupError({pickupcontent}) {
    pickuperror = pickupcontent;
    notifyListeners();
  }

  adddropError({dropcontent}) {
    droperror = dropcontent;
    notifyListeners();
  }

  addContentError({content}) {
    contenterror = content;
    notifyListeners();
  }

  addweightError({weightcontent}) {
    weighterror = weightcontent;
    notifyListeners();
  }

  addimageError({imageError}) {
    imageerror = imageError;
    notifyListeners();
  }



void clearSingleTripData(){ 

  
   pickuperror = '';
   droperror = '';
   contenterror = '';
   weighterror = '';
   errormessage = '';
   imageerror = '';
   notifyListeners();

}






}











/// Validation  for Round Trip 
/// 
/// 
/// 
/// 



class RoundValidationErrorProvider with ChangeNotifier {

  String pickuperror  = '';
  String droperror    = '';
  String contenterror = '';
  String weighterror  = '';
  String errormessage = '';
  String imageerror   = '';

  addpicupError({pickupcontent}) {
    pickuperror = pickupcontent;
    notifyListeners();
  }

  adddropError({dropcontent}) {
    droperror = dropcontent;
    notifyListeners();
  }

  addContentError({content}) {
    contenterror = content;
    notifyListeners();
  }

  addweightError({weightcontent}) {
    weighterror = weightcontent;
    notifyListeners();
  }

  addimageError({imageError}) {
    imageerror = imageError;
    notifyListeners();
  }


 clearRoundTripData(){
      pickuperror  = '';
      droperror    = '';
      contenterror = '';
      weighterror  = '';
      errormessage = '';
      imageerror   = '';
      notifyListeners();
 }




}
