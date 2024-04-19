import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:proyecto/Partidos.dart';
import 'registro.dart';
import 'aviso.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(LoginPage());
}

class LoginPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    final url = Uri.parse('http://192.168.100.53:8080/api/auth');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': emailController.text,
        'password': passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      // Aquí puedes manejar la respuesta del servidor si el inicio de sesión es exitoso
      // Por ejemplo, puedes navegar a la siguiente pantalla
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NextScreen()),
      );
    } else {
      // Aquí puedes manejar la respuesta del servidor si el inicio de sesión falla
      // Por ejemplo, mostrar un mensaje de error al usuario
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error en el inicio de sesión')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            // Fondo de imagen
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('resources/fondo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Contenido de la página
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Espacio para el logo o título
                      Text(
                        'GOAL',
                        style: TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 70.0),
                      // Campos de texto para correo y contraseña
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
                      // Botón de iniciar sesión
                      ElevatedButton(
                        onPressed: () {
                          login(context);
                        },
                        child: Text('Iniciar Sesión'),
                      ),
                      SizedBox(height: 20.0),
                      // Botón de registro
                      Text(
                        '¿Eres nuevo? ¡Regístrate aquí!',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()),
                          );
                        },
                        child: Text('¡Regístrate!'),
                      ),
                      SizedBox(height: 280),
                      Container(
                        margin: EdgeInsets.only(
                          left: 25,
                          right: 25,
                          top: 20,
                          bottom: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                        ),
                        child: InkWell(
                          onTap: () {
                            // Aquí puedes navegar a la pantalla de aviso de privacidad
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AvisoPrivacidadPage()),
                            );
                          },
                          child: Text(
                            'Aviso de Privacidad',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: const Color.fromARGB(255, 10, 98, 170)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GOAL",
      home: PartidosScreen(),
    );
  }
}
