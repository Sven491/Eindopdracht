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
    const Listpage(),
    const Search(),
    const Account(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
        /* drawer: Drawer(
        child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Movielist_logo.png'),
              fit: BoxFit.cover,
            ),
          ), 
          child: null,
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
            Navigator.pushNamed(context, '/home');
            Navigator.pop(context);},
          ),
          ListTile(
            title: const Text('Watchlist'),
            onTap: () {
            Navigator.pushNamed(context, '/list');
            Navigator.pop(context);},
          ),
          ListTile(
            title: const Text('account'),
            onTap: () {
            Navigator.pushNamed(context, '/account');
            Navigator.pop(context);},
          ),
        ],
      ),
    ), */
      appBar: AppBar(title: Text('Home'),),
      bottomNavigationBar: BottomNavbar(
        onTabChange: (index) => navigateBottomBar(index),
      ),    
      body: pages[currentindex],
    );
  }
  }