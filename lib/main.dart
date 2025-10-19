import 'package:app_links/app_links.dart';
import 'package:testing/Features/Authscreen/AuthController/controllerForFavAdd.dart';
import 'package:testing/Features/Authscreen/Splashscreen.dart';
import 'package:testing/Features/Foodmodule/Data/cartprovider.dart';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Addfoodcontroller.dart';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Bannercontroller.dart';
import 'package:testing/Features/Foodmodule/Foodviewscreen/AddButtonFunctions/Buttonfunctionalities.dart';
import 'package:testing/Features/Foodmodule/Foodviewscreen/AddButtonFunctions/Foodclearsearch.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/Foodgetcontroller.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Orderprocess.dart';
import 'package:testing/Features/Homepage/homepage.dart';
import 'package:testing/Features/OrderScreen/OrderScreenController/OrdersControllerPagination.dart';
import 'package:testing/Features/OrderScreen/OrderScreenController/Orderviewscreen_notifyview..dart';
import 'package:testing/Features/OrderScreen/OrderScreenController/trackOrderController.dart';
import 'package:testing/Mart/Cartscreen/Commoncartwidgets/Martadditionalinfo.dart';
import 'package:testing/Mart/Common/MartButtonFunctionalites.dart';
import 'package:testing/Mart/Homepage/MartHomepageController/MartcategorypaginationController.dart';
import 'package:testing/Mart/MartProductsview/Productscontroller/ProductgetpaginationController.dart';
import 'package:testing/Meat/Common/Searchshopcontroller.dart';
import 'package:testing/Meat/MeatButtonFunctionalities/TotalitemcountButton.dart';
import 'package:testing/Meat/MeatController.dart/MeatProductviewcontroller.dart';
import 'package:testing/Meat/MeatData/Meatfavprovider.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatOrderController/ControllerForFavMeat.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatOrderController/MeatCouponcontroller.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatOrderController/MeatFavouritecontroller.dart';
import 'package:testing/Meat/MeatOrderscreen/meatadditionalinfo.dart';
import 'package:testing/map_provider/AddressProvider/addressProvider.dart';
import 'package:testing/map_provider/Map%20Screens/MapSearch.dart/addressnameController.dart';
import 'package:testing/Features/coupon/couponController.dart';
import 'package:testing/firebase_options.dart';
import 'package:testing/map_provider/locationprovider.dart';
import 'package:testing/parcel/p_services_provider/imagePickerProvider.dart';
import 'package:testing/parcel/p_services_provider/p_address_provider.dart';
import 'package:testing/parcel/p_services_provider/p_distance_provider.dart';
import 'package:testing/parcel/p_services_provider/p_historyController.dart';
import 'package:testing/parcel/p_services_provider/p_regon_provider.dart';
import 'package:testing/parcel/p_services_provider/p_validation_errorProvider.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/localvaluesmanagement.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'Features/Bottomsheets/Adduserbottomsheet.dart';
import 'Features/Foodmodule/getFoodCartProvider.dart';
import 'Features/Homepage/profile/imageUploader.dart';
import 'Features/OrderScreen/OrderScreenController/resturantIdController.dart';
import 'InternetConnectivity/netWork_Controller.dart';
import 'parcel/p_services_provider/p_Round_Trip_Validation.dart';
import 'parcel/p_services_provider/p_createParcel_Provider.dart';

// Background message handler
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  flutterLocalNotificationsPlugin.show(
    message.data.hashCode,
    message.data['title'],

    message.data['body'],
    payload: message.data['screen'].toString(), // Pass the route as the payload
    NotificationDetails(
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        sound: const RawResourceAndroidNotificationSound(
            "default_notification_sound"),
        playSound: true,
      ),
    ),
  );
}

// Notification channel and plugin initialization
AndroidNotificationChannel channel = const AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  importance: Importance.max,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.instance.getToken().then((value){
    tokenFCM = value.toString();
  });

  FirebaseMessaging.instance.requestPermission(
    badge: true,
    sound: true,
    alert: true,
  );

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await GetStorage.init();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final appLinks = AppLinks(); // AppLinks is singleton

