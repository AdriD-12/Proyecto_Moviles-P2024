import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:proyecto/src/components/login_component.dart';

Future main() async {
  print("Open Main Goal");
  await dotenv.load(fileName: ".env");
  runApp(Goal());
}

class Goal extends StatelessWidget {
  const Goal();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GOAL",
      home: LoginComponent(),
    );
  }
}
