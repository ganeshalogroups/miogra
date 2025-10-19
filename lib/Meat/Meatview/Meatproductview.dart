// ignore_for_file: file_names, must_be_immutable, avoid_print
import 'package:testing/Features/Foodmodule/getFoodCartProvider.dart';
import 'package:testing/Meat/Common/searchbardelegate.dart';
import 'package:testing/Meat/Homepage/Meathomepage.dart';
import 'package:testing/Meat/MeatButtonFunctionalities/MeatAddproductController.dart/AddmeatController.dart';
import 'package:testing/Meat/MeatButtonFunctionalities/MeatProductAddButton.dart';
import 'package:testing/Meat/MeatButtonFunctionalities/TotalitemcountButton.dart';
import 'package:testing/Meat/MeatController.dart/MeatProductviewcontroller.dart';
import 'package:testing/Meat/MeatController.dart/Meatsearchcontroller.dart';
import 'package:testing/Meat/Meatview/Listclass.dart';
import 'package:testing/Meat/Meatview/MeatAddons.dart';
import 'package:testing/Meat/Meatview/Meatsilverapp.dart';
import 'package:testing/Meat/Meatview/SilverTopButton.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Shimmers/MeatProductviewshimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class Meatproductviewscreen extends StatefulWidget {
  dynamic totalDis;
  dynamic shopname;
  dynamic shopid;
  dynamic imgurl;
  dynamic rating;
  dynamic city;
  dynamic region;
  bool isFrommeatscreen;
  dynamic fulladdress;
   dynamic iscustomizable;
  dynamic addOnsL;
  dynamic customizemeatVariants;
  dynamic meatCustomerPrice;
  dynamic meatId;
  dynamic itemcountNotifier;
  final List meatfavourListDetails;
  dynamic shop;
  Meatproductviewscreen(
      {required this.shopname,
      this.meatfavourListDetails = const [],
      this.iscustomizable,
      this.addOnsL,
      this.customizemeatVariants,
      required this.shopid,
      required this.imgurl,
      required this.rating,
      required this.totalDis,
      this.meatId,
      this.meatCustomerPrice,
      this.itemcountNotifier,
      required this.city,
      required this.region,
      required this.fulladdress,
      this.shop,
      super.key,
      this.isFrommeatscreen=false});

  @override
  State<Meatproductviewscreen> createState() => _MeatproductviewscreenState();
}

