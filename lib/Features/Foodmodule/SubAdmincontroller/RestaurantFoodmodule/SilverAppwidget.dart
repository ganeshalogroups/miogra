// // // ignore_for_file: file_names, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

// // import 'package:cached_network_image/cached_network_image.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:testing/Features/Authscreen/Loginscreen.dart';
// // import 'package:testing/Features/Foodmodule/Data/cartprovider.dart';
// // import 'package:testing/Features/Foodmodule/Domain/favouritemodel.dart';
// // import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Foodsearchlistgetcontroller.dart';
// // import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodhomepage.dart';
// // import 'package:testing/Features/Foodmodule/Foodviewscreen/AddButtonFunctions/Buttonfunctionalities.dart';
// // import 'package:testing/Features/Foodmodule/SubAdmincontroller/Getmenucountcontroller.dart';
// // import 'package:testing/Features/Foodmodule/SubAdmincontroller/Getnearbyrescontroller.dart';
// // import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Redirectcontroller.dart';
// // import 'package:testing/utils/Buttons/CustomFavourite.dart';
// // import 'package:testing/utils/Buttons/CustomLogoutdialog.dart';
// // import 'package:testing/utils/Buttons/CustomTextstyle.dart';
// // import 'package:testing/utils/Buttons/Customspace.dart';
// // import 'package:testing/utils/Const/ApiConstvariables.dart';
// // import 'package:testing/utils/Const/constImages.dart';
// // import 'package:testing/utils/Containerdecoration.dart';
// // import 'package:testing/utils/CustomColors/Customcolors.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:get/get.dart';
// // import 'package:provider/provider.dart';
// // import 'package:animated_flip_counter/animated_flip_counter.dart';

// // // ignore: must_be_immutable
// // class SliverAppBarWidget extends StatefulWidget {
// //   final dynamic restaurantimg;
// //   final dynamic resRating;
// //   final dynamic restaurantname;
// //   // final List<dynamic>? additionalImages;
// //   final List<dynamic>? restaurantfoodtitle;
// //   final dynamic restaurantcity;
// //   final dynamic restaurantregion;
// //   final dynamic restaurantreview;
// //   final dynamic offerPercentage;
// //   final dynamic restaurantAvailable;
// //   // dynamic menu;
// //   bool isFromDishScreen;
// //   dynamic restaurantId;
// //   // dynamic restaurant;
// //   dynamic favouriteid;
// //   dynamic reviews;
// //   // dynamic favouritestatus;
// //   // final List favourListDetails;
// //   SliverAppBarWidget({
// //     this.isFromDishScreen = false,
// //      this.resRating,
// //     required this.restaurantimg,
// //     required this.restaurantname,
// //     this.restaurantfoodtitle,
// //     this.offerPercentage,
// //     this.reviews,
   
// //     // this.favourListDetails = const [],
// //     required this.restaurantcity,
// //     required this.restaurantregion,
// //     required this.restaurantreview,
// //     // required this.menu,
// //     // this.restaurant,
// //     this.restaurantId,
// //     this.favouriteid,
// //     // required this.favouritestatus,
// //     super.key,
// //     required this.restaurantAvailable,
// //     // this.additionalImages,
// //   });

// //   @override
// //   State<SliverAppBarWidget> createState() => _SliverAppBarWidgetState();
// // }

// // class _SliverAppBarWidgetState extends State<SliverAppBarWidget> {
// //   Nearbyrescontroller nearbyreget = Get.put(Nearbyrescontroller());

// //   Menucountgetcontroller menu = Get.put(Menucountgetcontroller());
// //   Foodsearchcontroller createrecentsearch = Get.put(Foodsearchcontroller());
// //   RedirectController redirect = Get.put(RedirectController());
// //   String? firstDetailId;
// //   @override
// //   // void initState() {
// //   //   WidgetsBinding.instance.addPostFrameCallback((_) {
// //   //     // redirect.getredirectDetails();
// //   //     menu.menucountget(restaurantid: widget.restaurantId);
// //   //   });

// //   //   // TODO: implement initState
// //   //   super.initState();
// //   // }

// //   @override
// //   Widget build(BuildContext context) {
// // print(" IMAGE ${widget.restaurantimg}");
// // String fullAddress =  widget.restaurantAvailable["address"]["fullAddress"];

// // List<String> parts = fullAddress.split(',');

// // String updated = "";
// // if (parts.length > 2) {
// //   updated = "${parts[0]}, ${parts[1]},\n${parts.sublist(2).join(',')}";
// // } else {
// //   updated = fullAddress;
// // }



// //     double rating = widget.restaurantreview.toString() == 'null'
// //         ? 0
// //         : double.tryParse(widget.restaurantreview.toString())
// //                 ?.roundToDouble() ??
// //             0;
// //     final restaurant = FavoriteRestaurant(
// //       id: widget.restaurantId,
// //       name: widget.restaurantname.toString(),
// //       city: widget.restaurantcity,
// //       region: widget.restaurantregion.toString(),
// //       imageUrl: widget.restaurantimg,
// //       rating: widget.restaurantreview,
// //     );
// //     final favoritesProvider = Provider.of<FavoritesProvider>(context);

// //     return SliverAppBar(
// //       toolbarHeight: 0,
// //       expandedHeight: MediaQuery.of(context).size.height / 1.85,
// //       // expandedHeight: 400.h,
// //       pinned: true,
// //       floating: false, // Ensure it doesn't float on scroll
// //       snap: false, // Ensure it doesn't snap back when scrolling stops
// //       automaticallyImplyLeading: false,
// //       flexibleSpace: FlexibleSpaceBar(
// //         expandedTitleScale: 2,
// //         collapseMode: CollapseMode.pin,
// //         background: Column(
// //           children: [
// //             Container(
// //               height: 240.h, // Adjust height as needed
// //               decoration: const BoxDecoration(
// //                 color: Customcolors.DECORATION_WHITE,
// //               ),
// //               child: Stack(
// //                 children: [
// //                   widget.restaurantAvailable?['restaurantAvailable'] != true ||
// //                           widget.restaurantAvailable?['activeStatus'] !=
// //                               'online' ||
// //                           widget.restaurantAvailable?['status'] != true
// //                       ? ClipRRect(
// //                         borderRadius: BorderRadiusGeometry.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
// //                           child: ColorFiltered(
// //                             colorFilter: const ColorFilter.mode(
// //                               Colors.grey,
// //                               BlendMode.saturation,
// //                             ),
// //                             child: CachedNetworkImage(
// //                               height: 250.h,
// //                               imageUrl: widget.restaurantimg,
// //                               placeholder: (context, url) =>
// //                                   Image.asset("${fastxdummyImg}"),
// //                               errorWidget: (context, url, error) =>
// //                                   Image.asset("${fastxdummyImg}"),
// //                               fit: BoxFit.cover,
// //                               width: MediaQuery.of(context)
// //                                   .size
// //                                   .width, // Full screen width
// //                             ),
// //                           ),
// //                         )
// //                       : ClipRRect(
// //                          borderRadius: BorderRadiusGeometry.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
// //                           child: CachedNetworkImage(
// //                             height: 240.h,
// //                             imageUrl: widget.restaurantimg,
// //                             placeholder: (context, url) =>
// //                                 Image.asset("${fastxdummyImg}"),
// //                             errorWidget: (context, url, error) =>
// //                                 Image.asset("${fastxdummyImg}"),
// //                             fit: BoxFit.cover,
// //                             width: MediaQuery.of(context)
// //                                 .size
// //                                 .width, // Full screen width
// //                           ),
// //                         ),
// //                   Positioned(
// //                     top: 0, // Position at the top
// //                     left: 0,
// //                     right: 0,
// //                     child: Column(
// //                       children: [
// //                         Row(
// //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                           children: [
// //                             Padding(
// //                               padding: const EdgeInsets.all(8.0),
// //                               child: GestureDetector(
// //                                 onTap: () {
// //                                   Provider.of<ButtonController>(context,
// //                                           listen: false)
// //                                       .hideButton();

