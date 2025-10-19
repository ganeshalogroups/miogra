// // ignore_for_file: avoid_print

// ignore_for_file: unused_local_variable, file_names, avoid_print, unnecessary_brace_in_string_interps, unnecessary_string_interpolations

import 'dart:async';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/Foodgetcontroller.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/Getmenucountcontroller.dart';
import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Foodsearchlistgetcontroller.dart';
import 'package:testing/Features/Foodmodule/Foodviewscreen/AddButtonFunctions/Foodclearsearch.dart';
import 'package:testing/Features/Foodmodule/Foodviewscreen/AddButtonFunctions/Buttonfunctionalities.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/Getnearbyrescontroller.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/FoodViewPagedList.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodhomepage.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/SilverAppwidget.dart';
import 'package:testing/Features/Foodmodule/getFoodCartProvider.dart';
import 'package:testing/utils/Buttons/CustomIconBtn.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/Decorations/ContainerDecorations.dart';
import 'package:testing/utils/Shimmers/Foodlistshimmer.dart';
import 'package:testing/utils/Shimmers/Nofoodavailableloader.dart';
import 'package:testing/utils/Shimmers/viewrestaurantloader.dart';
import 'package:get/get.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import '../../Foodcategorycontroller/Addfoodcontroller.dart';

// ignore: must_be_immutable
class Foodviewscreen extends StatefulWidget {
  dynamic restaurantId;
  // String? fulladdress;
  // String? restaurantname;
  // String? restaurantcity;
  // String? restaurantregion;
  bool isFromDishScreeen;
  // final List<dynamic>? restaurantfoodtitle;
  // dynamic restaurantreview;
  // dynamic reviews;
  // String? restaurantimg;
  // dynamic restaurant;
  // dynamic menu;
  // final List<dynamic>? additionalImages;
  // final List favourListDetails;
  dynamic totalDis;
  dynamic iscustomizable;
  dynamic addOnsL;
  dynamic foodType;
  dynamic customizeFoodVarients;
  dynamic itemcountNotifier;
  dynamic foodCustomerPrice;
  dynamic foodId;
  dynamic searchvalue;

  //  dynamic favouritestatus;
  Foodviewscreen({
    this.restaurantId,
    this.isFromDishScreeen = false,
    // this.restaurantcity,
    // this.restaurantfoodtitle,
    required this.totalDis,
    // this.restaurantname,
    // this.restaurantregion,
    this.iscustomizable,
    // this.restaurantreview,
    // this.reviews,
    // this.restaurantimg,
    // this.restaurant,
    this.searchvalue,
    // required this.fulladdress,
    // required this.favouritestatus,
    // this.menu,
    // this.favourListDetails = const [],
    super.key,
    // this.additionalImages,
    this.customizeFoodVarients,
    this.foodCustomerPrice,
    this.addOnsL,
    this.foodId,
    this.foodType,
    this.itemcountNotifier,
  });

  @override
  State<Foodviewscreen> createState() => _FoodviewscreenState();
}

class _FoodviewscreenState extends State<Foodviewscreen> {
    Nearbyrescontroller nearbyreget = Get.put(Nearbyrescontroller());
  TextEditingController foodsearch = TextEditingController();
  final ScrollController _firstController = ScrollController();
  final AddProductController controller = Get.put(AddProductController());
  // Nearbyrescontroller nearbyreget = Get.put(Nearbyrescontroller());
  Foodcartcontroller foodcart = Get.put(Foodcartcontroller());
  ButtonController buttonController = ButtonController();
  Foodsearchcontroller createrecentsearch = Get.put(Foodsearchcontroller());
  final ScrollController _scrollController = ScrollController();
  // RedirectController redirect = Get.put(RedirectController());

  Menucountgetcontroller menu = Get.put(Menucountgetcontroller());
  final Map<String, GlobalKey> _categoryKeys = {};

