// // ignore_for_file: file_names, deprecated_member_use

// import 'package:blurrycontainer/blurrycontainer.dart';
// import 'package:dotted_line/dotted_line.dart';
// import 'package:testing/Features/Authscreen/AuthController/Logincontroller.dart';
// import 'package:testing/Features/Authscreen/AuthController/Registercontroller.dart';
// import 'package:testing/Features/Authscreen/GoogleSignin/GoogleSignInApi.dart';
// import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Redirectcontroller.dart';
// import 'package:testing/Features/Homepage/profile.dart';
// import 'package:testing/map_provider/denidescreen.dart';
// import 'package:testing/map_provider/request_permission_page.dart';
// import 'package:testing/utils/Buttons/CustomButton.dart';
// import 'package:testing/utils/Buttons/CustomContainer.dart';
// import 'package:testing/utils/Buttons/CustomTextstyle.dart';
// import 'package:testing/utils/Buttons/Customspace.dart';
// import 'package:testing/utils/Buttons/Customtextformfield.dart';
// import 'package:testing/utils/Const/ApiConstvariables.dart';
// import 'package:testing/utils/Const/constImages.dart';
// import 'package:testing/utils/Containerdecoration.dart';
// import 'package:testing/utils/CustomColors/Customcolors.dart';
// import 'package:testing/utils/Validator/phonenumformate.dart';
// import 'package:testing/utils/Validator/validations.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';

// class Loginscreen extends StatefulWidget {
//   const Loginscreen({super.key});

//   @override
//   State<Loginscreen> createState() => _LoginscreenState();
// }

// class _LoginscreenState extends State<Loginscreen> with WidgetsBindingObserver {
//   RedirectController redirect = Get.put(RedirectController());
//   TextEditingController userNumberCon = TextEditingController();
//   LoginscreenController logincon = Get.put(LoginscreenController());
//   RegisterscreenController regcon = Get.put(RegisterscreenController());

//   bool _isExpanded = false;
//   bool isLoading = false;
//   bool isGoogleLoading = false;
//    bool isgoogle = false;
//   @override
//   void initState() {
//     getStorage.read("mobilenumb") ?? userNumberCon.text;
//  redirect.getredirectDetails();
//      for (var item
//                               in redirect.redirectLoadingDetails["data"]) {
//                             if (item["key"] == "googlelogin") {
//                            isgoogle = item["value"].toString().toLowerCase()=="true";

//                               break; // Exit loop once the "whatsappLink" is found and launched
//                             }
//                           }
//     super.initState();
//     userNumberCon.addListener(() {
//       setState(() {
//         hasText = userNumberCon.text.isNotEmpty;
//       });
//     });
   
//     WidgetsBinding.instance.addObserver(this);
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   @override
//   void didChangeMetrics() {
//     super.didChangeMetrics();
//     final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
//     setState(() {
//       _isExpanded = bottomInset > 0;
//     });
//   }

//   Future<void> handleLogin() async {
//     if (formkey.currentState!.validate()) {
//       setState(() {
//         isLoading = true; // Start loading
//       });

//       // Simulate a delay (e.g., for API call)
//       await Future.delayed(const Duration(seconds: 2));

//       // Call your API (logincon.loginApi)
//       logincon.loginApi(mobileNo: userNumberCon.text.removeAllWhitespace);

//       setState(() {
//         isLoading = false; // Stop loading after API call
//       });
//     }
//   }

//   final formkey = GlobalKey<FormState>();
//   final _formatter = FourDigitFormatter();