// //                                   if (widget.isFromDishScreen) {
// //                                     Get.back();
// //                                     createrecentsearch
// //                                         .foodsearchlistloading.value = true;

// //                                     // Delay for 2 seconds to simulate loading, then fetch data
// //                                     Future.delayed(const Duration(seconds: 1),
// //                                         () async {
// //                                       createrecentsearch
// //                                           .foodsearchlistloading.value = false;
// //                                     });
// //                                   } else {
// //                                     Get.off(const Foodscreen(),
// //                                         transition: Transition.leftToRight);
// //                                   }
// //                                 },
// //                                 child: Container(
// //                                   height: 35,
// //                                   width: 35,
// //                                   decoration: const BoxDecoration(
// //                                     color: Colors.white60,
// //                                     borderRadius:
// //                                         BorderRadius.all(Radius.circular(40)),
// //                                   ),
// //                                   child: const Icon(
// //                                     Icons.arrow_back_ios_new_rounded,
// //                                     color: Customcolors.DECORATION_BLACK,
// //                                   ),
// //                                 ),
// //                               ),
// //                             ),
// //                             // UserId != null
// //                             //     ?

// // //                             Padding(
// // //                               padding:
// // //                                   const EdgeInsets.symmetric(horizontal: 12),
// // //                               child: FavoriteIcon(
// // //                                 isFavorite:
// // //                                     favoritesProvider.isFavorite(restaurant.id),
// // //                                 onTap: () {
// // //                                   if (UserId == null) {
// // //                                     showDialog(
// // //   context: context,
// // //   builder: (_) => LoginRequiredDialog(
// // //     title: "Login Required",
// // //     content: "Please login to add or remove this favorite item.",
// // //     cancelText: "Later",
// // //     confirmText: "Log In",
// // //     onConfirm: () {
// // //       // Navigate or perform any action
// // //       Get.offAll(() => const Loginscreen());
// // //     },
// // //   ),
// // // );
                                   
// // //                                     return;
// // //                                   }

