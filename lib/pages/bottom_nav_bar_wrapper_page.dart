import 'package:flutter/material.dart';

import '../pages/bottom_nav_bar_page.dart';

class BottomNavBarPageWrapper extends StatefulWidget {
  static const String routeName = '/home';
  @override
  _BottomNavBarPageWrapperState createState() => _BottomNavBarPageWrapperState();
}

class _BottomNavBarPageWrapperState extends State<BottomNavBarPageWrapper> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
          return false;
        } else {
          return true;
        }
      },
      child: BottomNavBarPage(
        currentIndex: _currentIndex,
        onIndexChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
