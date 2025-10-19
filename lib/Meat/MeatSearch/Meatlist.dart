// ignore_for_file: must_be_immutable, file_names
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:testing/Meat/MeatController.dart/Meatsearchcontroller.dart';
import 'package:testing/Meat/MeatSearch/MeatlistTab.dart';
import 'package:testing/Meat/MeatSearch/Shopmeatlist.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Shimmers/Searchlistshimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
class Meatlistscreen extends StatefulWidget {
  final dynamic searchvalue;
  final dynamic meatproductcategoryid;
    final VoidCallback? onSearchReset;

  const Meatlistscreen({
    required this.searchvalue,
    required this.meatproductcategoryid,
    super.key, this.onSearchReset,
  });

  @override
  State<Meatlistscreen> createState() => _MeatlistscreenState();
}

class _MeatlistscreenState extends State<Meatlistscreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isSearching = false;
  Timer? _debounce;
  final TextEditingController _searchController = TextEditingController();
  final Meatsearchcontroller meatlistsearch = Get.put(Meatsearchcontroller());
  final TextEditingController meatsearchcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      meatlistsearch.getrecentmeatsearch(
        meatproductcategoryid: widget.meatproductcategoryid,
      );
    });

    meatsearchcontroller.text = widget.searchvalue;

    Timer(Duration.zero, () {
      meatlistsearch.meatsearchlistbyshop(widget.searchvalue,);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void searchRefresh({required String searchValue}) {
    meatsearchcontroller.text = searchValue;

    Timer(Duration.zero, () {
      meatlistsearch.meatsearchlistbyshop(searchValue);
    });
  }

  void onFieldSubmit({required String value}) {
    meatsearchcontroller.text = value;

    Timer(Duration.zero, () {
      meatlistsearch.meatsearchlistbyshop(value);
    });

    setState(() {
      _isSearching = false;
    });
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      indicatorColor: Customcolors.darkpurple,
      indicatorSize: TabBarIndicatorSize.tab,
      tabs: const [
        Tab(child: Text('Shop', style: CustomTextStyle.smallboldblack)),
        Tab(child: Text('Meats', style: CustomTextStyle.smallboldblack)),
      ],
    );
  }

  Widget _buildSearchField() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
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
                ),
              ],
            ),
            child: TextFormField(
              controller: meatsearchcontroller,
              cursorColor: Customcolors.DECORATION_GREY,
              cursorWidth: 2.0,
              cursorRadius: const Radius.circular(5.0),
              decoration: InputDecoration(
                hintText: 'Search for ‘Fish’',
                hintStyle: const TextStyle(
                  fontFamily: 'Poppins-Regular',
                  color: Customcolors.DECORATION_GREY,
                ),
                border: InputBorder.none,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Customcolors.DECORATION_BLACK,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                suffixIcon: _isSearching
                    ? InkWell(
                        onTap: () {
                          meatsearchcontroller.clear();
                          setState(() {
                            _isSearching = false;
                          });
                        },
                        child:  Icon(
                          MdiIcons.close,
                          color: Customcolors.DECORATION_BLACK,
                        ),
                      )
                    : const SizedBox(),
              ),
              onFieldSubmitted: (value) {
                if (value.isNotEmpty){
                  onFieldSubmit(value: value);
                } else{
                  setState(() {
                      meatsearchcontroller.text = '';
                  });
                }
              },
              onChanged: (value) {
                if (_debounce?.isActive ?? false) _debounce!.cancel();

                _debounce = Timer(const Duration(milliseconds: 500), () {
                  if (value.isNotEmpty) {
                    meatlistsearch.meatsearchlistbyshop(value);
                    setState(() => _isSearching = true);
                  } else {
                    setState(() => _isSearching = false);
                  }
                });
              },
            ),
          ),
        ),
        if (_isSearching) Obx(() => _buildSearchResults()),
      ],
    );
  }

  Widget _buildSearchResults() {
    if (meatlistsearch.meatlistloading.isTrue) {
      return const SearchlistShimmer();
    } else if (meatlistsearch.meatlist.isEmpty ||
    meatlistsearch.meatlist == null ||
    meatlistsearch.meatlist == "null" ||meatlistsearch.meatlist["data"]["AdminUserList"]==null||
    meatlistsearch.meatlist["data"]["AdminUserList"].isEmpty) {
      return _buildNoResults();
    } else {
      return _buildResultsList();
    }
  }

  Widget _buildNoResults() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 8),
        child: RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            children: [
              TextSpan(text: 'Oops!\n', style: CustomTextStyle.redtext),
              TextSpan(
                text: 'We could not understand what you mean, ',
                style: CustomTextStyle.chipgrey,
              ),
              TextSpan(
                text: 'try something relevant',
                style: CustomTextStyle.chipgrey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultsList() {
    final data = meatlistsearch.meatlist["data"]["AdminUserList"];
    return SizedBox(
    height: MediaQuery.of(context).size.height * 0.7.h,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          final categoryDetails = data[index]["categoryDetails"];
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: categoryDetails.length,
            itemBuilder: (context, subIndex) {
              final meats = categoryDetails[subIndex]["meats"];
              if (meats == null || meats.isEmpty) return const SizedBox();
      
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: meats.length,
                itemBuilder: (context, meatIndex) {
                  return _buildMeatTile(meats[meatIndex]);
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildMeatTile(dynamic meat) {
    return InkWell(
      onTap: () {
        searchRefresh(searchValue: meat['meatName'].toString());
        setState(() => _isSearching = false);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          hoverColor: Customcolors.DECORATION_GREY,
          tileColor: Customcolors.DECORATION_WHITE,
          leading: SizedBox(
            width: 80,
            child: ClipRRect(
              child: CachedNetworkImage(
                placeholder: (context, url) =>Image.asset(meatdummy),
                errorWidget: (context, url, error) =>Image.asset(meatdummy),
                imageUrl: meat["meatImgUrl"],
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            meat["meatName"].toString().capitalizeFirst!,
            style: CustomTextStyle.profile,
          ),
          subtitle: Text(
            meat["meatShopName"].toString().capitalizeFirst!,
            style: CustomTextStyle.addressfetch,
          ),
        ),
      ),
    );
  }

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
          title: const Text(
            'Search for meats & shops',
            style: CustomTextStyle.darkgrey,
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap:() {
              Get.back();
              widget.onSearchReset;
            },
            child: const Icon(Icons.arrow_back),
          ),
          bottom: !_isSearching
              ? PreferredSize(
                  preferredSize: const Size.fromHeight(100.0),
                  child: Column(
                    children: [
                      _buildSearchField(),
                      _buildTabBar(),
                    ],
                  ),
                )
              : const PreferredSize(
                  preferredSize: Size.fromHeight(0.0),
                  child: SizedBox(),
                ),
        ),
        body: _isSearching
            ? _buildSearchField()
            : TabBarView(
                controller: _tabController,
                children: [
                  Shopmeatlist(searchvalue: widget.searchvalue),
                  MeatlistTab(searchvalue: widget.searchvalue),
                ],
              ),
      ),
    );
  }
}