// // //                                   // ✅ Proceed with favorite/unfavorite if UserId is not null
// // //                                   if (favoritesProvider
// // //                                       .isFavorite(restaurant.id)) {
// // //                                     favoritesProvider
// // //                                         .removeFavorite(restaurant.id);
// // //                                     nearbyreget.updateFavouriteFun(
// // //                                       productCategoryId: productCateId,
// // //                                       userId: UserId,
// // //                                       productId: restaurant.id,
// // //                                     );
// // //                                   } else {
// // //                                     favoritesProvider.addFavorite(restaurant);
// // //                                     nearbyreget.addfavouritesApi(
// // //                                       productCategoryId: productCateId,
// // //                                       userId: UserId,
// // //                                       productId: restaurant.id,
// // //                                     );
// // //                                   }
// // //                                 },
// // //                               ),
// // //                             ),
// //                             //: SizedBox(),
// //                           ],
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             Padding(
// //               padding: const EdgeInsets.all(10.0),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   SizedBox(
// //                     width: MediaQuery.of(context).size.width / 1.1.w,
// //                     child: Text(
// //                       widget.restaurantname
// //                           .toString()
// //                           .capitalizeFirst
// //                           .toString(),
// //                       overflow: TextOverflow.ellipsis,
// //                      // style: CustomTextStyle.subheading,
// //                       style: TextStyle(
// //       fontSize: 20.sp,
// //       fontWeight: FontWeight.w800,
// //       color: Customcolors.DECORATION_GREY,
// //       fontFamily: 'Poppins-SemiBold'),
// //                     ),
// //                     ),
                
// //                   const CustomSizedBox(height: 5),
// //                   // SizedBox(
// //                   //   height: 25.h,
// //                   //   child: ListView.builder(
// //                   //     shrinkWrap: true,
// //                   //     scrollDirection: Axis.horizontal,
// //                   //     itemCount: widget.restaurantfoodtitle!.length,
// //                   //     itemBuilder: (context, index) {
// //                   //       return Padding(
// //                   //         padding: const EdgeInsets.symmetric(horizontal: 3),
// //                   //         child: Row(
// //                   //           children: [
// //                   //             Text(
// //                   //               widget.restaurantfoodtitle![index]
// //                   //                       ['foodCusineName']
// //                   //                   .toString()
// //                   //                   .capitalizeFirst
// //                   //                   .toString(),
// //                   //               style: CustomTextStyle.darkgrey12,
// //                   //               overflow: TextOverflow.ellipsis,
// //                   //               softWrap: true,
// //                   //             ),
// //                   //             const SizedBox(width: 15),
// //                   //           ],
// //                   //         ),
// //                   //       );
// //                   //     },
// //                   //   ),
// //                   // ),
// //                   const CustomSizedBox(height: 5),
// //                   Row(
// //                     children: [
// //                       // const Icon(
// //                       //   Icons.location_on_rounded,
// //                       //   size: 20,
// //                       //   color: Customcolors.darkpurple,
// //                       // ),
// //                        Image.asset(
// //                           "assets/images/location_icon.png",
// //                         height: 30.sp,
// //                           //height: 30,
// //                         ),

                     
// // SizedBox(width: 10,),

// //                       Text(
// //                  updated
// //                             .toString()
// //                             .capitalizeFirst
// //                             .toString(),
                            

// //                       //  style: CustomTextStyle.foodviewtext,
// //                       style: TextStyle(
// //       fontSize: 13.sp,
// //       fontWeight: FontWeight.w600,
// //       color: Customcolors.DECORATION_GREY,
// //       fontFamily: 'Poppins-Medium'),
// //                     ),
                      
// //                     ],
// //                   ),
// //                   SizedBox(height: 20,),

// //   Row(children: [
// //               RichText(
// //   text: TextSpan(
// //     children: [
// //       TextSpan(
// //         text: 'Delivery Within ',
// //         style: GoogleFonts.montserrat(
// //           fontSize: 10.sp,
// //           color: Colors.black,
// //          // fontFamily: 'Poppins-Medium',
// //           fontWeight: FontWeight.w600,
// //         ),
// //       ),
// //       TextSpan(
// //         text: '10 Min',
// //         style: TextStyle(
// //           fontSize: 11.sp,
// //           color: Colors.green,
// //           fontWeight: FontWeight.w700,
// //         ),
// //       ),
// //       TextSpan(
// //         text: ' To ',
// //         style: TextStyle(
// //           fontSize: 11.sp,
// //           color: Colors.black,
// //           fontWeight: FontWeight.w800,
// //         ),
// //       ),
// //       TextSpan(
// //         text: '20 Min',
// //         style: TextStyle(
// //           fontSize: 11.sp,
// //           color: Colors.green,
// //           fontWeight: FontWeight.w700,
// //         ),
// //       ),
// //     ],
// //   ),
// // ),


// //                 Spacer(),
// //           //   widget.restaurantAvailable["ratings"] != null   //&&   widget.restaurantAvailable["ratings"]
// //               widget.resRating != "0" &&   widget.resRating != null
// //                       ? 
// //                     Row(
// //                 children: [
// //                  Image.asset("assets/images/star_icon.png",height: 16.sp,),
// //                             SizedBox(width: 5,),
// //                  ShaderMask(
// //   shaderCallback: (bounds) => const LinearGradient(
// //     colors: [Color(0xFFAE62E8), Color(0xFF623089)],
// //      begin: Alignment.topCenter,   // 👈 Start from top
// //     end: Alignment.bottomCenter,  // 👈 End at bottom
// //   ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
// //                   child: Text(widget.resRating.toString(),
// //                           //  widget.restaurantAvailable["rating"].toString(),
// //                             overflow: TextOverflow.ellipsis,
// //                            // style: CustomTextStyle.blacktext,
// //                            style: TextStyle(
// //                       fontSize: 16.sp,
// //                       fontWeight: FontWeight.w800,
// //                       color: Colors.white,
// //                       fontFamily: 'Poppins-Regular',
// //                     )
// //                           ),
// //                 )
                     
// //                       ]) :  Row(
// //                 children: [
// //                   // Icon(
// //                   //         Icons.star_outline_rounded,
// //                   //         size: 23.sp,
// //                   //         color: Color(0xFF623089)
// //                   //       ),
// //                      Image.asset("assets/images/star_icon.png",height: 16.sp,),
// //                             SizedBox(width: 5,),
// //                 ShaderMask(
// //   shaderCallback: (bounds) => const LinearGradient(
// //     colors: [Color(0xFFAE62E8), Color(0xFF623089)],
// //      begin: Alignment.topCenter,   // 👈 Start from top
// //     end: Alignment.bottomCenter,  // 👈 End at bottom
// //   ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
// //                   child: Text(
// //                            "0.0",
// //                             overflow: TextOverflow.ellipsis,
// //                            // style: CustomTextStyle.blacktext,
// //                            style: TextStyle(
// //                       fontSize: 16.sp,
// //                       fontWeight: FontWeight.w800,
// //                      // color: Color(0xFF623089),
// //                        color: Colors.white,
// //                       fontFamily: 'Poppins-Regular',
// //                     )
// //                           ),
// //                 )
                     
// //                       ]),
                      
               
// //                ],),
               
// //                 //  old my desogn
// //                   // const CustomSizedBox(height: 5),
// //                   // Row(
// //                   //   crossAxisAlignment: CrossAxisAlignment.start,
// //                   //   mainAxisAlignment: MainAxisAlignment.end,
// //                   //   children: [
// //                   //     rating != 0 &&
// //                   //             (widget.reviews.toString().isNotEmpty ||
// //                   //                 widget.reviews != 0)
// //                   //         ? Expanded(
// //                   //             child: Column(
// //                   //               mainAxisAlignment: MainAxisAlignment.center,
// //                   //               children: [
// //                   //                 Padding(
// //                   //                   padding: const EdgeInsets.all(8.0),
// //                   //                   child: rating != 0
// //                   //                       ? Row(
// //                   //                           mainAxisAlignment:
// //                   //                               MainAxisAlignment.center,
// //                   //                           children: [
// //                   //                             const Icon(
// //                   //                               Icons.star,
// //                   //                               size: 20,
// //                   //                               color: Colors.amber,
// //                   //                             ),
// //                   //                             5.toWidth,
// //                   //                             Text(
// //                   //                               rating.toString(),
// //                   //                               style: CustomTextStyle
// //                   //                                   .smallboldtext,
// //                   //                             ),
// //                   //                           ],
// //                   //                         )
// //                   //                       : const SizedBox.shrink(),
// //                   //                 ),
// //                   //                 widget.reviews.toString().isEmpty ||
// //                   //                         widget.reviews == 0
// //                   //                     ? const SizedBox.shrink()
// //                   //                     : Text(
// //                   //                         "( ${widget.reviews.toString()} reviews)",
// //                   //                         style: CustomTextStyle
// //                   //                             .font12blackregular),
// //                   //               ],
// //                   //             ),
// //                   //           )
// //                   //         : const SizedBox.shrink(),
// //                   //     rating != 0 &&
// //                   //             (widget.reviews.toString().isNotEmpty ||
// //                   //                 widget.reviews != 0)
// //                   //         ? const SizedBox(
// //                   //             height: 60,
// //                   //             child: VerticalDivider(
// //                   //               width: 1,
// //                   //               thickness: 1,
// //                   //               color: Customcolors.DECORATION_MEDIUMGREY,
// //                   //             ),
// //                   //           )
// //                   //         : const SizedBox.shrink(),
// //                   //     Expanded(
// //                   //       child: Column(
// //                   //         mainAxisAlignment: MainAxisAlignment.center,
// //                   //         children: [
// //                   //           Padding(
// //                   //             padding: const EdgeInsets.all(8.0),
// //                   //             child: Row(
// //                   //               mainAxisAlignment: MainAxisAlignment.center,
// //                   //               children: [
// //                   //                 const Image(
// //                   //                   image: AssetImage(
// //                   //                       "assets/images/File_duotone.png"),
// //                   //                       color:  Color(0xFF623089),
// //                   //                   height: 16,
// //                   //                   width: 25,
// //                   //                 ),
// //                   //                 Obx(() {
// //                   //                   if (menu.ismenucountloading.isTrue) {
// //                   //                     // Display a placeholder text or some static counter until loading completes
// //                   //                     return const AnimatedFlipCounter(
// //                   //                       value:
// //                   //                           0, // Starting value during loading
// //                   //                       duration: Duration(milliseconds: 500),
// //                   //                       textStyle:
// //                   //                           CustomTextStyle.smallboldtext,
// //                   //                     );
// //                   //                   } else if (menu.menucountModel == null ||
// //                   //                       menu.menucountModel["data"] == null) {
// //                   //                     // Handle the case where data is not available
// //                   //                     return const Center(
// //                   //                         child: Text('0',
// //                   //                             style: CustomTextStyle
// //                   //                                 .smallboldtext));
// //                   //                   } else {
// //                   //                     // Display the animated count after data is loaded
// //                   //                     int itemCount =
// //                   //                         menu.menucountModel["data"]?.length ??
// //                   //                             0;
// //                   //                     return AnimatedFlipCounter(
// //                   //                       value: itemCount,
// //                   //                       duration:
// //                   //                           const Duration(milliseconds: 500),
// //                   //                       textStyle:
// //                   //                           CustomTextStyle.smallboldtext,
// //                   //                     );
// //                   //                   }
// //                   //                 })
// //                   //               ],
// //                   //             ),
// //                   //           ),
// //                   //           const Text('Menu variants',
// //                   //               style: CustomTextStyle.font12blackregular),
// //                   //         ],
// //                   //       ),
// //                   //     ),
// //                   //     const SizedBox(
// //                   //       height: 60,
// //                   //       child: VerticalDivider(
// //                   //         width: 1,
// //                   //         thickness: 1,
// //                   //         color: Customcolors.DECORATION_MEDIUMGREY,
// //                   //       ),
// //                   //     ),
// //                   //     Expanded(
// //                   //       child: Column(
// //                   //         mainAxisAlignment: MainAxisAlignment.center,
// //                   //         children: [
// //                   //           Padding(
// //                   //             padding: const EdgeInsets.all(8.0),
// //                   //             child: Row(
// //                   //               mainAxisAlignment: MainAxisAlignment.center,
// //                   //               children: [
// //                   //                 const Image(
// //                   //                   image: AssetImage(
// //                   //                       "assets/images/discount.png"),
// //                   //                   height: 15,
// //                   //                   width: 20,
// //                   //                 ),
// //                   //                 (widget.offerPercentage != null &&
// //                   //                         widget.offerPercentage
// //                   //                             .toString()
// //                   //                             .isNotEmpty &&
// //                   //                         widget.offerPercentage != 0)
// //                   //                     ? Center(
// //                   //                         child: Text(
// //                   //                             '${widget.offerPercentage} % ',
// //                   //                             style: CustomTextStyle
// //                   //                                 .smallboldtext))
// //                   //                     : Obx(() {
// //                   //                         // Check if loading is in progress
// //                   //                         if (redirect
// //                   //                             .isredirectLoading.isTrue) {
// //                   //                           return AnimatedFlipCounter(
// //                   //                             value: double.tryParse(
// //                   //                                     0.toString()) ??
// //                   //                                 20.0, // Fallback to 20 if value is invalid
// //                   //                             duration: const Duration(
// //                   //                                 seconds:
// //                   //                                     1), // Set the duration of the animation
// //                   //                             curve: Curves
// //                   //                                 .easeInOut, // Optional: Set the animation curve
// //                   //                             textStyle: CustomTextStyle
// //                   //                                 .smallboldtext, // Customize text style

// //                   //                             suffix:
// //                   //                                 "% off ", // Add suffix text
// //                   //                           );
// //                   //                         }
// //                   //                         // If data is missing or null, show a default value
// //                   //                         else if (redirect
// //                   //                                     .redirectLoadingDetails ==
// //                   //                                 null ||
// //                   //                             redirect.redirectLoadingDetails[
// //                   //                                     "data"] ==
// //                   //                                 null) {
// //                   //                           return const Center(
// //                   //                               child: Text('No offers',
// //                   //                                   style: CustomTextStyle
// //                   //                                       .smallboldtext));
// //                   //                         } else {
// //                   //                           // Searching for "offerValue" in the data and using it directly
// //                   //                           for (var item in redirect
// //                   //                                   .redirectLoadingDetails[
// //                   //                               "data"]) {
// //                   //                             if (item["key"] == "offerValue") {
// //                   //                               // Directly access and display the offerValue with AnimatedFlipCounter
// //                   //                               return Row(
// //                   //                                 children: [
// //                   //                                   //  Text("Enjoy ", style: CustomTextStyle.smallboldtext),
// //                   //                                   Center(
// //                   //                                     child:
// //                   //                                         AnimatedFlipCounter(
// //                   //                                       value: double.tryParse(
// //                   //                                               item["value"]
// //                   //                                                   .toString()) ??
// //                   //                                           00.0, // Fallback to 20 if value is invalid
// //                   //                                       duration: const Duration(
// //                   //                                           seconds:
// //                   //                                               1), // Set the duration of the animation
// //                   //                                       curve: Curves
// //                   //                                           .easeInOut, // Optional: Set the animation curve
// //                   //                                       textStyle: CustomTextStyle
// //                   //                                           .smallboldtext, // Customize text style suffix:"% off ", // Add suffix text
// //                   //                                     ),
// //                   //                                   ),
// //                   //                                   const Text(" %",
// //                   //                                       style: CustomTextStyle
// //                   //                                           .smallboldtext)
// //                   //                                 ],
// //                   //                               );
// //                   //                             }
// //                   //                           }
// //                   //                           // If the "offerValue" is not found, fallback to default value
// //                   //                           return const Center(
// //                   //                               child: Text('No offers',
// //                   //                                   style: CustomTextStyle
// //                   //                                       .smallboldtext));
// //                   //                         }
// //                   //                       })
// //                   //                 // Text(
// //                   //                 //   '20%off',
// //                   //                 //   style: CustomTextStyle.smallboldtext,
// //                   //                 // ),
// //                   //               ],
// //                   //             ),
// //                   //           ),
// //                   //           const Text('Yummy Deals!',
// //                   //               style: CustomTextStyle.font12blackregular),
// //                   //         ],
// //                   //       ),
// //                   //     ),
// //                   //   ],
// //                   // ),
// //                   // const Divider(color: Customcolors.DECORATION_MEDIUMGREY),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }



























// ignore_for_file: file_names, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testing/Features/Authscreen/Loginscreen.dart';
import 'package:testing/Features/Foodmodule/Data/cartprovider.dart';
import 'package:testing/Features/Foodmodule/Domain/favouritemodel.dart';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Foodsearchlistgetcontroller.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodhomepage.dart';
import 'package:testing/Features/Foodmodule/Foodviewscreen/AddButtonFunctions/Buttonfunctionalities.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/Getmenucountcontroller.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/Getnearbyrescontroller.dart';
import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Redirectcontroller.dart';
import 'package:testing/utils/Buttons/CustomFavourite.dart';
import 'package:testing/utils/Buttons/CustomLogoutdialog.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';

// ignore: must_be_immutable
class SliverAppBarWidget extends StatefulWidget {
  final dynamic restaurantimg;
  final dynamic resRating;
  final dynamic restaurantname;
  // final List<dynamic>? additionalImages;
  final List<dynamic>? restaurantfoodtitle;
  final dynamic restaurantcity;
  final dynamic restaurantregion;
  final dynamic restaurantreview;
  final dynamic offerPercentage;
  final dynamic restaurantAvailable;
  // dynamic menu;
  bool isFromDishScreen;
  dynamic restaurantId;
  // dynamic restaurant;
  dynamic favouriteid;
  dynamic reviews;
  // dynamic favouritestatus;
  // final List favourListDetails;
  SliverAppBarWidget({
    this.isFromDishScreen = false,
     this.resRating,
    required this.restaurantimg,
    required this.restaurantname,
    this.restaurantfoodtitle,
    this.offerPercentage,
    this.reviews,
   
    // this.favourListDetails = const [],
    required this.restaurantcity,
    required this.restaurantregion,
    required this.restaurantreview,
    // required this.menu,
    // this.restaurant,
    this.restaurantId,
    this.favouriteid,
    // required this.favouritestatus,
    super.key,
    required this.restaurantAvailable,
    // this.additionalImages,
  });

  @override
  State<SliverAppBarWidget> createState() => _SliverAppBarWidgetState();
}

class _SliverAppBarWidgetState extends State<SliverAppBarWidget> {
  Nearbyrescontroller nearbyreget = Get.put(Nearbyrescontroller());

  Menucountgetcontroller menu = Get.put(Menucountgetcontroller());
  Foodsearchcontroller createrecentsearch = Get.put(Foodsearchcontroller());
  RedirectController redirect = Get.put(RedirectController());
  String? firstDetailId;
  @override

  @override
  Widget build(BuildContext context) {
print(" IMAGE ${widget.restaurantimg}");
String fullAddress =  widget.restaurantAvailable["address"]["fullAddress"];

List<String> parts = fullAddress.split(',');

String updated = "";
if (parts.length > 2) {
  updated = "${parts[0]}, ${parts[1]},\n${parts.sublist(2).join(',')}";
} else {
  updated = fullAddress;
}



    double rating = widget.restaurantreview.toString() == 'null'
        ? 0
        : double.tryParse(widget.restaurantreview.toString())
                ?.roundToDouble() ??
            0;
    final restaurant = FavoriteRestaurant(
      id: widget.restaurantId,
      name: widget.restaurantname.toString(),
      city: widget.restaurantcity,
      region: widget.restaurantregion.toString(),
      imageUrl: widget.restaurantimg,
      rating: widget.restaurantreview,
    );
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return SliverAppBar(
      toolbarHeight: 0,
      expandedHeight: MediaQuery.of(context).size.height / 1.85,
      // expandedHeight: 400.h,
      pinned: true,
      floating: false, // Ensure it doesn't float on scroll
      snap: false, // Ensure it doesn't snap back when scrolling stops
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 2,
        collapseMode: CollapseMode.pin,
        background: Column(
          children: [
            Container(
              height: 240.h, // Adjust height as needed
              decoration: const BoxDecoration(
                color: Customcolors.DECORATION_WHITE,
              ),
              child: Stack(
                children: [
                  widget.restaurantAvailable?['restaurantAvailable'] != true ||
                          widget.restaurantAvailable?['activeStatus'] !=
                              'online' ||
                          widget.restaurantAvailable?['status'] != true
                      ? ClipRRect(
                        borderRadius: BorderRadiusGeometry.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                          child: ColorFiltered(
                            colorFilter: const ColorFilter.mode(
                              Colors.grey,
                              BlendMode.saturation,
                            ),
                            child: CachedNetworkImage(
                              height: 250.h,
                              imageUrl: widget.restaurantimg,
                              placeholder: (context, url) =>
                                  Image.asset("${fastxdummyImg}"),
                              errorWidget: (context, url, error) =>
                                  Image.asset("${fastxdummyImg}"),
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context)
                                  .size
                                  .width, // Full screen width
                            ),
                          ),
                        )
                      : ClipRRect(
                         borderRadius: BorderRadiusGeometry.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                          child: CachedNetworkImage(
                            height: 240.h,
                            imageUrl: widget.restaurantimg,
                            placeholder: (context, url) =>
                                Image.asset("${fastxdummyImg}"),
                            errorWidget: (context, url, error) =>
                                Image.asset("${fastxdummyImg}"),
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context)
                                .size
                                .width, // Full screen width
                          ),
                        ),
                  Positioned(
                    top: 0, // Position at the top
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Provider.of<ButtonController>(context,
                                          listen: false)
                                      .hideButton();

                                  if (widget.isFromDishScreen) {
                                    Get.back();
                                    createrecentsearch
                                        .foodsearchlistloading.value = true;

                                    // Delay for 2 seconds to simulate loading, then fetch data
                                    Future.delayed(const Duration(seconds: 1),
                                        () async {
                                      createrecentsearch
                                          .foodsearchlistloading.value = false;
                                    });
                                  } else {
                                    Get.off(const Foodscreen(),
                                        transition: Transition.leftToRight);
                                  }
                                },
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: const BoxDecoration(
                                    color: Colors.white60,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)),
                                  ),
                                  child: const Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: Customcolors.DECORATION_BLACK,
                                  ),
                                ),
                              ),
                            ),
                          
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.1.w,
                    child: Text(
                      widget.restaurantname
                          .toString()
                          .capitalizeFirst
                          .toString(),
                      overflow: TextOverflow.ellipsis,
                     // style: CustomTextStyle.subheading,
                      style: TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w800,
      color: Customcolors.DECORATION_GREY,
      fontFamily: 'Poppins-SemiBold'),
                    ),
                    ),
                
                  const CustomSizedBox(height: 5),
              
                  const CustomSizedBox(height: 5),
                  Row(
                    children: [
                     
                       Image.asset(
                          "assets/images/location_icon.png",
                        height: 30.sp,
                          //height: 30,
                        ),

                     
SizedBox(width: 10,),

                      Expanded(
                        child: Text(
                                         updated
                              .toString()
                              .capitalizeFirst
                              .toString(),
                                    maxLines: 2,                  
                          overflow: TextOverflow.ellipsis,
                        //  style: CustomTextStyle.foodviewtext,
                        style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: Customcolors.DECORATION_GREY,
                              fontFamily: 'Poppins-Medium'),
                                            ),
                      ),
                      
                    ],
                  ),
                  SizedBox(height: 20,),

  Row(children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Delivery Within ',
                        style: GoogleFonts.montserrat(
                          fontSize: 10.sp,
                          color: Colors.black,
                         // fontFamily: 'Poppins-Medium',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: '10 Min',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.green,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: ' To ',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text: '20 Min',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.green,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),


             
          //   widget.restaurantAvailable["ratings"] != null   //&&   widget.restaurantAvailable["ratings"]
              widget.resRating != "0" &&   widget.resRating != null
                      ? 
                    Row(
                children: [
                 Image.asset("assets/images/star_icon.png",height: 16.sp,),
                            SizedBox(width: 5,),
                 ShaderMask(
  shaderCallback: (bounds) => const LinearGradient(
    colors: [Color(0xFFAE62E8), Color(0xFF623089)],
     begin: Alignment.topCenter,   // 👈 Start from top
    end: Alignment.bottomCenter,  // 👈 End at bottom
  ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                  child: Text(widget.resRating.toString(),
                          //  widget.restaurantAvailable["rating"].toString(),
                            overflow: TextOverflow.ellipsis,
                           // style: CustomTextStyle.blacktext,
                           style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      fontFamily: 'Poppins-Regular',
                    )
                          ),
                )
                     
                      ]) :  Row(
                children: [
                  
                     Image.asset("assets/images/star_icon.png",height: 16.sp,),
                            SizedBox(width: 5,),
                ShaderMask(
  shaderCallback: (bounds) => const LinearGradient(
    colors: [Color(0xFFAE62E8), Color(0xFF623089)],
     begin: Alignment.topCenter,   // 👈 Start from top
    end: Alignment.bottomCenter,  // 👈 End at bottom
  ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                  child: Text(
                           "0.0",
                            overflow: TextOverflow.ellipsis,
                          
                           style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                     // color: Color(0xFF623089),
                       color: Colors.white,
                      fontFamily: 'Poppins-Regular',
                    )
                          ),
                )
                     
                      ]),
                      
               
               ],),
               
               
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
















