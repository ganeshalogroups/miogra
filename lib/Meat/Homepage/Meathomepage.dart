// ignore_for_file: file_names, must_be_immutable

import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Bannercontroller.dart';
import 'package:testing/Features/Foodmodule/getFoodCartProvider.dart';
import 'package:testing/Features/Homepage/AddressController/Addresscontroller.dart';
import 'package:testing/Meat/Homepage/MeatBanner.dart';
import 'package:testing/Meat/Homepage/MeatShops.dart';
import 'package:testing/Meat/Homepage/productcategory.dart';
import 'package:testing/Meat/MeatButtonFunctionalities/MeatAddproductController.dart/AddmeatController.dart';
import 'package:testing/Meat/MeatController.dart/Meatcategory.dart';
import 'package:testing/Meat/MeatController.dart/Meatshopsgetcontroller.dart';
import 'package:testing/Meat/MeatData/Meatfavprovider.dart';
import 'package:testing/Meat/MeatDomain/Meatfavmodel.dart';
import 'package:testing/Meat/MeatOrderscreen/CartAppbar.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatOrderController/ControllerForFavMeat.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatOrderHistoryTabbar/MeatOrdersTab.dart';
import 'package:testing/Meat/MeatOrderscreen/meatadditionalinfo.dart';
import 'package:testing/Meat/MeatSearch/MeatTextformfield.dart';
import 'package:testing/Meat/Meatview/Meatproductview.dart';
import 'package:testing/common/commonRotationalTextWidget.dart';
import 'package:testing/map_provider/Map%20Screens/markervaluse.dart';
import 'package:testing/utils/Buttons/CustomAlertDialoug.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/Const/localvaluesmanagement.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Custom_Widgets/addressbottomsheet.dart';
import 'package:testing/utils/Custom_Widgets/customCartBox.dart';
import 'package:testing/utils/Shimmers/Nearestrestaurantshimmer.dart';
import 'package:testing/utils/Toast/customtoastmessage.dart';
import 'package:testing/utils/exitapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class Meathomepage extends StatefulWidget {
  dynamic meatproductcategoryid;
   Meathomepage({
    required this.meatproductcategoryid,
    super.key});

  @override
  State<Meathomepage> createState() => MeathomepageState();
}

