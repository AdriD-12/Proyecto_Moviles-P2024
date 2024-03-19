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
            // Contenido de la p�gina
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Espacio para el logo o t�tulo
                      // Aqu� puedes a�adir un logo o un t�tulo si lo deseas
                      SizedBox(height: 100.0),
                      // Campos de texto para correo y contrase�a
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
                          hintText: 'Contrase�a',
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.5),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      // Bot�n de iniciar sesi�n
                      ElevatedButton(
                        onPressed: () {
                          // Aqu� puedes agregar la l�gica para iniciar sesi�n
                        },
                        child: Text('Iniciar Sesi�n'),
                      ),
                      SizedBox(height: 20.0),
                      // Bot�n de registro
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegistroPage()),
                          );
                        },
                        child: Text('�Eres nuevo? �Reg�strate aqu�!',
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
        child: Text('P�gina de Registro'),
      ),
    );
  }
}
