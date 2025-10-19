
// ignore_for_file: file_names

import 'package:testing/common/cartscreenWidgets.dart';
import 'package:testing/common/edgeIncetsClass.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/Decorations/boxDecoration.dart';
import 'package:flutter/widgets.dart';
class OrderDetailsBody extends StatelessWidget {
  final String addressType;
  final String userAddress;

  const OrderDetailsBody({
    super.key,
    required this.addressType,
    required this.userAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        5.toHeight,
       Container(
  decoration: BoxDecorationsFun.whiteCircelRadiusDecoration(),
  padding: paddingAll(padding: 12.0),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const SizedBox(width: 5),
      AddressTypeIcon(addressType: addressType),
      10.toWidth,
      Flexible(
        child: RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: "Delivered to ",
                style: CustomTextStyle.boldblack12,
              ),
              TextSpan(
                text: userAddress,
                style: CustomTextStyle.smallgrey,
              ),
            ],
          ),
        ),
      ),
      5.toWidth,
    ],
  ),
),
 const SizedBox(height: 10),
      ],
    );
  }
}
