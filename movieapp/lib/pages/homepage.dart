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
            title: const Text('Item 1'),
            onTap: () {

            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
            },
          ),
        ],
      ),
    ),
      appBar: AppBar(title: Text('Home Page poep'),),
          body: Center(
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.list),
                  onPressed:() {
                    Navigator.pushNamed(context, '/list');
                  },
                ),

              ],
            ),
          ),
        );
      }
    }