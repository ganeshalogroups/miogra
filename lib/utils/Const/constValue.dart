// ignore_for_file: file_names
import 'package:logger/logger.dart';

String? staticLatitude = "";
String? staticLongitude = "";
String? currentAddress = "";
Map<String, dynamic>? selectedAddress = {};
Map<String, dynamic> addressData = {};

String currentlatitude = '';
String currentlongitude = '';

String currentfullinitialaddress = '';
String? currentaddress;

//for email registation or login

String usergoogleemail = '';
String usergoogleusername = '';

double initiallat = 0.0;
double initiallong = 0.0;

String contactType = 'myself';
String country = 'India';

// for resturantdestinatiin

double resturantLatitude = 8.197601834538228;
double resturantLongitude = 77.38650532586492;

//ngl lat long  8.180089, 77.416949

/// for navigation
///

bool buttonfunction = false;

// List<String> cartIdList = [];

bool isDuplicatePage = false;

bool isCart = false;
List cartidList = [];
const double searchBarHeight = 60.0;

String postcode = '';
// String type = '';

final logger = Logger();

// List<dynamic> cartItems = [];

String homeLocationIcon = 'assets/images/Subtract.png';

// String gresturantId ='';

Logger loge = Logger();

String pickupvalidationquot = 'Please select Pickup Address';
String dropvalidationquot = 'Please select Drop Address';
String packagecontentQuot = 'Please select Package Type';
String packageweightQuot = 'Please select Package Weight';
String imageErrorQuot = 'Please Upload Image ';

String parcelservice = 'services';
String foodservices = 'restaurant';

String vendorIdforParcel = '';
String? globalImageUrlLink;
dynamic kilometre;

String? selectedFullAddress;
//// Rotation Text Contents
///




List<String> foodrotationTexts = [
  '‘ Parotta ’',
  '‘ Pizza ’',
  '‘ Burger ’',
  '‘ Sushi ’',
  '‘ Biriyani ’',
];



// for meat flow


List<String> rotationTextsMeatFlow = [
            '‘ Sea Fish ’',
            '‘ Fillets & Slices ’',
            '‘ Prawns ’',
            '‘ Crabs ’',
            '‘ Lobsters ’',
            '‘ Dry Fish ’',
          ];



// for mart flow


List<String> rotationTextsMartFlow = [
            '‘ vegetables ’',
            '‘ Fruits ’',
            '‘ Oils ’',
            '‘ Rice ’',
            '‘ Snacks ’',
            '‘ Masala ’',
          ];

// final GlobalKey<FormState> tipformKey = GlobalKey<FormState>();