import 'package:flutter/material.dart';
import 'package:proyecto/src/pages/login.dart';
import 'package:proyecto/src/pages/register.dart';

class DeclarationComponent extends StatelessWidget {
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
                'Privacy Notice',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Version: Minimum Viable Product - It is recommended to read the following privacy notice before starting to use the application www.privacynotice.com - For more information about the use of the app or any issues with it, please contact the event staff, they will provide you with the information you require. -Thank you for using the application =D - By pressing accept, you are stating that you have read and accepted the Terms of Use and Conditions, which can be found at www.privacynotice.com',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Navegar a la p�gina de registro
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: Text('Close'),
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
