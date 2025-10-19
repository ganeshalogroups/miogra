// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_string_interpolations

import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Bannercontroller.dart';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Foodsearchlistgetcontroller.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/FoodsearchTabbar/Voicesearch.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/Getnearbyrescontroller.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodhomepage.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodlist.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodviewfirstscreen.dart';
import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Redirectcontroller.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Shimmers/SearchShimmer.dart';
import 'package:testing/utils/Shimmers/Searchlistloader.dart';
import 'package:testing/utils/Shimmers/Searchlistshimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class Foodsearchscreen extends StatefulWidget {
  // dynamic restaurant;
  const Foodsearchscreen({ super.key});

  @override
  State<Foodsearchscreen> createState() => _FoodsearchscreenState();
}


class _FoodsearchscreenState extends State<Foodsearchscreen> {
     Nearbyrescontroller nearbyreget = Get.put(Nearbyrescontroller());
  Foodsearchcontroller createrecentsearch = Get.put(Foodsearchcontroller());
  TextEditingController searchcontroller = TextEditingController();
  RecentSearchController recentSearchController = Get.put(RecentSearchController());
  RedirectController redirect = Get.put(RedirectController());
  final List<String> imagetext = [
    "Biriyani", "Pizza", "Noodles", "Icecream",
  ];

  bool _isSearching = false;
  Timer? _debounce;
  
