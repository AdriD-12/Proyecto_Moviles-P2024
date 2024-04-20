import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:proyecto/Partidos.dart';
import 'package:proyecto/shared_preferences.dart';
import 'registro.dart';
import 'aviso.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    home: LoginPage(),
  ));
}

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          _buildContent(context),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('resources/fondo.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'GOAL',
                style: TextStyle(fontSize: 80, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 70.0),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Correo',
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.5),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Contraseña',
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.5),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () => _login(context),
                child: Text('Iniciar Sesion'),
              ),
              SizedBox(height: 20.0),
              Text(
                '¿Eres nuevo? ¡Registrate aqui!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: Text('¡Registrate!'),
              ),
              SizedBox(height: 280),
              _buildPrivacyPolicyLink(context),
            ],
          ),
        ),
      ),
    );
  }

  _login(BuildContext context) async {
    final url = Uri.parse('http://192.168.50.29:8080/api/auth');

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'email': emailController.text,
          'password': passwordController.text,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        String token = jsonResponse['token'];

        // Guardar el token en SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);
        String? tokent = await AuthService.getToken();

        if (tokent != null) {
          print('El token guardado es: $tokent');
        } else {
          print('No se encontró ningún token guardado.');
        }

        print('Token: $token');
        // Redirigir a la página Partidos.dart
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PartidosScreen()),
        );
      } else if (response.statusCode == 400) {
        // Mostrar un mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error en el correo o contraseña'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        print('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Widget _buildPrivacyPolicyLink(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AvisoPrivacidadPage()),
          );
        },
        child: Text(
          'Aviso de Privacidad',
          textAlign: TextAlign.center,
          style: TextStyle(color: const Color.fromARGB(255, 10, 98, 170)),
        ),
      ),
    );
  }
}