// // ignore_for_file: file_names, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:testing/Features/Authscreen/Loginscreen.dart';
// import 'package:testing/Features/Foodmodule/Data/cartprovider.dart';
// import 'package:testing/Features/Foodmodule/Domain/favouritemodel.dart';
// import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Foodsearchlistgetcontroller.dart';
// import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodhomepage.dart';
// import 'package:testing/Features/Foodmodule/Foodviewscreen/AddButtonFunctions/Buttonfunctionalities.dart';
// import 'package:testing/Features/Foodmodule/SubAdmincontroller/Getmenucountcontroller.dart';
// import 'package:testing/Features/Foodmodule/SubAdmincontroller/Getnearbyrescontroller.dart';
// import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Redirectcontroller.dart';
// import 'package:testing/utils/Buttons/CustomFavourite.dart';
// import 'package:testing/utils/Buttons/CustomLogoutdialog.dart';
// import 'package:testing/utils/Buttons/CustomTextstyle.dart';
// import 'package:testing/utils/Buttons/Customspace.dart';
// import 'package:testing/utils/Const/ApiConstvariables.dart';
// import 'package:testing/utils/Const/constImages.dart';
// import 'package:testing/utils/Containerdecoration.dart';
// import 'package:testing/utils/CustomColors/Customcolors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import 'package:animated_flip_counter/animated_flip_counter.dart';

