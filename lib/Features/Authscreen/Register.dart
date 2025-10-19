
// ignore_for_file: file_names

import 'package:testing/Features/Authscreen/AuthController/Logincontroller.dart';
import 'package:testing/Features/Authscreen/AuthController/Registercontroller.dart';
import 'package:testing/Features/Authscreen/GoogleSignin/GoogleSignInApi.dart';
import 'package:testing/Features/Authscreen/Loginscreen.dart';
import 'package:testing/utils/Buttons/CustomButton.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Buttons/Customtextformfield.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Validator/phonenumformate.dart';
import 'package:testing/utils/Validator/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';



// ignore: must_be_immutable
class RegisterScreen extends StatefulWidget {
  String? user;
  String? mobnumber;
  RegisterScreen({super.key, this.user,this.mobnumber});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController userName        = TextEditingController();
  TextEditingController mobileNumber    = TextEditingController();
  TextEditingController emailController = TextEditingController();
  LoginscreenController logincon = Get.put(LoginscreenController());


  RegisterscreenController registerscreenController =Get.put(RegisterscreenController());
  final formkey = GlobalKey<FormState>();
   bool isLoading = false;





@override
void initState() {
  super.initState();

  // Check and assign the email
  if (widget.user != null && widget.user != "null") {
    emailController.text = widget.user.toString();
  } else {
    emailController.text = "";
  }

  // Check and assign the mobile number
  if (widget.mobnumber != null ) {
    String mobileNoo = widget.mobnumber!;
    String formattedMobileNo = '${mobileNoo.substring(0, 5)} ${mobileNoo.substring(5)}';
    mobileNumber.text = formattedMobileNo;
  } else {
    mobileNumber.text = "";
  }

}






//   @override
//   void initState() {
// print('------;;; ${widget.mobnumber}');
//     // widget.user == null || widget.user == "null" ? emailController.text = "" : emailController.text = widget.user.toString();
//     if(useremail !=''){
//         useremail == null || useremail == "" ? emailController.text = "" : emailController.text = useremail.toString();
//     }else{
//         String mobileNoo = mobilenumb;
//         String formattedMobileNo = '${mobileNoo.substring(0, 5)} ${mobileNoo.substring(5)}';
//         mobilenumb == null  || mobilenumb == "" ? mobileNumber.text = "" : mobileNumber.text = formattedMobileNo.toString();
//     }   
//     super.initState();
//   }





  
    final _formatter = FourDigitFormatter();


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
       
        Get.off(() => const Loginscreen(),transition: Transition.leftToRight);

