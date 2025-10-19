// ignore_for_file: file_names
import 'package:testing/Meat/Homepage/Meathomepage.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatOrderHistoryTabbar/MeatFavourites.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatOrderHistoryTabbar/MeatOrderHistory.dart';
import 'package:testing/Meat/MeatOrderscreen/MeatOrderHistoryTabbar/MeatOrderlistTab.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/exitapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MeatOrderTab extends StatefulWidget {
  const MeatOrderTab({super.key});

  @override
  State<MeatOrderTab> createState() => _MeatOrderTabState();
}
late TabController tabController;
class _MeatOrderTabState extends State<MeatOrderTab>with SingleTickerProviderStateMixin {
 @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  
  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
     return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        await ExitApp.meathomepage();
        
      },
      child: Scaffold(
        backgroundColor: Customcolors.DECORATION_CONTAINERGREY,
        appBar: AppBar(
          leading: IconButton(onPressed: () {

            Get.off(Meathomepage(meatproductcategoryid: meatproductCateId,),transition: Transition.rightToLeft);
            
          }, icon: const Icon(Icons.arrow_back),),
          title: const Text('History', style: CustomTextStyle.darkgrey),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize:const Size.fromHeight(60.0), // height of the custom AppBar content
                
            child: Column(
              children: [
                TabBar(
                  indicatorColor: Customcolors.darkpurple,
                  indicatorSize: TabBarIndicatorSize.tab,
                  controller: tabController,
                  tabs: const [
                    Tab(
                      child: Text(
                        'Orders',
                        style: CustomTextStyle.smallboldblack,
                      ),
                    ),
                    Tab(
                        child: Text(
                      'History',
                      style: CustomTextStyle.smallboldblack,
                    )),
                    Tab(
                        child: Text(
                      'Favorite',
                      style: CustomTextStyle.smallboldblack,
                    )),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
        controller: tabController,
        children:  [MeatorderlistTab(), const MeatOrderHistory(), const MeatFavourites()],
        ),
      ),
    );
 
  }
}