// // ignore: must_be_immutable
// class SliverAppBarWidget extends StatefulWidget {
//   final dynamic restaurantimg;
//   final dynamic restaurantname;
//   // final List<dynamic>? additionalImages;
//   final List<dynamic>? restaurantfoodtitle;
//   final dynamic restaurantcity;
//   final dynamic restaurantregion;
//   final dynamic restaurantreview;
//   final dynamic offerPercentage;
//   final dynamic restaurantAvailable;
//   // dynamic menu;
//   bool isFromDishScreen;
//   dynamic restaurantId;
//   // dynamic restaurant;
//   dynamic favouriteid;
//   dynamic reviews;
//   // dynamic favouritestatus;
//   // final List favourListDetails;
//   SliverAppBarWidget({
//     this.isFromDishScreen = false,
//     required this.restaurantimg,
//     required this.restaurantname,
//     this.restaurantfoodtitle,
//     this.offerPercentage,
//     this.reviews,
//     // this.favourListDetails = const [],
//     required this.restaurantcity,
//     required this.restaurantregion,
//     required this.restaurantreview,
//     // required this.menu,
//     // this.restaurant,
//     this.restaurantId,
//     this.favouriteid,
//     // required this.favouritestatus,
//     super.key,
//     required this.restaurantAvailable,
//     // this.additionalImages,
//   });

