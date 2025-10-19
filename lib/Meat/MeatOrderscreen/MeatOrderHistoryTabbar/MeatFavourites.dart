// ignore_for_file: file_names, avoid_print

import 'package:testing/Meat/MeatData/Meatfavprovider.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatOrderController/MeatFavouritecontroller.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatOrderHistoryTabbar/MeatFavcard.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Buttons/Customspace.dart';
import 'package:testing/utils/Shimmers/FavouriteResgetshimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

class MeatFavourites extends StatefulWidget {
  const MeatFavourites({super.key});

  @override
  State<MeatFavourites> createState() => _MeatFavouritesState();
}

class _MeatFavouritesState extends State<MeatFavourites> {
 @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        i = 0;
      });
    _loadData();
    });
    super.initState();
  }


   void _loadData() {
    Provider.of<MeatFavouritegetPagination>(context, listen: false).clearData()
        .then((_) {
      Provider.of<MeatFavouritegetPagination>(context, listen: false)
          .meatfavget(offset: i);
    });
  }
  @override
  Widget build(BuildContext context) {
   final meatfavoritesProvider = Provider.of<MeatFavoritesProvider>(context);
  
   var productviewprovider = Provider.of<MeatFavouritegetPagination>(context);
  return  NotificationListener<ScrollNotification>(
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
                
                          Provider.of<MeatFavouritegetPagination>(context, listen: false)
                              .meatfavget(
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
                    }, child: Consumer<MeatFavouritegetPagination>(
                      builder: (context, value, child) {
                        if (value.isLoading) {
                          return const Center(child: Favouriteresgetshimmer(),);
                        } else if (value.fetchedDatas.isEmpty) {
                          return buildNoDataScreen(context);
                        } else {
                          return MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: AnimationLimiter(
                              child: ListView.builder(
                                addAutomaticKeepAlives: false,
                                addRepaintBoundaries: false,
                                addSemanticIndexes: false,
                                physics: const AlwaysScrollableScrollPhysics(),
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
                                        child: Meatfavcard(
                                        meatfavoritesProvider: meatfavoritesProvider,
                                          data: value.fetchedDatas[index],
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
                    ));
                    
  
  

  }
   int i = 0;


    Widget buildNoDataScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
      child:Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Image.asset("assets/images/Nofavitems.png",height: 300,),
        const CustomSizedBox(height: 40,),
        const Text("No Favourites", style: CustomTextStyle.googlebuttontext),
        const Text("You haven’t liked any items yet.", style: CustomTextStyle.blacktext)
        ],),
      )
    );
  }
}