  @override
  void initState() {
    redirect.getredirectDetails();
    // createrecentsearch.dishessearchlistbyres(searchcontroller.text);
    super.initState();
  }


oncreatesearch({searchvalue,searchtype,resid}){
Timer(const Duration(milliseconds: 500), () {
// createrecentsearch.createrecentsearch( searchvalue,  "recentsearch",  "", productCateId, UserId, searchvalue,resid);
createrecentsearch.createrecentsearch( hashtagImage: "",searchType:searchtype,productCateid: productCateId,hashtagName: searchvalue.toString().trim(),restaurantid: resid );
 });
}
  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        searchcontroller.clear();
        recentSearchController.recentSearchText.value = '';
        Get.off(const Foodscreen(), transition: Transition.rightToLeft, preventDuplicates: true);
      },
      child: Scaffold(
        backgroundColor: Customcolors.DECORATION_WHITE,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title:  Text(
nearbyreget.selectedIndex.value==0?'Search for dishes & restaurants':"Search for products and shops",

 style: CustomTextStyle.darkgrey),
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              searchcontroller.clear();
              recentSearchController.recentSearchText.value = '';
              Get.off(const Foodscreen(), transition: Transition.rightToLeft, preventDuplicates: true);
            },
            child: const Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          color: Customcolors.DECORATION_WHITE,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              offset: const Offset(0, 4),
                              blurRadius: 1,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Obx(() {
                           // Sync the text controller only once when needed
                        if (recentSearchController.recentSearchText.value.isNotEmpty &&
                        searchcontroller.text != recentSearchController.recentSearchText.value) {
                        searchcontroller.text = recentSearchController.recentSearchText.value;
                        searchcontroller.selection = TextSelection.fromPosition(
                        TextPosition(offset: searchcontroller.text.length),
                        );}

                          return TextFormField(
                            cursorColor: Customcolors.DECORATION_GREY,
                            cursorWidth: 2.0,
                            cursorRadius: const Radius.circular(5.0),
                            controller: searchcontroller,
                            decoration: InputDecoration(
                              hintText: nearbyreget.selectedIndex.value==0?'Search for ‘Parotta’':"Search for ‘Vegetables’",
                              hintStyle: const TextStyle(
                                fontFamily: 'Poppins-Regular',
                                color: Customcolors.DECORATION_GREY,
                              ),
                              border: InputBorder.none,
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Customcolors.DECORATION_BLACK,
                              ),
                              suffixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _isSearching
                                      ? InkWell(
                                          onTap: () {
                                            searchcontroller.clear();
                                            setState(() {
                                              _isSearching = false;
                                            });
                                          },
                                          child: Icon(
                                            MdiIcons.close,
                                            color: Customcolors.DECORATION_DARKGREY,
                                            size: 20,
                                          ),
                                        )
                                      : const SizedBox(),
                                  const SizedBox(width: 5),
                                ],
                              ),
                              contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                            ),
                            // onFieldSubmitted: (value) {
                            //   if (value.isNotEmpty) {
                            //     Timer(Duration(milliseconds: 500), () {
                            //       createrecentsearch.createrecentsearch(
                            //         value,
                            //         "recentsearch",
                            //         "",
                            //         productCateId,
                            //         UserId,
                            //       );
                            //       Provider.of<HomepageProvider>(context, listen: false).getHomepagedatas();
                            //     });
                            //     Get.to(
                            //       Foodlistscreen(searchvalue: value,restaurantid: "",type: "",),
                            //       transition: Transition.rightToLeft,
                            //       duration: Duration(milliseconds: 300),
                            //     );
                            //     setState(() {
                            //       _isSearching = false; // Update the state to indicate searching
                            //     });
                            //     searchcontroller.clear();
                            //     recentSearchController.recentSearchText.value = '';
                            //   } else {
                            //     setState(() {
                            //       _isSearching = false;
                            //       searchcontroller.text = ''; // Clear the search text field
                            //     });
                            //   }
                            // },
                            onChanged: (value) {
                              if (_debounce?.isActive ?? false) _debounce!.cancel();
                              _debounce = Timer(const Duration(milliseconds: 500), () {
                                if (value.isNotEmpty) {
                                  // createrecentsearch.foodsearchlistbyres(value,"");
                                  createrecentsearch.fetchsearchlistbyres(value);
                                  print(value);
                                  setState(() {
                                    _isSearching = true; // Update the state to indicate searching
                                  });
                                } else {
                                  setState(() {
                                    createrecentsearch.foodsearchlist = {};
                                    _isSearching = false;
                                  });
                                }
                              });
                            },
                          );
                        }),
                      ),
                    ),
                    if (_isSearching) ...[
                    Obx(() {
                        if (createrecentsearch.fetchsearchlistloading.isTrue) {
                          return const SearchlistShimmer();
                        } else if (createrecentsearch.fetchsearchlist["data"] == "Regular expression is invalid: missing closing parenthesis" ||
                            createrecentsearch.fetchsearchlist["data"] == "Regular expression is invalid: quantifier does not follow a repeatable item") {
                          return const SizedBox();
                        } else if (createrecentsearch.fetchsearchlist == null ||
                            createrecentsearch.fetchsearchlist == "null" ||
                            createrecentsearch.fetchsearchlist.isEmpty ||
                            createrecentsearch.fetchsearchlist["data"]["data"].isEmpty) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 8),
                              child: RichText(
                                textAlign: TextAlign.center,
                                softWrap: true,
                                text: const TextSpan(
                                  children: [
                                    TextSpan(text: 'Oops!\n', style: CustomTextStyle.redtext),
                                    TextSpan(text: 'We could not understand what you mean, ', style: CustomTextStyle.chipgrey),
                                    TextSpan(text: 'try something relevant', style: CustomTextStyle.chipgrey),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus(); // Closes the keyboard
                          },
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.8,
                                child: NotificationListener<ScrollNotification>(
                                  onNotification: (ScrollNotification scrollNotification) {
                                    if (scrollNotification is ScrollStartNotification) {
                                      FocusScope.of(context).unfocus(); // Close keyboard on scroll
                                    }
                                    return false;
                                  },
                              child: ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: createrecentsearch.fetchsearchlist["data"]["data"].length,
                                itemBuilder: (context, indexone) {
                                   
                                  final type = createrecentsearch.fetchsearchlist!["data"]["data"][indexone]["document"]["type"];
                                 final imageUrl =type=="Restaurant"? createrecentsearch.fetchsearchlist!["data"]["data"][indexone]["document"]["logoUrl"]:createrecentsearch.fetchsearchlist!["data"]["data"][indexone]["document"]["foodImgUrl"]; // Adjust this to your actual image key
                                final isRestaurant = type == "Restaurant";
                                 final isInactive = isRestaurant
                                ? createrecentsearch.fetchsearchlist!["data"]["data"][indexone]["document"]["activeStatus"] == "offline"
                                : createrecentsearch.fetchsearchlist!["data"]["data"][indexone]["document"]["foodCategoryStatus"] == false || createrecentsearch.fetchsearchlist!["data"]["data"][indexone]["document"]["foodStatus"] == false;
                             return  !isInactive ?
                                           InkWell(
                                            onTap: () {
                                               oncreatesearch(searchtype:type,searchvalue:type=="Restaurant"?createrecentsearch.fetchsearchlist["data"]["data"][indexone]["document"]["name"]: createrecentsearch.fetchsearchlist["data"]["data"][indexone]["document"]["foodName"].toString(),resid:createrecentsearch.fetchsearchlist["data"]["data"][indexone]["document"]["_id"]);
                                                type=="Restaurant"?
                                                Get.to(
                                                Foodviewscreen(
                                                totalDis         : 5,
                                                restaurantId     :createrecentsearch.fetchsearchlist["data"]["data"][indexone]["document"]["_id"],
                                                // restaurant: restaurant,
                                                isFromDishScreeen: false,
                                               ),
                                                transition: Transition.rightToLeft,
                                                duration: const Duration(milliseconds: 300),
                                              ) :Get.to(
                                                Foodlistscreen(
                                                  restaurantid:"",
                                                  searchvalue: type=="Restaurant"?createrecentsearch.fetchsearchlist["data"]["data"][indexone]["document"]["name"]: createrecentsearch.fetchsearchlist["data"]["data"][indexone]["document"]["foodName"].toString(), type: type,
                                                ),
                                                transition: Transition.rightToLeft,
                                                duration: const Duration(milliseconds: 300),
                                              );
                                              setState(() {
                                                _isSearching = false;
                                              });
                                              searchcontroller.clear();
                                              recentSearchController.recentSearchText.value = '';
                                            },
                                            child: Padding(
                                              padding:  const EdgeInsets.symmetric(horizontal: 8,vertical: 6),
                                              child: ListTile(
                                                hoverColor: Customcolors.DECORATION_GREY,
                                                tileColor: Customcolors.DECORATION_WHITE,
                                                leading:type=="Dish"? SizedBox(
                                                  width: 60,
                                                  height: 80,
                                                  child:  ClipRRect(
                                                   borderRadius: BorderRadius.circular(15),
                                                    child: CachedNetworkImage(
                                                      placeholder: (context, url) => Image.asset("${fastxdummyImg}"),
                                                      errorWidget: (context, url, error) => Image.asset("${fastxdummyImg}"),
                                                      imageUrl: "${globalImageUrlLink}${imageUrl}",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ): CachedNetworkImage(
                                                 imageUrl: "$globalImageUrlLink$imageUrl",
                                                 imageBuilder: (context, imageProvider) => Container(
                                                 width: 60,
                                                 height: 60,
                                                 decoration: BoxDecoration(
                                                 shape: BoxShape.circle,
                                                 border: Border.all(color: Colors.white, width: 1.5),
                                                 boxShadow: [
                                                 BoxShadow(
                                                 color: Colors.grey.shade300,
                                                 spreadRadius: 1,
                                                 blurRadius: 3,
                                                 offset: const Offset(0, 2),
                                                 ),
                                                ],
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                                ),
                                                ),
                                                placeholder: (context, url) => Image.asset("${fastxdummyImg}"),
                                                errorWidget: (context, url, error) => Image.asset("${fastxdummyImg}"),
                                                ),
                                                title: _buildHighlightedText(
                                                 searchText: searchcontroller.text.trim(),
                                                 resultText: type == "Restaurant"
                                                ? createrecentsearch.fetchsearchlist["data"]["data"][indexone]["document"]["name"]
                                                : createrecentsearch.fetchsearchlist["data"]["data"][indexone]["document"]["foodName"],),

                                                subtitle:type=="Restaurant"? Row(
                                                children: [
                                              createrecentsearch.fetchsearchlist["data"]["data"][indexone]["document"]["rating"]==null||
                                              createrecentsearch.fetchsearchlist["data"]["data"][indexone]["document"]["rating"]==0?
                                              const SizedBox.shrink():
                                                const Icon(
                                                Icons.star,
                                                size: 20,
                                                color: Colors.amber,
                                                ),
                                                createrecentsearch.fetchsearchlist["data"]["data"][indexone]["document"]["rating"]==null||
                                              createrecentsearch.fetchsearchlist["data"]["data"][indexone]["document"]["rating"]==0?
                                              const SizedBox.shrink():
                                                Text(" ${createrecentsearch.fetchsearchlist["data"]["data"][indexone]["document"]["rating"]}",
                                                overflow: TextOverflow.ellipsis,
                                                style: CustomTextStyle.boldgrey),
                                                createrecentsearch.fetchsearchlist["data"]["data"][indexone]["document"]["totalRatingCount"]=="null"||
                                                createrecentsearch.fetchsearchlist["data"]["data"][indexone]["document"]["totalRatingCount"]==0?
                                                 Text(
                                                  type.toString().capitalizeFirst.toString(),
                                                  style: CustomTextStyle.addressfetch,
                                                )
                                                : Text(" (${createrecentsearch.fetchsearchlist["data"]["data"][indexone]["document"]["totalRatingCount"]} reviews)",
                                                style: CustomTextStyle.boldgrey),
                                                ],): Text(
                                                  type.toString().capitalizeFirst.toString(),
                                                  style: CustomTextStyle.addressfetch,
                                                ),
                                              ),
                                            ),
                                          )
                                          : Padding(
                                           padding: const EdgeInsets.all(8.0),
                                           child: Opacity(
                                           opacity: 1.0,
                                             child: Container(
                                             decoration: BoxDecoration(
                                                color: const Color.fromARGB(255, 227, 224, 224),
                                                borderRadius: BorderRadius.circular(15),
                                             ),
                                             child: ListTile(
                                                  hoverColor: Customcolors.DECORATION_GREY,
                                                  tileColor: Customcolors.DECORATION_WHITE,
                                                  leading:type=="Dish"? SizedBox(
                                                    width: 60,
                                                    height: 80,
                                                    child:  ClipRRect(
                                                     borderRadius: BorderRadius.circular(15),
                                                      child: ColorFiltered(
                                                      colorFilter: const ColorFilter.mode(
                                                      Colors.grey,
                                                      BlendMode.saturation,),
                                                        child: CachedNetworkImage(
                                                          placeholder: (context, url) => Image.asset("${fastxdummyImg}"),
                                                          errorWidget: (context, url, error) => Image.asset("${fastxdummyImg}"),
                                                          imageUrl: "${globalImageUrlLink}${imageUrl}",
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ): CachedNetworkImage(
                                                   imageUrl: "$globalImageUrlLink$imageUrl",
                                                   imageBuilder: (context, imageProvider) => Container(
                                                   width: 60,
                                                   height: 60,
                                                   decoration: BoxDecoration(
                                                   shape: BoxShape.circle,
                                                   border: Border.all(color: Colors.white, width: 1.5),
                                                   boxShadow: [
                                                   BoxShadow(
                                                   color: Colors.grey.shade300,
                                                   spreadRadius: 1,
                                                   blurRadius: 3,
                                                   offset: const Offset(0, 2),
                                                   ),
                                                  ],
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                 colorFilter: const ColorFilter.mode(
                                                      Colors.grey,
                                                      BlendMode.saturation,),
                                                  ),
                                                  ),
                                                  ),
                                                  placeholder: (context, url) => Image.asset("${fastxdummyImg}"),
                                                  errorWidget: (context, url, error) => Image.asset("${fastxdummyImg}"),
                                                  ),
                                                  title: _buildHighlightedText(
                                                    searchText: searchcontroller.text.trim(),
                                                    resultText: type == "Restaurant"
                                                    ? createrecentsearch.fetchsearchlist["data"]["data"][indexone]["document"]["name"]
                                                    : createrecentsearch.fetchsearchlist["data"]["data"][indexone]["document"]["foodName"],),
                                                  subtitle:type=="Restaurant"? Row(
                                                  children: [
                                                    createrecentsearch.fetchsearchlist["data"]["data"][indexone]["document"]["rating"]==null||
                                              createrecentsearch.fetchsearchlist["data"]["data"][indexone]["document"]["rating"]==0?
                                              const SizedBox.shrink():
                                                  const Icon(
                                                  Icons.star,
                                                  size: 20,
                                                  color: Colors.amber,
                                                  ),
                                                    createrecentsearch.fetchsearchlist["data"]["data"][indexone]["document"]["rating"]==null||
                                              createrecentsearch.fetchsearchlist["data"]["data"][indexone]["document"]["rating"]==0?
                                              const SizedBox.shrink():
                                                  Text(" ${createrecentsearch.fetchsearchlist["data"]["data"][indexone]["document"]["rating"]}",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: CustomTextStyle.darkgrey),
                                                   createrecentsearch.fetchsearchlist["data"]["data"][indexone]["document"]["totalRatingCount"]=="null"||
                                                createrecentsearch.fetchsearchlist["data"]["data"][indexone]["document"]["totalRatingCount"]==0
                                                  ? Text(
                                                    type.toString().capitalizeFirst.toString(),
                                                    style: CustomTextStyle.addressfetch,
                                                  )
                                                  : Text(" (${createrecentsearch.fetchsearchlist["data"]["data"][indexone]["document"]["totalRatingCount"]} reviews)",
                                                  style: CustomTextStyle.darkgrey),
                                                  ],): Text(
                                                    type.toString().capitalizeFirst.toString(),
                                                    style: CustomTextStyle.addressfetch,
                                                  ),
                                                ),
                                              ),
                                           ),);
                               
                                },
                              ),
                            ),
                          ));
                        }
                      }),
                   
                    ],
                  ],
                ),
                if (!_isSearching) ...[
                  CustomSizedBox(height: 50.h),

                    const Serchlistloading(),
                  // const Padding(
                  //   padding: EdgeInsets.all(12.0),
                  //   child: Text("Popular Searches", style: CustomTextStyle.boldblack),
                  // ),
                  // Column(
                  //   children: [
                  //     const CustomSizedBox(height: 10),
                  //     Consumer<HomepageProvider>(
                  //       builder: (context, value, child) {
                  //         if (value.isLoading) {
                  //           return const ShimmerGridList();
                  //         } else if (value.orderModel.isEmpty || value.orderModel == null || value.orderModel.isEmpty ||
                  //             value.orderModel["popular"] == null || value.orderModel["popular"] == "null") {
                  //           return const CircularProgressIndicator();
                  //         } else {
                  //           return Padding(
                  //             padding: const EdgeInsets.symmetric(horizontal: 5),
                  //             child: SizedBox(
                  //               child: ResponsiveGridList(
                  //                 minItemWidth: 40,
                  //                 maxItemsPerRow: 3,
                  //                 minItemsPerRow: 3,
                  //                 horizontalGridSpacing: 5,
                  //                 horizontalGridMargin: 1,
                  //                 listViewBuilderOptions: ListViewBuilderOptions(physics: const NeverScrollableScrollPhysics(), shrinkWrap: true),
                  //                 children: List.generate(
                  //                   value.orderModel["popular"].length, (index)  {
                  //                     // final type = value.orderModel["popular"][index]["searchType"];
                  //                return InkWell(
                  //                     borderRadius: BorderRadius.circular(30),
                  //                     onTap: () {
                  //                       Get.to(Foodlistscreen(searchvalue: value.orderModel["popular"][index]["hashtagName"].toString(),restaurantid: "", type: "", ),
                  //                        transition: Transition.rightToLeft,
                  //                               duration: const Duration(milliseconds: 300),
                  //                             );
                  //                     },
                  //                     child: Container(
                  //                       height: 40,
                  //                       decoration: BoxDecoration(
                  //                         borderRadius: BorderRadius.circular(30),
                  //                         border: Border.all(color: Customcolors.DECORATION_GREY),
                  //                       ),
                  //                       padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  //                       child: Row(
                  //                         children: [
                  //                           const Icon(
                  //                             Icons.access_time_rounded,
                  //                             size: 22,
                  //                             color: Customcolors.DECORATION_GREY,
                  //                           ),
                  //                           const SizedBox(width: 6),
                  //                           Flexible(
                  //                             child: Text(
                  //                               value.orderModel["popular"][index]["hashtagName"].toString(),
                  //                               softWrap: true,
                  //                               style: CustomTextStyle.chipgrey,
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                   );
                  //                 })
                  //               ),
                  //             ),
                  //           );
                  //         }
                  //       },
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 0.01,
                  // ),



