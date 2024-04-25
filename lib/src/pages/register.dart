import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'declaration.dart';
import 'login.dart'; // Importa el archivo login.dart

void main() async {
  print("Open Register");
  await dotenv.load(fileName: ".env");
  runApp(RegisterPage());
}

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Registro'),
        ),
        body: RegisterComponent(),
      ),
    );
  }
}