//   @override
//   State<SliverAppBarWidget> createState() => _SliverAppBarWidgetState();
// }

// class _SliverAppBarWidgetState extends State<SliverAppBarWidget> {
//   Nearbyrescontroller nearbyreget = Get.put(Nearbyrescontroller());

//   Menucountgetcontroller menu = Get.put(Menucountgetcontroller());
//   Foodsearchcontroller createrecentsearch = Get.put(Foodsearchcontroller());
//   RedirectController redirect = Get.put(RedirectController());
//   String? firstDetailId;
//   @override
//   // void initState() {
//   //   WidgetsBinding.instance.addPostFrameCallback((_) {
//   //     // redirect.getredirectDetails();
//   //     menu.menucountget(restaurantid: widget.restaurantId);
//   //   });

//   //   // TODO: implement initState
//   //   super.initState();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     double rating = widget.restaurantreview.toString() == 'null'
//         ? 0
//         : double.tryParse(widget.restaurantreview.toString())
//                 ?.roundToDouble() ??
//             0;
//     final restaurant = FavoriteRestaurant(
//       id: widget.restaurantId,
//       name: widget.restaurantname.toString(),
//       city: widget.restaurantcity,
//       region: widget.restaurantregion.toString(),
//       imageUrl: widget.restaurantimg,
//       rating: widget.restaurantreview,
//     );
//     final favoritesProvider = Provider.of<FavoritesProvider>(context);

