// ignore_for_file: prefer_final_fields

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:la_restaurant/data/api/api_service.dart';
import 'package:la_restaurant/resto_provider.dart';
import 'package:la_restaurant/ui/food_list_page.dart';
import 'package:la_restaurant/ui/profile_page.dart';
import 'package:la_restaurant/widgets/platform_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;
  List<Widget> _listWidget = [
    ChangeNotifierProvider(
      create: (context) => RestoProvider(apiService: ApiService()),
      child: FoodListPage(),
    ),
    ProfilePage()
  ];

  List<BottomNavigationBarItem> bottomNavBarItem = [
    BottomNavigationBarItem(
        icon: Icon(Platform.isIOS ? CupertinoIcons.home : Icons.home),
        label: 'home'),
    BottomNavigationBarItem(
        icon: Icon(Platform.isIOS ? CupertinoIcons.person : Icons.person),
        label: 'profile')
  ];

  void _onBottomNavBarTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _bottomNavIndex,
          items: bottomNavBarItem,
          onTap: _onBottomNavBarTapped),
    );
  }

  Widget _buildIOS(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: bottomNavBarItem,
        ),
        tabBuilder: (context, index) {
          return _listWidget[index];
        });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIOS);
  }
}
