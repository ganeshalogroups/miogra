

// ignore_for_file: file_names, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/FoodsearchTabbar/Dishes.dart';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Foodsearchlistgetcontroller.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/FoodsearchTabbar/Restaurantfoodlist.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/Getnearbyrescontroller.dart';
import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Redirectcontroller.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Shimmers/Searchlistshimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// ignore: must_be_immutable
class Foodlistscreen extends StatefulWidget {
final String type;
 dynamic searchvalue;
 dynamic restaurantid;
   Foodlistscreen({required this.searchvalue,this.restaurantid, super.key, required this.type});

  @override
  State<Foodlistscreen> createState() => _FoodlistscreenState();
}

class _FoodlistscreenState extends State<Foodlistscreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isSearching = false;
  Timer? _debounce;
   Nearbyrescontroller nearbyreget = Get.put(Nearbyrescontroller());
  final TextEditingController _searchController = TextEditingController();
  TextEditingController searchcontroller = TextEditingController();
  final Foodsearchcontroller createrecentsearch = Get.put(Foodsearchcontroller());
  RedirectController redirect = Get.put(RedirectController());
  final FocusNode searchFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
     // Set tab index based on type
  if (widget.type == "Restaurant") {
    _tabController.index = 0; // Restaurant tab
  } if (widget.type == "Dish") {
    _tabController.index = 1; // Dishes tab
  } else {
    _tabController.index = 1; // Dishes tab 
  }
    clearfromsearch();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // searchlist.bannerget();
      redirect.getredirectDetails();
    });


    searchcontroller.text = widget.searchvalue;
    // Initializing search results if searchvalue is provided
    Timer(Duration.zero, () {
      // createrecentsearch.foodsearchlistbyres(widget.searchvalue,widget.restaurantid ?? "");
     createrecentsearch.dishessearchlistbyres(searchcontroller.text,false);
      print("From foodsearch${widget.restaurantid}");
      print(widget.searchvalue);
    });
  }

bool _wasSearching = false;
bool _hasClearedManually = false;

void searchRefresh({required String searchValue, required String type}) {
  searchcontroller.text = searchValue;

  // Change tab based on the type
  if (type == "Restaurant") {
    _tabController.index = 0;
  } else if (type == "Dish") {
    _tabController.index = 1;
  }

  // Perform the search with correct flag based on current tab
  Timer(Duration.zero, () {
    bool flag = (_tabController.index == 0) ? false : true;
    createrecentsearch.dishessearchlistbyres(searchValue, flag);
    print("/////////////////////////searchRefresh////////////////////////////");
  });
}

void afterclearsearch({required String searchValue}) {
  searchcontroller.text = searchValue;

  Timer(Duration.zero, () {
    bool flag = (_tabController.index == 0) ? false : true;
    createrecentsearch.dishessearchlistbyres(searchValue, flag);
    print("000000000000000000000000000000");
  });
}

void clearfromsearch() {
  searchcontroller.addListener(() {
    if (searchcontroller.text.isEmpty && _wasSearching && !_hasClearedManually) {
      _hasClearedManually = true;
      afterclearsearch(searchValue: "");
      _wasSearching = false;
    }
  });
}

void onfieldsubmit({required String valuee}) {
  searchcontroller.text = valuee;

  Timer(Duration.zero, () {
    bool flag = (_tabController.index == 0) ? false : true;
    createrecentsearch.dishessearchlistbyres(valuee, flag);
  });

  setState(() {
    _isSearching = false;
  });
}

// searchRefresh({required String searchValue, required String type}) {
//   searchcontroller.text = searchValue;

//   // Change tab based on the type
//   if (type == "Restaurant") {
//     _tabController.index = 0;
//   } else if (type == "Dish") {
//     _tabController.index = 1;
//   }

//   // Perform the search
//   Timer(Duration.zero, () {
//     // createrecentsearch.foodsearchlistbyres(searchValue, "");
//      createrecentsearch.dishessearchlistbyres(searchValue,false);
//     print("/////////////////////////searchRefresh////////////////////////////");
//   });
// }


// afterclearsearch({searchValue}){

//      searchcontroller.text = searchValue;


