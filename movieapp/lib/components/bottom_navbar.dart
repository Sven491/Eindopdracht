// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:amicons/amicons.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavbar extends StatelessWidget{
  void Function(int)? onTabChange;
  BottomNavbar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GNav(
        color: Colors.grey[400],
        activeColor: Colors.grey.shade700,
        tabActiveBorder: Border.all(color: Colors.white),
        tabBackgroundColor: Colors.grey.shade100,
        mainAxisAlignment: MainAxisAlignment.center,
        tabBorderRadius: 10,
        onTabChange: (value) => onTabChange!(value),
        tabs: const[
        GButton(icon: Amicons.iconly_home_fill, text: 'Home'),
        GButton(icon: Amicons.iconly_search_fill, text: 'Search'),
        GButton(icon: Amicons.iconly_bookmark_fill, text: 'Watchlist'),
        GButton(icon: Amicons.iconly_user_2_fill, text: 'Account'),
      ]
      ),
    );
  }
}  