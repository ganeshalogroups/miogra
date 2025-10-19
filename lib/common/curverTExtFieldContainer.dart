// ignore: must_be_immutable
import 'package:testing/common/custom_richText.dart';
import 'package:testing/map_provider/Map%20Screens/markervaluse.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/Decorations/boxDecoration.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFieldContainers extends StatelessWidget {
  bool ithaveAddress;
  String locationType;
  bool isSelected;
  bool isNeedIcon;
  final VoidCallback? onTap;
  TextStyle? fontstyle;
  String? fullAddress;

  TextFieldContainers({
    super.key,
    this.isSelected = false,
    required this.locationType,
    this.isNeedIcon = false,
    this.fontstyle,
    this.ithaveAddress = false,
    this.fullAddress,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ithaveAddress
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomRichText(fieldName: locationType))
            : const SizedBox.shrink(),
        InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: ithaveAddress ? 8.0 : 12.0, horizontal: 10),
            decoration: BoxDecorationsFun.bottomCurvedBoxBorder(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                10.toWidth,
                Expanded(
                  child: ithaveAddress
                      ? Text(
                          fullAddress ?? '',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: fontstyle,
                        )
                      : CustomRichText(fieldName: locationType),
                ),
                isNeedIcon
                    ? const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.grey,
                      )
                    : Image.asset(
                        othersicon,
                        scale: 3.5,
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
