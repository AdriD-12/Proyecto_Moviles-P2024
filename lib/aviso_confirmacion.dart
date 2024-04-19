import 'package:flutter/material.dart';
import 'registro.dart';

void main() {
  runApp(AvisoConfirmPage());
}

class AvisoConfirmPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: AvisoPrivacidadScreen(),
      ),
    );
  }
}

class AvisoPrivacidadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Fondo de la imagen
        Image.asset(
          'resources/fondo.png', // Ajusta la ruta de la imagen seg�n su ubicaci�n en tu proyecto
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        // Contenedor blanco para el texto del aviso de privacidad
        Container(
          color: Colors.white
              .withOpacity(0.8), // Opacidad para que se vea la imagen de fondo
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Aviso de Privacidad',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Version: Minimo Producto Viable - Se recomienda leer el siguiente aviso de privacidad antes de empezar a usar la aplicacion www.avisoprivacidad.com - Para mas informacion sobre el uso de la app o algun error de la misma favor de comunicarse con el staff del evento, el le dara la informacion que usted requiera. -Gracias por utilizar la aplicacion =D - A presionar aceptar, esta diciendo que a leido y ????a los Terminos de Uso y Condiciones, estas se pueden encontrar en www.avisoprivacidad.com ',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Navegar a la p�gina de registro
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: Text('Aceptar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/*
class RegisterPage extends StatelessWidget {
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
*/