//   @override
//   Widget build(BuildContext context) {
//     final keyboardsize = MediaQuery.of(context).viewInsets.bottom;
//     return PopScope(
//       onPopInvoked: (didPop) async {
//         Fluttertoast.cancel();
//         SystemNavigator.pop();
//       },
//       child: Scaffold(
//         backgroundColor: Customcolors.DECORATION_WHITE,
//         body: Form(
//           key: formkey,
//           autovalidateMode: AutovalidateMode.onUserInteraction,
//           child: SingleChildScrollView(
//             physics: const NeverScrollableScrollPhysics(),
//             child: Column(
//               children: [
//                 InkWell(
//                   child: AnimatedContainer(
//                     width: MediaQuery.of(context).size.width,
//                     height: _isExpanded ? 200.h : 240.h,
//                     alignment:
//                         _isExpanded ? Alignment.center : Alignment.topCenter,
//                     duration: const Duration(milliseconds: 500),
//                     curve: Curves.fastEaseInToSlowEaseOut,
//                     child: Stack(
//                       children: [
//                         CustomContainer(
//                           decoration:
//                               CustomContainerDecoration.loginPaddingDecoration(
//                                   color: Customcolors.DECORATION_WHITE),
//                           height: _isExpanded ? 240.h : 260.h,
//                           width: double.infinity,
//                           child: ClipRRect(
//                             borderRadius: const BorderRadius.only(
//                               bottomLeft: Radius.circular(20),
//                               bottomRight: Radius.circular(20),
//                             ),
//                             child: Image.asset(
//                             //  loginPageBanner,
//                         "assets/images/Gemini_Generated_Image_6bhalv6bhalv6bha.png",
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           top: 40.h,
//                           right: 10,
//                           child: BlurryContainer(
//                               width: 60,
//                               height: 40,
//                               elevation: 6,
//                             borderRadius: BorderRadius.circular(5),
//                             //  color: Customcolors.DECORATION_BLURORANGE,
//                               color:    Customcolors.darkpurple,

