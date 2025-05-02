import 'package:flutter/material.dart';
import 'package:stylomate/views/wardrobe/done_wardrobe._screen.dart';
import 'package:stylomate/views/wardrobe/preview_wardrobe.dart';
import 'package:stylomate/views/wardrobe/scan_wardrobe_screen.dart';
import 'package:stylomate/views/settings/setting_screen.dart';
import 'package:stylomate/views/wardrobe/add_wardrobe_screen.dart';
import './name_routes.dart';
import 'package:stylomate/views/home/home_screen.dart';
import 'package:stylomate/views/profile/profile_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> get routes => {
    RouteNames.home: (context) => HomeScreen(),
    RouteNames.profile: (context) => ProfileScreen(),
    RouteNames.addWardrobe: (context) => AddWardrobeScreen(),
    RouteNames.settings: (context) => SettingScreen(),
    RouteNames.scanWardrobe: (context) => ScanWardrobeScreen(),
    RouteNames.previewWardrobe: (context) => const PreviewWardrobeScreen(),
    RouteNames.doneWardrobe: (context) => const DoneWardrobeScreen(),
  };
}