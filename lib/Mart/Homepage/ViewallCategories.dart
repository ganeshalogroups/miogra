// ignore_for_file: file_names, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:testing/Mart/Homepage/MartHomepage.dart';
import 'package:testing/Mart/Homepage/MartHomepageController/MartcategorypaginationController.dart';
import 'package:testing/Mart/MartProductsview/Martproductsidebar.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class Viewallcategories extends StatefulWidget {
  const Viewallcategories({ super.key,});

  @override
  State<Viewallcategories> createState() => _ViewallcategoriesState();
}

class _ViewallcategoriesState extends State<Viewallcategories> {
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
    Provider.of<MartCategoryviewPaginations>(context, listen: false).clearData().then((value) {
    Provider.of<MartCategoryviewPaginations>(context, listen: false).fetchviewallcategories(offset: i);
    });
  }

  @override
  Widget build(BuildContext context) {
    var categoryviewprovider = Provider.of<MartCategoryviewPaginations>(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        Get.off(const MartHomepage());
      },
      child: Scaffold(
        backgroundColor: Customcolors.pureWhite,
        appBar: AppBar(
          backgroundColor: Customcolors.pureWhite,
          title: const Text(
            'Categories',
            style: CustomTextStyle.darkgrey,
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () {
              Get.off(const MartHomepage());
            },
            child: const Icon(Icons.arrow_back),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 10),
            NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification notification) {
              if (notification is ScrollStartNotification) {
                print('Scroll started');
              } else if (notification is ScrollUpdateNotification) {
                print('Scrolling in progress');
              } else if (notification is ScrollEndNotification) {
                if (categoryviewprovider.totalCount != null &&
                    categoryviewprovider.fetchCount != null &&
                    categoryviewprovider.fetchedDatas.length !=
                    categoryviewprovider.totalCount) {
                  setState(() {
                    i = i + 1;
                  });

                  Provider.of<MartCategoryviewPaginations>(context,listen: false)
                    .fetchviewallcategories(
                    offset: i,
                  );

                  print('No more data to fetch in If Part ${categoryviewprovider.totalCount}  ${categoryviewprovider.fetchCount}');
                } else {
                  print( 'No more data to fetch  ${categoryviewprovider.totalCount}  ${categoryviewprovider.fetchCount}');
                }

                print('Scroll ended $i');
              }
              return true;
            }, child: Consumer<MartCategoryviewPaginations>(
              builder: (context, value, child) {
                if (value.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (value.fetchedDatas.isEmpty) {
                  return Center(
                      child: Column(
                    children: [
                      SizedBox(
                          height: 200,
                          child: Image.asset("assets/meat_images/Nomeatavailable.gif")),
                      const Text(
                        "No Meat available",
                        style: CustomTextStyle.chipgrey,
                      ),
                    ],
                  ));
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ResponsiveGridList(
                      minItemWidth: 80,
                      maxItemsPerRow: 4,
                      minItemsPerRow: 4,
                      horizontalGridSpacing: 10,
                      verticalGridSpacing: 10, // Spacing between rows
                      listViewBuilderOptions: ListViewBuilderOptions(
                        physics:const AlwaysScrollableScrollPhysics(), // Ensures scrolling works
                        shrinkWrap: true,
                      ),
                      children: List.generate(
                        value.moreDataLoading
                            ? value.fetchedDatas.length + 1
                            : value.fetchedDatas.length,
                        (index) {
                          if (index >= value.fetchedDatas.length) {
                            return const Center(
                                child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: CupertinoActivityIndicator(
                                color: Colors.orange,
                              ),
                            ));
                          }
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(
                                      Productsidebar(
                                        categoryId: value.fetchedDatas[index]["_id"],
                                        isFromhomepage: false,
                                        categorydata: value.fetchedDatas[index],
                                      ),
                                      transition: Transition.rightToLeft);
                                },
                                child: _buildCategoryItem(fetchedDatas: value.fetchedDatas[index]),
                              ),
                              const SizedBox(height: 5), // Space between image and text
                              Text(
                                value.fetchedDatas[index]["meatCateName"].toString().capitalizeFirst.toString(),
                                style: CustomTextStyle.subblack,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                }
              },
            )),
          ],
        ),
      ),
    );
  }

  int i = 0; // dont play with this line
  Widget _buildCategoryItem({required fetchedDatas}) {
    return Container(
      width: 80,
      height: 80,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(253, 246, 245, 1),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: CachedNetworkImage(
          imageUrl: fetchedDatas["meatCateImage"],
          width: 50,
          height: 50,
          placeholder: (context, url) => Image.asset(
            meatdummy,
            width: 50,
            height: 50,
          ),
          errorWidget: (context, url, error) => Image.asset(
            meatdummy,
            width: 50,
            height: 50,
          ),
        ),
      ),
    );
  }
}
