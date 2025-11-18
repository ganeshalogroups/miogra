// // ignore_for_file: must_be_immutable, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodlist.dart';
// import 'package:testing/utils/Buttons/CustomTextstyle.dart';
// import 'package:testing/utils/Const/constImages.dart';
// import 'package:testing/utils/Const/constValue.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class Productcategorylist extends StatefulWidget {
// dynamic homepagedetails;
//    Productcategorylist({super.key,required this.homepagedetails});

//   @override
//   State<Productcategorylist> createState() => _ProductcategorylistState();
// }

// class _ProductcategorylistState extends State<Productcategorylist> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//      height: 105.h,
//       child: ListView.builder(
//       itemCount: widget.homepagedetails.length,
//       shrinkWrap: true,
//       addAutomaticKeepAlives: false,
//       addRepaintBoundaries : false,
//       addSemanticIndexes   : false,
//       scrollDirection      : Axis.horizontal,
//       itemBuilder:(context, index) {
//           return GestureDetector(
//            onTap: () {
      
//            Get.to(Foodlistscreen(searchvalue: widget.homepagedetails[index]["hashtagName"].toString().capitalizeFirst.toString(),restaurantid: "",type: "",), transition: Transition.leftToRight);
      
      
//              },
//                                           child: Column(
//                                               children: [
                                       
//                                               SizedBox(
//                                                 width: 90.w,
//                                                 height: 70.h,
//                                                 child: CachedNetworkImage(
//                                                   imageUrl: "${globalImageUrlLink}${widget.homepagedetails[index]["hashtagImage"].toString()}",
                                                    
                                                          
//                                                   imageBuilder: (context, imageProvider) => Container( 
                                                      
//                                                             width: 90.w,
//                                                             height: 70.h,
//                                                             decoration: BoxDecoration( image: DecorationImage( image: imageProvider,fit: BoxFit.contain))),   
                                                 
                                                         
//                                                   placeholder: (context, url) => Container(
//   decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(10),
//   ),
//   child: ClipRRect(
//     borderRadius: BorderRadius.circular(10),
//     child: Image.asset(
//       "${fastxdummyImg}",
//       fit: BoxFit.cover,
//       width: double.infinity,
//       height: double.infinity,
//     ),
//   ),
// ),

//                                                   // Container(
//                                                   //     decoration    : BoxDecoration(
//                                                   //     image         : DecorationImage(image: AssetImage('assets/images/restdummy.jpg'),fit: BoxFit.cover),
//                                                   //     borderRadius  :  BorderRadius.circular(10),
//                                                   //     color         : Colors.transparent, // Background color (optional)
//                                                   //   ),
//                                                   // ),
                                                  
      
      
      
//                                                   errorWidget: (context, url, error) =>
                                                      
//                                                   //  Container(
//                                                   //     decoration: BoxDecoration(
//                                                   //     image: DecorationImage(image: AssetImage('assets/images/restdummy.jpg'), fit: BoxFit.cover),
//                                                   //     borderRadius:BorderRadius.circular(10), 
//                                                   //     color: Colors.transparent,                    
//                                                   //   ),
//                                                   // ),
//                                                   Container(
//   decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(10),
//   ),
//   child: ClipRRect(
//     borderRadius: BorderRadius.circular(10),
//     child: Image.asset(
//       "${fastxdummyImg}",
//       fit: BoxFit.cover,
//       width: double.infinity,
//       height: double.infinity,
//     ),
//   ),
// ),
//                                                 ),
//                                               ),
            
//                                               // Spacer(),
            
//                                               SizedBox(height: 5.h),
            
            
//                                               SizedBox(
//                                                   width: 80.w,
//                                                   child: AutoSizeText(
//                                                     textAlign: TextAlign.center,
//                                                     widget.homepagedetails[index]["hashtagName"].toString().capitalizeFirst.toString(),
//                                                     style: CustomTextStyle.addressfetch,
//                                                     maxLines: 1,
//                                                     wrapWords: true,
//                                                  ),
//                                               ),
            
//                                             ],
//              ),
//           );
                                      
//       },),
//     );
//   }
// }



// ignore_for_file: must_be_immutable, unnecessary_string_interpolations, unnecessary_brace_in_string_interps



































// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodlist.dart';
// import 'package:testing/utils/Buttons/CustomTextstyle.dart';
// import 'package:testing/utils/Const/constImages.dart';
// import 'package:testing/utils/Const/constValue.dart';

// class Productcategorylist extends StatefulWidget {
//   dynamic homepagedetails;
//   Productcategorylist({super.key, required this.homepagedetails});

//   @override
//   State<Productcategorylist> createState() => _ProductcategorylistState();
// }

