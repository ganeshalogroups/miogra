// ignore_for_file: avoid_print, file_names

import 'dart:async';
import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:testing/Features/Homepage/homeStyles/FoodHomedecorations.dart';
import 'package:testing/Features/OrderScreen/OrderScreenController/trackOrderController.dart';
import 'package:testing/Features/OrderScreen/TrackOrderdetails.dart';
import 'package:testing/map_provider/Map%20Screens/markervaluse.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/CustomDottedline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';



// ignore: must_be_immutable
class Trackorder extends StatefulWidget {
  bool isfromhome;
  String  ordeID;
  dynamic resname;
  dynamic status;
  dynamic ordercode;
  dynamic datetime;
    LatLng userlat;
    dynamic createdAt;
  LatLng resturantlatlng;
  Trackorder(
      {this.resname,
      this.status,
      this.ordercode,
      this.datetime,
      this.isfromhome = false,
      required this.ordeID,
      required this.resturantlatlng,
      required this.userlat,
      this.createdAt,
      super.key});

  @override
  State<Trackorder> createState() => _TrackorderState();
}

class _TrackorderState extends State<Trackorder> {



  Timer? canceltimer;                          // Timer for countdown
  final Map<int, int> _countdownValues = {};   

  Timer? _timer;
  int    _activeIndex = 0;
  var    orderState = '';


  @override
  void initState() {
    super.initState();
    // Ensure this runs after the widget is fully built
    WidgetsBinding.instance.addPostFrameCallback((_)  async {
        orderState = widget.status;
        orderState = await Provider.of<TrackOrderController>(context, listen: false).getOrders(orderId: widget.ordeID);
        _updateStepper(orderStatus: orderState);
        _startTimer();
    });
  }
  
