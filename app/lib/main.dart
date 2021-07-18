import 'package:doorbell/views/connect.dart';
import 'package:doorbell/views/login.dart';
import 'package:doorbell/views/register.dart';
import 'package:doorbell/views/startup.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'There are no accidents - Master Oogway',
      theme: ThemeData(
          colorScheme: ColorScheme(
              secondary: Color(0xFF3a506b),
              background: Color(0xFF0b132b),
              primaryVariant: Color(0xFF4B8895),
              primary: Color(0xFF5bc0be),
              secondaryVariant: Color(0xFF1c2541),
              error: Colors.red,
              onSurface: Colors.white,
              onError: Colors.white,
              onBackground: Colors.white,
              onPrimary: Colors.white,
              onSecondary: Colors.white,
              brightness: Brightness.dark,
              surface: Color(0xFF115792))),
      home: StartupPage(),
      debugShowCheckedModeBanner: false,
      routes: {
        'login': (_) => LoginPage(),
        'register': (_) => RegisterPage(),
        'addDevice': (_) => ConnectionPage(),
      },
    );
  }
}