  String selectedFoodType = "";
  bool showNonVegContent = true;
  bool isSelected = false;
  bool vegisSelected = false;
  bool eggisSelected = false;
  bool showPureVegContent = true;
  bool showEggcontent = true;
  bool showClearButton = false;

  final FocusNode _focusNode = FocusNode();
  Timer? _debounce;
// bool _hasShownAddonsSheet = false;

  @override
  void initState() {
    super.initState();

    forrefreshpage();

    _focusNode.addListener(_focusNodeListener);
    _focusNode.addListener(_fabVisibilityListener);
  }

  void _focusNodeListener() {
    if (_focusNode.hasFocus) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _fabVisibilityListener() {
    if (!mounted) return;
    setState(() {
      controller.isFabVisible.value = !_focusNode.hasFocus;
    });
  }

  void callapi() {
    Provider.of<FoodProductviewPaginations>(context, listen: false)
        .clearData()
        .then((value) {
      Provider.of<FoodProductviewPaginations>(context, listen: false)
          .fetchFoodData(
              restaurantid: widget.restaurantId.toString(),
              searchvalue: foodsearch.text,
              foodtype: selectedFoodType,
              offset: i);
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusNodeListener);
    _focusNode.removeListener(_fabVisibilityListener);

    _scrollController.dispose();
    _focusNode.dispose();

    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    foodsearch.dispose();

    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 400), () {
      if (!mounted) return;

      String newFoodType = "";
      bool showNonVeg = true;
      bool showVeg = true;
      bool showEgg = true;

      if (value.isEmpty) {
        if (isSelected) {
          newFoodType = "nonveg";
          showVeg = false;
          showEgg = false;
        } else if (vegisSelected) {
          newFoodType = "veg";
          showNonVeg = false;
          showEgg = false;
        } else if (eggisSelected) {
          newFoodType = "egg";
          showNonVeg = false;
          showVeg = false;
        }
      } else {
        if (isSelected) {
          newFoodType = "nonveg";
          showVeg = false;
          showEgg = false;
        } else if (vegisSelected) {
          newFoodType = "veg";
          showNonVeg = false;
          showEgg = false;
        } else if (eggisSelected) {
          newFoodType = "egg";
          showNonVeg = false;
          showVeg = false;
        }
      }

      // Only update state if something changed
      if (selectedFoodType != newFoodType ||
          showNonVegContent != showNonVeg ||
          showPureVegContent != showVeg ||
          showEggcontent != showEgg) {
        setState(() {
          selectedFoodType = newFoodType;
          showNonVegContent = showNonVeg;
          showPureVegContent = showVeg;
          showEggcontent = showEgg;
        });
      }

      // Call API outside setState
      callapi();
      foodcart.getfoodcartfood(km: widget.totalDis);
    });
  }

  void veg() {
    if (!mounted) return;
    setState(() {
      selectedFoodType = "veg";
    });
    callapi();
    foodcart.getfoodcartfood(km: widget.totalDis);
  }

  void nonveg() {
    if (!mounted) return;
    setState(() {
      selectedFoodType = "nonveg";
    });
    callapi();
    foodcart.getfoodcartfood(km: widget.totalDis);
  }

  void egg() {
    if (!mounted) return;
    setState(() {
      selectedFoodType = "egg";
    });
    callapi();
    foodcart.getfoodcartfood(km: widget.totalDis);
  }

  Future<void> checkIfItemInCart() async {
    try {
      var cartItems = await foodcart.getfoodcartfood(km: widget.totalDis);

      var currentItem = cartItems.firstWhere(
        (item) => item['restaurantId'] == widget.restaurantId,
        orElse: () => null,
      );

      if (!mounted) return;

      if (currentItem != null &&
          currentItem['restaurantId'] == widget.restaurantId) {
        setState(() {
          currentItem[
              'quantity']; // You might want to capture quantity here too
          isCart = true;
        });
      } else if (currentItem != null) {
        setState(() {
          isCart = true;
          Provider.of<ButtonController>(context, listen: false).showButton();
        });
      } else {
        setState(() {
          isCart = false;
          Provider.of<ButtonController>(context, listen: false).hideButton();
        });
      }
    } catch (e) {
      print("Error checking if item is in cart: $e");
    }
  }

