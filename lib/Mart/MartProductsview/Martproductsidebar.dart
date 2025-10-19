// ignore_for_file: file_names, non_constant_identifier_names, must_be_immutable, avoid_print

import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:testing/Mart/Common/MartButtonFunctionalites.dart';
import 'package:testing/Mart/Homepage/MartAddbutton.dart';
import 'package:testing/Mart/MartProductsview/Martsubsidebar.dart';
import 'package:testing/Mart/MartProductsview/Productscontroller/ProductgetpaginationController.dart';
import 'package:testing/Mart/MartProductsview/Productscontroller/Subcategorycontroller.dart';
import 'package:testing/Mart/MartProductsview/ViewProducts.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/exitapp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class Productsidebar extends StatefulWidget {
bool isFromhomepage;
dynamic categoryId;
dynamic categorydata;
Productsidebar({super.key, this.categoryId, this.isFromhomepage=false, this.categorydata});

  @override
  State<Productsidebar> createState() => _ProductsidebarState();
}

class _ProductsidebarState extends State<Productsidebar> {
  final TextEditingController martsearch = TextEditingController();
   final PageController _pagecontroller = PageController();
  bool martisSearching = false;
  Timer? debounce;
MartsubCategoriescontroller martsubcat=Get.put(MartsubCategoriescontroller());
  @override
  void initState() {
categoryload();
    // TODO: implement initState
     WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        i = 0;
      });

     _loadData();
    });
    super.initState();
  }
  void categoryload(){
   Timer(const Duration(milliseconds: 300), () {

    martsubcat.martsubcategoryget(categoryid: widget.categoryId);
    });
  
  }

 Future <void> _loadData() async {
  // Clear data immediately so UI updates
  // Provider.of<MartProductGetPaginations>(context, listen: false).clearData();

  // Delay fetching new data
  // Timer(Duration(milliseconds: 500), () {
    Provider.of<MartProductGetPaginations>(context, listen: false).clearData().then((value) {
     Timer(const Duration(milliseconds: 500), () { 
       Provider.of<MartProductGetPaginations>(context, listen: false)
        .fetchallproducts(
      offset: i,
      cateid: widget.categoryId,
      subcateid:"",
      //  martsubcat.subcategory["data"][0]["_id"].isEmpty?martsubcat.selectedSubcategoryid.value: martsubcat.subcategory["data"][0]["_id"],
      searchvalue: martsearch.text,
    );
      // });
    //  Provider.of<MartProductGetPaginations>(context, listen: false)
    //     .fetchallproducts(
    //   offset: i,
    //   cateid: widget.categoryId,
    //   subcateid: martsubcat.subcategory["data"][0]["_id"].isEmpty?martsubcat.selectedSubcategoryid.value: martsubcat.subcategory["data"][0]["_id"],
    //   searchvalue: martsearch.text,
    // );
    } );
   
  });
}

  @override
  Widget build(BuildContext context) {
  var Productgetprovider = Provider.of<MartProductGetPaginations>(context);
  return PopScope(
    canPop: true,
   onPopInvoked: (didPop) async {
  if (didPop) return; // Prevent multiple calls

  await ExitApp.backPop();
},

    child: Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,      
      floatingActionButton: const Column(
      mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MartAddProductButton( ),
        ],
      ),
      backgroundColor: Customcolors.pureWhite,
      appBar: AppBar(
       elevation: 0,
        backgroundColor: Customcolors.pureWhite,
        title: const Text(
          'Vegetables',
          style: CustomTextStyle.darkgrey,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () async {
          await ExitApp.backPop();
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10), // Adjust spacing
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Customcolors.DECORATION_WHITE,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: const Offset(0, 4),
                      blurRadius: 1,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: ValueListenableBuilder<TextEditingValue>(
                 valueListenable: martsearch,
                 builder: (context, value, child) {
                   bool showCancelIcon = value.text.isNotEmpty;
                   return  TextFormField(
                    cursorColor: Customcolors.DECORATION_GREY,
                    cursorWidth: 2.0,
                    cursorRadius: const Radius.circular(5.0),
                    controller: martsearch,
                    decoration: InputDecoration(
                      hintText: 'Search for Apple',
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
                         color: Customcolors.DECORATION_DARKGREY, ),
                          onPressed: () {
                          martsearch.clear();
                          martsubcat.clearmartproductname();
                          context.read<MartProductGetPaginations>().clearData(); // Clear previous data
                          context.read<MartProductGetPaginations>().fetchallproducts(
                              cateid:widget.categoryId,
                              subcateid: martsubcat.selectedSubcategoryid.value,
                              searchvalue: ""
                            );
                  
                            },
                          ): null,
                      contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                    ),
                    onFieldSubmitted: (value) {
                    martsubcat.searchmartproductname(value);
                    context.read<MartProductGetPaginations>().clearData(); // Clear previous data
                    context.read<MartProductGetPaginations>().fetchallproducts(
                              cateid:widget.categoryId,
                              subcateid: martsubcat.selectedSubcategoryid.value,
                              searchvalue: value
                            );
                    
                    },
                    onChanged: (value) {  martsubcat.searchmartproductname(value);
                      context.read<MartProductGetPaginations>().clearData(); // Clear previous data
                      context.read<MartProductGetPaginations>().fetchallproducts(
                              cateid:widget.categoryId,
                              subcateid: martsubcat.selectedSubcategoryid.value,
                              searchvalue: value
                            );},
                  );
               
                 },
                ),
              ),
            ),
          ),
          Expanded(
          child: Row( crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Subsidebar(categoryId: widget.categoryId, offset: i,pagecontroller: _pagecontroller,categorydata:widget.categorydata ,),
             Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Customcolors.DECORATION_CONTAINERGREY,
                    ),
                    child: PageView(
                      scrollDirection: Axis.vertical,
                      controller: _pagecontroller,
                      children: [
                       NotificationListener<ScrollNotification>(
                          onNotification: (ScrollNotification notification) {
                        if (notification is ScrollStartNotification) {
                          print('Scroll started');
                        } else if (notification is ScrollUpdateNotification) {
                          print('Scrolling in progress');
                        } else if (notification is ScrollEndNotification) {
                          if (Productgetprovider.totalCount != null &&
                              Productgetprovider.fetchCount != null &&
                              Productgetprovider.fetchedDatas.length !=
                                  Productgetprovider.totalCount) {
                            setState(() {
                              i = i + 1;
                            });
                  
                            Provider.of<MartProductGetPaginations>(context, listen: false).fetchallproducts(
                              offset: i,
                              cateid:widget.categoryId,
                              subcateid: martsubcat.selectedSubcategoryid.value,
                              searchvalue: martsubcat.searchproductnamesearch.value
                            );
                  
                            print('No more data to fetch in If Part ${Productgetprovider.totalCount}  ${Productgetprovider.fetchCount}');
                          } else {
                            print('No more data to fetch  ${Productgetprovider.totalCount}  ${Productgetprovider.fetchCount}');
                          }
                  
                          print('Scroll ended $i');
                        }
                        return true;
                      }, 
                      child: 
                      Column(
                        children: [
                          Expanded(
                            child: Consumer<MartProductGetPaginations>(
                              builder: (context, value, child) {
                                if (value.isLoading) {
                                  return const Center(child: CircularProgressIndicator());
                                } else if (value.fetchedDatas.isEmpty) {
                                  return const Center(child: Text("No product available",style: CustomTextStyle.chipgrey,));
                                } else {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child:  ResponsiveGridList(
                                shrinkWrap: true,
                                horizontalGridSpacing: 7,
                                verticalGridSpacing: 7,
                                horizontalGridMargin: 7,
                                verticalGridMargin: 7,
                                minItemWidth: 70,
                                minItemsPerRow: 2,
                                maxItemsPerRow: 2,
                                listViewBuilderOptions: ListViewBuilderOptions(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: const AlwaysScrollableScrollPhysics()
                                ),
                                children: List.generate(   value.moreDataLoading
                                          ? value.fetchedDatas.length + 1
                                          : value.fetchedDatas.length, (index) {
                                                if (index >= value.fetchedDatas.length) {
                                          return const Center(
                                            child: Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: CupertinoActivityIndicator(color: Colors.orange,),
                                          ));
                                        }
                                  ValueNotifier<int> itemCountNotifier = ValueNotifier<int>(0);
                                  return InkWell(
                                  onTap: () {
                                     Navigator.push(
                                     context,
                                     MaterialPageRoute(builder: (context) => Viewproducts(fetcheddatas:  value.fetchedDatas[index],)),
                                     );
                                  },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Customcolors.pureWhite,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(8),
                                              child: Container(
                                                height: 65,
                                                width: double.infinity,
                                                color: Colors.white,
                                                child:CachedNetworkImage(
                                              imageUrl:  value.fetchedDatas[index]["productListImgUrl"],
                                               width: double.infinity,
                                              fit: BoxFit.contain,
                                              placeholder: (context, url) => Image.asset(
                                              meatdummy,
                                              width: double.infinity,
                                              fit: BoxFit.contain,
                                             ),
                                             errorWidget: (context, url, error) => Image.asset(
                                             meatdummy,
                                             width: double.infinity,
                                            fit: BoxFit.contain,
                                            ),
                                           )
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row( crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                      value.fetchedDatas[index]["productListName"].toString().capitalizeFirst.toString(),
                                                        overflow: TextOverflow.clip,
                                                        maxLines: 3,
                                                        style: CustomTextStyle.meatbold,
                                                      ),
                                                    ),
                                                    Text(
                                                       "${value.fetchedDatas[index]["productList"]["unitValue"].toString()}${value.fetchedDatas[index]["productList"]["unit"].toString()}",
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: CustomTextStyle.midboldsmall,
                                                    ),
                                                  ],
                                                ),
                                                value.fetchedDatas[index]["productListDiscription"].isEmpty?const SizedBox(height: 0,):
                                                Text("(${ value.fetchedDatas[index]["productListDiscription"].toString().capitalizeFirst})",
                                                  style: CustomTextStyle.midboldsmall,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "₹${value.fetchedDatas[index]["productList"]["customerPrice"].toString()}",
                                                      style: CustomTextStyle.martbold,
                                                      maxLines: 1,
                                                    ),
                                                    const SizedBox(width: 7),
                                                    const Text(
                                                      "₹30.00",
                                                      style: CustomTextStyle.redstrikeredsmall,
                                                      maxLines: 1,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Martaddbutton(isFromSidebar: true,itemcountNotifier: itemCountNotifier,),
                                                const SizedBox(height: 5),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                             );
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 55.h,)
                        ],
                      )),
                      
                      ],
                    ),
                  ),
                ),
        ],
      ),
    )],
          )),
  );
}int i = 0; // dont play with this line
}

