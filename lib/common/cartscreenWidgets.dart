// ignore_for_file: file_names

import 'package:testing/Features/Bottomsheets/Adduserbottomsheet.dart';
import 'package:testing/map_provider/Map%20Screens/markervaluse.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Decorations/boxDecoration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CartAppBarTitle extends StatelessWidget {
  dynamic title;
  dynamic subTitlel;
  CartAppBarTitle({super.key, this.subTitlel, this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        5.toHeight,
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: CustomTextStyle.boldblack2,
        ),
        5.toHeight,
        Text(
          subTitlel,
          style: CustomTextStyle.mapgrey12,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

// address icon

class AddressTypeIcon extends StatelessWidget {
  final String addressType;

  const AddressTypeIcon({
    super.key,
    required this.addressType,
  });

  @override
  Widget build(BuildContext context) {
    String selectedIcon = addressType == 'Home'
        ? homeicon
        : (addressType == 'Other' || addressType == 'Current')
            ? othersicon
            : workicon;

    return Image.asset(
      selectedIcon,
      scale: 3,
      color:  Color(0xFF623089),
    );
  }
}

// // ignore: must_be_immutable
// class CartAddressBar extends StatelessWidget {
//   dynamic addressType;
//   dynamic fullAddress;

//   CartAddressBar(
//       {super.key, required this.addressType, required this.fullAddress});

//   @override
// //   Widget build(BuildContext context) {
// //     return Row(
// //       mainAxisAlignment: MainAxisAlignment.start,
// //       crossAxisAlignment: CrossAxisAlignment.center,
// //       children: [
// //         SizedBox(width: 5),
// //         AddressTypeIcon(addressType: addressType),
// //         10.toWidth,
// //         Text(
// //           "Delivered to $addressType",
// //           style: CustomTextStyle.boldblack12,
// //         ),
// //         5.toWidth,
// //         Text(
// //           "|",
// //           style: TextStyle(color: Customcolors.DECORATION_GREY),
// //         ),
// //         SizedBox(width: 5), // Add space between
// //         SizedBox(
// //             width: 100,
// //             child: Text(fullAddress,
// //                 overflow: TextOverflow.ellipsis,
// //                 style: CustomTextStyle.smallgrey)),
// //         Icon(Icons.keyboard_arrow_down, color: Customcolors.DECORATION_BLACK),
// //       ],
// //     );
// //   }
// // }
// @override
// Widget build(BuildContext context) {
//   final bool isEmptyAddress = fullAddress == null || fullAddress.toString().isEmpty;
//   final bool isCurrent = addressType != null && addressType.toString().toLowerCase() == 'current';

//   return Row(
//     mainAxisAlignment: MainAxisAlignment.start,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       SizedBox(width: 5),
//       AddressTypeIcon(addressType: addressType),
//       10.toWidth,
//       Text(
//         isCurrent || isEmptyAddress ? "Select your delivery address" : "Delivered to $addressType",
//         style: CustomTextStyle.boldblack12,
//       ),
//       if (!isCurrent && !isEmptyAddress) ...[
//         5.toWidth,
//         Text("|", style: TextStyle(color: Customcolors.DECORATION_GREY)),
//         5.toWidth,
//         SizedBox(
//           width: 100,
//           child: Text(
//             fullAddress.toString(),
//             overflow: TextOverflow.ellipsis,
//             style: CustomTextStyle.smallgrey,
//           ),
//         ),
//       ],
//       Icon(Icons.keyboard_arrow_down, color: Customcolors.DECORATION_BLACK),
//     ],
//   );
// }
// }
// ignore: must_be_immutable
class CartAddressBar extends StatelessWidget {
  final String addressType;
  final String fullAddress;

  const CartAddressBar({
    super.key,
    required this.addressType,
    required this.fullAddress,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelectAddress = addressType.toLowerCase() == 'current' || fullAddress.isEmpty;

    return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 5),
        AddressTypeIcon(addressType: addressType),
        const SizedBox(width: 10),

        // Title
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isSelectAddress ? "Select your Delivery Address" : "Delivered to $addressType",
                style: CustomTextStyle.boldblack12,
              ),
              const SizedBox(height: 2),
              if (!isSelectAddress)
                Text(
                  fullAddress,
                  maxLines: 4,
                  // overflow: TextOverflow.ellipsis,
                  style: CustomTextStyle.smallgrey,
                ),
            ],
          ),
        ),

        const Icon(Icons.keyboard_arrow_down, color: Customcolors.DECORATION_BLACK),
      ],
    );
  }
}

//  Add Delivary Instructions

class AddDeliveryInstructions extends StatelessWidget {
  
  final VoidCallback onTapp;
  const AddDeliveryInstructions({super.key,required this.onTapp});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapp,
      child: Container(
        height: 40,
        decoration: BoxDecorationsFun.whiteCircelRadiusDecoration(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Consumer<InstantUpdateProvider>(
                builder: (context, value, child) {
                  if (value.delInstruction != '') {
                    return Text(value.delInstruction,
                        style: CustomTextStyle.carttblack);
                  } else {
                    return const Text('Add Delivery Instructions',
                        style: CustomTextStyle.carttblack);
                  }
                },
              ),
              const Icon(Icons.keyboard_arrow_right,
                  color: Customcolors.DECORATION_GREY),
            ],
          ),
        ),
      ),
    );
  }
}