  void forrefreshpage() {
    checkIfItemInCart();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;

      final foodProvider =
          Provider.of<FoodProductviewPaginations>(context, listen: false);

      try {
        await foodProvider.clearData();
        await foodProvider.fetchFoodData(
            restaurantid: widget.restaurantId.toString(),
            searchvalue: foodsearch.text,
            foodtype: selectedFoodType,
            offset: i);
      } catch (e) {
        print("Error fetching food data: $e");
        // Optional: show an error snackbar/message
      }

      if (!mounted) return;

      setState(() {
        isInitialLoading = false;
      });

      menu.menucountget(restaurantid: widget.restaurantId);
    });
  }

  bool isInitialLoading = true;

  @override
  Widget build(BuildContext context) {
    // bool isFilterApplied = showNonVegContent || showPureVegContent || showEggcontent;
    var productviewprovider = Provider.of<FoodProductviewPaginations>(context);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        Provider.of<FoodCartProvider>(context, listen: false)
            .getfoodcartProvider(km: 5);
        if (widget.isFromDishScreeen) {
          createrecentsearch.dishessearchlistloading.value = true;
          Future.delayed(const Duration(milliseconds: 100), () async {
            createrecentsearch.dishessearchlistloading.value = false;
          });
        }
        if (didPop) return;
        // await ExitApp.backPop();
        Get.off(const Foodscreen(), transition: Transition.rightToLeft);
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (notification is ScrollStartNotification) {
            print('Scroll started');
          } else if (notification is ScrollUpdateNotification) {
            print('Scrolling in progress');
          } else if (notification is ScrollEndNotification) {
            if (productviewprovider.totalCount != null &&
                productviewprovider.fetchCount != null &&
                productviewprovider.fetchedDatas.length !=
                    productviewprovider.totalCount) {
              setState(() {
                i = i + 1;
              });

              Provider.of<FoodProductviewPaginations>(context, listen: false)
                  .fetchFoodData(
                restaurantid: widget.restaurantId.toString(),
                searchvalue: "",
                foodtype: selectedFoodType,
                offset: i,
              );
              print(
                  'No more data to fetch in If Part ${productviewprovider.totalCount}  ${productviewprovider.fetchCount}');
            } else {
              print(
                  'No more data to fetch  ${productviewprovider.totalCount}  ${productviewprovider.fetchCount}');
            }
            print('Scroll ended $i');
          }
          return true;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: isInitialLoading
              ? const SizedBox() // ✅ Full screen loader
              : Stack(
                  children: [
                    // productviewprovider.restaurantDetails?['restaurantAvailable'] == true
                    productviewprovider.restaurantDetails?[
                                    'restaurantAvailable'] ==
                                true ||
                            productviewprovider
                                    .restaurantDetails?['activeStatus'] ==
                                'online' ||
                            productviewprovider.restaurantDetails?['status'] ==
                                true
                        ? AddProductButton(
                            isfromTabscreen: widget.isFromDishScreeen,
                            totalDis: widget.totalDis,
                            // restaurant: widget.restaurant,
                            restaurantId: widget.restaurantId,
                            restaurantcity: productviewprovider
                                    .restaurantDetails?['address']["city"] ??
                                '',
                            restaurantfoodtitle: productviewprovider
                                .restaurantDetails?['cusineList'],
                            restaurantimg:
                                "$globalImageUrlLink${productviewprovider.restaurantDetails?['imgUrl']}",
                            restaurantname: productviewprovider
                                    .restaurantDetails?['name'] ??
                                '',
                            restaurantregion: productviewprovider
                                    .restaurantDetails?['address']["region"] ??
                                '',
                            restaurantreview: productviewprovider
                                .restaurantDetails?["ratingAverage"],
                            reviews: productviewprovider
                                .restaurantDetails?["ratings"].length,
                            fulladdress: productviewprovider
                                        .restaurantDetails?['address']
                                    ["fullAddress"] ??
                                '',
                          )
                        : const SizedBox.shrink(),
                    productviewprovider.restaurantDetails?[
                                    'restaurantAvailable'] ==
                                true &&
                            productviewprovider
                                    .restaurantDetails?['activeStatus'] ==
                                'online' &&
                            productviewprovider.restaurantDetails?['status'] ==
                                true
                        ? menubutton(productviewprovider)
                        : const SizedBox.shrink(),
                  ],
                ),
          backgroundColor: Customcolors.DECORATION_CONTAINERGREY,
          body: isInitialLoading
              ? const Viewrestaurantloader() // ✅ Full screen loader
              : SafeArea(
                  child: Consumer<FoodProductviewPaginations>(
                    builder: (context, value, child) {
                      dynamic offerPercentage = productviewprovider
                              .restaurantDetails
                              .containsKey('servicesType')
                          ? productviewprovider
                                  .restaurantDetails["servicesType"]
                              ["offerPercentage"]
                          : "";
                      return CustomScrollView(
                        controller: _scrollController,
                        slivers: [
                          SliverAppBarWidget(
                            restaurantAvailable:
                                productviewprovider.restaurantDetails,
                            offerPercentage: offerPercentage,
                            isFromDishScreen: widget.isFromDishScreeen,
                            restaurantimg:
                                "$globalImageUrlLink${productviewprovider.restaurantDetails?['imgUrl']}", // Replace with actual image URL or variable
                            restaurantname: productviewprovider
                                    .restaurantDetails?['name'] ??
                                '',
                            restaurantfoodtitle:
                                productviewprovider.restaurantDetails?[
                                    'cusineList'], // Example data
                            restaurantId: widget.restaurantId,
                            restaurantcity: productviewprovider
                                    .restaurantDetails?['address']["region"] ??
                                '',
                            restaurantregion: productviewprovider
                                    .restaurantDetails?['address']["city"] ??
                                '',
                            restaurantreview: productviewprovider
                                .restaurantDetails["ratingAverage"],
                            // restaurant: widget.restaurant,
                            reviews: productviewprovider
                                .restaurantDetails?["ratings"].length,
                          ),
                          SliverPersistentHeader(
                            delegate: _SearchBarDelegate(
                                child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child:
                                  searchfoodfield(context, productviewprovider),
                            )),
                            pinned: true,
                            floating: true,
                          ),
                          SliverList(
                            delegate: SliverChildListDelegate(
                              [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const CustomSizedBox(
                                        height: 15,
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child:
                                            filtermethod(productviewprovider),
                                      ),
                                      const CustomSizedBox(height: 10),
                                      productviewprovider
                                                          .restaurantDetails?[
                                                      'restaurantAvailable'] !=
                                                  true ||
                                              productviewprovider
                                                          .restaurantDetails?[
                                                      'activeStatus'] !=
                                                  'online' ||
                                              productviewprovider
                                                          .restaurantDetails?[
                                                      'status'] !=
                                                  true
                                          ? const Notdeliverable()
                                          : const SizedBox.shrink(),
                                      if (showNonVegContent ||
                                          showPureVegContent ||
                                          showEggcontent)
                                        //  if (isFilterApplied)
                                        Consumer<FoodProductviewPaginations>(
                                            builder: (context, value, child) {
                                          // Scoped checks and loading for food list only
                                          if (value.isLoading &&
                                              (showNonVegContent ||
                                                  showPureVegContent ||
                                                  showEggcontent)) {
                                            return const Center(
                                                child: Foodlistshimmer());
                                          }

                                          bool allEmpty = value
                                                  .fetchedDatas.isNotEmpty &&
                                              value.fetchedDatas.every(
                                                  (category) =>
                                                      category.foods == null ||
                                                      category.foods.isEmpty);

                                          if (value.fetchedDatas.isEmpty) {
                                            return const Nofoodavailable();
                                          }

                                          if (allEmpty) {
                                            return allemptyreturn(value);
                                          }

                                          return ListView.builder(
                                            addAutomaticKeepAlives: false,
                                            addRepaintBoundaries: false,
                                            addSemanticIndexes: false,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: value
                                                    .fetchedDatas.length +
                                                ((value.moreDataLoading ||
                                                        (value.totalCount !=
                                                                null &&
                                                            value.fetchedDatas
                                                                    .length ==
                                                                value
                                                                    .totalCount))
                                                    ? 1
                                                    : 0),
                                            itemBuilder: (context, index) {
                                              if (index >=
                                                  value.fetchedDatas.length) {
                                                if (value.moreDataLoading) {
                                                  return const Center(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(16.0),
                                                      child: Foodlistshimmer(),
                                                    ),
                                                  );
                                                } else if (value.totalCount !=
                                                        null &&
                                                    value.fetchedDatas.length ==
                                                        value.totalCount) {
                                                  return fssaimethod(value);
                                                }
                                              }
var resCommission =  productviewprovider.restaurantDetails;
                                              var currentData =
                                                  value.fetchedDatas[index];
                                              if (currentData.foods == null ||
                                                  currentData.foods.isEmpty) {
                                                return const SizedBox.shrink();
                                              }

                                              return Column(
                                                children: [
                                                  FoodViewPagedList(
                                                    rescommission: resCommission["servicesType"]["commissionRate"],
                                                    restaurantAvailable:
                                                        productviewprovider
                                                                .restaurantDetails ??
                                                            "",
                                                    offerPercentage:
                                                        offerPercentage,
                                                    categoryKeys: _categoryKeys,
                                                    fetchedDatas: currentData,
                                                    restaurantDetails:
                                                        value.restaurantDetails,
                                                    totalDis: widget.totalDis,
                                                    indexone: index,
                                                    restaurantname:
                                                        productviewprovider
                                                                .restaurantDetails?[
                                                            'name'],
                                                    resid: widget.restaurantId,
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }),
                                      CustomSizedBox(
                                        height: 150.h,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }

  Column allemptyreturn(FoodProductviewPaginations value) {
    return Column(
      children: [
        const Center(child: Nofoodavailable()),
        SizedBox(height: 15.h),
        value.restaurantDetails == null ||
                value.restaurantDetails["fssaiNumber"].isEmpty
            ? const SizedBox.shrink()
            : Column(
                children: [
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/Fssai-Logo-PNG-Transparent.png",
                        height: 25,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        " License No. ${value.restaurantDetails["fssaiNumber"].toString()}",
                        style: CustomTextStyle.boldgrey,
                      ),
                    ],
                  ),
                ],
              ),
      ],
    );
  }

  Row filtermethod(FoodProductviewPaginations productviewprovider) {
    final bool isRestaurantAvailable =
        productviewprovider.restaurantDetails?['restaurantAvailable'] == true &&
            productviewprovider.restaurantDetails?['activeStatus'] ==
                'online' &&
            productviewprovider.restaurantDetails?['status'] == true;

    return nearbyreget.selectedIndex.value==0?  
     Row(
      children: [
        // Non veg chip
        GestureDetector(
          onTap: isRestaurantAvailable && !isSelected
              ? () {
                  setState(() {
                    vegisSelected = false;
                    eggisSelected = false;
                    isSelected = true;
                    Timer(const Duration(milliseconds: 500), () {
                      Timer(const Duration(milliseconds: 100), nonveg);
                    });
                  });
                }
              : null,
          child: Opacity(
            opacity: isRestaurantAvailable ? 1.0 : 0.5,
            child: Container(
              height: 25.h,
              decoration: CustomBoxDecoration()
                  .isBoxCheckedDecoration(isSelected: isSelected),
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child:
               Row(
                children: [
                  reusableIcons(iconName: nonvegIcon),
                  const SizedBox(width: 5),
                  Text(
                    "Non veg",
                     style: TextStyle(
      fontSize: 13,
      color:isSelected? Colors.white:Customcolors.darkgrey,
      fontFamily: 'Poppins-Regular'),
                   // style: CustomTextStyle.chipgrey,
                  ),
                  if (isSelected)
                    InkWell(
                      onTap: isRestaurantAvailable
                          ? () {
                              setState(() {
                                selectedFoodType = "";
                                isSelected = false;
                                showNonVegContent = true;
                                showPureVegContent = true;
                                showEggcontent = true;
                                callapi();
                              });
                            }
                          : null,
                      child: closeCircleIcon(size: 17),
                    ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(width: 10),

        // Pure veg chip
        GestureDetector(
          onTap: isRestaurantAvailable && !vegisSelected
              ? () {
                  setState(() {
                    isSelected = false;
                    eggisSelected = false;
                    vegisSelected = true;
                    Timer(const Duration(milliseconds: 500), () {
                      Timer(const Duration(milliseconds: 100), veg);
                    });
                  });
                }
              : null,
          child: Opacity(
            opacity: isRestaurantAvailable ? 1.0 : 0.5,
            child: Container(
              height: 25.h,
              decoration: CustomBoxDecoration()
                  .isBoxCheckedDecoration(isSelected: vegisSelected),
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  reusableIcons(iconName: vegIcon),
                  const SizedBox(width: 5),
                   Text(
                    "Pure veg",
                    style: TextStyle(
      fontSize: 13,
      color:vegisSelected? Colors.white:Customcolors.darkgrey,
      fontFamily: 'Poppins-Regular'),
                   // style: CustomTextStyle.chipgrey,
                  ),
                  if (vegisSelected)
                    InkWell(
                      onTap: isRestaurantAvailable
                          ? () {
                              setState(() {
                                selectedFoodType = "";
                                vegisSelected = false;
                                showNonVegContent = true;
                                showPureVegContent = true;
                                showEggcontent = true;
                                callapi();
                              });
                            }
                          : null,
                      child: closeCircleIcon(size: 17),
                    ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(width: 10),

        // Egg chip
        GestureDetector(
          onTap: isRestaurantAvailable && !eggisSelected
              ? () {
                  setState(() {
                    vegisSelected = false;
                    isSelected = false;
                    eggisSelected = true;
                    Timer(const Duration(milliseconds: 500), () {
                      Timer(const Duration(milliseconds: 100), egg);
                    });
                  });
                }
              : null,
          child: Opacity(
            opacity: isRestaurantAvailable ? 1.0 : 0.5,
            child: Container(
              height: 25.h,
              decoration: CustomBoxDecoration()
                  .isBoxCheckedDecoration(isSelected: eggisSelected),
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  reusableIcons(iconName: eggIcon),
                  const SizedBox(width: 5),
                   Text(
                    "Egg",
                     style: TextStyle(
      fontSize: 13,
      color:eggisSelected? Colors.white:Customcolors.darkgrey,
      fontFamily: 'Poppins-Regular'),
                  //  style: CustomTextStyle.chipgrey,
                  ),
                  if (eggisSelected)
                    InkWell(
                      onTap: isRestaurantAvailable
                          ? () {
                              setState(() {
                                selectedFoodType = "";
                                eggisSelected = false;
                                showNonVegContent = true;
                                showPureVegContent = true;
                                showEggcontent = true;
                                callapi();
                              });
                            }
                          : null,
                      child: closeCircleIcon(size: 17),
                    ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(width: 10),
      ],
    ) : Row();
  }

  Center fssaimethod(FoodProductviewPaginations value) {
    return Center(
      child: value.restaurantDetails == null ||
              value.restaurantDetails["fssaiNumber"].isEmpty
          ? const SizedBox.shrink()
          : Column(
              children: [
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/Fssai-Logo-PNG-Transparent.png",
                      height: 25,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      " License No. ${value.restaurantDetails["fssaiNumber"].toString()}",
                      style: CustomTextStyle.boldgrey,
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  Container searchfoodfield(
      BuildContext context, FoodProductviewPaginations productviewprovider) {
    return Container(
      height: searchBarHeight,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: Customcolors.DECORATION_WHITE,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // Shadow color
            offset:
                const Offset(0, 4), // Horizontal offset: 0, Vertical offset: 4
            blurRadius: 1, // Blur radius
            spreadRadius: 0, // Spread radius
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Consumer<FoodSearchProvider>(
              builder: (context, provider, child) {
                return TextFormField(
                  cursorColor: Customcolors.DECORATION_GREY,
                  cursorWidth: 2.0, // Set the cursor width
                  cursorRadius: const Radius.circular(5.0),
                  focusNode: _focusNode,
                  controller: foodsearch,
                  onFieldSubmitted: (value) async {
                    Timer(const Duration(milliseconds: 500), () {
                      _onSearchChanged(value);
                    });
                  },
                  onChanged: (value) {
                    Timer(const Duration(milliseconds: 500), () {
                      _onSearchChanged(value);
                    });
                  },
                  decoration: InputDecoration(
                    hintText:
                        'Search in ${productviewprovider.restaurantDetails?['name'].toString().capitalizeFirst.toString()}',
                    hintStyle: const TextStyle(
                      fontFamily: 'Poppins-Regular',
                      color: Customcolors.DECORATION_GREY,
                    ),
                    border: InputBorder.none,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Customcolors.DECORATION_BLACK,
                    ),
                    suffixIcon: provider.showClearButton
                        ? IconButton(
                            icon: Icon(
                              MdiIcons.close,
                              size: 18,
                              color: Customcolors.DECORATION_BLACK,
                            ),
                            onPressed: () {
                              setState(() {
                                foodsearch.clear();
                                _onSearchChanged('');
                              });
                            },
                          )
                        : null,
                    contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                  ),
                );
              },
            )),
      ),
    );
  }

  int i = 0; // dont play with this line

  Positioned menubutton(FoodProductviewPaginations provider) {
    return Positioned(
      right: 15,
      // bottom: 90.h,
      bottom: 60.h,
      child: InkWell(
        onTap: () => _showTestDialog(provider),
        child: Container(
          height: 50,
          decoration: CustomContainerDecoration.menubuttondecoration(),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Image(
              image: AssetImage("assets/images/Menucard.png"),
              height: 25,
            ),
          ),
        ),
      ),
    );
  }

  void _showTestDialog(FoodProductviewPaginations provider) {
    showDialog(
      context: context,
      builder: (context) {
        return Stack(
          children: [
            Consumer<FoodProductviewPaginations>(
              builder: (context, value, child) {
                if (value.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                final visibleCategories = value.fetchedDatas
                    .where((category) =>
                        category.foods != null &&
                        category.foods!.isNotEmpty &&
                        category.status == true)
                    .toList();

                // If no menu available
                if (visibleCategories.isEmpty) {
                  return Center(
                    child: Material(
                      borderRadius: BorderRadius.circular(12),
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text("No Menu available!",
                            style: CustomTextStyle.chipgrey),
                      ),
                    ),
                  );
                }

                // Calculate dynamic height
                // final double itemHeight = 35.h;
                // final double maxHeight = 250.0;
                // final double calculatedHeight = visibleCategories.length * itemHeight;
                // final double finalHeight = calculatedHeight > maxHeight ? maxHeight : calculatedHeight;
                final double itemHeight = 35.h;
                const double maxHeight = 250.0;
                const int maxVisibleItems = 5;

                final double calculatedHeight =
                    visibleCategories.length * itemHeight;
                final bool isScrollable =
                    visibleCategories.length > maxVisibleItems;
                final double finalHeight =
                    isScrollable ? maxHeight : calculatedHeight;

                return Positioned(
                  left: 45,
                  right: 20,
                  top: MediaQuery.of(context).size.height / 2.h -
                      finalHeight / 2.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Material(
                      color: Colors.white,
                      shape: const BeveledRectangleBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Spacer(),
                                  Text("Choose Your Category",
                                      style: CustomTextStyle.bigORANGEtext),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () => Navigator.pop(context),
                                    child: closeIconForMenu(size: 15),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: finalHeight,
                                child: isScrollable
                                    ? Scrollbar(
                                        controller: _firstController,
                                        thickness: 4,
                                        thumbVisibility: true,
                                        radius: const Radius.circular(8),
                                        child: ListView.builder(
                                          controller: _firstController,
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          itemCount: visibleCategories.length,
                                          itemBuilder: (context, index) {
                                            final category =
                                                visibleCategories[index];
                                            return buildCategoryItem(category);
                                          },
                                        ),
                                      )
                                    : ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: visibleCategories.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          final category =
                                              visibleCategories[index];
                                          return buildCategoryItem(category);
                                        },
                                      ),
                              ),

                              // SizedBox(
                              //   height: finalHeight,
                              //   child: Scrollbar(
                              //     thickness: 4,
                              //     thumbVisibility: true,
                              //     controller: _firstController,
                              //     radius: Radius.circular(8),
                              //     child: ListView.builder(
                              //       controller: _firstController,
                              //       physics: visibleCategories.length > 5
                              //           ? AlwaysScrollableScrollPhysics()
                              //           : NeverScrollableScrollPhysics(),
                              //       shrinkWrap: true,
                              //       itemCount: visibleCategories.length,
                              //       itemBuilder: (context, index) {
                              //         final category = visibleCategories[index];
                              //         return Padding(
                              //           padding: const EdgeInsets.all(8.0),
                              //           child: InkWell(
                              //             onTap: () {
                              //               Navigator.pop(context);
                              //               Future.delayed(Duration(milliseconds: 300), () {
                              //                 final key = _categoryKeys[category.foodCateName?.toString().capitalizeFirst ?? ''];
                              //                 if (key?.currentContext != null) {
                              //                   Scrollable.ensureVisible(
                              //                     key!.currentContext!,
                              //                     duration: Duration(milliseconds: 500),
                              //                     curve: Curves.easeInOut,
                              //                     alignment: 0.1,
                              //                   );
                              //                 }
                              //               });
                              //             },
                              //             child: Row(
                              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //               children: [
                              //                 Text(category.foodCateName?.toString().capitalizeFirst ?? '', style: CustomTextStyle.blackB14),
                              //                 Text("${category.foods!.length}", style: CustomTextStyle.blackB14),
                              //               ],
                              //             ),
                              //           ),
                              //         );
                              //       },
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  reusableIcons({iconName}) {
    return Image(
      image: AssetImage(iconName),
      height: 15,
      width: 15,
    );
  }

  Widget buildCategoryItem(category) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
            Future.delayed(const Duration(milliseconds: 300), () {
              final key = _categoryKeys[
                  category.foodCateName?.toString().capitalizeFirst ?? ''];
              if (key?.currentContext != null) {
                Scrollable.ensureVisible(
                  key!.currentContext!,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  alignment: 0.1,
                );
              }
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: 230,
                  child: Text(
                      category.foodCateName?.toString().capitalizeFirst ?? '',
                      style: CustomTextStyle.blackB14)),
              Text("${category.foods?.length ?? 0}",
                  style: CustomTextStyle.blackB14),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SearchBarDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => searchBarHeight;

  @override
  double get minExtent => searchBarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
