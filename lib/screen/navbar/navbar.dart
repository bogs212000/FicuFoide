// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:io';
import 'package:ficufoide/screen/home/home.page.dart';
import 'package:ficufoide/screen/results/result.dart';
import 'package:flutter/material.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';

import '../food/food.add.dart';
import '../profile/profilepage.dart';
class NavBar extends StatefulWidget {
  NavBar({Key? key,}) : super(key: key);
  static String id = "NavBar";
  bool loading = false;
  @override
  State<NavBar> createState() => _NavBarState();
}


class _NavBarState extends State<NavBar> {
  static final List<Widget> _myPages = <Widget>[
    Home(),
    ProfilePage(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _myPages[_selectedIndex],
      bottomNavigationBar: FlashyTabBar(
      selectedIndex: _selectedIndex,
      showElevation: true,
      onItemSelected: (index) => setState(() {
        _selectedIndex = index;
      }),
      items: [
        FlashyTabBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        FlashyTabBarItem(
          icon: Icon(Icons.person),
          title: Text('Profile'),
        ),
      ],
    ),
    );
  }
}