// ignore_for_file: prefer_final_fields

import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:la_restaurant/data/api/api_service.dart';
import 'package:la_restaurant/data/providers/resto_provider.dart';
import 'package:la_restaurant/style/color.dart';
import 'package:la_restaurant/ui/favorite_page.dart';
import 'package:la_restaurant/ui/food_list_page.dart';
import 'package:la_restaurant/ui/profile_page.dart';
import 'package:la_restaurant/widgets/platform_widget.dart';
import 'package:provider/provider.dart';

import 'setting_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;

  List<Widget> _listWidget = [
    FoodListPage(),
    FavoritePage(),
    SettingPage(),
  ];

  List<Widget> bottomNavBarItem = [
    Icon(Platform.isIOS ? CupertinoIcons.home : Icons.home,
        color: Colors.white),
    Icon(
      Platform.isIOS ? CupertinoIcons.heart_fill : Icons.favorite,
      color: Colors.white,
    ),
    Icon(Platform.isIOS ? CupertinoIcons.settings : Icons.settings,
        color: Colors.white),
  ];

  void _onBottomNavBarTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _listWidget[_bottomNavIndex],
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: CurvedNavigationBar(
                color: kPrimaryColor,
                buttonBackgroundColor: kPrimaryColor,
                backgroundColor: Colors.transparent,
                height: 48,
                items: bottomNavBarItem,
                onTap: _onBottomNavBarTapped),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
        androidBuilder: _buildAndroid, iosBuilder: _buildAndroid);
  }
}
