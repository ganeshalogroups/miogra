// ignore_for_file: avoid_print

import 'package:image_cropper/image_cropper.dart';
import 'package:testing/Features/Homepage/profile/imageUploader.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Validator/validations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:testing/Features/Authscreen/AuthController/Registercontroller.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customtextformfield.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:image_cropper/image_cropper.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatefulWidget {
  dynamic image;
  EditProfileScreen({super.key, this.image});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool isTyping = false;
  TextEditingController userName = TextEditingController();
  ImageUploader fileuploader = Get.put(ImageUploader());
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController emailController = TextEditingController();
  RegisterscreenController registerscreenController =
      Get.put(RegisterscreenController());
  final formkey = GlobalKey<FormState>();
  final box = GetStorage();
  String? imageUploadUrl = "";
  File? _image;
  String? _imageErrorText;

  @override
  void initState() {
    String? mobileNumbers = box.read("mobilenumb");
    String? email = box.read("useremail");
    String? username = box.read("username");

    userName = TextEditingController(text: username);
    mobileNumber = TextEditingController(text: mobileNumbers);
    emailController = TextEditingController(text: email);

    super.initState();
  }

  bool isUploading = false;
  //NEW CODE
  Future<void> _pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile == null) return;

      setState(() => isUploading = true);

      // ── Crop ──────────────────────────────────────────────────────────────
      final CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        // aspectRatioPresets: [
        //   CropAspectRatioPreset.square,
        //   CropAspectRatioPreset.ratio3x2,
        //   CropAspectRatioPreset.original,
        //   CropAspectRatioPreset.ratio4x3,
        //   CropAspectRatioPreset.ratio16x9,
        // ],
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
           // toolbarColor: Colors.deepOrange,
            toolbarColor:Customcolors.darkpurple,
activeControlsWidgetColor:   Customcolors.darkpurple,
 
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(minimumAspectRatio: 1.0),
        ],
      );

      if (croppedFile == null) {
        setState(() => isUploading = false);
        return; // user cancelled crop
      }

   //   ── Size check (1 MB) ────────────────────────────────────────────────
     final int bytes = await File(croppedFile.path).length();
     const int maxSize = 1 * 1024 * 1024; // 1 MB

      if (bytes > maxSize) {
        setState(() {
          isUploading = false;
          _imageErrorText = 'Please upload an image under 1 MB';
        });
        return;
      }

    //  ── Passed size check: proceed ───────────────────────────────────────
      setState(() {
        _image = File(croppedFile.path);
        _imageErrorText = null;

        isTyping = true;
      });

      await fileuploader
          .uploadImage(pickedFile, XFile(croppedFile.path))
          .whenComplete(() => setState(() => isUploading = false));
     } catch (e) {
      setState(() => isUploading = false);
      debugPrint("Error picking/cropping image: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went wrong: $e')),
      );
     }
  }

