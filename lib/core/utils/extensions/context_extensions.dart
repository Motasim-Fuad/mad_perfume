import 'package:flutter/material.dart';

extension ContextX on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;

  double get height => MediaQuery.sizeOf(this).height;

  bool get isRtl => Directionality.of(this) == TextDirection.rtl;

  EdgeInsets get viewPadding => MediaQuery.paddingOf(this);
}
