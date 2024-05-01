import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:proyecto/src/components/login_component.dart';
import 'package:proyecto/src/pages/dashboard.dart'; // Importa la página principal

import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  final prefs = await SharedPreferences.getInstance();
  final String? token = prefs
      .getString('token'); // Recupera el token de las preferencias compartidas

  runApp(Goal(token: token)); // Pasa el token a la aplicación
}

class Goal extends StatelessWidget {
  final String? token;

  const Goal({this.token});

  @override
  Widget build(BuildContext context) {
    if (token != null) {
      // Si hay un token almacenado, redirige directamente a la página principal
      return MaterialApp(
        title: "GOAL",
        home: DashboardPage(),
      );
    } else {
      // Si no hay un token almacenado, redirige a la pantalla de inicio de sesión
      return MaterialApp(
        title: "GOAL",
        home: LoginComponent(),
      );
    }
  }
}
