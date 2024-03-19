import 'package:flutter/material.dart';

void main() {
  runApp(LoginPage());
}

class LoginPage extends StatelessWidget {
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
                      // Aquí puedes añadir un logo o un título si lo deseas
                      SizedBox(height: 100.0),
                      // Campos de texto para correo y contraseña
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Correo',
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.5),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
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
                          // Aquí puedes agregar la lógica para iniciar sesión
                        },
                        child: Text('Iniciar Sesión'),
                      ),
                      SizedBox(height: 20.0),
                      // Botón de registro
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegistroPage()),
                          );
                        },
                        child: Text('¿Eres nuevo? ¡Regístrate aquí!',
                          style: TextStyle(
                            color: Colors.white
                          )),
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

class RegistroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Center(
        child: Text('Página de Registro'),
      ),
    );
  }
}