// Subscribe to all events (initial link and further)

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Initialize local notifications
      var initializationSettingsAndroid =
          const AndroidInitializationSettings('@mipmap/ic_launcher');
      var initializationSettings =
          InitializationSettings(android: initializationSettingsAndroid);

      flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
          print("+++++++++++++++++++++++++++++++++++++++++++++");
          print(response.payload);
          String? targetScreen = response.payload;
          if (targetScreen != null && targetScreen != "none") {
            Get.to(() => Orderviewscreen(
                  orderId: targetScreen.toString(),
                ));
          }
        },
      );
      FirebaseMessaging.onMessage.listen(_onMessageReceived);
      FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpened);
    });
    final sub = appLinks.uriLinkStream.listen((uri) {
      // Do something (navigation, ...)
      print("hhgdjjshjsbhhb ****************** ${uri}");
    });
  }

  // Handle messages when the app is opened from a notification
  static Future<void> _onMessageOpened(RemoteMessage message) async {
    print("Customer App opened via notification");
    String? targetScreen = message.data['screen']; // Example key

    if (targetScreen != null && targetScreen != "none") {
      print(
          "++++++++++++++++++_onMessageOpened function+++++++++++++++++++++++++++");
      print(targetScreen);
      Get.to(() => Orderviewscreen(
            orderId: targetScreen.toString(),
          ));
    }
    print(
        'App opened from _onMessageOpened function notification: ${message.notification?.title}');
    String? route = message.data['route']; // Extract the route from data
    if (route != null) {
      Get.toNamed(route);
    }
  }

  // Foreground message handler
  static Future<void> _onMessageReceived(RemoteMessage message) async {
    print('Received message: ${message.notification?.title}');
    await _showLocalNotification(message);
  }

  // Show a local notification
  static Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'your_channel_id', // Make sure to match this with AndroidManifest.xml
      'Your Channel Name',
      channelDescription: 'Your channel description',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
      payload: message.data['screen'], // Pass the route as the payload
    );
  }

  // var latpass;
  @override
  Widget build(BuildContext context) {
    //  Get.put(NetworkConnectivity(), permanent: true);
    Get.put(Foodcartcontroller());
    Get.put<TipsProvider>(TipsProvider());

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      child: Builder(
        builder: (context) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => TripImageProvider()),
              ChangeNotifierProvider(create: (_) => TipsProvider()),
              ListenableProvider(create: (context) => LocationProvider()),
              ChangeNotifierProvider(create: (_) => FavoritesProvider()),
              ChangeNotifierProvider(create: (_) => MeatFavoritesProvider()),
              ChangeNotifierProvider(
                  create: (context) => AddressNameController()),
              ChangeNotifierProvider(create: (context) => FoodCartProvider()),
              ChangeNotifierProvider(
                  create: (context) => FoodProductviewPaginations()),
              ChangeNotifierProvider(create: (context) => HomepageProvider()),
              ChangeNotifierProvider(create: (context) => ButtonController()),
              ChangeNotifierProvider(
                  create: (context) => MeatButtonController()),
              ChangeNotifierProvider(
                  create: (context) => MartButtonController()),
              ChangeNotifierProvider(create: (context) => CouponController()),
              ChangeNotifierProvider(
                  create: (context) => MeatCouponController()),
              ChangeNotifierProvider(create: (context) => MapDataProvider()),
              ChangeNotifierProvider(create: (context) => ListProvider()),
              ChangeNotifierProvider(
                  create: (context) => InitializeFavProvider()),
              ChangeNotifierProvider(
                  create: (context) => MeatInitializeFavProvider()),
             ChangeNotifierProvider(create: (context) => MeatListProvider()),
              ChangeNotifierProvider(
                  create: (context) => MeatFavouritegetPagination()),
              ChangeNotifierProvider(
                  create: (context) => TrackOrderController()),
              ChangeNotifierProvider(create: (context) => GetOrdersProvider()),
              ChangeNotifierProvider(create: (context) => SearchResturant()),
              ChangeNotifierProvider(create: (context) => SearchShop()),
              ChangeNotifierProvider(create: (context) => GetAddressProvider()),
              ChangeNotifierProvider(
                  create: (context) => InstantUpdateProvider()),
              ChangeNotifierProvider(
                  create: (context) => MartCategoryviewPaginations()),
              ChangeNotifierProvider(
                  create: (context) => MartProductGetPaginations()),
              ChangeNotifierProvider(
                  create: (context) => MeatInstantUpdateProvider()),
              ChangeNotifierProvider(
                  create: (context) => MartInstantUpdateProvider()),
              ChangeNotifierProvider(create: (context) => FoodSearchProvider()),
              ChangeNotifierProvider(
                  create: (context) => ParcelAddressProvider()),
              ChangeNotifierProvider(
                  create: (context) => ValidationErrorProvider()),
              ChangeNotifierProvider(
                  create: (context) => ImageUploaderProvider()),
              ChangeNotifierProvider(
                  create: (context) => CreatePArcelProvider()),
              ChangeNotifierProvider(
                  create: (context) => CommonDistanceGetClass()),
              ChangeNotifierProvider(
                  create: (context) => ParcelRegonProvider()),
              ChangeNotifierProvider(
                  create: (context) => MeatProductviewPaginations()),
              ChangeNotifierProvider(
                  create: (context) => RoundTripLOcatDataProvider()),
              ChangeNotifierProvider(
                  create: (context) => RoundTripImageUploaderProvider()),
              ChangeNotifierProvider(
                  create: (context) => RoundValidationErrorProvider()),
              ChangeNotifierProvider(
                  create: (context) => ParcelOrdersHistoryProvider()),
                
            ],
            child: GlobalLoaderOverlay(
              // ignore: deprecated_member_use
              useDefaultLoading: false,
              overlayWidgetBuilder: (_) {
                return const Center(
                    child: CupertinoActivityIndicator(
                        color: Customcolors.DECORATION_BLACK));
              },
              child: GetMaterialApp(
                key: navigatorKey,
                builder: (BuildContext context, Widget? child) {
                  return MediaQuery(
                    //  data: MediaQuery.of(context).copyWith(textScaler:  TextScaler.noScaling),
                    data: MediaQuery.of(context)
                        .copyWith(textScaler: const TextScaler.linear(1.0)),
                    child: child!,
                  );
                },
                debugShowCheckedModeBanner: false,
                title: 'Kipgra',
                theme: ThemeData(
                    brightness: Brightness.light, // Set to light mode
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: Customcolors.DECORATION_WHITE,
                      brightness: Brightness.light,
                    ),
                    bottomSheetTheme: const BottomSheetThemeData(
                        backgroundColor: Colors.white,
                        modalBackgroundColor: Colors.white,
                        surfaceTintColor: Colors.white),
                    useMaterial3: true),
               home: const SplashScreen(),
          // home: Orderprocess(),
              ),
            ),
          );
        },
      ),
    );
  }
}