// class _ProductcategorylistState extends State<Productcategorylist> {
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(), // disable internal scroll if inside ListView
//       padding: EdgeInsets.all(10.w),
//       itemCount: widget.homepagedetails.length,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 4, // Number of columns
//         mainAxisSpacing: 12.h,
//         crossAxisSpacing: 12.w,
//         childAspectRatio: 0.9, // adjust height ratio
//       ),
//       itemBuilder: (context, index) {
//         return GestureDetector(
//           onTap: () {
//             Get.to(
//               Foodlistscreen(
//                 searchvalue: widget.homepagedetails[index]["hashtagName"]
//                     .toString()
//                     .capitalizeFirst
//                     .toString(),
//                 restaurantid: "",
//                 type: "",
//               ),
//               transition: Transition.leftToRight,
//             );
//           },
//           child: Column(
//             children: [
//               SizedBox(
//                 width: 90.w,
//                 height: 70.h,
//                 child: CachedNetworkImage(
//                   imageUrl:
//                       "${globalImageUrlLink}${widget.homepagedetails[index]["hashtagImage"].toString()}",
//                   imageBuilder: (context, imageProvider) => Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       image: DecorationImage(
//                         image: imageProvider,
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                   ),
//                   placeholder: (context, url) => Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(10),
//                       child: Image.asset(
//                         fastxdummyImg,
//                         fit: BoxFit.cover,
//                         width: double.infinity,
//                         height: double.infinity,
//                       ),
//                     ),
//                   ),
//                   errorWidget: (context, url, error) => Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(10),
//                       child: Image.asset(
//                         fastxdummyImg,
//                         fit: BoxFit.cover,
//                         width: double.infinity,
//                         height: double.infinity,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 5.h),
//               SizedBox(
//                 width: 80.w,
//                 child: AutoSizeText(
//                   widget.homepagedetails[index]["hashtagName"]
//                       .toString()
//                       .capitalizeFirst
//                       .toString(),
//                   textAlign: TextAlign.center,
//                   style: CustomTextStyle.addressfetch,
//                   maxLines: 1,
//                   wrapWords: true,
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }












// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodlist.dart';
// import 'package:testing/utils/Buttons/CustomTextstyle.dart';
// import 'package:testing/utils/Const/constImages.dart';
// import 'package:testing/utils/Const/constValue.dart';

// class Productcategorylist extends StatelessWidget {
//   final dynamic homepagedetails;
//   const Productcategorylist({super.key, required this.homepagedetails});

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(), // Parent scroll handles it
//       padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
//       itemCount: homepagedetails.length,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 4, // 4 items per row
//         crossAxisSpacing: 12.w,
//         mainAxisSpacing: 12.h,
//         childAspectRatio: 0.75, // makes image taller than text
//       ),
//       itemBuilder: (context, index) {
//         return GestureDetector(
//           onTap: () {
//             Get.to(
//               Foodlistscreen(
//                 searchvalue: homepagedetails[index]["hashtagName"]
//                     .toString()
//                     .capitalizeFirst
//                     .toString(),
//                 restaurantid: "",
//                 type: "",
//               ),
//               transition: Transition.leftToRight,
//             );
//           },
//           child: Column(
//             children: [
//               /// Category Image
//               Container(
//                 width: 70.w,
//                 height: 70.w,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(50), // circle image
//                   color: Colors.grey[200],
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(50),
//                   child: CachedNetworkImage(
//                     imageUrl:
//                         "$globalImageUrlLink${homepagedetails[index]["hashtagImage"].toString()}",
//                     fit: BoxFit.cover,
//                     placeholder: (context, url) =>
//                         Image.asset(fastxdummyImg, fit: BoxFit.cover),
//                     errorWidget: (context, url, error) =>
//                         Image.asset(fastxdummyImg, fit: BoxFit.cover),
//                   ),
//                 ),
//               ),
          
//               SizedBox(height: 6.h),
          
//               /// Category Name
//               SizedBox(
//                 width: 80.w,
//                 child: AutoSizeText(
//                   homepagedetails[index]["hashtagName"]
//                       .toString()
//                       .capitalizeFirst
//                       .toString(),
//                   textAlign: TextAlign.center,
//                   style: CustomTextStyle.addressfetch,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
















import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodlist.dart';

import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';

class Productcategorylist extends StatelessWidget {
  final dynamic homepagedetails;
  const Productcategorylist({super.key, required this.homepagedetails});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // handled by parent scroll
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      itemCount: homepagedetails.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // 4 items per row
        crossAxisSpacing: 15,
        mainAxisSpacing: 12,
        childAspectRatio: 0.8, // adjust to make look balanced
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Get.to(
              Foodlistscreen(
                searchvalue: homepagedetails[index]["hashtagName"]
                    .toString()
                    .capitalizeFirst
                    .toString(),
                restaurantid: "",
                type: "",
              ),
              transition: Transition.leftToRight,
            );
          },
          child: Container(
        
            decoration: BoxDecoration(
              color:Color(0xFFF7F7F7),
              borderRadius: BorderRadius.circular(12.r),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.black12,
              //     blurRadius: 4,
              //     offset: const Offset(0, 2),
              //   )
              // ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Circle Image inside container
                Container(
                  width: 45.w,
                  height: 45.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                  ),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl:
                          "$globalImageUrlLink${homepagedetails[index]["hashtagImage"].toString()}",
                  //   fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Image.asset(fastxdummyImg, ),
                      errorWidget: (context, url, error) =>
                          Image.asset(fastxdummyImg, fit: BoxFit.cover),
                    ),
                  ),
                ),

                SizedBox(height: 2.h),

                /// Text below
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: AutoSizeText(
                    homepagedetails[index]["hashtagName"]
                        .toString()
                        .capitalizeFirst
                        .toString(),
                    textAlign: TextAlign.center,
                  //  style: CustomTextStyle.addressfetch,
                  style:  TextStyle(
      fontSize: 11.sp,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      fontFamily: 'Poppins-Medium'
      ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
