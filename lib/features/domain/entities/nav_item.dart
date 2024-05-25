import 'package:flutter/material.dart';

class NavItem {
  final String navName;
  final IconData navIcon;
  bool isSelected;

  NavItem({
    required this.navName,
    required this.navIcon,
    this.isSelected = false,
  });
}
