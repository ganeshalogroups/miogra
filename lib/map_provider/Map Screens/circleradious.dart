


  import 'dart:math';

double calculateDistance(lat1, lon1, lat2, lon2) {

      const double R = 6371000; // Radius of the Earth in meters
      double dLat = (lat2 - lat1) * pi / 180.0;
      double dLon = (lon2 - lon1) * pi / 180.0;
      double a = sin(dLat / 2) * sin(dLat / 2) + cos(lat1 * pi / 180.0) * cos(lat2 * pi / 180.0) * sin(dLon / 2) * sin(dLon / 2);
      double c = 2 * atan2(sqrt(a), sqrt(1 - a));
      double distance = R * c;
      return distance;


  }





  