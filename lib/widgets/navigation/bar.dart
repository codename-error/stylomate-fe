import 'package:flutter/material.dart';
import 'package:stylomate/themes/custom_icons.dart';
import 'item.dart';
import 'package:stylomate/themes/custom_colors.dart';

class FloatingNavigationBar extends StatefulWidget {
  final int initialIndex;

  const FloatingNavigationBar({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<FloatingNavigationBar> createState() => _FloatingNavigationBarState();
}

class _FloatingNavigationBarState extends State<FloatingNavigationBar> {
  late int _selectedIndex = 0;

  final List<Map<String, dynamic>> _navigationItems = [
    {
      'icon': Stylomateicon.home,
      'label': 'Home',
      'route': '/',
    },
    {
      'icon': Stylomateicon.magic,
      'label': 'Try-on',
      'route': '/try-on',
    },
    {
      'icon': Stylomateicon.camera,
      'label': 'Style me',
      'route': '/style-me',
    },
    {
      'icon': Stylomateicon.account,
      'label': 'Profile',
      'route': '/profile',
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;

    // Set correct initial index based on current route
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final String currentRoute = ModalRoute.of(context)?.settings.name ?? '/';
      updateSelectedIndexByRoute(currentRoute);
    });
  }

  void updateSelectedIndexByRoute(String route) {
    for (int i = 0; i < _navigationItems.length; i++) {
      if (_navigationItems[i]['route'] == route) {
        setState(() {
          _selectedIndex = i;
        });
        break;
      }
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pushNamed(context, _navigationItems[index]['route']);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 4,
      left: 0,
      right: 0,
      child: Center(
        child: IntrinsicWidth(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: CustomColors.secondary500,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  _navigationItems.length,
                  (index) => NavigationItem(
                    icon: _navigationItems[index]['icon'],
                    label: _navigationItems[index]['label'],
                    isActive: index == _selectedIndex,
                    onTap: () => _onItemTapped(index),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
