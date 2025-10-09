import 'package:flutter/material.dart';

class Listpage extends StatefulWidget {
  const Listpage({super.key});

  @override
  State<Listpage> createState() => _ListpageState();
}

class _ListpageState extends State<Listpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List page'),
      ),
      body: const Center(
        child: Text('Welcome to the List Page!'),
      ),
    );
  }
}