//     // Initializing search results if searchvalue is provided
//     Timer(Duration.zero, () {
//       // createrecentsearch.foodsearchlistbyres(searchValue,"");
//        createrecentsearch.dishessearchlistbyres(searchValue,false);
//          print("000000000000000000000000000000");
//     });

// }

//   clearfromsearch() {
//   searchcontroller.addListener(() {
//     if (searchcontroller.text.isEmpty && _wasSearching && !_hasClearedManually) {
//       _hasClearedManually = true;
//       afterclearsearch(searchValue: "");
//       _wasSearching = false;
//     }
//   });
// }

// onfieldsubmir({valuee}){
//  searchcontroller.text = valuee;

//     // Initializing search results if searchvalue is provided
//     Timer(Duration.zero, () {
//       createrecentsearch.dishessearchlistbyres(valuee,false);
//     });
//   setState(() {
//      _isSearching = false;
//       });

// }


  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }
  Widget _buildTabBar() {
    return TabBar(
      indicatorColor: Customcolors.darkpurple,
      indicatorSize: TabBarIndicatorSize.tab,
      controller: _tabController,
      tabs:  [
        Tab(child: Text(nearbyreget.selectedIndex.value==0?"Restaurant":"Shop", style: CustomTextStyle.smallboldblack)),
        Tab(child: Text(nearbyreget.selectedIndex.value==0?"Dishes":'Products', style: CustomTextStyle.smallboldblack)),
      ],
    );
  }



  Widget _buildSearchField() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
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
              child: TextFormField(
                controller: searchcontroller,
                cursorColor: Customcolors.DECORATION_GREY,
                cursorWidth: 2.0,                           // Set the cursor width
                cursorRadius: const Radius.circular(5.0), 
                decoration: InputDecoration(
                  hintText:nearbyreget.selectedIndex.value==0?'Search for ‘Parotta’':"Search for ‘Vegetables’",
                  hintStyle: const TextStyle(
                    fontFamily: 'Poppins-Regular',
                    color: Customcolors.DECORATION_GREY,
                  ),
                  border: InputBorder.none,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Customcolors.DECORATION_BLACK,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                   suffixIcon: searchcontroller.text.isNotEmpty
    ? InkWell(
        onTap: () {
        setState(() {
          _hasClearedManually = false; // reset before clearing
        });
          searchcontroller.clear();
          FocusScope.of(context).requestFocus(FocusNode()); // dismiss keyboard
          // afterclearsearch(searchValue: "");
          setState(() {
            _isSearching = false;
          });
             afterclearsearch(searchValue: "");
        },
        child: Icon(
          MdiIcons.close,
          color: Customcolors.DECORATION_DARKGREY,
          size: 20,
        ),
      )
    : null,

                ),
                onFieldSubmitted: (value) {
                  if (value.isNotEmpty) {
                  onfieldsubmit(valuee: value);
                  } else {
                    setState(() {
                      searchcontroller.text = '';
                    });
                  }
                },
                onChanged: (value) {
                  if (_debounce?.isActive ?? false) _debounce!.cancel();

                  // Start a new timer
                  _debounce = Timer(const Duration(milliseconds: 500), () {
                    if (value.isNotEmpty) {
                      // createrecentsearch.foodsearchlistbyres(value,"");
                       createrecentsearch.fetchsearchlistbyres(value);
                      // setState(() {
                      //   _isSearching = true;
                      // });
                      setState(() {
        _isSearching = true;
        _wasSearching = true;
        _hasClearedManually = false;
      });
                    } else {
                      setState(() {
                        _isSearching = false;
                      });
                    }
                  });
                },
              ),
            ),
          ),



          if (_isSearching) ...[
            Obx(() {
              if (createrecentsearch.fetchsearchlistloading.isTrue) {
                return const SearchlistShimmer();
              } else if (createrecentsearch.fetchsearchlist == null ||
                  createrecentsearch.fetchsearchlist == "null" ||
                  createrecentsearch.fetchsearchlist.isEmpty ||
                  createrecentsearch.fetchsearchlist["data"]["data"] == null ||
                  createrecentsearch.fetchsearchlist["data"]["data"].isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 8),
                    child: RichText(
                      textAlign: TextAlign.center,
                      softWrap: true,
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Oops!\n',
                            style: CustomTextStyle.redtext,
                          ),
                          TextSpan(
                            text: 'We could not understand what you mean, ',
                            style: CustomTextStyle.chipgrey,
                          ),
                          TextSpan(
                            text: 'try something relevant',
                            style: CustomTextStyle.chipgrey,
                          ),
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
                                
                           return !isInactive ?
                                 InkWell(
                                    onTap: () {
                                    
                                          searchRefresh(searchValue:type=="Restaurant"?createrecentsearch.fetchsearchlist["data"]["data"][indexone]["document"]["name"]: createrecentsearch.fetchsearchlist["data"]["data"][indexone]["document"]["foodName"].toString(), type: type);
                                                setState(() {
                                                  _isSearching = false;
                                                });
                                        
                                              loge.i( type=="Restaurant"?createrecentsearch.fetchsearchlist["data"]["data"][indexone]["document"]["name"]: createrecentsearch.fetchsearchlist["data"]["data"][indexone]["document"]["foodName"].toString());
                            
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 6),
                                      child: ListTile(
                                        hoverColor: Customcolors.DECORATION_GREY,
                                        tileColor: Customcolors.DECORATION_WHITE,
                                        leading:type=="Dish"? SizedBox(
                                           width: 60,
                                           height: 80,
                                          child: ClipRRect(
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
                                                ), title: _buildHighlightedText(
                                                    searchText: searchcontroller.text.trim(),
                                                    resultText: type == "Restaurant"
                                                    ? createrecentsearch.fetchsearchlist["data"]["data"][indexone]["document"]["name"]
                                                    : createrecentsearch.fetchsearchlist["data"]["data"][indexone]["document"]["foodName"],),
                                                subtitle:type=="Restaurant"?  Row(
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
                                                    createrecentsearch.fetchsearchlist["data"]["data"][indexone]["document"]["rating"]==null||createrecentsearch.fetchsearchlist["data"]["data"][indexone]["document"]["rating"]==0?
                                              const SizedBox.shrink():
                                                  const Icon(
                                                  Icons.star,
                                                  size: 20,
                                                  color: Colors.amber,
                                                  ),
                                                    createrecentsearch.fetchsearchlist["data"]["data"][indexone]["document"]["rating"]==null||createrecentsearch.fetchsearchlist["data"]["data"][indexone]["document"]["rating"]==0?
                                              const SizedBox.shrink():Text(" ${createrecentsearch.fetchsearchlist["data"]["data"][indexone]["document"]["rating"]}",
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
                  ),
                );
              }
            }),
          ],
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
       //Nearbyrescontroller nearbyreget = Get.put(Nearbyrescontroller());
    return PopScope(
    canPop: false,
     onPopInvoked: (didPop) async {
        
        if (didPop) return;
         Get.back();
      },
      child: Scaffold(
         backgroundColor: Customcolors.DECORATION_WHITE,
        appBar: AppBar(
          title:  Text(nearbyreget.selectedIndex.value==0?'Search for dishes & restaurants':"Search for products and shops", style: CustomTextStyle.darkgrey),
          bottom: !_isSearching
              ? PreferredSize(
                  preferredSize: const Size.fromHeight(100.0),
                  child: Column(
                    children: [
                      _buildSearchField(),
                      _buildTabBar(),
                    ],
                  ),
                )
              : const PreferredSize(
                  preferredSize: Size.fromHeight(0.0),
                  child: Column(
                    children: [
                      SizedBox(),
                    ],
                  ),
                ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: InkWell(
                  onTap: () {
                  Get.back();},
                  child: const Icon(Icons.arrow_back)),
        ),
      
        body: _isSearching
            ? _buildSearchField()
            : TabBarView(
                controller: _tabController,
                children: [
                  Restaurantfoodlist(searchvalue:searchcontroller.text.toString().isEmpty? "restaurants": searchcontroller.text.toString()),
                  Dishes(searchvalue:searchcontroller.text.toString().isEmpty? "dishes": searchcontroller.text.toString()),
                ],
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
