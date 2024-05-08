import 'package:flutter/material.dart';
import 'package:proyecto/src/components/notification_manager.dart';

class CourtsSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Fields'),
      ),
      body: Stack(
        children: [
          // Fondo de la fotografía
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'resources/fondoCanchasIteso.png'), // Ruta de tu fotografía
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Cuadros con números
          Positioned(
            top: 220, // Puedes ajustar estas coordenadas según tu preferencia
            left: 230,
            child: NumberBox(1),
          ),
          Positioned(
            top: 550,
            left: 110,
            child: NumberBox(2),
          ),
          Positioned(
            top: 550,
            left: 300,
            child: NumberBox(3),
          ),
          Positioned(
            top: 550,
            left: 200,
            child: NumberBox(4),
          ),
        ],
      ),
    );
  }
}

class NumberBox extends StatelessWidget {
  final int numero;

  NumberBox(this.numero);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Mostrar un diálogo de confirmación
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Confirm'),
              content: Text('Are you sure you want to select the box $numero?'),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Confirm'),
                  onPressed: () {
                    print("Notification");
                    NotificationManager.showNotification(
                      title: 'HI!',
                      body: 'This is a test notification.',
                    );
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      child: Container(
        width: 50,
        height: 50,
        color: Colors.white.withOpacity(0.5), // Color semi-transparente
        child: Center(
          child: Text(
            numero.toString(),
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