//OLD CODE
  // Future<void> _pickImage() async {
  //   try {
  //     final pickedFile =
  //         await ImagePicker().pickImage(source: ImageSource.gallery);

  //     if (pickedFile != null) {
  //       setState(() {
  //         isUploading = true;
  //       });

  //       CroppedFile? croppedFile = await ImageCropper().cropImage(
  //         sourcePath: pickedFile.path,
  //         aspectRatioPresets: [
  //           CropAspectRatioPreset.square,
  //           CropAspectRatioPreset.ratio3x2,
  //           CropAspectRatioPreset.original,
  //           CropAspectRatioPreset.ratio4x3,
  //           CropAspectRatioPreset.ratio16x9,
  //         ],
  //         uiSettings: [
  //           AndroidUiSettings(
  //             toolbarTitle: 'Cropper',
  //             toolbarColor: Colors.deepOrange,
  //             toolbarWidgetColor: Colors.white,
  //             initAspectRatio: CropAspectRatioPreset.original,
  //             lockAspectRatio: false,
  //           ),
  //           IOSUiSettings(
  //             minimumAspectRatio: 1.0,
  //           ),
  //         ],
  //       );

  //       if (croppedFile != null) {
  //         setState(() {
  //           _image = File(croppedFile.path);
  //           isTyping = true;
  //         });

  //         await fileuploader
  //             .uploadImage(pickedFile, XFile(croppedFile.path))
  //             .then((value) {
  //           setState(() {
  //             isUploading = false;
  //           });
  //         });
  //       } else {}
  //     } else {}
  //   } catch (e) {
  //     print("Error picking and cropping image: $e");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Customcolors.DECORATION_CONTAINERGREY,
      appBar: AppBar(
        backgroundColor: Customcolors.DECORATION_WHITE,
        centerTitle: true,
        title: const Text(
          'Edit Profile',
          style: CustomTextStyle.darkgrey,
        ),
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            setState(() {
              profileuploed = '';
            });

            Get.back();
          },
          child: const Icon(Icons.arrow_back,
              color: Customcolors.DECORATION_BLACK),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 27),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      ClipOval(
                        child: SizedBox(
                          height: 115,
                          width: 115,
                          child: _image != null
                              ? Image.file(_image!, fit: BoxFit.cover)
                              : widget.image != null
                                  ? Image.network(widget.image,
                                      fit: BoxFit.cover)
                                  : Image.asset("assets/images/Profile.png",
                                      fit: BoxFit.cover),
                        ),
                      ),
                      Positioned(
                        bottom: 7,
                        right: 0,
                        child: GestureDetector(
                          onTap: () async {
                            await _pickImage();
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: const BoxDecoration(
                             // color: Colors.orange,
                              color: Customcolors.darkpurple,
 
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.edit,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (_imageErrorText != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    _imageErrorText!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 13,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: AddressFormFeild(
                  validator: profilevalidateName,
                  controller: userName,

                  // focusNode: otpFocusNode,

                  onChanged: (value) {
                    setState(() {
                      isTyping = value.isNotEmpty;
                    });
                  },

                  // controller: housenocontroller,

                  readonly: false,
                  hintText: '',

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
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 16.0),
                                )
                              ]),
                        ),
                      ],
                    ),

                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 10),
                    errorStyle: CustomTextStyle.notetext,
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
                      borderSide:
                          BorderSide(color: Customcolors.DECORATION_GREY),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),

                    // hintStyle: RedoCustomTextStyle.regularTextFormHintStyle,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: AddressFormFeild(
                  controller: mobileNumber,
                  readonly: true,
                  hintText: '',
                  decoration: InputDecoration(
                    label: Row(
                      children: [
                        RichText(
                          text: const TextSpan(
                              text: "Mobile Number",
                              style: CustomTextStyle.addressfeildtext,
                              children: []),
                        ),
                      ],
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 10),
                    errorStyle: CustomTextStyle.notetext,
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
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Customcolors.DECORATION_RED),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Customcolors.DECORATION_GREY),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Customcolors.DECORATION_GREY),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    // hintStyle: RedoCustomTextStyle.regularTextFormHintStyle,
                  ),
                  onChanged: (value) {
                    isTyping = value.isNotEmpty;
                  },
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: AddressFormFeild(
                  controller: emailController,
                  readonly: true,
                  hintText: '',
                  decoration: InputDecoration(
                    label: Row(
                      children: [
                        RichText(
                          text: const TextSpan(
                              text: "E-mail",
                              style: CustomTextStyle.addressfeildtext,
                              children: []),
                        ),
                      ],
                    ),

                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 10),
                    errorStyle: CustomTextStyle.notetext,
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
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Customcolors.DECORATION_RED),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Customcolors.DECORATION_GREY),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Customcolors.DECORATION_GREY),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    // hintStyle: RedoCustomTextStyle.regularTextFormHintStyle,
                  ),
                  onChanged: (value) {
                    isTyping = value.isNotEmpty;
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 3),
              isTyping
                  ? isUploading
                      ? Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration:
                                CustomContainerDecoration.profileborder(),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width * 0.9,
                                    50),
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                              ),
                              child: const Text('Update Profile',
                                  style: CustomTextStyle.profilegrey),
                            ),
                          ),
                        )
                      : Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: CustomContainerDecoration
                                .gradientbuttondecoration(),
                            child: ElevatedButton(
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  Navigator.pop(context);

                                  registerscreenController
                                      .profileUpdate(
                                    name: userName.text.toString(),
                                    imageurl: getStorage.read('imgUrl'),

                                    // imageurl:  profileuploed
                                    // imageurl: ImageUploader.img.value,
                                  )
                                      .then((value) {
                                    setState(() {
                                      _image = null;
                                      username = userName.text.toString();
                                      profileuploed = '';
                                    });
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                              ),
                              child: const Text(
                                'Update Profile',
                                style: CustomTextStyle.loginbuttontext,
                              ),
                            ),
                          ),
                        )
                  : Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: CustomContainerDecoration.profileborder(),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(
                                MediaQuery.of(context).size.width * 0.9, 50),
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                          child: const Text('Update Profile',
                              style: CustomTextStyle.profilegrey),
                        ),
                      ),
                    ),
              const SizedBox(height: 35),
            ],
          ),
        ),
      ),
    );
  }
}
