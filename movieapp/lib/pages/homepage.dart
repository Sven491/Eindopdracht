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
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          ListTile(
            title: const Text('Watchlist'),
            onTap: () {
            Navigator.pushNamed(context, '/list');},
          ),
          ListTile(
            title: const Text('account'),
            onTap: () {
            Navigator.pushNamed(context, '/account');},
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