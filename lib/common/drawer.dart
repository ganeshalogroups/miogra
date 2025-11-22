import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:testing/Features/Authscreen/AuthController/Registercontroller.dart';
import 'package:testing/Features/Authscreen/GoogleSignin/GoogleSignInApi.dart';
import 'package:testing/Features/Authscreen/Splashscreen.dart';
import 'package:testing/Features/Foodmodule/Data/cartprovider.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Restaurantcard.dart';
import 'package:testing/Features/Homepage/AddressController/Addresscontroller.dart';
import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Redirectcontroller.dart';
import 'package:testing/Features/Homepage/Profile_Orders/Faq.dart';
import 'package:testing/Features/Homepage/Profile_Orders/your_order.dart';
import 'package:testing/Features/Homepage/profile.dart';
import 'package:testing/Features/Homepage/profile/addressbook.dart';
import 'package:testing/Features/Homepage/profile/editprofile.dart';
import 'package:testing/utils/Buttons/CustomButton.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';

import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Shimmers/profilecardShimmer.dart';

class CustomDrawer extends StatefulWidget {
  final String userName;
  final String email;
  final String phone;
  final String? profileImage;

  const CustomDrawer({
    super.key,
    this.userName = "Abi",
    this.email = "abi@gmail.com",
    this.phone = "123456",
    this.profileImage,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
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
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.70,
      child: SingleChildScrollView(
        child: Column(
          children: [
            
            UserId == null?  const SizedBox.shrink() : Obx(() {
                    if (getProfile.isuserDataLoading.isTrue) {
                      return const ProfileCardShimmer();
                    } else if (getProfile.profilege == null) {
                      return const Text('');
                    } else {
                      // return profileTile(
                      //   context: context,
                      //   username: getProfile.profilege!.data!.name,
                      //   email: getProfile.profilege!.data!.email,
                      //   imageurl: getProfile.profilege!.data!.imgUrl,
                      //   phonenumber: getProfile.profilege!.data!.mobileNo,
                      // );
        
                 return 
              Container(
              height: 210,
              width: double.infinity,
              padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Customcolors.lightpurple,
                    Customcolors.darkpurple,
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    // backgroundImage: widget.profileImage != null
                    //     ? NetworkImage(getProfile.profilege!.data!.imgUrl.toString())
                    //     : null,
                    // child: widget.profileImage == null
                    //     ? const Icon(Icons.person, size: 45, color: Colors.grey)
                    //     : null,
                      child:  getProfile.profilege!.data!.imgUrl != null 
                       ? ClipOval(
                        child: SizedBox(
                          height: 115,
                          width: 115,
                          child: Image.network(
                            getProfile.profilege!.data!.imgUrl.toString(),
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
                                 getProfile.profilege!.data!.name.toString().isNotEmpty
                                      ?  getProfile.profilege!.data!.name.toString().substring(0, 1).toUpperCase()
                                      : '',
                                  style: CustomTextStyle.boldblack32,
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    : Text(
                       getProfile.profilege!.data!.name.toString().isNotEmpty
                            ? getProfile.profilege!.data!.name.toString().substring(0, 1).toUpperCase()
                            : '',
                        style: CustomTextStyle.boldblack32,
                      ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                   getProfile.profilege!.data!.name.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("+91 ${getProfile.profilege!.data!.mobileNo}",
                   
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  Text(
                   getProfile.profilege!.data!.email.toString(),
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            );
                    }
                  }),
        
        
            const SizedBox(height: 20),
        
            // ================= MENU ITEMS ===================
            drawerItem(
              icon: Icons.gps_fixed_rounded,
              title: "Address Book",
              subtitle: "Add new address & Edit Address",
              onTap: () {
                  Get.to(const AddressbookScreen(),
                                transition: Transition.leftToRight);
              },
            ),
          const SizedBox(height: 20),
            drawerItem(
              icon: Icons.mode_edit_outlined,
              title: "Edit Profile",
              subtitle: "Edit your name & profile picture",
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
            ),
          const SizedBox(height: 20),
            drawerItem(
              icon: Icons.shopping_cart_checkout_rounded,
              title: "Your Orders",
              subtitle: "View your previous orders",
              onTap: () {
                  Get.to(const YourOrdersTabsScreen(),
                                transition: Transition.leftToRight);
              },
            ),
          const SizedBox(height: 20),
            drawerItem(
              icon: Icons.question_mark_outlined,
              title: "FAQ",
              subtitle: "Frequently Asked Questions",
              onTap: () {
                   Get.to(const FAQScreen(),
                                transition: Transition.leftToRight);
              },
            ),
          const SizedBox(height: 20),
            drawerItem(
              icon: Icons.info_outline_rounded,
              title: "About",
              subtitle: "Know more about Miogra & Terms of Services",
              onTap: () {
                 for (var item
                                in redirect.redirectLoadingDetails["data"]) {
                              if (item["key"] == "termsandservice") {
                                launchwebUrl(context, item["value"]);
        
                                break; // Exit loop once the "whatsappLink" is found and launched
                              }
                            }
              },
            ),
          const SizedBox(height: 20),
            drawerItem(
              icon: Icons.privacy_tip_outlined,
              title: "Privacy Policy",
              subtitle: "Our Privacy Policy",
              onTap: () {
                  for (var item
                                in redirect.redirectLoadingDetails["data"]) {
                              if (item["key"] == "privacyLink") {
                                launchwebUrl(context, item["value"]);
        
                                break; // Exit loop once the "whatsappLink" is found and launched
                              }
                            }
              },
            ),
          const SizedBox(height: 20),
            // drawerItem(
            //   icon: Icons.logout_outlined,
            //   title: "Logout",
            //   subtitle: "",
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            // ),
         drawerItem(
              icon: Icons.delete_outline_outlined,
              title: 'Delete your Miogra Account',
              subtitle: "",
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
                                        gradient: const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                           colors: [
                                           
        
                                            Customcolors.darkpinkColor,
         Customcolors.darkpinkColor
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
            ),
          const SizedBox(height: 20),
        
             UserId != null?
                        drawerItem(
                                    icon: Icons.logout_outlined,
                                    title: "Logout",
                                    subtitle: "",
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
                                  )
                        :const SizedBox.shrink(),
        
        //                        SizedBox(height: 10.h),
        
        //           InkWell(
        //                         onTap: () {
        //                           showDialog(
        //                             context: context,
        //                             builder: (context) {
        //                               return AlertDialog(
        //                                 surfaceTintColor: Colors.white,
        //                                 shape: RoundedRectangleBorder(
        //                                     borderRadius: BorderRadius.circular(10)),
        //                                 title: const Center(
        //                                     child: Text('Account Deletion',
        //                                         style: CustomTextStyle.boldblack18)),
        //                                 buttonPadding:
        //                                     const EdgeInsets.symmetric(horizontal: 10),
        //                                 actionsAlignment: MainAxisAlignment.spaceAround,
        //                                 actions: [
        //                                   InkWell(
        //                                     borderRadius: BorderRadius.circular(30),
        //                                     onTap: () {
        //                                       Navigator.pop(context);
        //                                     },
        //                                     child: Container(
        //                                       height: 44,
        //                                       width: 100,
        //                                       decoration: BoxDecoration(
        //                                           borderRadius:
        //                                               BorderRadius.circular(30),
        //                                           border: Border.all(
        //                                               color: Customcolors
        //                                                   .DECORATION_GREY)),
        //                                       child: const Center(
        //                                         child: Text(
        //                                           'No',
        //                                           style: CustomTextStyle.grey12,
        //                                         ),
        //                                       ),
        //                                     ),
        //                                   ),
        //                                   CustomButton(
        //                                       borderRadius: BorderRadius.circular(30),
        //                                       width: 100,
        //                                       gradient: const LinearGradient(
        //                                         begin: Alignment.topCenter,
        //                                         end: Alignment.bottomCenter,
        //                                          colors: [
        //                                           // Color(0xFFF98322), // Color code for #F98322
        //                                           // Color(0xFFEE4C46), // End color
        
        //                                           Customcolors.lightpurple,
        //  Customcolors.darkpurple
        //                                         ],
        //                                       ),
        //                                       onPressed: () {
        //                                         getProfile.profileDeleteUser();
        //                                         Provider.of<FavoritesProvider>(context,
        //                                                 listen: false)
        //                                             .deleteDatabaseAndData();
        //                                       },
        //                                       child: const Text('Yes',
        //                                           style:
        //                                               CustomTextStyle.loginbuttontext))
        //                                 ],
        //                                 content: const Text(
        //                                   'This action will delete your account. Are you sure you want to continue?',
        //                                   style: CustomTextStyle.grey12,
        //                                 ),
        //                               );
        //                             },
        //                           );
        //                         },
        //                         child: Container(
        //                           // height: 40,
        //                          // width: MediaQuery.of(context).size.width,
        //                           // margin: const EdgeInsets.symmetric(horizontal: 16),
        //                           padding: const EdgeInsets.symmetric(
        //                               horizontal: 16, vertical: 16),
        //                           decoration: BoxDecoration(
        //                             color: Customcolors.DECORATION_LIGHTGREY,
        //                             borderRadius: BorderRadius.circular(10),
        //                             boxShadow: [
        //                               BoxShadow(
        //                                 color: Colors.grey.withOpacity(0.1),
        //                                 spreadRadius: 1,
        //                                 blurRadius: 3,
        //                                 offset: const Offset(0, 1),
        //                               ),
        //                             ],
        //                           ),
        //                           alignment: Alignment.center,
        //                           child: const Text(
        //                             'Delete your Miogra Account',
        //                             style: CustomTextStyle.bolddecorationORANGEtext,
        //                           ),
        //                         ),
        //                       )
          ],
        ),
      ),
    );
  }

  // ================= ITEM TEMPLATE ===================
  Widget drawerItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Customcolors.darkpurple, size: 25.sp),
      title: Text(
        title,
        style:  TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: subtitle.isEmpty
          ? null
          : Text(
              subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
      trailing: const Icon(
        Icons.arrow_forward_ios_outlined,
        size: 18,
        color: Colors.grey,
      ),
      onTap: onTap,
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


}