class MeathomepageState extends State<Meathomepage> {
  AddressController      meataddresscontroller = Get.put(AddressController()); 
  Categorymeatlistcontroller getcat = Get.put(Categorymeatlistcontroller());
  MeatShopsGetlist           shopget       = Get.put(MeatShopsGetlist()); 
  MeatAddcontroller          meatcart          = Get.put(MeatAddcontroller()); 
  final PageController shopgetpagecontroller = PageController(initialPage: 0); 
  final Bannerlistcontroller bannerlist = Get.put(Bannerlistcontroller());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
    var meatcartprovider  = Provider.of<FoodCartProvider>(context, listen: false);              
    shopget.meatshopPagingController.refresh();  
    meatcart.getbillmeatcartmeat(km: 0);
    meataddresscontroller.getaddressapi(context: context,latitude: initiallat,longitude: initiallong);          
    meataddresscontroller.getprimaryaddressapi(); 
    getcat.meatcategoryget();
     Future.delayed(Duration.zero, () {
            meatcartprovider.getmeatcartProvider(km: resGlobalKM);
        });
     WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MeatFavoritesProvider>(context, listen: false).initializeDatabase();
    });
        Provider.of<MeatInitializeFavProvider>(context, listen: false).favInitiliteProvider(cntxtt: context);
    });


    // TODO: implement initState
    super.initState();
  }

     forrefresh() {

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        loge.i(resGlobalKM);
        bannerlist.bannerget(productType: 'meat');
         shopget.meatshopPagingController.refresh();  
         meatcart.getbillmeatcartmeat(km: 0);
         meataddresscontroller.getaddressapi(context: context,latitude: initiallat,longitude: initiallong);          
         meataddresscontroller.getprimaryaddressapi(); 
         getcat.meatcategoryget();
      });
    }
    @override
      void dispose() {
      shopgetpagecontroller.dispose();
      super.dispose();
    }
    
  @override
  Widget build(BuildContext context) {
    final mapData = Provider.of<MapDataProvider>(context);
    final meatcartprovider  =  Provider.of<FoodCartProvider>(context);
    var   orderForOthers  =  Provider.of<MeatInstantUpdateProvider>(context); 
     final meatfavoritesProvider  =  Provider.of<MeatFavoritesProvider>(context);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
       // await ExitApp.homepop();
      },
      child: Scaffold(
        backgroundColor: Customcolors.pureWhite,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Customcolors.pureWhite,
          automaticallyImplyLeading: true,
          scrolledUnderElevation: 0,
          surfaceTintColor: Customcolors.pureWhite,
          actions: [
            IconButton(
              onPressed: () { Get.to(const MeatOrderTab(),transition: Transition.leftToRight);
                      },
              icon: const Icon(
                Icons.history,
                color: Customcolors.DECORATION_BLACK,
              ),
            ),
          ],
          title: InkWell(
            onTap: () {
              addressbottomsheet(context).then((value) {
               shopget.meatshopPagingController.refresh();  
               meatcartprovider.getmeatcartProvider(km: resGlobalKM);
               }); 
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(othersicon, scale: 3),
                const SizedBox(width: 5),
                Text(
                  '${mapData.postalCode} - ${mapData.addressType}',
                  style: CustomTextStyle.font12popinBlack,
                ),
                const Icon(Icons.keyboard_arrow_down_outlined),
              ],
            ),
          ),
        ),
        body: RefreshIndicator(
        color:Customcolors.darkpurple, 
        onRefresh: () async {
         await Future.delayed(const Duration(seconds: 2), () {
                  return forrefresh();
                },
              );  
           },
          child: Stack(
          children: [
           SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SearchForBarWidget(
                        onTap: () {
                          Get.to(MeatTextformfield(meatproductcategoryid: widget.meatproductcategoryid,),
                              transition: Transition.leftToRight);
                        },
                        rotationTexts: rotationTextsMeatFlow),
                    19.toHeight,
                    const MeatBanner(),
                    19.toHeight,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Text("Categories",
                              style: CustomTextStyle.googlebuttontext),
                        ),
                        10.toHeight,
                        const MeatProductcategory(),
                      ],
                    ),
                    15.toHeight,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Text("Shops For you",
                              style: CustomTextStyle.googlebuttontext),
                        ),
                        10.toHeight,
                         PagedListView<int, dynamic>(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              addAutomaticKeepAlives: false,
                              addRepaintBoundaries: false,
                              addSemanticIndexes: false,
                              pagingController: shopget.meatshopPagingController,
                              builderDelegate: PagedChildBuilderDelegate<dynamic>(
                                animateTransitions: true,
                                transitionDuration: const Duration(milliseconds: 500),
                                itemBuilder: (context, shopget, index) {
              
                                  final shop = MeatFavoriteShop(
                                    id: shopget["_id"],
                                    name: shopget["name"].toString(),
                                    city: shopget["address"]["city"].toString(),
                                    region: shopget["address"]["region"].toString(),
                                    imageUrl: shopget["imgUrl"].toString(),
                                    rating: shopget["ratingAverage"].toString(),
                                  );
                                  double endlat  = double.parse(shopget["address"]["latitude"].toString());
                                  double endlong = double.parse(shopget["address"]["longitude"].toString());
                                     
                                  // bool isfav = nearbyresget['isFavourite'];
            
                                  return Meatshops(
                                    meatfavoritesProvider:meatfavoritesProvider,
                                    shopget: shopget,
                                    langitude: endlong,
                                    latitude: endlat, shop: shop,
                                  );
                                },
              
                                firstPageProgressIndicatorBuilder: (context)   => const Nearestresshimmer(),
                                firstPageErrorIndicatorBuilder   : (context)   =>  _buildNoDataScreen(context),
                                newPageErrorIndicatorBuilder     : (context)   =>  const SizedBox(),
                                noMoreItemsIndicatorBuilder      : (context)   =>  const SizedBox(),
                                newPageProgressIndicatorBuilder  : (context)   =>  const Nearestresshimmer(),
                                noItemsFoundIndicatorBuilder     : (context)   => _buildNoDataScreen(context),
                                   
                              ),
                            ),
                      
                      ],
                    ),
                  ],
                ),
              ),
            ),
            meatcartprovider.isHaveMeat
  ? Positioned(
      bottom: 15,
      left: 15,
      right: 15,
      child: CustomCartBox(
        itemCount: meatcartprovider.meatCartDetails['totalQuantity'].toString(),
        price: meatcartprovider.meatCartDetails['totalMeatAmount'].toString(),
        restName: meatcartprovider.meatCartDetails['subAdminDetails']['name'],
        resImage: meatcartprovider.meatCartDetails['subAdminDetails']['imgUrl'],
        checkOut: () {
          List<dynamic> cartRes = [];
          cartRes = meatcartprovider.searchshopModel;

          if (cartRes.isNotEmpty) {
            if (cartRes[0]['status'] == true && cartRes[0]['activeStatus'] == "online") {
              final shop = MeatFavoriteShop(
                id: cartRes[0]["_id"],
                name: cartRes[0]["name"].toString(),
                city: cartRes[0]["address"]["city"].toString(),
                region: cartRes[0]["address"]["region"].toString(),
                imageUrl: cartRes[0]["imgUrl"].toString(),
                rating: cartRes[0]["ratingAverage"].toString(),
              );

              double totalDistance = double.tryParse(meatcartprovider.totalDis.split(' ').first.toString()) ?? 0.0;
               
              Get.to(
                CartitemsScreen(
                  totalDis: totalDistance,
                  meatfavourListDetails: cartRes[0]["favourListDetails"],
                  shop: shop,
                  shopId: shop.id,
                  shopcity: shop.city,
                  shopimg: shop.imageUrl,
                  shopname: shop.name,
                  shopregion: shop.region,
                  rating: cartRes[0]['ratingAverage']?.toString() ?? '0',
                  fulladdress: cartRes[0]["address"]?['fullAddress']?.toString() ?? '',
                ),
                transition: Transition.rightToLeft,
              );
            }  else if ((cartRes.isNotEmpty&&cartRes[0]['status'] == false || cartRes[0]['activeStatus'] == "offline")) {
               AppUtils.showToast('The Shop is currently closed. Please select another restaurant.');
            }
            } else if (cartRes.isEmpty) {
              AppUtils.showToast('The address you selected is outside the Shop\'s \ndelivery area.');
            }
        },
        clearCart: () {
          List<dynamic> cartRes = [];
          cartRes = meatcartprovider.searchshopModel;

          if (meatcartprovider.searchshopModel.isNotEmpty || cartRes.isNotEmpty) {
            CustomLogoutDialog.show(
              context: context,
              title: 'Clear cart?',
              content: "Are you sure you want to clear your cart from ${cartRes[0]["name"].toString()} Shop?",
              onConfirm: () async {
                meatcart.clearmeatCartItem(context: context).then((value) {
                  meatcartprovider.getmeatcartProvider(km: resGlobalKM);

                  setState(() {
                    orderForSomeOneName = '';
                    orderForSomeOnePhone = '';
                  });

                  orderForOthers.meatupDateInstruction(instruction: '');
                  orderForOthers.meatupdateSomeOneDetaile(someOneName: '', someOneNumber: '');
                });

                Get.back();
              },
              buttonname: 'Yes',
              oncancel: () { Navigator.pop(context); },
            );
          } else {
            CustomLogoutDialog.show(
              context: context,
              title: 'Clear cart?',
              content: "Are you sure you want to clear your cart from this Restaurant?",
              onConfirm: () async {
                meatcart.clearmeatCartItem(context: context).then((value) {
                  meatcartprovider.getmeatcartProvider(km: resGlobalKM);

                  setState(() {
                    orderForSomeOneName = '';
                    orderForSomeOnePhone = '';
                  });

                  orderForOthers.meatupDateInstruction(instruction: '');
                  orderForOthers.meatupdateSomeOneDetaile(someOneName: '', someOneNumber: '');
                });

                Get.back();
              },
              buttonname: 'Yes',
              oncancel: () { Navigator.pop(context); },
            );
          }
        },
        viewResturant: () {
          List<dynamic> cartRes = [];
          cartRes = meatcartprovider.searchshopModel;
          
          double totalDistance = double.parse(meatcartprovider.totalDis.split(' ').first.toString());
          if (cartRes.isNotEmpty&&cartRes[0]['status'] == true && cartRes[0]['activeStatus'] == "online") {
            final shop = MeatFavoriteShop(
              id: cartRes[0]["_id"],
              name: cartRes[0]["name"].toString(),
              city: cartRes[0]["address"]["city"].toString(),
              region: cartRes[0]["address"]["region"].toString(),
              imageUrl: cartRes[0]["imgUrl"].toString(),
              rating: cartRes[0]['ratingAverage']?.toString() ?? '0',
            );

            Get.to(
              Meatproductviewscreen(
                totalDis: totalDistance,
                shop: shop,
                shopid: shop.id,
                city: shop.city,
                shopname: shop.name,
                rating: cartRes[0]['ratingAverage']?.toString() ?? '0',
                region: shop.region,
                imgurl: shop.imageUrl,
                meatfavourListDetails: cartRes[0]["favourListDetails"] ?? [],
                fulladdress: cartRes[0]["address"]?['fullAddress']?.toString() ?? '',
              ),
              transition: Transition.rightToLeft,
              curve: Curves.easeIn,
            );
          } else {
            AppUtils.showToast('The address you selected is outside the Shop\'s \ndelivery area.');
          }
        },
      ),
    )
  : const SizedBox()

           ],
          ),
        ),
      ),
    );
  }
}
 Widget _buildNoDataScreen(BuildContext context) => const SizedBox(
      height: 400,
      child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Center( child: Text("No Data Available!",style: CustomTextStyle.chipgrey))), 
  );
Future<dynamic> addressbottomsheet(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      isDismissible: true,
      showDragHandle: true,
      enableDrag: true,
      builder: (context) => AddressBottomSheet(isfrommeat: true,));
}
