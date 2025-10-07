import 'package:flutter/material.dart';

class Listpage extends StatelessWidget {
  const Listpage({super.key});

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
