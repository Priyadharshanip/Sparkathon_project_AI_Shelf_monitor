import 'package:flutter/material.dart';
import 'pages/welcome_page.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/admin_home_page.dart';

void main() {
  runApp(SmartShelfApp());
}

class SmartShelfApp extends StatelessWidget {
  const SmartShelfApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartShelf',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomePage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/admin': (context) => AdminHomePage(),
      },
    );
  }
}