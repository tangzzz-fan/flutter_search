import 'package:flutter/material.dart';

class ActionSheetItem {
  final String title;
  final IconData? icon;
  final VoidCallback onTap;

  const ActionSheetItem({
    required this.title,
    this.icon,
    required this.onTap,
  });
}