//                   const Padding(
//                     padding: EdgeInsets.all(12.0),
//                     child: Text("Recent Searches", style: CustomTextStyle.boldblack),
//                   ),
//                   Column(
//                     children: [
//                       const CustomSizedBox(height: 10),
//                       Consumer<HomepageProvider>(
//   builder: (context, value, child) {
//     if (value.isLoading) {
//       return const ShimmerGridList();
//     }

//     final allRecent = value.orderModel?["recent"] as List?;
//     final recentList = allRecent
//         ?.where((item) =>item["searchType"] == "Restaurant" || item["searchType"] == "Dish").toList();

//     if (recentList == null || recentList.isEmpty) {
//       return Column(
//         children: [
//           Image.asset("assets/images/recentsearchgif.gif"),
//           const Text("No Recent searches Available", style: CustomTextStyle.chipgrey),
//         ],
//       );
//     }

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 5),
//       child: SizedBox(
//         child: ResponsiveGridList(
//           minItemWidth: 40,
//           maxItemsPerRow: 3,
//           minItemsPerRow: 3,
//           horizontalGridSpacing: 5,
//           horizontalGridMargin: 1,
//           listViewBuilderOptions:  ListViewBuilderOptions(
//             physics: const NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//           ),
//           children: List.generate(
//             recentList.length,
//             (index) {
//               final item = recentList[index];
//               return InkWell(
//                 borderRadius: BorderRadius.circular(30),
//                 onTap: () {
//                   if (item["searchType"] == "Restaurant") {
//                     Get.to(
//                       Foodviewscreen(
//                         totalDis: 5,
//                         restaurantId: item["navigateId"] ?? "",
//                         isFromDishScreeen: false,
//                       ),
//                       transition: Transition.rightToLeft,
//                       duration: const Duration(milliseconds: 300),
//                     );
//                   } else if (item["searchType"] == "Dish") {
//                     Get.to(
//                       Foodlistscreen(
//                         searchvalue: item["hashtagName"] ?? "",
//                         restaurantid: "",
//                         type: "",
//                       ),
//                       transition: Transition.rightToLeft,
//                       duration: const Duration(milliseconds: 300),
//                     );
//                   }
//                 },
//                 child: Container(
//                   height: 40,
//                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(30),
//                     border: Border.all(color: Customcolors.DECORATION_GREY),
//                   ),
//                   child: Row(
//                     children: [
//                       const Icon(Icons.access_time_rounded,size: 22, color: Customcolors.DECORATION_GREY),
//                       const SizedBox(width: 6),
//                       Flexible(
//                         child: Text(
//                           item["hashtagName"]?.toString() ?? "",
//                           softWrap: true,
//                           style: CustomTextStyle.chipgrey,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   },
// ), ],
//                   ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildHighlightedText({required String searchText, required String resultText}) {
  if (searchText.isEmpty) return Text(resultText);

  final lowerResult = resultText.toLowerCase();
  final lowerSearch = searchText.toLowerCase();

  final matchStart = lowerResult.indexOf(lowerSearch);
  if (matchStart < 0) return Text(resultText, style: CustomTextStyle.greybold,); // No match found

  final matchEnd = matchStart + searchText.length;

  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: resultText.substring(0, matchStart),
          style: CustomTextStyle.greybold, // Normal text style
        ),
        TextSpan(
          text: resultText.substring(matchStart, matchEnd),
          style: CustomTextStyle.searchhighlight, // Highlight style
        ),
        TextSpan(
          text: resultText.substring(matchEnd),
          style: CustomTextStyle.greybold,
        ),
      ],
    ),
  );
}

}
