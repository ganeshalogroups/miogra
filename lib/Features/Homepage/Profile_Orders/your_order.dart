import 'package:testing/Features/OrderScreen/OrderScreenController/Getallorders.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class YourOrdersTabsScreen extends StatefulWidget {
  const YourOrdersTabsScreen({super.key});

  @override
  State<YourOrdersTabsScreen> createState() => _YourOrdersTabsScreenState();
}

// late TabController _tabController;

class _YourOrdersTabsScreenState extends State<YourOrdersTabsScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // _tabController.dispose();
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
        Get.back();
      },
      child: Scaffold(
        backgroundColor: Customcolors.DECORATION_CONTAINERGREY,
        appBar: AppBar(
          // automaticallyImplyLeading: true,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text('Orders', style:TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Customcolors.DECORATION_DARKGREY,
      fontFamily: 'Poppins-Regular')),
          centerTitle: true,
          // bottom: PreferredSize(
          //   preferredSize:
          //       Size.fromHeight(50.0), // height of the custom AppBar content

          //   child: Column(
          //     children: [
          //       TabBar(
          //         indicatorColor: Customcolors.darkpurple,
          //         indicatorSize: TabBarIndicatorSize.tab,
          //         controller: _tabController,
          //         tabs: const [
          //           Tab(
          //             child: Text(
          //               'Food',
          //               style: CustomTextStyle.smallboldblack,
          //             ),
          //           ),
          //           Tab(
          //               child: Text(
          //             'Package',
          //             style: CustomTextStyle.smallboldblack,
          //           )),
          //           Tab(
          //               child: Text(
          //             'Meat',
          //             style: CustomTextStyle.smallboldblack,
          //           )),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
        
        ),
        body:  GetallorderlistTab(isFromHome: true),
        // TabBarView(
        //   controller: _tabController,
        //   children: [
        //     GetallorderlistTab(isFromHome: true),
        //     // ParcelgetallorderlistTab(isFromHome: true),
        //     // MeatgetallorderlistTab(isFromHome: true)
        //   ],
        // ),
      ),
    );
  }
}
