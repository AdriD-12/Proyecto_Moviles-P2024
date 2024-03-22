import 'package:flutter/material.dart';
import 'registro.dart';
import 'aviso.dart';

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
                      Text( 'GOAL',
                        style: TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.w500
                          ),
                        textAlign: TextAlign.center,
                      ),
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
                      Text('�Eres nuevo? �Reg�strate aqu�!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white
                          )),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterPage()),
                          );
                        },
                        child: Text('�Reg�strate!'),
                      ),
                      SizedBox(height: 280),
                      Container(
                        margin: EdgeInsets.only(
                          left: 25,
                          right: 25,
                          top: 20,
                          bottom: 20
                          ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                        ),
                        child:
                          InkWell(
                            onTap: () {
                              // Aqu� puedes navegar a la pantalla de aviso de privacidad
                              Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => AvisoPrivacidadPage()),
                              );
                            },
                            child: Text(
                              'Aviso de Privacidad',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color.fromARGB(255, 10, 98, 170)
                                ),
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

