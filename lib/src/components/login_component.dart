import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto/src/pages/dashboard.dart';
import 'package:proyecto/src/pages/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginComponent extends StatelessWidget {
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
              SizedBox(height: 50.0),
              Image.asset(
                'resources/goalLogo.png',
                height: 300,
                width: 200,
              ),
              SizedBox(height: 30.0),
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  'Welcome to GOAL',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30.0),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () => _login(context),
                child: Text('Login'),
              ),
              SizedBox(height: 20.0),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: Text(
                  'Are you new? Register here!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _login(BuildContext context) async {
    final String apiUrl = dotenv.env['BACKEND_ENDPOINT']!;
    final url = Uri.parse('$apiUrl/auth');
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
        final responseData = json.decode(response.body);
        String token = responseData['token'];

        int userId = responseData['user']['id'];

        // Guardar el token en SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);

        // Guardar email y password
        SharedPreferences prefsEandP = await SharedPreferences.getInstance();
        prefsEandP.setString('email', emailController.text);
        prefsEandP.setString('password', passwordController.text);
        prefsEandP.setInt('id', userId);

        print('Token: $token');
        // Redirigir a la página Partidos.dart
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardPage(),
          ),
        );
      } else if (response.statusCode == 400) {
        // Mostrar un mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('There is an error in the email or password.'),
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
}
