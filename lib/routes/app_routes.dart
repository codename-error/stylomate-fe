import 'package:flutter/material.dart';
import './name_routes.dart';
import 'package:stylomate/views/home/home_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> get routes => {
    RouteNames.home: (context) => HomeScreen(),
  };
}