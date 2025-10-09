// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:MovieList/pages/account.dart';
import 'package:MovieList/pages/homepage.dart';
import 'package:MovieList/pages/mainpage.dart';
import 'package:MovieList/pages/listpage.dart';
import 'package:MovieList/pages/search.dart';
import 'package:flutter/material.dart';

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
      home: MainPage(),
      initialRoute: '/',
      routes: {
        '/main': (context) => MainPage(),
        '/home': (context) => Homepage(),
        '/list': (context) => Listpage(),
        '/account': (context) => Account(),
        '/search': (context) => Search(),
      },
    );
  }
}