        // ignore: void_checks
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Customcolors.DECORATION_WHITE,
        body: SingleChildScrollView(
          child: Form(
            key: formkey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                CustomContainer(
                  height: 200.h,
                  decoration: CustomContainerDecoration.gradientdecoration(),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CustomContainer( height: 100.h,),
                          Positioned(
                            top: 60.h,
                            left: 10.w,
                            child: InkWell(
                              onTap: () async {
            
                                 await GoogleSignInApi.logout().whenComplete(() {
                                 
                                   Navigator.push( context,MaterialPageRoute( builder: (_) => const Loginscreen()));
                                 });
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
                            left: 140.w,
                            child: InkWell(
                              onTap: () {
            


                                  //  getStorage.remove("mobilenumb"); 
                                  //  getStorage.remove("Usertoken");  
                                  //  getStorage.remove("UserId");      
                                  //  getStorage.remove("useremail");   
                                  //  getStorage.remove("username");


                              },
                              child: const Text(
                                "Register",
                                style: CustomTextStyle.whiteheading,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Center(
                        child: Column(
                          children: [
                            Text(
                              "Let's get to know",
                              style: CustomTextStyle.whitetext,
                            ),
                            Text(
                             "each other better!",
                              style: CustomTextStyle.whitetextnormalbold,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                CustomSizedBox(
                  height: 30.h,
                ),
                AnimatedPadding(

                padding: MediaQuery.of(context).viewInsets/2.5,
                duration: const Duration(milliseconds: 100),

                  child: Column(children: [ 
                    Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: AddressFormFeild(
                      readonly: false,
                      hintText: '',
                      controller: userName,
                      validator: validateName,
                      decoration: InputDecoration(
                        label: Row(
                          children: [
                            RichText(
                              text: const TextSpan(
                                  text: "Name",
                                  style: CustomTextStyle.addressfeildtext,
                                  children: [
                                    TextSpan(
                                      text: ' *',
                                      style: CustomTextStyle.redtext,
                                    )
                                  ]),
                            ),
                          ],
                        ),
                        contentPadding: const EdgeInsets.symmetric( vertical: 12.0, horizontal: 10),
                        errorStyle:CustomTextStyle.notetext,
                        isDense: false,
                        isCollapsed: false,
                        counterText: "",
                        errorMaxLines: 2,
                        fillColor: Colors.transparent,
                        filled: true,
                        hintStyle: CustomTextStyle.addressfeildtext,
                        prefixStyle: const TextStyle(
                          color: Customcolors.DECORATION_BLACK,
                        ),
                        prefixIconColor: Customcolors.DECORATION_BLACK,
                        prefixIconConstraints:
                            const BoxConstraints(minWidth: 0, minHeight: 0),
                        errorBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Customcolors.DECORATION_RED),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            )),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Customcolors.DECORATION_GREY),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                        focusedErrorBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Customcolors.DECORATION_RED),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            )),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide   : BorderSide(color: Customcolors.DECORATION_GREY),
                            borderRadius : BorderRadius.only(
                            bottomLeft   : Radius.circular(15),
                            bottomRight  : Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  CustomSizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: mobilenumb == null
                        ? AddressFormFeild(
                            readonly: false,
                            controller: mobileNumber,
                            validator: validatepPhone,
                              inputFormatters: [_formatter],
                              maxLength: 11,
                            hintText: '',
                            decoration: InputDecoration(
                              label: RichText(
                                text: const TextSpan(
                                    text: "Mobile Number",
                                    style: CustomTextStyle.addressfeildtext,
                                    children: [
                                      TextSpan(
                                        text: ' *',
                                        style: CustomTextStyle.redtext,
                                      )
                                    ]),
                              ),
                              contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
                              errorStyle:CustomTextStyle.notetext,
                              isDense: false,
                              isCollapsed: false,
                              counterText: "",
                              errorMaxLines: 2,
                              fillColor: Colors.transparent,
                              filled: true,
                              hintStyle: CustomTextStyle.addressfeildtext,
                              prefixText: "+91 ",
                              prefixStyle: CustomTextStyle.googlebuttontext,
                              prefixIconColor: Customcolors.DECORATION_BLACK,
                              prefixIconConstraints:const BoxConstraints(minWidth: 0, minHeight: 0),
                              errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Customcolors.DECORATION_RED),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  )),
                              focusedErrorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Customcolors.DECORATION_RED),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  )),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Customcolors.DECORATION_GREY),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Customcolors.DECORATION_GREY),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                              ),
                            ),
                             keyboardType: TextInputType.number,
                          )
                        : AddressFormFeild(
                            readonly: true,
                             controller: mobileNumber,
                            validator: validatepPhone,
                              inputFormatters: [_formatter],
                              maxLength: 11,
                            hintText: '',
                            decoration: InputDecoration(
                              label: RichText(
                                text: const TextSpan(
                                    text: "Mobile Number",
                                    style: CustomTextStyle.addressfeildtext,
                                    children: [
                                      TextSpan(
                                        text: ' *',
                                        style:CustomTextStyle.redtext
                                      )
                                    ]),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 10),
                              errorStyle:CustomTextStyle.notetext,
                              isDense: false,
                              isCollapsed: false,
                              counterText: "",
                              errorMaxLines: 2,
                              fillColor: Colors.transparent,
                              filled: true,
                              hintStyle: CustomTextStyle.addressfeildtext,
                              prefixText: "+91 ",
                              prefixStyle: CustomTextStyle.googlebuttontext,
                              prefixIconColor: Customcolors.DECORATION_BLACK,
                              prefixIconConstraints:const BoxConstraints(minWidth: 0, minHeight: 0),
                              errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Customcolors.DECORATION_RED),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  )),
                              focusedErrorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Customcolors.DECORATION_RED),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  )),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide( color: Customcolors.DECORATION_GREY),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Customcolors.DECORATION_GREY),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                              ),
                            ),
                             keyboardType: TextInputType.number,
                          ),
                  ),
                  CustomSizedBox(
                    height: 10.h,
                  ),
                  widget.user == null || widget.user == "null"
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17),
                          child: AddressFormFeild(
                            readonly: false,
                            hintText: '',
                            controller: emailController,
                            validator: validateEmail,
                            decoration: InputDecoration(
                              label: Row(
                                children: [
                                  RichText(
                                    text: const TextSpan(
                                        text: "E-mail",
                                        style: CustomTextStyle.addressfeildtext,
                                        children: [
                                          TextSpan(
                                            text: ' *',
                                            style: CustomTextStyle.redtext,
                                          )
                                        ]),
                                  ),
                                ],
                              ),
                              contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
                              errorStyle:CustomTextStyle.notetext,
                              isDense: false,
                              isCollapsed: false,
                              counterText: "",
                              errorMaxLines: 2,
                              fillColor: Colors.transparent,
                              filled: true,
                              hintStyle: CustomTextStyle.addressfeildtext,
                              prefixStyle: const TextStyle(color: Customcolors.DECORATION_BLACK,),
                              prefixIconColor: Customcolors.DECORATION_BLACK,
                              prefixIconConstraints:const BoxConstraints(minWidth: 0, minHeight: 0),
                              errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Customcolors.DECORATION_RED),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  )),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide( color: Customcolors.DECORATION_GREY),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                              ),
                              focusedErrorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Customcolors.DECORATION_RED),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  )),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Customcolors.DECORATION_GREY),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17),
                          child: AddressFormFeild(
                            readonly: true,
                            validator: validateEmail,
                            controller: emailController,
                            hintText: " ",
                            decoration: InputDecoration(
                              label: Row(
                                children: [
                                  RichText(
                                    text: const TextSpan(
                                        text: "E-mail",
                                        style: CustomTextStyle.addressfeildtext,
                                        children: [
                                          TextSpan(
                                            text: ' *',
                                            style: CustomTextStyle.redtext,
                                          )
                                        ]),
                                  ),
                                ],
                              ),
                              contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
                              errorStyle:CustomTextStyle.notetext,
                              isDense: false,
                              isCollapsed: false,
                              counterText: "",
                              errorMaxLines: 2,
                              fillColor: Colors.transparent,
                              filled: true,
                              hintStyle: CustomTextStyle.addressfeildtext,
                              prefixStyle: const TextStyle(
                                color: Customcolors.DECORATION_BLACK,
                              ),
                              prefixIconColor: Customcolors.DECORATION_BLACK,
                              prefixIconConstraints:const BoxConstraints(minWidth: 0, minHeight: 0),
                              errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide( color: Customcolors.DECORATION_RED),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  )),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Customcolors.DECORATION_GREY),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                              ),
                              focusedErrorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide( color: Customcolors.DECORATION_RED),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  )),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide( color: Customcolors.DECORATION_GREY),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                              ),
                            ),
                          ),
                        ),
                  CustomSizedBox(
                    height: 30.h,
                  ),
                  Center(
                    child:
                        CustomButton(
                                 width: MediaQuery.of(context).size.width * 0.9,
                                onPressed: () {
                              
                                 if (formkey.currentState!.validate()) {
                              setState(() {
                                      isLoading = true;
                                    });
                                    Future.delayed(const Duration(seconds: 2), () {
                                      setState(() {
                                        isLoading = false;
                                      });
                   
                                      
                                    }).whenComplete((){
                                      
                              

                                      registerscreenController.registerapi(
                                          mobileNo: mobileNumber.text.removeAllWhitespace,
                                          email: emailController.text.removeAllWhitespace,
                                          name: userName.text,
                                          context: context
                                      );
                                  
                                      // Get.offAll(RequestPermissionPage(isEnabled: true), transition: Transition.upToDown);

                                    } );



                                // print(mobileNumber.text);
                                // print(emailController.text);
                                // debugPrint(userName.text);
                                // Navigator.push(context, MaterialPageRoute( builder: (_) => HomeScreenPage()));
                              
                          }
                              
                                },
                                borderRadius: BorderRadius.circular(20),
                                child: isLoading
                                    ? const Padding(
                                        padding: EdgeInsets.all(11.0),
                                        child: Row(
                                          mainAxisAlignment:MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Loading",
                                              style: CustomTextStyle.loginbuttontext,
                                            ),
                                     
                                          ],
                                        ),
                                      )
                                    : const
                                     Text(
                                      'Register',
                          style: CustomTextStyle.loginbuttontext,
                                      ),
                              ),
                             
                    //  Container(
                    //   height: 55,
                    //   width: MediaQuery.of(context).size.width * 0.9, // Adjust the width based on screen size
                    //   decoration:CustomContainerDecoration.gradientbuttondecoration(),
                    //   child: ElevatedButton(
                    //     onPressed: () {
                          
                    //       if (formkey.currentState!.validate()) {
                              
                    //             print(mobileNumber.text);
                    //             print(emailController.text);
                    //             debugPrint(userName.text);
                              
                              
                              
                    //             registerscreenController.registerapi(
                    //               mobileNo: mobileNumber.text,
                    //               email: emailController.text,
                    //               name: userName.text,
                    //             );
                              
                    //           // Navigator.push(context, MaterialPageRoute( builder: (_) => HomeScreenPage()));
                              
                    //       }
                              
                              
                    //     },
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: Colors.transparent,
                    //       shadowColor: Colors.transparent,
                    //       padding: const EdgeInsets.symmetric(vertical: 16),
                    //       textStyle: const TextStyle(fontSize: 16),
                    //     ),
                    //     child: const Text(
                    //       'Register',
                    //       style: CustomTextStyle.loginbuttontext,
                    //     ),
                    //   ),
                    // ),
                  ),
                               ],),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