//     return SliverAppBar(
//       toolbarHeight: 0,
//       expandedHeight: MediaQuery.of(context).size.height / 1.78,
//       // expandedHeight: 400.h,
//       pinned: true,
//       floating: false, // Ensure it doesn't float on scroll
//       snap: false, // Ensure it doesn't snap back when scrolling stops
//       automaticallyImplyLeading: false,
//       flexibleSpace: FlexibleSpaceBar(
//         expandedTitleScale: 2,
//         collapseMode: CollapseMode.pin,
//         background: Column(
//           children: [
//             Container(
//               height: 250.h, // Adjust height as needed
//               decoration: const BoxDecoration(
//                 color: Customcolors.DECORATION_WHITE,
//               ),
//               child: Stack(
//                 children: [
//                   widget.restaurantAvailable?['restaurantAvailable'] != true ||
//                           widget.restaurantAvailable?['activeStatus'] !=
//                               'online' ||
//                           widget.restaurantAvailable?['status'] != true
//                       ? ClipRRect(
//                           child: ColorFiltered(
//                             colorFilter: const ColorFilter.mode(
//                               Colors.grey,
//                               BlendMode.saturation,
//                             ),
//                             child: CachedNetworkImage(
//                               height: 250.h,
//                               imageUrl: widget.restaurantimg,
//                               placeholder: (context, url) =>
//                                   Image.asset("${fastxdummyImg}"),
//                               errorWidget: (context, url, error) =>
//                                   Image.asset("${fastxdummyImg}"),
//                               fit: BoxFit.cover,
//                               width: MediaQuery.of(context)
//                                   .size
//                                   .width, // Full screen width
//                             ),
//                           ),
//                         )
//                       : ClipRRect(
//                           child: CachedNetworkImage(
//                             height: 250.h,
//                             imageUrl: widget.restaurantimg,
//                             placeholder: (context, url) =>
//                                 Image.asset("${fastxdummyImg}"),
//                             errorWidget: (context, url, error) =>
//                                 Image.asset("${fastxdummyImg}"),
//                             fit: BoxFit.cover,
//                             width: MediaQuery.of(context)
//                                 .size
//                                 .width, // Full screen width
//                           ),
//                         ),
//                   Positioned(
//                     top: 0, // Position at the top
//                     left: 0,
//                     right: 0,
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: GestureDetector(
//                                 onTap: () {
//                                   Provider.of<ButtonController>(context,
//                                           listen: false)
//                                       .hideButton();

//                                   if (widget.isFromDishScreen) {
//                                     Get.back();
//                                     createrecentsearch
//                                         .foodsearchlistloading.value = true;

//                                     // Delay for 2 seconds to simulate loading, then fetch data
//                                     Future.delayed(const Duration(seconds: 1),
//                                         () async {
//                                       createrecentsearch
//                                           .foodsearchlistloading.value = false;
//                                     });
//                                   } else {
//                                     Get.off(const Foodscreen(),
//                                         transition: Transition.leftToRight);
//                                   }
//                                 },
//                                 child: Container(
//                                   height: 40,
//                                   width: 40,
//                                   decoration: const BoxDecoration(
//                                     color: Customcolors.DECORATION_WHITE,
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(40)),
//                                   ),
//                                   child: const Icon(
//                                     Icons.arrow_back,
//                                     color: Customcolors.DECORATION_BLACK,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             // UserId != null
//                             //     ?

// //                             Padding(
// //                               padding:
// //                                   const EdgeInsets.symmetric(horizontal: 12),
// //                               child: FavoriteIcon(
// //                                 isFavorite:
// //                                     favoritesProvider.isFavorite(restaurant.id),
// //                                 onTap: () {
// //                                   if (UserId == null) {
// //                                     showDialog(
// //   context: context,
// //   builder: (_) => LoginRequiredDialog(
// //     title: "Login Required",
// //     content: "Please login to add or remove this favorite item.",
// //     cancelText: "Later",
// //     confirmText: "Log In",
// //     onConfirm: () {
// //       // Navigate or perform any action
// //       Get.offAll(() => const Loginscreen());
// //     },
// //   ),
// // );
                                   
// //                                     return;
// //                                   }

