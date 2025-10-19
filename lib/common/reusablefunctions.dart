



import 'package:testing/utils/Const/constImages.dart';

String getFoodTypeIcon({required String foodType}) {
  switch (foodType.toLowerCase()) {
    case 'nonveg':
      return nonvegIcon;
    case 'veg':
      return vegIcon;
    case 'egg':
      return eggIcon;
    default:
      return ''; // Return an empty string if no match
  }
}