class _MeatproductviewscreenState extends State<Meatproductviewscreen> {
  TextEditingController meatsearch = TextEditingController();
  final ScrollController scrollController = ScrollController();
  MeatAddcontroller meatcart = Get.put(MeatAddcontroller());
  Meatsearchcontroller meatlistsearch = Get.put(Meatsearchcontroller());
   MeatButtonController meatbuttonController = MeatButtonController();
  MeatProductviewController productview = Get.put(MeatProductviewController());
  final PageController productviewcontroller = PageController(initialPage: 0);
  final FocusNode focusNode = FocusNode();
  bool showCancelIcon = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        i = 0;
      });

      Provider.of<MeatProductviewPaginations>(context, listen: false)
          .clearData()
          .then((value) {
        Provider.of<MeatProductviewPaginations>(context, listen: false)
            .fetchEarningData(
                meatCategoryId: productview.selectedFoodCusineId.value,
                searchvalue: meatsearch.text,
                shopid: widget.shopid);
      });
    });
    checkIfItemInCart();
    meatsearch.addListener(() {
      setState(() {
        showCancelIcon = meatsearch.text.isNotEmpty;
      });
    });
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        // Scroll to the TextFormField when it gains focus
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.ease,
        );
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // productview.meatproductviewPagingController.refresh();
      productview.meatcategorybuttonget(shopid: widget.shopid);
    });
    super.initState();
  }
  bool _hasInitialized = false;
 @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasInitialized && widget.iscustomizable == true) {
        _hasInitialized = true; // Ensure this block executes only once
      
      // Delay showing the bottom sheet until after the build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        addonsBottomSheet(
          context: context,
          addOns: widget.addOnsL,
          customizedmeatvariants: widget.customizemeatVariants,
          shopname: widget.shopname,
          itemcountNotifier: widget.itemcountNotifier,
          shopid: widget.shopid,
          meatid: widget.meatId,
        ).then((value) {
          final productProvider =
              Provider.of<MeatProductviewPaginations>(context, listen: false);
          
          // Clear data and fetch new data
          productProvider.clearData().then((_) {
            productProvider.fetchEarningData(
              meatCategoryId: productview.selectedFoodCusineId.value,
              searchvalue: meatsearch.text,
              shopid: widget.shopid,
            );
      });
        });
        meatbuttonController.showmeatButton();
        meatbuttonController.incrementmeatItemCount(1);
      });
    }
  }

  Future<dynamic> addonsBottomSheet(
      {required BuildContext context,
      required customizedmeatvariants,
      required addOns,
      required shopname,
      required itemcountNotifier,
      required shopid,
      required meatid}) {
    return showModalBottomSheet(
      backgroundColor: Customcolors.DECORATION_WHITE,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Meataddons(
          shopname: shopname,
          customizedFoodvariants: customizedmeatvariants,
          addOns: addOns,
          shopid: shopid,
          meatid: meatid,
          itemcountNotifier: itemcountNotifier,
        );
      },
    );
  }

  @override
  void dispose() {
    meatsearch.dispose();
    productviewcontroller.dispose();
    super.dispose();
  }

  Future<void> checkIfItemInCart() async {
    try {
      var cartItems = await meatcart.getmeatcartmeat(km: widget.totalDis);

      var currentItem = cartItems.firstWhere(
        (item) => item['subAdminId'] == widget.shopid,
        orElse: () => null,
      );

      if (currentItem != null && currentItem['subAdminId'] == widget.shopid) {
        setState(() {
          currentItem['quantity'];
        });
      } else if (currentItem != null) {
        setState(() {
          Provider.of<MeatButtonController>(context, listen: false).showmeatButton();
        });
      } else {
        setState(() {
          Provider.of<MeatButtonController>(context, listen: false).hidemeatButton();
        });
      }
    } catch (e) {
      print("Error checking if item is in cart: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    var productviewprovider = Provider.of<MeatProductviewPaginations>(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
      Provider.of<MeatButtonController>(context, listen: false).hidemeatButton();
        Provider.of<FoodCartProvider>(context, listen: false).getmeatcartProvider(km: 5);

        if (widget.isFrommeatscreen) {
          meatlistsearch.meatlistloading.value = true;

         Future.delayed(const Duration(seconds: 1), () async {
            meatlistsearch.meatlistloading.value =false; // Stop loading state after fetching data
          });
        }
        if (didPop) return;
       Navigator.pushReplacement(
      context,MaterialPageRoute(builder: (context) => Meathomepage(meatproductcategoryid: meatproductCateId,)),);
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Stack(
          children:  [
            MeatAddproductbutton(
            meatfavourListDetails:widget.meatfavourListDetails ,
            rating: widget.rating,
            shopId: widget.shopid,
            isfromTabscreen: widget.isFrommeatscreen,
            shopcity: widget.city,
            shopimg: widget.imgurl,
            shopname: widget.shopname,
            fulladdress: widget.fulladdress, 
            shopregion: widget.region, shop: widget.shop,
            totalDis: widget.totalDis,
            )],
        ),
        backgroundColor: Customcolors.DECORATION_CONTAINERGREY,
        body: SafeArea(
          top: true,
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              Meatsilverappwidget(
                shopname: widget.shopname,
                rating: widget.rating,
                city: widget.city,
                region: widget.region,
                imgurl: widget.imgurl,
                shop:widget.shop,
                shopid: widget.shopid,
              ),
              SilverTopbuttons(
                shopid: widget.shopid,
              ),
              SliverPersistentHeader(
                delegate: SearchBarDelegate(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      height: searchBarHeight,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Customcolors.DECORATION_WHITE,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2), // Shadow color
                            offset: const Offset(0, 4), // Horizontal offset: 0, Vertical offset: 4
                            blurRadius: 1, // Blur radius
                            spreadRadius: 0, // Spread radius
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: ValueListenableBuilder<TextEditingValue>(
                            valueListenable: meatsearch,
                            builder: (context, value, child) {
                              bool showCancelIcon = value.text.isNotEmpty;
                
                              return TextFormField(
                                focusNode: focusNode,
                                cursorColor: Customcolors.DECORATION_GREY,
                                cursorWidth: 2.0,
                                cursorRadius: const Radius.circular(5.0),
                                controller: meatsearch,
                                onFieldSubmitted: (value) async {
                                  productview.searchmeatname(value);
                                  context.read<MeatProductviewPaginations>().clearData(); // Clear previous data
                                  context.read<MeatProductviewPaginations>()
                                      .fetchEarningData(
                                          meatCategoryId: productview.selectedFoodCusineId.value,
                                          searchvalue: value,
                                          shopid: widget.shopid);
                                },
                                onChanged: (value) {
                                  productview.searchmeatname(value);
                                  context.read<MeatProductviewPaginations>().clearData(); // Clear previous data
                                  context.read<MeatProductviewPaginations>()
                                      .fetchEarningData(
                                          meatCategoryId: productview.selectedFoodCusineId.value,
                                          searchvalue: value,
                                          shopid: widget.shopid);
                                },
                                decoration: InputDecoration(
                                  hintText: 'Search in ${widget.shopname.toString().capitalizeFirst.toString()}',
                                  hintStyle: const TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                    color: Customcolors.DECORATION_GREY,
                                  ),
                                  border: InputBorder.none,
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: Customcolors.DECORATION_BLACK,
                                  ),
                                  suffixIcon: showCancelIcon
                                      ? IconButton(
                                          icon: Icon(
                                            MdiIcons.close,
                                            color: Customcolors.DECORATION_DARKGREY,
                                          ),
                                          onPressed: () {
                                            meatsearch.clear();
                                            productview.clearsearchmeatname();
                                            context.read<MeatProductviewPaginations>().clearData(); // Clear previous data
                                            context.read<MeatProductviewPaginations>()
                                                .fetchEarningData(
                                                   meatCategoryId: productview.selectedFoodCusineId.value,
                                                   searchvalue: "",
                                                   shopid: widget.shopid);
                
                                          },
                                        )
                                      : null,
                                  contentPadding:const EdgeInsets.symmetric(vertical: 15.0),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                pinned: true,
                floating: true,
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    CustomSizedBox(height: 20.h),
                    NotificationListener<ScrollNotification>(
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
                
                          Provider.of<MeatProductviewPaginations>(context, listen: false)
                              .fetchEarningData(
                            meatCategoryId: productview.selectedFoodCusineId.value,
                            searchvalue: meatsearch.text,
                            shopid: widget.shopid,
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
                    }, child: Consumer<MeatProductviewPaginations>(
                      builder: (context, value, child) {
                        if (value.isLoading) {
                          return const Center(child: ShopListWithShimmer());
                        } else if (value.fetchedDatas.isEmpty) {
                          return Center(child: Column(
                            children:  [
                            SizedBox(height: 200,
                            child: Image.asset("assets/meat_images/Nomeatavailable.gif")),
                            // CustomSizedBox(height: 10,),
                            const Text("No Meat available",style: CustomTextStyle.chipgrey,),
                            ],
                          ));
                        } else {
                          return MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: AnimationLimiter(
                              child: ListView.builder(
                                addAutomaticKeepAlives: false,
                                addRepaintBoundaries: false,
                                addSemanticIndexes: false,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: value.moreDataLoading
                                    ? value.fetchedDatas.length + 1
                                    : value.fetchedDatas.length,
                                itemBuilder: (context, index) {
                                  if (index >= value.fetchedDatas.length) {
                                    return const Center(
                                      child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: CupertinoActivityIndicator(),
                                    ));
                                  }
                                  return AnimationConfiguration.staggeredList(
                                   position: index,
                                   duration: const Duration(milliseconds: 750),
                                    child: SlideAnimation(
                                    verticalOffset: 50.0,
                                      child: FadeInAnimation(
                                        child: MeatItemWidget(
                                          shopname: widget.shopname,
                                          data: value.fetchedDatas[index],
                                          shopId: widget.shopid, totalDis: widget.totalDis,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        }
                      },
                    )),
                    const CustomSizedBox(height: 100),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  int i = 0; // dont play with this line
}
