import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'pages/login/login_page.dart';

void main() {
  runApp(const MyApp());
}

final routes = {
  '/': (BuildContext context) => const LoginPage(),
  '/home': (BuildContext context) => const HomePage(),
};

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sqflite App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: routes,
    );
  }
}
