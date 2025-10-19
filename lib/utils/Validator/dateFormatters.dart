

// ignore_for_file: file_names

import 'package:intl/intl.dart';

class DateTimeFormaterC{



String formatDateTime(String isoDateTime) {
  // Parse the ISO 8601 string into a DateTime object
  DateTime parsedDateTime = DateTime.parse(isoDateTime);
  // Format the DateTime object into a readable string
  String formattedDateTime = DateFormat('yyyy-MM-dd hh:mm a').format(parsedDateTime);

  return formattedDateTime;
}





}