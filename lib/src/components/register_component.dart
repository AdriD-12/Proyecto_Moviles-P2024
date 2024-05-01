import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:proyecto/src/pages/dashboard.dart';
import 'package:proyecto/src/pages/declaration.dart';
import 'package:proyecto/src/pages/login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RegisterComponent extends StatelessWidget {
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
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 20),
          Text(
            '¡Regístrate para comenzar!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Expanded(
            child: RegisterForm(),
          ),
        ],
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _declarationCheck = false;

  _register(BuildContext context) async {
    final String apiUrl = dotenv.env['BACKEND_ENDPOINT']!;
    final url = Uri.parse('$apiUrl/register');

    if (!(_formKey.currentState?.validate() ?? false)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Datos ingresados no v�lidos'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!_declarationCheck) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Favor de aceptar t�rminos y condiciones'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'email': _emailController.text,
          'password': _passwordController.text,
          'first_name': _firstnameController.text,
          'last_name': _lastnameController.text,
          'birthday': _birthdayController.text
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        String token = responseData['token'];

        // Guardar el token en SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);

        print('Token: $token');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('El usuario ha sido generado.'),
            backgroundColor: Colors.green,
          ),
        );
        // Redirigir a la página Partidos.dart
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardPage(),
          ),
        );
      } else if (response.statusCode == 400) {
        // Mostrar un mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Datos ingresados no v�lidos'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        print('Failed to register: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _firstnameController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Por favor ingresa tu nombre';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _lastnameController,
              decoration: InputDecoration(
                labelText: 'Apellido Paterno',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Correo Electrónico',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Por favor ingresa tu correo electrónico';
                }
                // Puedes agregar más validaciones para el formato del correo electrónico si lo deseas
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              obscureText: true,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Por favor ingresa tu contraseña';
                }
                // Puedes agregar más validaciones para la fortaleza de la contraseña si lo deseas
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirmar Contraseña',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              obscureText: true,
              validator: (value) {
                if (value != _passwordController.text) {
                  return 'Las contraseñas no coinciden';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _birthdayController,
              decoration: InputDecoration(
                labelText: 'Fecha de Nacimiento',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            Checkbox(
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.all(Colors.green),
              value: _declarationCheck,
              onChanged: (bool? value) {
                setState(() {
                  _declarationCheck = value ?? false;
                });
              },
            ),
            InkWell(
              onTap: () {
                // Navegar a la pantalla de aviso de privacidad
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DeclarationPage()),
                );
              },
              child: Text(
                'Aviso de Privacidad',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _register(context),
              child: Text('Aceptar'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla de inicio de sesión
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Volver a Iniciar Sesión'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.grey[600],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
