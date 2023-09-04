import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

/// Navigation items for the app [NavigationItem]
enum NavigationItem {
  register(iconData: LineAwesomeIcons.user_check, label: 'Auth'),
  home(iconData: Icons.dashboard_outlined, label: 'Home'),
  profile(iconData: LineAwesomeIcons.user_circle, label: 'Profile'),
  ;

  const NavigationItem({
    required this.iconData,
    required this.label,
  });
  final IconData iconData;
  final String label;
}
