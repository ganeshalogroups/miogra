

// ignore_for_file: file_names

import 'package:flutter/material.dart';

EdgeInsetsGeometry paddingAll({double padding = 10.0}) {
  return EdgeInsets.all(padding);
}

EdgeInsetsGeometry paddingSymmetric({double vertical = 10.0, double horizontal = 10.0}) {
  return EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal);
}

EdgeInsetsGeometry paddingOnly({double left = 0.0, double top = 0.0, double right = 0.0, double bottom = 0.0}) {
  return EdgeInsets.only(left: left, top: top, right: right, bottom: bottom);
}