  String orderSts = '';

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) async {
      try {
        // Check if the widget is still mounted before making async calls
        if (!mounted) return;

        var newOrderState = await Provider.of<TrackOrderController>(context, listen: false).getOrders(orderId: widget.ordeID);
        
        if (!mounted) return;

        // Safely update the state
        setState(() {
          orderState = newOrderState;
          orderSts = orderState.toString();
        });

        _updateStepper(orderStatus: orderSts);
          
        if (orderSts == 'delivered' || orderSts == 'cancelled') {
            _timer?.cancel(); // Stop the timer
            _timer = null; // Set timer to null to avoid potential memory leaks
        }
      } catch (e) {

        print('Error fetching order status: $e');

        }
      }
    );
    }

  void _updateStepper({required String orderStatus}) {
    int newIndex = _getActiveIndex(status: orderStatus);
    if (newIndex != _activeIndex) {
      setState(() {
        _activeIndex = newIndex;
      });
    }
  }


  @override
  void dispose() {
     canceltimer?.cancel();
    _timer?.cancel();
    super.dispose();
  }






  List<StepperData> _buildStepperData() {
    return [
      StepperData(
        title: StepperText("Restaurant accepted the order", textStyle: _activeIndex >= 1 ? TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins-Medium',
      color: Customcolors.darkpurple
     ) : CustomTextStyle.chipgrey ),
       
        iconWidget: Container(
          // padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _activeIndex >= 1 ? Customcolors.darkpurple  : Customcolors.DECORATION_GREY,
                            
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
          child: _activeIndex >= 1
              ? const Center(child: Icon(Icons.check, size: 13, color: Colors.white)) : null,
        ),
      ),
      StepperData(
        title: StepperText(
          "Order assigned to delivery partner",
          textStyle: _activeIndex >= 2 ?TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins-Medium',
      color: Customcolors.darkpurple
     ) : CustomTextStyle.chipgrey,
        ),

        iconWidget: Container(
          decoration: BoxDecoration(
            color: _activeIndex >= 2  ? Customcolors.darkpurple : Customcolors.DECORATION_GREY,
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
          child: _activeIndex >= 2   ? const Icon(Icons.check, size: 13, color: Colors.white) : null,

        ),
      ),

      StepperData(
        title: StepperText(
          "Order picked up",
          textStyle: _activeIndex >= 3
              ? TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins-Medium',
      color: Customcolors.darkpurple
     )
              : CustomTextStyle.chipgrey,
        ),
        iconWidget: Container(
          // padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _activeIndex >= 3
                ? Customcolors.darkpurple
                : Customcolors.DECORATION_GREY,
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
          child: _activeIndex >= 3
              ? const Icon(Icons.check, size: 13, color: Colors.white)
              : null,
        ),
      ),
      StepperData(

        title: StepperText(
          "Delivery partner reached door",
          textStyle: _activeIndex >= 4   ? TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins-Medium',
      color: Customcolors.darkpurple
     )  : CustomTextStyle.chipgrey,
          
        ),
        iconWidget: Container(
          decoration: BoxDecoration(
            color: _activeIndex >= 4  ? Customcolors.darkpurple  : Customcolors.DECORATION_GREY,
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
          child: _activeIndex >= 4
              ? const Icon(Icons.check, size: 13, color: Colors.white)
              : null,
        ),
      ),
      StepperData(
        title: StepperText(
          "Order delivered",
          textStyle: _activeIndex >= 5
              ? TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins-Medium',
      color: Customcolors.darkpurple
     )
              : CustomTextStyle.chipgrey,
        ),
        iconWidget: Container(
          decoration: BoxDecoration(
            color: _activeIndex >= 5 ? Customcolors.darkpurple  : Customcolors.DECORATION_GREY,
            
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
          child: _activeIndex >= 5 ? const Icon(Icons.check, size: 13, color: Colors.white) : null,
             
            
        ),
      ),
    ];
  }









  List<StepperData> rejectedSteperData({statuss}) {
    return [
      StepperData(
        title: StepperText(
          "Restaurant Initialized",
          textStyle: _activeIndex >= 1 ? CustomTextStyle.DECORATION_regulartext : CustomTextStyle.chipgrey,
            
        ),
           iconWidget: Container(
          decoration: const BoxDecoration(
            color: Customcolors.darkpurple ,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child:  const Icon(Icons.check, size: 13, color: Colors.white) ,

        ),
      ),
      StepperData(
        title: StepperText(
     statuss == 'cancelled' ? 'Order Canceled'  :   "Order rejected By Resturant",
          textStyle: _activeIndex >= 2 ? CustomTextStyle.DECORATION_regulartext : CustomTextStyle.chipgrey,
        ),

        iconWidget: Container(
          decoration: const BoxDecoration(
            color: Customcolors.darkpurple ,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child:  const Icon(Icons.check, size: 13, color: Colors.white) ,

        ),
      ),



    ];
  }









  int _getActiveIndex({status}) {
    switch (status) {
      case "new":
        return 1; // Highlight "Restaurant accepted the order"
      case "orderAssigned":
        return 2; // Highlight "Your order is being prepared"
      case "orderPickedUped":
        return 3; // Highlight "Delivery partner picked up the order"
      case "deliverymanReachedDoor":
        return 4; // Highlight "Delivery partner at your door step"
      case "delivered":
        return 5;
      default:
        return 0; // Default to first step
    }
  }



    Future<void> makePhoneCall({ required String phoneNumber}) async {
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );
      await launchUrl(launchUri);
    }

Future<void> makeSms({required String phoneNumber, required String message}) async {
  final Uri launchUri = Uri(
    scheme: 'sms',
    path: phoneNumber,
    query: 'body=${Uri.encodeComponent(message)}',
    // queryParameters: <String, String>{
    //   'body': message,
    // },
  );

  if (await canLaunchUrl(launchUri)) {
    await launchUrl(launchUri);
  } else {
    throw 'Could not launch SMS';
  }
}









@override
  Widget build(BuildContext context) {
  var orderProvider = Provider.of<TrackOrderController>(context).orderModel;

  var createdAt = DateTime.parse(widget.createdAt);
   // var formattedTime = formatTime(dateStr: value.orderModel[index]['createdAt']);
  int countdownValue = _getCountdownValue(createdAt);

      return PopScope(
    child: Scaffold(
      backgroundColor: Customcolors.DECORATION_CONTAINERGREY,
      appBar: AppBar(
        title: const Text('Track Order', style: CustomTextStyle.darkgrey),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                // Stepper and other widgets
                Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: FoodDecorations().stepperBoxDecoraion,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${widget.resname.toString().capitalizeFirst}",
                                  style: CustomTextStyle.boldblack2,
                                ),
                                // Text(
                                //   "${orderState.toString().capitalizeFirst}",
                                //   style: CustomTextStyle.yellowtext,
                                // ),
                                  Expanded(
  flex: 15,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Flexible(
        child: Text(
          getStatusLabel(orderState.toString() ?? ''),
          style: getStatusTextStyle(orderState.toString() ?? ''),
          overflow: TextOverflow.visible,
          textAlign: TextAlign.right,
        ),
      ),
    ],
  ),
),

                              ],
                            ),
                                const SizedBox(height: 5),
                            Text(
                              "Order Id :  ${widget.ordercode.toString()}",
                              style: CustomTextStyle.mapgrey,
                            ),
                            Text(
                              "${widget.datetime}",
                              style: CustomTextStyle.mapgrey,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: CustomDottedContainer(),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
    
                              child: orderSts == 'rejected'|| orderSts == 'cancelled' ?
                              
                              AnotherStepper(
                                stepperList:  rejectedSteperData(statuss: orderSts),
                                stepperDirection: Axis.vertical,
                                iconWidth: 20,
                                iconHeight: 20,
                                activeBarColor: Customcolors.darkpurple,
                                inActiveBarColor: Customcolors.DECORATION_GREY,
                                inverted: false,
                                verticalGap: 12,
                                activeIndex: _activeIndex,
                                barThickness: 1,
                              )
                              :
                               AnotherStepper(
                                stepperList:  _buildStepperData(),
                                stepperDirection: Axis.vertical,
                                iconWidth: 20,
                                iconHeight: 20,
                                activeBarColor: Customcolors.darkpurple,
                                inActiveBarColor: Customcolors.DECORATION_GREY,
                                inverted: false,
                                verticalGap: 12,
                                activeIndex: _activeIndex,
                                barThickness: 1,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: CustomDottedContainer(),
                            ),
    
                          ],
                        ),
                      )
                    ),
              
    
    
    
              Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Customcolors.DECORATION_WHITE,
                        boxShadow: [
                          BoxShadow(
                            color:
                                Customcolors.DECORATION_LIGHTGREY, //color of shadow
                            spreadRadius: 5, //spread radius
                            blurRadius: 7, // blur radius
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "Deliver to",
                              style: CustomTextStyle.smallblacktext,
                            ),
                            const SizedBox(height: 10),
                            Consumer<TrackOrderController>(
                              builder: (context, value, child) {
                                if (value.orderModel == null) {
                                  return const SizedBox.shrink();
                                } else {
              
              
              
                              String fullAddress =   '${value.orderModel['dropAddress'][0]['houseNo']}, ${value.orderModel['dropAddress'][0]['landMark'].toString()}, ${value.orderModel['dropAddress'][0]['fullAddress']},';
              
              
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
    
    
    
    
    
                                      Image.asset(
                                          value.orderModel['dropAddress'][0]['addressType'] == 'Home'  ?  homeicon : value.orderModel['dropAddress'][0]['addressType'] == 'Other' || value.orderModel['dropAddress'][0]
                                                     
                                                 
                                          
                                                                   
                                               ['addressType'] == 'Current' || value.orderModel['dropAddress'][0]['addressType'] == 'Selected'  ? othersicon  : workicon,
                                                          
                                                      
                                                                 
                                                              
                                                          
                                                 
                                                 
                                          scale: 3,color:Color(0xFF623089)
),
                                      const SizedBox(width: 5),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              value.orderModel['dropAddress'][0]['addressType'].toString(),
                                              style: CustomTextStyle.boldblack2,
                                            ),
                                            const SizedBox(height: 5),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width * 0.75,
                                              child: Text(
                                                fullAddress,
                                                style: CustomTextStyle.chipgrey,
                                              ),
                                            ),
                                          ]),
                                    ],
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
    
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: FoodDecorations().delivarymanDecoraion,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
    
                            Row(
                              children: [
                                // Display delivery partner's image
                           
                                   orderProvider != null && 
                                     orderProvider['assigneeDetails'] != null &&  
                                     orderProvider['assigneeDetails']['imgUrl'] != null
                                       
    
    
                                        ?  CircleAvatar(backgroundImage: NetworkImage("$globalImageUrlLink${orderProvider['assigneeDetails']['imgUrl']}".toString()),radius: 25,)
                             
                                    : Container(
                                        margin: const EdgeInsets.only(right: 10),
                                        child: Image.asset(
                                          "assets/images/Profile.png",
                                          height: 45,
                                          width: 45,
                                        ),
                                      ),
    
    
    
                                const SizedBox(width: 10),
                                // Display delivery partner's name
                                Consumer<TrackOrderController>(
    
                                  builder: (context, value, child) {
    
                                    if (value.orderModel == null) {
                                      return const Text('Waiting for delivery partner...');
                                    } else if (value.orderModel['assigneeDetails'] == null) {
                                      return const Text('No delivery partner assigned yet.',   style: CustomTextStyle.smallgrey,);
                                    } else {
                                     if (_countdownValues.isEmpty) {
                for (int index = 0; index < value.orderModel.length; index++) {
                  DateTime createdAt = DateTime.parse(widget.createdAt);
                  _countdownValues[index] = _getCountdownValue(createdAt);
                }
                _startCountdown();
              }
                                      return Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                value.orderModel['assigneeDetails']['name'] ?? 'No name',
                                                style: CustomTextStyle.boldblack2,
                                              ),
                                              const SizedBox(height: 5),
                                              const Text(
                                                "Delivery Partner",
                                                style: CustomTextStyle.smallgrey,
                                              ),
                                          
                                          
                                          
                                          
                                          
                                          
                                          
                                            ],
                                          ),
    
    
    
    
    
    
    
    
    
    
                                          
                                        ],
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
    
                            // Call button and mail icon
             orderProvider != null &&   orderProvider['assigneeDetails'] != null && orderProvider['assigneeDetails']['mobileNo'] != null  ?    Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () async {
    
    
                             if( orderProvider != null &&   orderProvider['assigneeDetails'] != null && orderProvider['assigneeDetails']['mobileNo'] != null ){
    
                                     String mobileno = orderProvider['assigneeDetails']['mobileNo'].toString();
    
                                      await makePhoneCall(phoneNumber: mobileno);
    
                                }
                                  
                                  },
                                  child: Image.asset(
                                    height: 40,
                                    width: 30,
                                    "assets/images/Fill call.png",color: Color(0xFF623089),
                                  ),
                                ),
                                SizedBox(width: 15.w),
                                InkWell(
                                  onTap: () {
    
                                if( orderProvider != null &&   orderProvider['assigneeDetails'] != null && orderProvider['assigneeDetails']['mobileNo'] != null ){
    
    
                                  String mobileno = orderProvider['assigneeDetails']['mobileNo'].toString();

                                   makeSms(phoneNumber: mobileno,message: 'When Will I Get My Order');  
                                    // launchUrl(Uri.parse('https://wa.me/+91$mobileno?text= Hi, when will I get my order? '), mode: LaunchMode.externalApplication);
                                                                 
    
                                }else{
    
    
                                  
                                }
                                    // makeSms(phoneNumber: '9751460125');
    
                               
                                  },
                                  child: Image.asset(
                                    height: 40,
                                    width: 30,
                                    "assets/images/Fill mail.png",color: Color(0xFF623089),
                                  ),
                                ),
                              ],
                            ) :  const SizedBox(),
    
    
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.symmetric(vertical: 22,horizontal: 95),
                  child: Center(
                    child: InkWell(
                    onTap: () {
                      
                       Get.to(TrackOrderDetails(orderId: widget.ordeID,resturantlatlng: widget.resturantlatlng,userlat: widget.userlat,orderStatus: widget.status,), transition: Transition.leftToRight);
                       
                    },
                      child: CustomContainer(
                        decoration: CustomContainerDecoration.gradientbuttondecoration(),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          child: Center(
                            child: Text(
                              "View Map",
                              style: CustomTextStyle.smallwhitetext,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

  String getStatusLabel(String status) {
  switch (status) {
    case "new":
      return "Order is Being Prepared";
    case "initiated":
      return "Order Placed";
    case "orderAssigned":
      return "Order Assigned";
    case "orderPickedUped":
      return "Order Picked Up";
    case "delivered":
      return "Delivered";
    case "cancelled":
      return "Cancelled";
    case "rejected":
      return "Rejected";
    case "deliverymanReachedDoor":
      return "Deliveryman Reached Door";
    default:
      return "Unknown Status";
  }
}

TextStyle getStatusTextStyle(String status) {
  switch (status) {
    case "delivered":
      return CustomTextStyle.greenordertext;
    case "cancelled":
    case "rejected":
      return CustomTextStyle.redmarktext;
    default:
      return CustomTextStyle.orangeeetext;
  }
}

void _startCountdown() {

    canceltimer = Timer.periodic(const Duration(seconds: 1), (timer) {

      setState(() {
        _countdownValues.forEach((index, countdownValue) {
          if (countdownValue > 0) {
            _countdownValues[index] = countdownValue - 1;
          }
        });
      });
    });
  }
}





 int _getCountdownValue(DateTime createdAt) {
    DateTime currentTime = DateTime.now().toUtc();
    DateTime endTime = createdAt.add(const Duration(seconds: 60));
    Duration difference = endTime.difference(currentTime);
    return difference.isNegative ? 0 : difference.inSeconds;
  }




