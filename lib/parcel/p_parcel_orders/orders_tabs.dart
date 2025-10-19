// ignore_for_file: file_names

import 'package:testing/parcel/p_parcel_orders/parcel_orderhistory.dart';
import 'package:testing/parcel/p_parcel_orders/parcel_orderslist.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/exitapp.dart';
import 'package:flutter/material.dart';





class ParcelOrdersHistory extends StatefulWidget {
   const ParcelOrdersHistory({super.key});

  @override
  State<ParcelOrdersHistory> createState() => _ParcelOrdersHistoryState();
}

late TabController _tabController;

class _ParcelOrdersHistoryState extends State<ParcelOrdersHistory> with SingleTickerProviderStateMixin {
      
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        await ExitApp.parcelHome();

      },

      child: Scaffold(
        
        backgroundColor: Customcolors.DECORATION_CONTAINERGREY,
        
        appBar: AppBar(
          // automaticallyImplyLeading: true,
        
          leading: IconButton(
            
            onPressed: () async {

              await ExitApp.parcelHome();
        
          }, icon: const Icon(Icons.arrow_back)
          

        ),



          title: const Text('History', style: CustomTextStyle.darkgrey),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize:const Size.fromHeight(60.0), // height of the custom AppBar content
                
            child: Column(
              children: [
      
                TabBar(
                  indicatorColor : Customcolors.darkpurple,
                  indicatorSize  : TabBarIndicatorSize.tab,
                  controller     : _tabController,
                  tabs: const [
      
                    Tab(
                      child: Text(
                        'Ongoing',
                        style: CustomTextStyle.smallboldblack,
                      ),
                    ),

                    Tab(
                      child: Text(
                      'History',
                      style: CustomTextStyle.smallboldblack,
                    )),
              
                  ],
                ),
          
              ],
            ),
          ),
        ),
      
      
        body: TabBarView(
          controller : _tabController,
          children   :   [ParcelOrdersList(), const PArcelOrderHistory()],
        ),
      ),
    );
  }
}





// subAdminType=restaurant