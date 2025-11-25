// ignore_for_file: unnecessary_const, avoid_unnecessary_containers
import 'package:MovieList/components/bottom_navbar.dart';
import 'package:MovieList/pages/account.dart';
import 'package:MovieList/pages/homepage.dart';
import 'package:MovieList/pages/listpage.dart';
import 'package:MovieList/pages/search.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentindex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      currentindex = index;
    });
  }

  final List<Widget> pages = [
    const Homepage(),
    const SearchPage(),
    const ListPage(),
    const AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF1C1C2E),
        title: const Text(
          'MovieLovr.',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white70,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        leading: Opacity(
            opacity: 0.7,
          child: Image.asset(
            'assets/images/Movielist_logo.png',
            height: 30,
            width: 30,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 8,
            ),
          ],
        ),
        child: BottomNavbar(
          onTabChange: (index) => navigateBottomBar(index),
        ),
      ),
      body: pages[currentindex],
    );
  }
}
