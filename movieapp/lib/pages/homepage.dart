// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        drawer: Drawer(
        child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF551B14)),
            child: Center(
              child: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('movieapp\images\Movielist_logo.png'),  
                ),
          ),
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
    ),
      appBar: AppBar(title: Text('Home'),),
          body: Center(
            child: Row(
              children: [
                Container(
                   child: Column(
                     children: [
                       Text('Home Page'),
                     ],
                   )
                ),
              ],
            ),
          ),
        );
      }
    }