import 'package:flutter/material.dart';
import 'package:proyecto/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GOAL",
      home: LoginPage(),
    );
  }
}
