import 'package:flutter/material.dart';
import '../enums/sheet_position.dart';

class ActionSheetConfig {
  final SheetPosition position;
  final Offset? origin; // 弹出的起始位置
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final BoxDecoration? decoration;
  final bool dismissOnTapOutside;
  final Duration animationDuration;
  final Curve animationCurve;
  final Color? barrierColor;
  final bool useRootNavigator;

  const ActionSheetConfig({
    this.position = SheetPosition.bottom,
    this.origin,
    this.width,
    this.height,
    this.padding,
    this.decoration,
    this.dismissOnTapOutside = true,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.barrierColor,
    this.useRootNavigator = true,
  });
}
