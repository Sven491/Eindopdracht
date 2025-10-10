import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:MovieList/pages/account.dart';
import 'package:MovieList/pages/homepage.dart';
import 'package:MovieList/pages/loginpage.dart';
import 'package:MovieList/pages/mainpage.dart';
import 'package:MovieList/pages/listpage.dart';
import 'package:MovieList/pages/search.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://tgngawbyutmabrogghlw.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRnbmdhd2J5dXRtYWJyb2dnaGx3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjAwMzM2MzUsImV4cCI6MjA3NTYwOTYzNX0.IFqM3-sB2_NgnlnOHxlL1uIed8BS9froouZZMHabXEU',
  );
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
      home: LoginPage(),
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