import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

extension heightExtension on double {
  double get ofHeight => MediaQuery.of(context).size.height * this;

  double get ofWidth => MediaQuery.of(context).size.width * this;
}

BuildContext get context {
  BuildContext? ctx = Get.context;
  if (ctx == null) throw "couldn't find context";
  return ctx;
}

Widget get vacuum => Container(height: 0, width: 0);

Color primary = Color(0xFF0D00CA);
Color mild = Color(0xFFCEC9FC);
Color milder = Color(0xFFF1EFFF);

class Space extends StatelessWidget {
  final double height;
  final double width;

  Space.Y(double y)
      : height = y,
        width = 0;

  Space.X(double x)
      : width = x,
        height = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height, width: width);
  }
}

extension numFormatter on num {
  String get format =>
      NumberFormat("#,###.##").format(this);
}
