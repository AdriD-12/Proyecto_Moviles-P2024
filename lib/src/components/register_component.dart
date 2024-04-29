import 'package:flutter/material.dart';
import 'package:proyecto/src/pages/declaration.dart';
import 'package:proyecto/src/pages/login.dart';

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
  final _nombreController = TextEditingController();
  final _apellidoPaternoController = TextEditingController();
  final _apellidoMaternoController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _generoController = TextEditingController();
  final _fechaNacimientoController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? true) {
      print('Información almacenada');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('El usuario ha sido generado.'),
          backgroundColor: Colors.green,
        ),
      );
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
              controller: _nombreController,
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
              controller: _apellidoPaternoController,
              decoration: InputDecoration(
                labelText: 'Apellido Paterno',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _apellidoMaternoController,
              decoration: InputDecoration(
                labelText: 'Apellido Materno',
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
              controller: _generoController,
              decoration: InputDecoration(
                labelText: 'Género',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _fechaNacimientoController,
              decoration: InputDecoration(
                labelText: 'Fecha de Nacimiento',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
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
            SizedBox(height: 20),
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
          ],
        ),
      ),
    );
  }
}