//                               child: Center(
//                                   child: InkWell(
//                                 onTap: () {
//                                   Get.to(() => RequestPermissionPage(isEnabled: false)
// );
//                                 },
//                                 child: const Text(
//                                   "Skip",
//                                   style: CustomTextStyle.whitetext,
//                                 ),
//                               ))),
//                         ),
//                         Positioned(
//                           top: 90.h,
//                           left: 128.w,
//                           child: const Text(
//                             "Miogra",
//                             style: CustomTextStyle.logotext,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 CustomSizedBox(height: keyboardsize >= 343 ? 20.h : 25.h),
//                 Column(
//                   children: [
//                     AnimatedContainer(
//                       height: MediaQuery.of(context).size.height -
//                           (_isExpanded ? 200.h : 320.h),
//                       decoration: CustomContainerDecoration.whitecontainer(
//                         color: Customcolors.DECORATION_WHITE,
//                       ),
//                       curve: Curves.easeInOut,
//                       duration: const Duration(milliseconds: 500),
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 20.w),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             const Center(
//                               child: Text(
//                                 "Delivering Delight\nto Your Doorstep!",
//                                 style: CustomTextStyle.bigboldtext,
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                             CustomSizedBox(
//                                 height: keyboardsize >= 343 ? 10.h : 15.h),
//                             CustomTextFormField(
//                               hintText: 'Enter Mobile Number',
//                               labelText: hasText ? 'Enter Mobile Number' : null,
//                               controller: userNumberCon,
//                               validator: validatepPhone,
//                               inputFormatters: [_formatter],
//                               maxLength: 11,
//                               prefixIcon: SizedBox(
//                                 height: 50,
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         SizedBox(width: 10.w),
//                                         SvgPicture.asset(indianflagsvg),
//                                         const Center(
//                                           child: Text(' +91',
//                                               style: CustomTextStyle
//                                                   .googlebuttontext),
//                                         ),
//                                       ],
//                                     ),
//                                     const VerticalDivider(
//                                         indent: 5, endIndent: 5),
//                                   ],
//                                 ),
//                               ),
//                               keyboardType: TextInputType.number,
//                             ),

//                             CustomSizedBox(
//                                 height: keyboardsize >= 343 ? 15.h : 20.h),
//                             isLoading || logincon.islogindataLoading.isTrue
//                                 ? DisableButton(
//                                     borderRadius: BorderRadius.circular(5),
//                                     onPressed: null, // Disabled
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(11.0),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           LoadingAnimationWidget
//                                               .horizontalRotatingDots(
//                                             color:
//                                                 Customcolors.DECORATION_WHITE,
//                                             size: 24,
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   )
//                                 : CustomButton(
//                                     onPressed:
//                                         handleLogin, // Call handleLogin when button is pressed
//                                     borderRadius: BorderRadius.circular(5),
//                                     width: double.infinity,
//                                     child: const Text(
//                                       "Continue",
//                                       style: CustomTextStyle.loginbuttontext,
//                                     ),
//                                   ),
//                             //                       CustomButton(
//                             //                         width: double.infinity,
//                             //                         onPressed:isLoading||logincon.islogindataLoading.isTrue
//                             // ? null // Disables the button when loading
//                             // : () {
//                             //                           if (formkey.currentState!.validate()) {
//                             //                             setState(() {
//                             //                               isLoading = true;
//                             //                             });

//                             //                               // regcon.tokenapi(mobileNo: userNumberCon.text.removeAllWhitespace, cntxt: context);
//                             //                             logincon.loginApi(mobileNo: userNumberCon.text.removeAllWhitespace);

//                             //                             setState(() {
//                             //                               isLoading = false;
//                             //                             });
//                             //                           } else {}
//                             //                         },
//                             //                         borderRadius: BorderRadius.circular(20),
//                             //                         child: isLoading||logincon.islogindataLoading.isTrue
//                             //                             ? Padding(
//                             //                                 padding: const EdgeInsets.all(11.0),
//                             //                                 child: Row(
//                             //                                   mainAxisAlignment:
//                             //                                       MainAxisAlignment.center,
//                             //                                   children:  [
//                             //                                     LoadingAnimationWidget.horizontalRotatingDots(
//                             //                                     color: Customcolors.DECORATION_WHITE,
//                             //                                     size: 24,
//                             //                                     )
//                             //                                     // Text(
//                             //                                     //   "Loading",
//                             //                                     //   style:
//                             //                                     //       CustomTextStyle.loginbuttontext,
//                             //                                     // ),
//                             //                                   ],
//                             //                                 ),
//                             //                               )
//                             //                             : const Text(
//                             //                                 "Continue",
//                             //                                 style: CustomTextStyle.loginbuttontext,
//                             //                               ),
//                             //                       ),

//                             CustomSizedBox(height: 40.h),
//                             _isExpanded
//                                 ? CustomSizedBox(height: 100.h)
//                                 : 
//                             isgoogle?
//                                 Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       const Expanded(
//                                         child: Divider(
//                                           endIndent: 20,
//                                           color: Customcolors.DECORATION_GREY,
//                                         ),
//                                       ),
//                                       CustomSizedBox(width: 10.w),
//                                       const Center(
//                                         child: Text(
//                                           "Or Continue with",
//                                           style: CustomTextStyle.dividertext,
//                                         ),
//                                       ),
//                                       CustomSizedBox(width: 10.w),
//                                       const Expanded(
//                                         child: Divider(
//                                           indent: 20,
//                                           color: Customcolors.DECORATION_GREY,
//                                         ),
//                                       ),
//                                     ],
//                                   ):SizedBox.shrink(),
//                             CustomSizedBox(height: 10.h),
// isgoogle?

//                             Material(
//                               color: Colors
//                                   .transparent, // Ensures the background is transparent
//                               child: InkWell(
//                                 onTap: () async {
//                                   setState(() {
//                                     isGoogleLoading = true;
//                                   });
//                                   Future.delayed(const Duration(seconds: 2),
//                                       () {
//                                     setState(() {
//                                       isGoogleLoading = false;
//                                     });
//                                   }).whenComplete(
//                                       () => signIn(context: context));
//                                 },
//                                 borderRadius: BorderRadius.circular(20),
//                                 child: BlurryContainer(
//                                   height: 40,
//                                   borderRadius: BorderRadius.circular(5),
//                                   width: 130.w,
//                                   elevation: 1,
//                                   blur: 15,
//                                   child: Center(
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       children: [
//                                         Image.asset(googleIcon),
//                                         isGoogleLoading
//                                             ? const Text(
//                                                 "Loading",
//                                                 style: CustomTextStyle
//                                                     .googlebuttontext,
//                                               )
//                                             : const Text(
//                                                 "Google",
//                                                 style: CustomTextStyle
//                                                     .googlebuttontext,
//                                               ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ):SizedBox.shrink(),
//                             CustomSizedBox(height: 60.h),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     const Text(
//                       "By Continuing, you agree to our",
//                       style: CustomTextStyle.googlebuttontext,
//                     ),
//                     const CustomSizedBox(height: 10),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             //  launchwebUrl(context,"https://www.freeprivacypolicy.com/live/6492021b-22dd-4ba3-b648-4ad1e6d3533c");
//                             for (var item
//                                 in redirect.redirectLoadingDetails["data"]) {
//                               if (item["key"] == "termsandservice") {
//                                 launchwebUrl(context, item["value"]);

//                                 break; // Exit loop once the "whatsappLink" is found and launched
//                               }
//                             }
//                           },
//                           child: privacycontent(content: "Terms of Service"),
//                         ),
//                         const SizedBox(width: 5),
//                         InkWell(
//                           onTap: () {
//                             //  launchwebUrl(context,"https://www.freeprivacypolicy.com/live/6492021b-22dd-4ba3-b648-4ad1e6d3533c");
//                             for (var item
//                                 in redirect.redirectLoadingDetails["data"]) {
//                               if (item["key"] == "privacyLink") {
//                                 launchwebUrl(context, item["value"]);

//                                 break; // Exit loop once the "whatsappLink" is found and launched
//                               }
//                             }
//                           },
//                           child: privacycontent(content: "Privacy Policy"),
//                         ),
//                         const SizedBox(width: 5),
//                         InkWell(
//                           onTap: () {
//                             // launchwebUrl(context,"https://fastxrefundpolicy.blogspot.com/2024/10/refund-policy-fastx_22.html");
//                             for (var item
//                                 in redirect.redirectLoadingDetails["data"]) {
//                               if (item["key"] == "refundLink") {
//                                 launchwebUrl(context, item["value"]);

//                                 break; // Exit loop once the "whatsappLink" is found and launched
//                               }
//                             }
//                           },
//                           child: privacycontent(content: "Refund Policy"),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future signIn({context}) async {
//     final user = await GoogleSignInApi.login();

//     if (user != null) {
//       regcon.tokenemailapi(email: user.email, cntxt: context);
//     } else {}
//   }

// // Privacy contents

//   privacycontent({content}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text(
//           content,
//           style: CustomTextStyle.dividertext,
//         ),
//         const CustomSizedBox(height: 5),
//         const SizedBox(
//           height: 10,
//           width: 90,
//           child: DottedLine(
//             dashColor: Colors.grey,
//           ),
//         ),
//       ],
//     );
//   }
// }





















////CHANGED UI DESIGN


import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testing/Features/Authscreen/AuthController/Logincontroller.dart';
import 'package:testing/Features/Authscreen/AuthController/Registercontroller.dart';
import 'package:testing/Features/Authscreen/GoogleSignin/GoogleSignInApi.dart';
import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Redirectcontroller.dart';
import 'package:testing/Features/Homepage/profile.dart';
import 'package:testing/map_provider/denidescreen.dart';
import 'package:testing/map_provider/request_permission_page.dart';
import 'package:testing/utils/Buttons/CustomButton.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Buttons/Customtextformfield.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Validator/phonenumformate.dart';
import 'package:testing/utils/Validator/validations.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> with WidgetsBindingObserver {
  RedirectController redirect = Get.put(RedirectController());
  TextEditingController userNumberCon = TextEditingController();
  LoginscreenController logincon = Get.put(LoginscreenController());
  RegisterscreenController regcon = Get.put(RegisterscreenController());

  bool _isExpanded = false;
  bool isLoading = false;
  bool isGoogleLoading = false;
  bool isgoogle = false;
  @override
  void initState() {
    getStorage.read("mobilenumb") ?? userNumberCon.text;
    redirect.getredirectDetails();
    for (var item in redirect.redirectLoadingDetails["data"]) {
      if (item["key"] == "googlelogin") {
        isgoogle = item["value"].toString().toLowerCase() == "true";

        break; // Exit loop once the "whatsappLink" is found and launched
      }
    }
    super.initState();
    userNumberCon.addListener(() {
      setState(() {
        hasText = userNumberCon.text.isNotEmpty;
      });
    });

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    setState(() {
      _isExpanded = bottomInset > 0;
    });
  }

  Future<void> handleLogin() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        isLoading = true; // Start loading
      });

      // Simulate a delay (e.g., for API call)
      await Future.delayed(const Duration(seconds: 2));

      // Call your API (logincon.loginApi)
      logincon.loginApi(mobileNo: userNumberCon.text.removeAllWhitespace);

      setState(() {
        isLoading = false; // Stop loading after API call
      });
    }
  }

  final formkey = GlobalKey<FormState>();
  final _formatter = FourDigitFormatter();

  @override
  Widget build(BuildContext context) {
    final keyboardsize = MediaQuery.of(context).viewInsets.bottom;
    return PopScope(
      onPopInvoked: (didPop) async {
        Fluttertoast.cancel();
        SystemNavigator.pop();
      },
      child: Scaffold(
        backgroundColor: Customcolors.DECORATION_WHITE,
        body: Form(
          key: formkey,
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                InkWell(
                  child: AnimatedContainer(
                    width: MediaQuery.of(context).size.width,
                    height: _isExpanded ? 240.h : 300.h,
                    alignment:
                        _isExpanded ? Alignment.center : Alignment.topCenter,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastEaseInToSlowEaseOut,
                    child: Stack(
                      children: [
                        CustomContainer(
                          decoration:
                              CustomContainerDecoration.loginPaddingDecoration(
                                  color: Customcolors.DECORATION_WHITE),
                          height: _isExpanded ? 280.h : 320.h,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            child: Image.asset(
                              //  loginPageBanner,
                              "assets/images/Gemini_Generated_Image_6bhalv6bhalv6bha.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        // Positioned(
                        //   top: 40.h,
                        //   right: 10,
                        //   child: BlurryContainer(
                        //       width: 60,
                        //       height: 40,
                        //       elevation: 6,
                        //       borderRadius: BorderRadius.circular(5),
                        //       //  color: Customcolors.DECORATION_BLURORANGE,
                        //       color: Customcolors.darkpurple,
                        //       child: Center(
                        //           child: InkWell(
                        //         onTap: () {
                        //           Get.to(() =>
                        //               RequestPermissionPage(isEnabled: false));
                        //         },
                        //         child: const Text(
                        //           "Skip",
                        //           style: CustomTextStyle.whitetext,
                        //         ),
                        //       ))),
                        // ),
                        // Positioned(
                        //   top: 90.h,
                        //   left: 128.w,
                        //   child: const Text(
                        //     "Miogra",
                        //     style: CustomTextStyle.logotext,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                CustomSizedBox(height: keyboardsize >= 343 ? 20.h : 25.h),
                Column(
                  children: [
                    AnimatedContainer(
                      height: MediaQuery.of(context).size.height -
                          (_isExpanded ? 240.h : 320.h),
                      decoration: CustomContainerDecoration.whitecontainer(
                        color: Customcolors.DECORATION_WHITE,
                      ),
                      curve: Curves.easeInOut,
                      duration: const Duration(milliseconds: 500),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            // Image.asset(
                            //   "assets/images/Adobe Express - file (1).png",
                            //   height: 60,
                            // ),
                            ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [Color(0xFFAE62E8), Color(0xFF623089)],
                                begin: Alignment.topCenter, // 👈 Start from top
                                end: Alignment.bottomCenter, // 👈 End at bottom
                              ).createShader(Rect.fromLTWH(
                                  0, 0, bounds.width, bounds.height)),
                              child: Text("miogra",
                                  overflow: TextOverflow.ellipsis,
                                  // style: CustomTextStyle.blacktext,
                                  style: GoogleFonts.poppins(
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w800,
                                    // color: Color(0xFF623089),
                                    color: Colors.white,
                                    //fontFamily: 'Poppins-Regular',
                                  )),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Text(
                                // "Delivering Delight\nto Your Doorstep!",
                                "#1 Dining App",
                                //  style: CustomTextStyle.bigboldtext,
                                style: TextStyle(
                                    fontSize: 30.sp,
                                    //  fontWeight: FontWeight.w800,
                                    color: Customcolors.DECORATION_BLACK,
                                    fontFamily: 'Poppins-Bold'),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomSizedBox(
                                height: keyboardsize >= 343 ? 10.h : 15.h),
                            // CustomTextFormField(
                            //   hintText: 'Enter Mobile Number',
                            //   labelText: hasText ? 'Enter Mobile Number' : null,
                            //   controller: userNumberCon,
                            //   validator: validatepPhone,
                            //   inputFormatters: [_formatter],
                            //   maxLength: 11,
                            //   prefixIcon: SizedBox(
                            //     height: 50,
                            //     child: Row(
                            //       mainAxisSize: MainAxisSize.min,
                            //       children: [
                            //         Row(
                            //           children: [
                            //             SizedBox(width: 10.w),
                            //             //  SvgPicture.asset(indianflagsvg),
                            //             const Icon(
                            //               Icons.phone_iphone,
                            //               color:  Color(0xFF623089),
                            //             ),
                            //             const Center(
                            //               child: Text(' +91',
                            //                   style: CustomTextStyle
                            //                       .googlebuttontext),
                            //             ),
                            //           ],
                            //         ),
                            //        const VerticalDivider(
                            //            indent: 5, endIndent: 5),
                            //       ],
                            //     ),
                            //   ),
                            //   keyboardType: TextInputType.number,
                            // ),

                            SizedBox(
                             //  height: 50.h,
                              width: 280.w,
                              child: TextFormField(
                                autovalidateMode: AutovalidateMode.disabled,
                                maxLength: 11,
                                decoration: const InputDecoration(
                                  errorStyle: TextStyle(height: 0),

                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                  // alignLabelWithHint: true,
                                  labelText: 'Enter Mobile Number',
                                  floatingLabelStyle: TextStyle(
                                    color: Color(
                                        0xFF623089), // ✅ Label color on focus
                                  ),
                                  labelStyle: TextStyle(
                                    color: Color(0xFF623089),
                                  ),
                                  counterText: "",
                                  // contentPadding: EdgeInsets.symmetric(
                                  //   vertical: 12,
                                  //   horizontal: 12,
                                  // ), // ✅ Fixes overlapping

                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                    borderSide: BorderSide(
                                      color: Color(0xFF623089),
                                      width: 2,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    borderSide: BorderSide(
                                      color: Color(0xFF623089),
                                      width: 2,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      borderSide: BorderSide(
                                        color: Color(0xFF623089),
                                        width: 2,
                                      )),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      borderSide: BorderSide(
                                        color: Color(0xFF623089),
                                        width: 2,
                                      )),
                                  // ✅ Better prefix handling
                                  prefixIconConstraints: BoxConstraints(
                                    minWidth: 0,
                                    minHeight: 0,
                                  ),

                                  prefixIcon: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.phone_iphone,
                                          color: Color(0xFF623089),
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          '+91',
                                          style:
                                              CustomTextStyle.googlebuttontext,
                                        ),
                                        SizedBox(width: 6),
                                        VerticalDivider(
                                          indent: 10,
                                          endIndent: 10,
                                          thickness: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                controller: userNumberCon,
                                validator: validatepPhone,
                                inputFormatters: [_formatter],
                                keyboardType: TextInputType.number,
                              ),
                            ),

                            // const SizedBox(
                            //   height: 10,
                            // ),
                            CustomSizedBox(
                                height: keyboardsize >= 343 ? 15.h : 20.h),
                            isLoading || logincon.islogindataLoading.isTrue
                                ? DisableButton(
                                    borderRadius: BorderRadius.circular(5),
                                    onPressed: null, // Disabled
                                    child: Padding(
                                      padding: const EdgeInsets.all(11.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          LoadingAnimationWidget
                                              .horizontalRotatingDots(
                                            color:
                                                Customcolors.DECORATION_WHITE,
                                            size: 24,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      if (formkey.currentState!.validate()) {
                                        handleLogin();
                                      }
                                      ;
                                    },
                                    child: Container(
                                      // width: double.infinity,
                                      width: 280.w,
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          color: const Color(0xFF623089)),
                                      child: const Center(
                                        child: Text(
                                          "Get Started",
                                          // style: CustomTextStyle.loginbuttontext,
                                          style: TextStyle(
                                              fontSize: 17,
                                              // fontWeight: FontWeight.w300,
                                              color:
                                                  Customcolors.DECORATION_WHITE,
                                              fontFamily: 'Poppins-Bold'),
                                        ),
                                      ),
                                    ),
                                  ),

                            _isExpanded
                                ? CustomSizedBox(height: 100.h)
                                : isgoogle
                                    ? Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Expanded(
                                            child: Divider(
                                              endIndent: 20,
                                              color:
                                                  Customcolors.DECORATION_GREY,
                                            ),
                                          ),
                                          CustomSizedBox(width: 10.w),
                                          const Center(
                                            child: Text(
                                              "Or Continue with",
                                              style:
                                                  CustomTextStyle.dividertext,
                                            ),
                                          ),
                                          CustomSizedBox(width: 10.w),
                                          const Expanded(
                                            child: Divider(
                                              indent: 20,
                                              color:
                                                  Customcolors.DECORATION_GREY,
                                            ),
                                          ),
                                        ],
                                      )
                                    : SizedBox.shrink(),
                            // CustomSizedBox(height: 10.h),
                            isgoogle
                                ? Material(
                                    color: Colors
                                        .transparent, // Ensures the background is transparent
                                    child: InkWell(
                                      onTap: () async {
                                        setState(() {
                                          isGoogleLoading = true;
                                        });
                                        Future.delayed(
                                            const Duration(seconds: 2), () {
                                          setState(() {
                                            isGoogleLoading = false;
                                          });
                                        }).whenComplete(
                                            () => signIn(context: context));
                                      },
                                      borderRadius: BorderRadius.circular(20),
                                      child: BlurryContainer(
                                        height: 40,
                                        borderRadius: BorderRadius.circular(5),
                                        width: 130.w,
                                        elevation: 1,
                                        blur: 15,
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Image.asset(googleIcon),
                                              isGoogleLoading
                                                  ? const Text(
                                                      "Loading",
                                                      style: CustomTextStyle
                                                          .googlebuttontext,
                                                    )
                                                  : const Text(
                                                      "Google",
                                                      style: CustomTextStyle
                                                          .googlebuttontext,
                                                    ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink(),

                            CustomSizedBox(height: 30.h),
                             Center(
                              child: Column(
                                children: [
                                  Text(
                                    "We deliver",
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontFamily: "Poppins-Bold",
                                      color: Color(0xFF623089),
                                    ),
                                  ),
                                  Text(
                                    "deliciousness, fresh to your door!",
                                    style: TextStyle(
                                       fontSize: 15.sp,
                                        fontFamily: "Poppins-Bold",
                                        color: Color(0xFF623089)),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     const Text(
                //       "By Continuing, you agree to our",
                //       style: CustomTextStyle.googlebuttontext,
                //     ),
                //     const CustomSizedBox(height: 10),
                //     Row(
                //       crossAxisAlignment: CrossAxisAlignment.end,
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         InkWell(
                //           onTap: () {
                //             //  launchwebUrl(context,"https://www.freeprivacypolicy.com/live/6492021b-22dd-4ba3-b648-4ad1e6d3533c");
                //             for (var item
                //                 in redirect.redirectLoadingDetails["data"]) {
                //               if (item["key"] == "termsandservice") {
                //                 launchwebUrl(context, item["value"]);

                //                 break; // Exit loop once the "whatsappLink" is found and launched
                //               }
                //             }
                //           },
                //           child: privacycontent(content: "Terms of Service"),
                //         ),
                //         const SizedBox(width: 5),
                //         InkWell(
                //           onTap: () {
                //             //  launchwebUrl(context,"https://www.freeprivacypolicy.com/live/6492021b-22dd-4ba3-b648-4ad1e6d3533c");
                //             for (var item
                //                 in redirect.redirectLoadingDetails["data"]) {
                //               if (item["key"] == "privacyLink") {
                //                 launchwebUrl(context, item["value"]);

                //                 break; // Exit loop once the "whatsappLink" is found and launched
                //               }
                //             }
                //           },
                //           child: privacycontent(content: "Privacy Policy"),
                //         ),
                //         const SizedBox(width: 5),
                //         InkWell(
                //           onTap: () {
                //             // launchwebUrl(context,"https://fastxrefundpolicy.blogspot.com/2024/10/refund-policy-fastx_22.html");
                //             for (var item
                //                 in redirect.redirectLoadingDetails["data"]) {
                //               if (item["key"] == "refundLink") {
                //                 launchwebUrl(context, item["value"]);

                //                 break; // Exit loop once the "whatsappLink" is found and launched
                //               }
                //             }
                //           },
                //           child: privacycontent(content: "Refund Policy"),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future signIn({context}) async {
    final user = await GoogleSignInApi.login();

    if (user != null) {
      regcon.tokenemailapi(email: user.email, cntxt: context);
    } else {}
  }

// Privacy contents

  privacycontent({content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          content,
          style: CustomTextStyle.dividertext,
        ),
        const CustomSizedBox(height: 5),
        const SizedBox(
          height: 10,
          width: 90,
          child: DottedLine(
            dashColor: Colors.grey,
          ),
        ),
      ],
    );
  }
}