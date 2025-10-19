// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

closeIcon({ Color iconColor = Customcolors.darkpurple, double size = 20.0}) {
  return Icon(
    MdiIcons.close,
    size: size,
    color: iconColor,
    // color: Customcolors.DECORATION_WHITE
  );
}




closeCircleIcon({ Color iconColor = Customcolors.darkpurple, double size = 20.0}) {
  return Container(
  padding: const EdgeInsets.symmetric(horizontal: 3),
    decoration: const BoxDecoration(color: Color(0xffFDE6E6),shape: BoxShape.circle),
    child: Icon(
      MdiIcons.close,
      size: size,
      color: iconColor,
      // color: Customcolors.DECORATION_WHITE
    ),
  );
}


closeIconForMenu({ Color iconColor = Customcolors.darkpurple, double size = 20.0}) {
  return Container(
  padding: const EdgeInsets.all(3),
    decoration: const BoxDecoration(color: Color(0xffFDE6E6),shape: BoxShape.circle),
    child: Icon(
      MdiIcons.close,
      size: size,
      color: iconColor,
      // color: Customcolors.DECORATION_WHITE
    ),
  );
}
