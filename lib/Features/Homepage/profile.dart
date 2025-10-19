// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:testing/Features/Authscreen/AuthController/Registercontroller.dart';
import 'package:testing/Features/Authscreen/GoogleSignin/GoogleSignInApi.dart';
import 'package:testing/Features/Authscreen/Loginscreen.dart';
import 'package:testing/Features/Authscreen/Splashscreen.dart';
import 'package:testing/Features/Foodmodule/Data/cartprovider.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodhomepage.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Restaurantcard.dart';
import 'package:testing/Features/Homepage/AddressController/Addresscontroller.dart';
import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Redirectcontroller.dart';
import 'package:testing/Features/Homepage/Profile_Orders/Faq.dart';
import 'package:testing/Features/Homepage/homepage.dart';

import 'package:testing/Features/Homepage/profile/addressbook.dart';
import 'package:testing/Features/Homepage/profile/editprofile.dart';
import 'package:testing/utils/Buttons/CustomButton.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Shimmers/profilecardShimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'Profile_Orders/your_order.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  RegisterscreenController getProfile = Get.put(RegisterscreenController());
  AddressController addresscontroller = Get.put(AddressController());
  RedirectController redirect = Get.put(RedirectController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getProfile.profileget();
      redirect.getredirectDetails();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) return;

        Get.off(const Foodscreen(categoryFilter: "restaurant",), transition: Transition.rightToLeft);
        // Get.off(HomeScreenPage(), transition: Transition.rightToLeft);
      },
      child: Scaffold(
        backgroundColor: Customcolors.DECORATION_WHITE,
        appBar: AppBar(
            surfaceTintColor: Customcolors.DECORATION_WHITE,
            backgroundColor: Customcolors.DECORATION_WHITE,
            title: const Text('Profile ', style: TextStyle(
      fontSize: 20,
      color: Customcolors.DECORATION_DARKGREY,fontWeight: FontWeight.bold,
      fontFamily: 'Poppins-Regular')),
            automaticallyImplyLeading: false,
            leading: InkWell(
                onTap: () {
                  Get.off(const Foodscreen(categoryFilter: "restaurant",), transition: Transition.rightToLeft);
                },
                child: const Icon(Icons.arrow_back_ios_new_outlined)),
      //       actions: [
      //         Material(
      //           color: Colors.transparent,
      //           child: InkWell(
      //             borderRadius: const BorderRadius.all(Radius.circular(20)),
      //             onTap: () {
      //               for (var item in redirect.redirectLoadingDetails["data"]) {
      //                 if (item["key"] == "whatsappLink") {
      //                   launchWhatsApp(item["value"]);
      //                   break; // Exit loop once the "whatsappLink" is found and launched
      //                 }
      //               }
      //             },
      //             child: Padding(
      //               padding: const EdgeInsets.symmetric(horizontal: 16),
      //               child: Container(
      //                 height: 30,
      //                 width: 45,
      //                 decoration: const BoxDecoration(
      //                     //color: Color.fromARGB(255, 254, 210, 182),
      //                     color:  Customcolors.darkpurple,

      //                     borderRadius: BorderRadius.all(Radius.circular(5))),
      //                 child: const Center(
      //                     child: Text(
      //                   "Help",
      //                   style:TextStyle(
      // fontSize: 13,
      // fontWeight: FontWeight.w500,
      // fontFamily: 'Poppins-Medium',
      
      // color: Colors.white),
      //                 )),
      //               ),
      //             ),
      //           ),
      //         )
      //       ],
            centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
              UserId == null?  const SizedBox.shrink() : Obx(() {
                  if (getProfile.isuserDataLoading.isTrue) {
                    return const ProfileCardShimmer();
                  } else if (getProfile.profilege == null) {
                    return const Text('');
                  } else {
                    return profileTile(
                      context: context,
                      username: getProfile.profilege!.data!.name,
                      email: getProfile.profilege!.data!.email,
                      imageurl: getProfile.profilege!.data!.imgUrl,
                      phonenumber: getProfile.profilege!.data!.mobileNo,
                    );
                  }
                }),

               UserId == null? const SizedBox.shrink(): const Divider(
                    color: Customcolors.DECORATION_GREY,
                    endIndent: 10,
                    indent: 10),

                // SizedBox(height: 15),
                Container(
                  // width: MediaQuery.of(context).size.width / 1,
                  decoration: const BoxDecoration(
                    color: Customcolors.DECORATION_WHITE,
                  ),
                  // padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                   UserId != null?   InkWell(
                        onTap: () {
                          Get.to(const AddressbookScreen(),
                              transition: Transition.leftToRight);
                        },
                        child: profileoptions(
                            context: context,
                            icon: const SizedBox(
                                height: 30,
                                width: 30,
                                child: Icon(Icons.gps_fixed_rounded)),
                            fieldname: 'Address Book',
                            subname: 'Add new address & Edit Address'),
                      ):const SizedBox.shrink(),
                UserId != null?
                      InkWell(
                        onTap: () {
                          if (getProfile.profilege!.data?.imgUrl == null) {
                            Get.to(
                                EditProfileScreen(
                                    image: getProfile.profilege!.data!.imgUrl),
                                transition: Transition.leftToRight);
                          } else {
                            // setState(() {
                            //    profileImgae=   getProfile.profilege!.data!.imgUrl!;
                            // });

                            profileuploed = getProfile.profilege!.data!.imgUrl!;

                            getStorage.write(
                                'imgUrl', getProfile.profilege!.data!.imgUrl);
                            Get.to(
                                EditProfileScreen(
                                    image: getProfile.profilege!.data!.imgUrl),
                                transition: Transition.leftToRight);
                          }
                        },
                        child: profileoptions(
                            context: context,
                            icon: const SizedBox(
                                height: 30,
                                width: 30,
                                child: Icon(Icons.mode_edit_outlined)),
                            fieldname: 'Edit Profile',
                            subname: 'Edit your name & profile picture'),
                      ):
                   loginmethod(context),
                  UserId != null?
                      InkWell(
                        onTap: () {
                          Get.to(const YourOrdersTabsScreen(),
                              transition: Transition.leftToRight);
                        },
                        child: profileoptions(
                            context: context,
                            icon: const SizedBox(
                                height: 30,
                                width: 30,
                                child:
                                    Icon(Icons.shopping_cart_checkout_rounded)),
                            fieldname: 'Your Orders',
                            subname: 'View your previous orders'),
                      ):const SizedBox.shrink(),
                      //  InkWell(

                      //   onTap: () {
                      //     Get.to(WalletScreen(),
                      //         transition: Transition.leftToRight);
                      //   },

                      //   child: profileoptions(
                      //       context: context,
                      //       icon: SizedBox( height: 30,width: 30, child: Icon(MdiIcons.wallet)),
                      //       fieldname: 'Your Wallet',
                      //       subname  : 'View your previous orders'),
                      // ),
                      InkWell(
                        onTap: () {
                          Get.to(const FAQScreen(),
                              transition: Transition.leftToRight);
                        },
                        child: profileoptions(
                            context: context,
                            icon: const SizedBox(
                                height: 30,
                                width: 30,
                                child: Icon(Icons.question_mark_outlined)),
                            fieldname: 'FAQ',
                            subname: 'Frequently Asked Questions'),
                      ),

                      InkWell(
                        onTap: () {
                          for (var item
                              in redirect.redirectLoadingDetails["data"]) {
                            if (item["key"] == "termsandservice") {
                              launchwebUrl(context, item["value"]);

                              break; // Exit loop once the "whatsappLink" is found and launched
                            }
                          }
                        },
                        child: profileoptions(
                            context: context,
                            icon: const SizedBox(
                                height: 30,
                                width: 30,
                                child: Icon(Icons.info_outline_rounded)),
                            fieldname: 'About',
                            subname:
                                'Know more about Miogra & Terms of Services'),
                      ),
                    // UserId != null?
                    //   InkWell(
                    //     onTap: () {
                    //       for (var item
                    //           in redirect.redirectLoadingDetails["data"]) {
                    //         if (item["key"] == "refundLink") {
                    //           launchwebUrl(context, item["value"]);

                    //           break; // Exit loop once the "whatsappLink" is found and launched
                    //         }
                    //       }
                    //     },
                    //     child: profileoptions(
                    //         context: context,
                    //         icon: const SizedBox(
                    //             height: 30,
                    //             width: 30,
                    //             child: Icon(Icons.payment_outlined)),
                    //         fieldname: 'Payment &Refunds',
                    //         subname: 'Know more about Miogra'),
                    //   ):const SizedBox.shrink(),
                      InkWell(
                        onTap: () {
                          for (var item
                              in redirect.redirectLoadingDetails["data"]) {
                            if (item["key"] == "privacyLink") {
                              launchwebUrl(context, item["value"]);

                              break; // Exit loop once the "whatsappLink" is found and launched
                            }
                          }
                        },
                        child: profileoptions(
                            context: context,
                            icon: const SizedBox(
                                height: 30,
                                width: 30,
                                child: Icon(Icons.privacy_tip_outlined)),
                            fieldname: 'Privacy Policy',
                            subname: 'Our Privacy Policy'),
                      ),
                      UserId != null?
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                surfaceTintColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                title: const Center(
                                    child: Text('Logout',
                                        style: CustomTextStyle.boldblack18)),
                                buttonPadding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                actionsAlignment: MainAxisAlignment.spaceAround,
                                actions: [
                                  InkWell(
                                    borderRadius: BorderRadius.circular(30),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 44,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Customcolors
                                                  .DECORATION_GREY)),
                                      child: const Center(
                                        child: Text(
                                          'No',
                                          style: CustomTextStyle.grey12,
                                        ),
                                      ),
                                    ),
                                  ),
                                  CustomButton(
                                      borderRadius: BorderRadius.circular(5),
                                      width: 100,
                                      onPressed: () {
                                        setState(() {
                                          GoogleSignInApi.logout();

                                          ///====\\\====///\\\===|===|===|===|
                                          getStorage.remove("mobilenumb");

                                          ///====\\\====///\\\===|===|===|===|
                                          getStorage.remove("Usertoken");

                                          ///====\\\====///\\\===|===|===|===|
                                          getStorage.remove("UserId");

                                          ///====\\\====///\\\===|===|===|===|
                                          getStorage.remove("useremail");

                                          ///====\\\====///\\\===|===|===|===|
                                          getStorage.remove("username");

                                          ///====\\\====///\\\===|===|===|===|
                                          getStorage.remove("imgUrl");

                                          ///====\\\====///\\\===|===|===|===|
                                          addresscontroller.logout();

                                          ///====\\\====///\\\===|===|===|===|
                                          logoutfunction();
                                          newListData.clear();
                                        });

                                        Provider.of<FavoritesProvider>(context,
                                                listen: false)
                                            .deleteDatabaseAndData();

                                        // SystemNavigator.pop();
                                        Get.offAll(const SplashScreen(),
                                            transition: Transition.leftToRight);
                                      },
                                      child: const Text('Yes',
                                          style:
                                              CustomTextStyle.loginbuttontext))
                                ],
                                content: const Text(
                                  'Are you Sure You want to Logout?',
                                  style: CustomTextStyle.grey12,
                                ),
                              );
                            },
                          );
                        },
                        child: profileoptions(
                            context: context,
                            icon: const SizedBox(
                                height: 30,
                                width: 30,
                                child: Icon(Icons.logout_outlined)),
                            fieldname: 'Logout',
                            subname: 'Logout option'),
                      ):const SizedBox.shrink(),

                       SizedBox(height: 10.h), // spacing below Logout
                      // UserId != null?
                      // const Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: Padding(
                      //     padding: EdgeInsets.symmetric(horizontal: 16.0),
                      //     child: Text(
                      //       'Account Deletio',
                      //       style: CustomTextStyle
                      //           .profile, // Use your preferred heading style
                      //     ),
                      //   ),
                      // ):const SizedBox.shrink(),

                     // const SizedBox(height: 10),

                    // Container with "Delete your Fastx Account" text
                     UserId != null? InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                surfaceTintColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                title: const Center(
                                    child: Text('Account Deletion',
                                        style: CustomTextStyle.boldblack18)),
                                buttonPadding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                actionsAlignment: MainAxisAlignment.spaceAround,
                                actions: [
                                  InkWell(
                                    borderRadius: BorderRadius.circular(30),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 44,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          border: Border.all(
                                              color: Customcolors
                                                  .DECORATION_GREY)),
                                      child: const Center(
                                        child: Text(
                                          'No',
                                          style: CustomTextStyle.grey12,
                                        ),
                                      ),
                                    ),
                                  ),
                                  CustomButton(
                                      borderRadius: BorderRadius.circular(30),
                                      width: 100,
                                      gradient: const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                         colors: [
                                          // Color(0xFFF98322), // Color code for #F98322
                                          // Color(0xFFEE4C46), // End color

                                          Customcolors.lightpurple,
 Customcolors.darkpurple
                                        ],
                                      ),
                                      onPressed: () {
                                        getProfile.profileDeleteUser();
                                        Provider.of<FavoritesProvider>(context,
                                                listen: false)
                                            .deleteDatabaseAndData();
                                      },
                                      child: const Text('Yes',
                                          style:
                                              CustomTextStyle.loginbuttontext))
                                ],
                                content: const Text(
                                  'This action will delete your account. Are you sure you want to continue?',
                                  style: CustomTextStyle.grey12,
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          // height: 40,
                         // width: MediaQuery.of(context).size.width,
                          // margin: const EdgeInsets.symmetric(horizontal: 16),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          decoration: BoxDecoration(
                            color: Customcolors.DECORATION_LIGHTGREY,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Delete your Miogra Account',
                            style: CustomTextStyle.bolddecorationORANGEtext,
                          ),
                        ),
                      ):const SizedBox.shrink(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

Widget loginmethod(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
    child: Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFDF7F3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFFCBA5), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon in gradient circle
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Customcolors.lightpurple,
                Customcolors.darkpurple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Icon(Icons.lock_outline, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 16),

          // Title
          const Text(
            'You’re not logged in',
            style:CustomTextStyle.black14bold
          ),
          const SizedBox(height: 8),

          // Subtitle
          const Text(
            'Login to access your profile, saved addresses, orders, and more.',
            textAlign: TextAlign.center,
            style:CustomTextStyle.chipgreybold,
          ),
          const SizedBox(height: 24),

          // Gradient-styled button inside container
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Customcolors.lightpurple,
              Customcolors.darkpurple],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child:CustomButton(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            onPressed:() {
              Get.off(() => const Loginscreen(), transition: Transition.leftToRight);
            }, child:const Text("Login to your Account",style: CustomTextStyle.addressfeildbutton)),
          ),
        ],
      ),
    ),
  );
}
}
Widget profileTile({context, username, phonenumber, email, imageurl}) {
  return Container(
    height: 100.h,
    padding: const EdgeInsets.all(15),
    // width: MediaQuery.of(context).size.width / 1,
    decoration: const BoxDecoration(
      color: Customcolors.DECORATION_WHITE,
    ),
    child: Row(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue.shade100,
              child: imageurl != null && imageurl.isNotEmpty
                  ? ClipOval(
                      child: SizedBox(
                        height: 115,
                        width: 115,
                        child: Image.network(
                          imageurl,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child; // Image has fully loaded
                            } else {
                              return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                      width: 90,
                                      height: 90,
                                      color: Colors.grey[300]));
                            }
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Text(
                                username.isNotEmpty
                                    ? username.substring(0, 1).toUpperCase()
                                    : '',
                                style: CustomTextStyle.boldblack32,
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : Text(
                      username.isNotEmpty
                          ? username.substring(0, 1).toUpperCase()
                          : '',
                      style: CustomTextStyle.boldblack32,
                    ),
            ),
          ],
        ),
        const SizedBox(width: 15),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 200,
              child: Text(
                username.toString().capitalizeFirst!,
                maxLines: 2,
                style: CustomTextStyle.boldorange,
                overflow: TextOverflow.clip,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Text(
                '+91 $phonenumber\n$email',
                style: CustomTextStyle.profiletitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget profileoptions(
    {required BuildContext context,
    required Widget icon,
    required,
    required String fieldname,
    required String subname}) {
  bool isLogout = fieldname == "Logout";
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(
                children: [
                  icon,
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fieldname,
                        style: CustomTextStyle.foodpricetext,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      if (!isLogout)
                        SizedBox(
                          width: 260,
                          child: Text(
                            subname,
                            style: CustomTextStyle.chipgrey,
                            overflow: TextOverflow.clip,
                          ),
                        )
                    ],
                  )
                ],
              ),
              if (!isLogout)
                const Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Customcolors.DECORATION_GREY,
                  size: 20,
                )
            ]),
          ],
        ),
      ),
      const Divider(
        color: Customcolors.DECORATION_GREY,
        endIndent: 10,
        indent: 10,
      ),
    ],
  );
}

launchWhatsApp(redirectLoadingDetail) async {
  final link = redirectLoadingDetail;
  //  WhatsAppUnilink(
  //   phoneNumber: '${redirectLoadingDetail}',
  //   text: "Hello!",
  // );
  await launch('$link');
  print("watsapplinkurl$link");
}

void launchwebUrl(BuildContext context, String url) async {
  try {
    print("privacyurllll${url}");
    await canLaunch(url);
    await launch(url);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Something went wrong when launching URL"),
      ),
    );
    print("error");
  }
}
