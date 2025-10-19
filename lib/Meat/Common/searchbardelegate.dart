import 'package:testing/utils/Const/constValue.dart';
import 'package:flutter/material.dart';

class SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  SearchBarDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => searchBarHeight;

  @override
  double get minExtent => searchBarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}




