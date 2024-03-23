import 'package:flutter/material.dart';
import 'aviso.dart';

void main() {
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
        body: RegisterForm(),
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
      // Aquï¿½ puedes almacenar la informaciï¿½n en tu base de datos o realizar cualquier otra acciï¿½n necesaria
      print('Informaciï¿½n almacenada');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          TextFormField(
            controller: _nombreController,
            decoration: InputDecoration(labelText: 'Nombre'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Por favor ingresa tu nombre';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _apellidoPaternoController,
            decoration: InputDecoration(labelText: 'Apellido Paterno'),
          ),
          TextFormField(
            controller: _apellidoMaternoController,
            decoration: InputDecoration(labelText: 'Apellido Materno'),
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Correo Electrï¿½nico'),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Por favor ingresa tu correo electrï¿½nico';
              }
              // Puedes agregar mï¿½s validaciones para el formato del correo electrï¿½nico si lo deseas
              return null;
            },
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Contraseï¿½a'),
            obscureText: true,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Por favor ingresa tu contraseï¿½a';
              }
              // Puedes agregar mï¿½s validaciones para la fortaleza de la contraseï¿½a si lo deseas
              return null;
            },
          ),
          TextFormField(
            controller: _confirmPasswordController,
            decoration: InputDecoration(labelText: 'Confirmar Contraseña'),
            obscureText: true,
            validator: (value) {
              if (value != _passwordController.text) {
                return 'Las contraseñas no coinciden';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _generoController,
            decoration: InputDecoration(labelText: 'Género'),
          ),
          TextFormField(
            controller: _fechaNacimientoController,
            decoration: InputDecoration(labelText: 'Fecha de Nacimiento'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text('Aceptar'),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  Colors.green, // Cambia el color de fondo del botï¿½n a verde
            ),
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () {
              // Navegar a la pantalla de aviso de privacidad
              Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AvisoPrivacidadPage()),
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
    );
  }
}
