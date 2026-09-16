import 'package:flutter/widgets.dart';

class AppSizes {
  AppSizes._();

  static const double page = 20;
  static const double radius = 18;
  static const double radiusLg = 28;
  static const double buttonHeight = 54;
  static const double fieldHeight = 54;
  static const double navHeight = 56;
  static const double navBottomPad = 10;
  static const double navGap = 20;

  static double navClearanceOf(BuildContext context) {
    return navHeight +
        navBottomPad +
        navGap +
        MediaQuery.paddingOf(context).bottom;
  }
}
