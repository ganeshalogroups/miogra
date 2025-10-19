// ignore_for_file: file_names

import 'package:testing/Features/Foodmodule/Data/cartprovider.dart';
import 'package:testing/Features/Foodmodule/Domain/favouritemodel.dart';
import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodviewfirstscreen.dart';
import 'package:testing/Features/Foodmodule/getFoodCartProvider.dart';
import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Redirectcontroller.dart';
import 'package:testing/Features/OrderScreen/Favouriterestaurantcard.dart';
import 'package:testing/Features/OrderScreen/OrderScreenController/Favrestaurantcotroller.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Shimmers/FavouriteResgetshimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';



class Favourites extends StatefulWidget {
   const Favourites({ super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}



class _FavouritesState extends State<Favourites> {
  
 RedirectController redirect = Get.put(RedirectController());
FavresGetcontroller favrestget=Get.put(FavresGetcontroller());

    @override
      void initState() {
          WidgetsBinding.instance.addPostFrameCallback((_) async { 
  
redirect.getredirectDetails();
  });
      if(mounted){

        favrestget.favresPagingController.refresh();
        
      }

        super.initState();
      }




  refresh() async {
      await Future.delayed(const Duration(seconds: 2),() {
             favrestget.favresPagingController.refresh();
             redirect.getredirectDetails();
      },
    );
  }



  @override
  Widget build(BuildContext context) {
  
  final favoritesProvider = Provider.of<FavoritesProvider>(context);
  final foodcartprovider = Provider.of<FoodCartProvider>(context);

  
    return SingleChildScrollView(
      child: RefreshIndicator(
 color: Customcolors.darkpurple,
              onRefresh: () async {  
               await refresh();

            },



        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 8),
                   child: PagedListView<int, dynamic>(
                   physics: const NeverScrollableScrollPhysics(),
                   shrinkWrap: true,
                   addAutomaticKeepAlives: false,
                   addRepaintBoundaries: false,
                   addSemanticIndexes: false,
                   pagingController: favrestget.favresPagingController,
                   builderDelegate: PagedChildBuilderDelegate<dynamic>(
                     animateTransitions: true,
                     transitionDuration: const Duration(milliseconds: 500),
            
                     itemBuilder: (context, favresget, index) { 
            
                          final restaurant = FavoriteRestaurant(
                                    id:       favresget["restaurantDetails"]["_id"],
                                    name:     favresget["restaurantDetails"]["name"].toString(),
                                    city:     favresget["restaurantDetails"]["address"]["city"].toString(),
                                    region:   favresget["restaurantDetails"]["address"]["region"].toString(),
                                    imageUrl: "${globalImageUrlLink}${favresget["restaurantDetails"]["imgUrl"].toString()}",
                                    rating:   favresget["restaurantDetails"]["ratingAverage"].toString(),
                              ); 
            
                  // List<dynamic> additionalImages = favresget["restaurantDetails"]["additionalImage"] ?? [];
                    List<dynamic> additionalImages = (favresget["restaurantDetails"]["additionalImage"] )
                                   .map((img) => "$globalImageUrlLink$img").toList();
            
                          var endlat  = favresget["restaurantDetails"]["address"]["latitude"];
                          var endlong = favresget["restaurantDetails"]["address"]["longitude"];
            
                          return InkWell(
                            onTap: () {

                              
                                List<dynamic> cartRes = [];
                                cartRes = foodcartprovider.searchResModel;
            
                                // if (cartRes.isNotEmpty) {
            
                                  Get.to(
                                    Foodviewscreen(
                                    totalDis: 5,
                                    restaurantId        : restaurant.id,
                                  ),
            
                                    transition: Transition.rightToLeft,
                                    duration: const Duration(milliseconds: 200), curve: Curves.easeIn );
            
                            
                                // } else {
            
                                //   AppUtils.showToast("The address you selected is outside the restaurant's delivery area.");
                                      
                                // }
                             
                            },
            
            
                            child: Favouriterescard(
                                favoritesProvider: favoritesProvider,
                                favresget: favresget,
                                langitude: endlong,
                                latitude: endlat, 
                                restaurant: restaurant,
                            ),
                          ); 
                     
                     },
            
            
                     firstPageProgressIndicatorBuilder: (context) => const Favouriteresgetshimmer(),
                     firstPageErrorIndicatorBuilder: (context)  =>  _buildNoDataScreen(context),
                     newPageErrorIndicatorBuilder: (context)    =>  const SizedBox(),
                     noMoreItemsIndicatorBuilder:(context)      =>  const SizedBox(),
                     newPageProgressIndicatorBuilder: (context) =>  const Favouriteresgetshimmer(),
                     noItemsFoundIndicatorBuilder: (context)    => _buildNoDataScreen(context),
                     
                   )),
             )
          ],
        ),
      ),
    );
  }



  Widget _buildNoDataScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
      child:Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        const CustomSizedBox(height: 80,),
        Image.asset("assets/images/Nofavitems.png",height: 200,),
        const CustomSizedBox(height: 40,),
        // Text("No Favourites", style: CustomTextStyle.googlebuttontext),
        const Text("You haven't marked any restaurants as favorites yet", style: CustomTextStyle.blacktext,textAlign: TextAlign.center,)
        ],),
      )
    );
  }



}