// //                                   // ✅ Proceed with favorite/unfavorite if UserId is not null
// //                                   if (favoritesProvider
// //                                       .isFavorite(restaurant.id)) {
// //                                     favoritesProvider
// //                                         .removeFavorite(restaurant.id);
// //                                     nearbyreget.updateFavouriteFun(
// //                                       productCategoryId: productCateId,
// //                                       userId: UserId,
// //                                       productId: restaurant.id,
// //                                     );
// //                                   } else {
// //                                     favoritesProvider.addFavorite(restaurant);
// //                                     nearbyreget.addfavouritesApi(
// //                                       productCategoryId: productCateId,
// //                                       userId: UserId,
// //                                       productId: restaurant.id,
// //                                     );
// //                                   }
// //                                 },
// //                               ),
// //                             ),
//                             //: SizedBox(),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width / 1.1.w,
//                     child: Text(
//                       widget.restaurantname
//                           .toString()
//                           .capitalizeFirst
//                           .toString(),
//                       overflow: TextOverflow.ellipsis,
//                       style: CustomTextStyle.subheading,
//                     ),
//                   ),
//                   const CustomSizedBox(height: 5),
//                   SizedBox(
//                     height: 25.h,
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       scrollDirection: Axis.horizontal,
//                       itemCount: widget.restaurantfoodtitle!.length,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 3),
//                           child: Row(
//                             children: [
//                               Text(
//                                 widget.restaurantfoodtitle![index]
//                                         ['foodCusineName']
//                                     .toString()
//                                     .capitalizeFirst
//                                     .toString(),
//                                 style: CustomTextStyle.darkgrey12,
//                                 overflow: TextOverflow.ellipsis,
//                                 softWrap: true,
//                               ),
//                               const SizedBox(width: 15),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   const CustomSizedBox(height: 5),
//                   Row(
//                     children: [
//                       const Icon(
//                         Icons.location_on_rounded,
//                         size: 20,
//                         color: Customcolors.darkpurple,
//                       ),
//                       Text(
//                         widget.restaurantcity
//                             .toString()
//                             .capitalizeFirst
//                             .toString(),
//                         style: CustomTextStyle.foodviewtext,
//                       ),
//                     ],
//                   ),
//                   const CustomSizedBox(height: 5),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       rating != 0 &&
//                               (widget.reviews.toString().isNotEmpty ||
//                                   widget.reviews != 0)
//                           ? Expanded(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: rating != 0
//                                         ? Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               const Icon(
//                                                 Icons.star,
//                                                 size: 20,
//                                                 color: Colors.amber,
//                                               ),
//                                               5.toWidth,
//                                               Text(
//                                                 rating.toString(),
//                                                 style: CustomTextStyle
//                                                     .smallboldtext,
//                                               ),
//                                             ],
//                                           )
//                                         : const SizedBox.shrink(),
//                                   ),
//                                   widget.reviews.toString().isEmpty ||
//                                           widget.reviews == 0
//                                       ? const SizedBox.shrink()
//                                       : Text(
//                                           "( ${widget.reviews.toString()} reviews)",
//                                           style: CustomTextStyle
//                                               .font12blackregular),
//                                 ],
//                               ),
//                             )
//                           : const SizedBox.shrink(),
//                       rating != 0 &&
//                               (widget.reviews.toString().isNotEmpty ||
//                                   widget.reviews != 0)
//                           ? const SizedBox(
//                               height: 60,
//                               child: VerticalDivider(
//                                 width: 1,
//                                 thickness: 1,
//                                 color: Customcolors.DECORATION_MEDIUMGREY,
//                               ),
//                             )
//                           : const SizedBox.shrink(),
//                       Expanded(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const Image(
//                                     image: AssetImage(
//                                         "assets/images/File_duotone.png"),
//                                         color:  Color(0xFF623089),
//                                     height: 16,
//                                     width: 25,
//                                   ),
//                                   Obx(() {
//                                     if (menu.ismenucountloading.isTrue) {
//                                       // Display a placeholder text or some static counter until loading completes
//                                       return const AnimatedFlipCounter(
//                                         value:
//                                             0, // Starting value during loading
//                                         duration: Duration(milliseconds: 500),
//                                         textStyle:
//                                             CustomTextStyle.smallboldtext,
//                                       );
//                                     } else if (menu.menucountModel == null ||
//                                         menu.menucountModel["data"] == null) {
//                                       // Handle the case where data is not available
//                                       return const Center(
//                                           child: Text('0',
//                                               style: CustomTextStyle
//                                                   .smallboldtext));
//                                     } else {
//                                       // Display the animated count after data is loaded
//                                       int itemCount =
//                                           menu.menucountModel["data"]?.length ??
//                                               0;
//                                       return AnimatedFlipCounter(
//                                         value: itemCount,
//                                         duration:
//                                             const Duration(milliseconds: 500),
//                                         textStyle:
//                                             CustomTextStyle.smallboldtext,
//                                       );
//                                     }
//                                   })
//                                 ],
//                               ),
//                             ),
//                             const Text('Menu variants',
//                                 style: CustomTextStyle.font12blackregular),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 60,
//                         child: VerticalDivider(
//                           width: 1,
//                           thickness: 1,
//                           color: Customcolors.DECORATION_MEDIUMGREY,
//                         ),
//                       ),
//                       Expanded(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const Image(
//                                     image: AssetImage(
//                                         "assets/images/discount.png"),
//                                     height: 15,
//                                     width: 20,
//                                   ),
//                                   (widget.offerPercentage != null &&
//                                           widget.offerPercentage
//                                               .toString()
//                                               .isNotEmpty &&
//                                           widget.offerPercentage != 0)
//                                       ? Center(
//                                           child: Text(
//                                               '${widget.offerPercentage} % ',
//                                               style: CustomTextStyle
//                                                   .smallboldtext))
//                                       : Obx(() {
//                                           // Check if loading is in progress
//                                           if (redirect
//                                               .isredirectLoading.isTrue) {
//                                             return AnimatedFlipCounter(
//                                               value: double.tryParse(
//                                                       0.toString()) ??
//                                                   20.0, // Fallback to 20 if value is invalid
//                                               duration: const Duration(
//                                                   seconds:
//                                                       1), // Set the duration of the animation
//                                               curve: Curves
//                                                   .easeInOut, // Optional: Set the animation curve
//                                               textStyle: CustomTextStyle
//                                                   .smallboldtext, // Customize text style

//                                               suffix:
//                                                   "% off ", // Add suffix text
//                                             );
//                                           }
//                                           // If data is missing or null, show a default value
//                                           else if (redirect
//                                                       .redirectLoadingDetails ==
//                                                   null ||
//                                               redirect.redirectLoadingDetails[
//                                                       "data"] ==
//                                                   null) {
//                                             return const Center(
//                                                 child: Text('No offers',
//                                                     style: CustomTextStyle
//                                                         .smallboldtext));
//                                           } else {
//                                             // Searching for "offerValue" in the data and using it directly
//                                             for (var item in redirect
//                                                     .redirectLoadingDetails[
//                                                 "data"]) {
//                                               if (item["key"] == "offerValue") {
//                                                 // Directly access and display the offerValue with AnimatedFlipCounter
//                                                 return Row(
//                                                   children: [
//                                                     //  Text("Enjoy ", style: CustomTextStyle.smallboldtext),
//                                                     Center(
//                                                       child:
//                                                           AnimatedFlipCounter(
//                                                         value: double.tryParse(
//                                                                 item["value"]
//                                                                     .toString()) ??
//                                                             00.0, // Fallback to 20 if value is invalid
//                                                         duration: const Duration(
//                                                             seconds:
//                                                                 1), // Set the duration of the animation
//                                                         curve: Curves
//                                                             .easeInOut, // Optional: Set the animation curve
//                                                         textStyle: CustomTextStyle
//                                                             .smallboldtext, // Customize text style suffix:"% off ", // Add suffix text
//                                                       ),
//                                                     ),
//                                                     const Text(" %",
//                                                         style: CustomTextStyle
//                                                             .smallboldtext)
//                                                   ],
//                                                 );
//                                               }
//                                             }
//                                             // If the "offerValue" is not found, fallback to default value
//                                             return const Center(
//                                                 child: Text('No offers',
//                                                     style: CustomTextStyle
//                                                         .smallboldtext));
//                                           }
//                                         })
//                                   // Text(
//                                   //   '20%off',
//                                   //   style: CustomTextStyle.smallboldtext,
//                                   // ),
//                                 ],
//                               ),
//                             ),
//                             const Text('Yummy Deals!',
//                                 style: CustomTextStyle.font12blackregular),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   const Divider(color: Customcolors.DECORATION_MEDIUMGREY),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }