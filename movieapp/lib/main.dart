// ignore_for_file: unnecessary_import

import 'package:flutter/rendering.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:MovieList/pages/account.dart';
import 'package:MovieList/pages/homepage.dart';
import 'package:MovieList/pages/loginpage.dart';
import 'package:MovieList/pages/mainpage.dart';
import 'package:MovieList/pages/listpage.dart';
import 'package:MovieList/pages/search.dart';
import 'package:MovieList/pages/detailpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://tgngawbyutmabrogghlw.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRnbmdhd2J5dXRtYWJyb2dnaGx3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjAwMzM2MzUsImV4cCI6MjA3NTYwOTYzNX0.IFqM3-sB2_NgnlnOHxlL1uIed8BS9froouZZMHabXEU',
    headers: {'Content-Type': 'application/json;charset=UTF-8', 'api-key': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRnbmdhd2J5dXRtYWJyb2dnaGx3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjAwMzM2MzUsImV4cCI6MjA3NTYwOTYzNX0.IFqM3-sB2_NgnlnOHxlL1uIed8BS9froouZZMHabXEU'},
  );
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    final session = Supabase.instance.client.auth.currentSession;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF121212),
        useMaterial3: true,),
        // Check of ingelogde sessie aanwezig is -> anders naar inlogpagina
      home: session != null ? const MainPage() : const LoginPage(),
      initialRoute: '/',
      routes: {
        '/main': (context) => MainPage(),
        '/home': (context) => Homepage(),
        '/list': (context) => ListPage(),
        '/account': (context) => AccountPage(),
        '/search': (context) => SearchPage(),
        '/detail': (context) => Detailpage(),
      },
    );
  }
}