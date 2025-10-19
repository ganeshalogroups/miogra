// ignore_for_file: avoid_print, void_checks, file_names
import 'package:testing/Features/Authscreen/AuthController/Logincontroller.dart';
import 'package:testing/Features/Authscreen/Loginscreen.dart';
import 'package:testing/utils/Buttons/CustomButton.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Buttons/sms_callbutton.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

// ignore: must_be_immutable
class Otpscreen extends StatefulWidget {
  String? mobilenum;
   Otpscreen({super.key, this.mobilenum});

  @override
  State<Otpscreen> createState() => _OtpscreenState();
}

class _OtpscreenState extends State<Otpscreen> {

  LoginscreenController logincon = Get.put(LoginscreenController());

  bool isOtpFilled = false;
  bool isTyping    = false;
  bool isInvalidOtpMessageDisplayed = false;
  bool hasClickedButton  = false; // New state variable
  FocusNode otpFocusNode = FocusNode();

  final CountdownController _controller = CountdownController(autoStart: true);
  TextEditingController otpcontroller   = TextEditingController();
  final otpformkey                      = GlobalKey<FormState>();
  int endTime = DateTime.now().millisecondsSinceEpoch + 10000;
  bool _isTimerFinished = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    if(mounted){
FocusScope.of(context).requestFocus(otpFocusNode);
    }
      
    });
  }

  void resetState() {
    isOtpFilled = false;
    isTyping = false;
    isInvalidOtpMessageDisplayed = false;
    hasClickedButton = false;
    otpcontroller.clear();
    logincon.successMessage.value = "";
    logincon.showSmsCallMethod.value = false;
    _controller.restart();
  }

  void restartTimer() {
    setState(() {
      _isTimerFinished = false;
      _controller.restart();
    });
  }

  void onFinished() {
    setState(() {
      _isTimerFinished = true;

      // Actions to be performed when the countdown finishes
      hasClickedButton = false; // Reset button click status
    });
  }

  @override
  void dispose() {
    otpFocusNode.dispose();
    otpcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) async {
        resetState();
        return Future.value(true);
      },
      child: Form(
        key: otpformkey,
        child: Scaffold(
          backgroundColor: Customcolors.DECORATION_WHITE,
          body: SingleChildScrollView(
            child: Column(
              children: [
                CustomContainer(
                  height: 200.h,
                  decoration: CustomContainerDecoration.gradientdecoration(),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CustomContainer(height: 100.h),
                          Positioned(
                            top: 60.h,
                            left: 10.w,
                            child: InkWell(
                              onTap: () {
                                resetState();

                                Get.to(const Loginscreen(),transition: Transition.leftToRight);
              
                              },
                              child: const Icon(
                                Icons.arrow_back,
                                color: Customcolors.DECORATION_WHITE,
                                size: 30,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 60.h,
                            left: 100.w,
                            child: const Text(
                              "OTP verification",
                              style: CustomTextStyle.whiteheading,
                            ),
                          ),
                        ],
                      ),
                       Center(
                        child: Column(
                          children: [
                            const Text(
                              "We have sent a verification code to",
                              style: CustomTextStyle.whitetext,
                            ),
                            Text(
                              "+91-${widget.mobilenum}",
                              style: CustomTextStyle.whitetextbold,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50.h),
                CustomContainer(
                  height: 60.h,
                  width: MediaQuery.of(context).size.width / 1.2,
                  decoration: CustomContainerDecoration.whitecontainer(),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 4,
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(10),
                        activeBorderWidth: 1,
                        inactiveBorderWidth: 1,
                        fieldHeight: 50,
                        fieldWidth: 45,
                        activeFillColor: Customcolors.DECORATION_WHITE,
                        activeColor: Customcolors.DECORATION_GREY,
                        inactiveColor: Customcolors.DECORATION_GREY,
                    ),
                    keyboardType: TextInputType.number,
                    controller: otpcontroller,
                    enablePinAutofill: true,
                    onChanged: (value) {
                      
                      setState(() {
                        isOtpFilled = value.length == 4;
                        isTyping = value.isNotEmpty;
                        if (value.isNotEmpty && hasClickedButton) {


                          _controller.restart();
                          logincon.successMessage.value = "";
                          isInvalidOtpMessageDisplayed = false;
                        }
                      });
                    },
                    focusNode: otpFocusNode,
                  ),
                ),
                Obx(() {
                  if (logincon.successMessage.isNotEmpty) {
                    // Update state variable when "Uh oh! The OTP you entered is invalid.. Retry via" appears
                    isInvalidOtpMessageDisplayed = true;
                    return Text(
                      logincon.successMessage.value,
                      style: logincon.successMessage.value.contains("Didn't receive the OTP? Verify via:") ? CustomTextStyle
                              .boldgrey // Use your grey text style here
                          : CustomTextStyle
                              .rederrortext, // Use your red error text style here
                    );
                  } else if (logincon.showSmsCallMethod.value) {
                    return const Text(
                      "Uh oh! The OTP you entered is invalid.. Retry via",
                      style: CustomTextStyle.rederrortext,
                    );
                  } else {
                    return Countdown(
                      controller: _controller,
                      seconds: 40,
                      build: (_, double time) {
                        if (_isTimerFinished) {
                          String formattedTime = time.toInt().toString();
                          if (formattedTime.length == 1) {
                            formattedTime =
                                '0$formattedTime'; // Add leading zero for single-digit
                          }
                          return Column(
                            children: [
                              _isTimerFinished
                                  ? const Text(
                                      "Didn't receive the OTP? Verify via",
                                      style: CustomTextStyle.mapgrey,
                                    )
                                  : Text(
                                      "Didn't receive the OTP? Verify via:$formattedTime",
                                      style: CustomTextStyle.mapgrey,
                                    ),
                              const SizedBox(
                                height: 15,
                              ),
                              smscallmethod(isInvalidOtpMessageDisplayed)
                            ],
                          );
                        } else {
                          // Format time as a single digit
                          String formattedTime = time.toInt().toString();
                          if (formattedTime.length == 1) {
                            formattedTime =
                                '0$formattedTime'; // Add leading zero for single-digit
                          }
                          return Text(
                            "Didn't receive the OTP? Retry in 00.$formattedTime",
                            style: CustomTextStyle.mapgrey,
                          );
                        }
                      },
                      onFinished: onFinished,
                    );
                  }
                }),
                CustomSizedBox(height: 20.h),
                Obx(() {
                  return logincon.showSmsCallMethod.value ? smscallmethod(isInvalidOtpMessageDisplayed) : const SizedBox();

                }),
                CustomSizedBox(height: 15.h),
                CustomContainer(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: CustomContainer(
                    width: double.infinity,
                    child: (otpcontroller.text.length == 4 && !_isTimerFinished)
                        ? CustomButton(
                            width: double.infinity,
                            onPressed: () {
                             
                              if (otpformkey.currentState!.validate()) {
                                        logincon.verifyotp(
                                          otp: otpcontroller.text,
                                          otpId: logincon.logindetails["data"]["otpId"],
                                          phno: widget.mobilenum,
                                          contxt: context
                                        ).whenComplete(() {

                                          otpcontroller.clear();

                                     });

                            
                                  
                              } else {}
                            },
                            borderRadius: BorderRadius.circular(5),
                            child: const Text(
                              "Verify",
                              style: CustomTextStyle.loginbuttontext,
                            ),
                          )
                          : DisableButton(
                                onPressed: () {

                                },
                            borderRadius: BorderRadius.circular(5),
                            child: const Text(
                              "Verify",
                              style: CustomTextStyle.loginbuttontext,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }




  Row smscallmethod(bool isInvalidOtpMessageDisplayed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomContainer(
          // height: 30.h,
          // width: 98.w,
          child: Callsmsbutton(
            onPressed: (isTyping &&
                    hasClickedButton && !isInvalidOtpMessageDisplayed) // Disable button if message is displayed
                   
                ? null
                : () {
                    restartTimer();
                    setState(() {
                      isTyping = false;
                      hasClickedButton = true;
                      otpcontroller.clear();
                      // logincon.successMessage.value =
                      //     "Didn't receive the OTP? Verify via:";
                      logincon.showSmsCallMethod.value =
                          false; // Hide smscallmethod after clicking
                           logincon.loginApi(mobileNo:widget.mobilenum);
                          
                      // _controller.restart();
                    });
                  },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.mail_outline_rounded,
                  color: Customcolors.DECORATION_WHITE,
                  size: 18,
                ),
                Text(
                  " Resend OTP",
                  style: CustomTextStyle.smallwhitetext,
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 10.w), ],
    );
  }
}
