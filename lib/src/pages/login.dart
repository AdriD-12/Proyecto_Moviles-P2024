import 'package:flutter/material.dart';
import 'package:proyecto/src/components/login_component.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Check if this is required
void main() async {
  print("Open Login");
  await dotenv.load(fileName: ".env"); // Load .env file
  runApp(LoginPage());
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: LoginComponent(),
      ),
    );
  }
}
