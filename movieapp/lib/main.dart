import 'package:flutter/material.dart';
import 'package:movieapp/pages/homepage.dart';
import 'package:movieapp/pages/listpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,),
      home: const HomePage(),
      initialRoute: '/',
      routes: {
        '/home': (context) => const HomePage(),
        '/list': (context) => const Listpage(),
      },
    );
  }
}  