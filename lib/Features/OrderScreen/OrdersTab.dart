// ignore_for_file: file_names

import 'package:testing/Features/Foodmodule/SubAdmincontroller/RestaurantFoodmodule/Foodhomepage.dart';
import 'package:testing/Features/OrderScreen/Favourites.dart';
import 'package:testing/Features/OrderScreen/Ordershistory.dart';
import 'package:testing/Features/OrderScreen/Orderslist.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/exitapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';




class OrdersHistory extends StatefulWidget {

  const OrdersHistory({super.key});

  @override
  State<OrdersHistory> createState() => _OrdersHistoryState();
}

late TabController _tabController;

class _OrdersHistoryState extends State<OrdersHistory> with SingleTickerProviderStateMixin {
   

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }



  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


      //      canPop: false,
      //      onPopInvoked: (didPop) async{
      //      if (didPop) return;
      //        await ExitApp.foodhomepop(context);
      //      },



  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        await ExitApp.foodhomepage();
        
      },
      child: Scaffold(
        backgroundColor: Customcolors.DECORATION_CONTAINERGREY,
        appBar: AppBar(
          // automaticallyImplyLeading: true,
          leading: IconButton(onPressed: () {

            Get.off(const Foodscreen(),transition: Transition.rightToLeft);
            
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
                  controller: _tabController,
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
          controller: _tabController,
          children:  [Orderlist(), const FoodOrderHistory(), const Favourites()],
        ),
      ),
    );
  }
}
