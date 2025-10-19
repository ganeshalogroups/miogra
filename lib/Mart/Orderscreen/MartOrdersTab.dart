
// ignore_for_file: file_names

import 'package:testing/Mart/Homepage/MartHomepage.dart';
import 'package:testing/Mart/Orderscreen/MartOrderlistTab.dart';
import 'package:testing/Mart/Orderscreen/MartorderHistory.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MartorderTab extends StatefulWidget {
  const MartorderTab({super.key});

  @override
  State<MartorderTab> createState() => _MartorderTabState();
}
late TabController tabController;
class _MartorderTabState extends State<MartorderTab>with SingleTickerProviderStateMixin {
 @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
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
       Get.off(const MartHomepage());
        
      },
      child: Scaffold(
        backgroundColor: Customcolors.DECORATION_CONTAINERGREY,
        appBar: AppBar(
          leading: IconButton(onPressed: () {
 Get.off(const MartHomepage());
            
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
                  ],
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
        controller: tabController,
        children:  [MartorderlistTab(), const MartOrderHistory()],
        ),
      ),
    );
 
  }
}