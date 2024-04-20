import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:proyecto/aviso_confirmacion.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  runApp(MyApp());
}

class Partido {
  final String id;
  final String nombre;
  final String fecha;

  Partido({
    required this.id,
    required this.nombre,
    required this.fecha,
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Partidos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PartidosScreen(),
    );
  }
}

class PartidosScreen extends StatefulWidget {
  @override
  _PartidosScreenState createState() => _PartidosScreenState();
}

class _PartidosScreenState extends State<PartidosScreen> {
  List<Partido> Partidos = [];

  @override
  void initState() {
    super.initState();
    _fetchPartidos();
  }

  Future<void> _fetchPartidos() async {
    String apiUrl = dotenv.env['BACKEND_ENDPOINT']!;
    String? token = await AuthService.getToken();
    if (token == null) {
      print('No se encontró ningún token guardado.');
      return;
    }

    final response = await http.get(
      Uri.parse('$apiUrl/event'),
      headers: {
        'Accept': '*/*',
        'jwt': '$token',
      },
    );

    if (response.statusCode == 200) {
      final dynamic jsonData = jsonDecode(response.body);
      if (jsonData.containsKey('events') && jsonData['events'] is List) {
        setState(() {
          Partidos = (jsonData['events'] as List)
              .map((x) => Partido(
                    id: x['id'].toString(),
                    nombre: x['name'],
                    fecha: x['start_date'],
                  ))
              .toList();
        });
      } else {
        // Manejar el caso donde 'events' no está presente o no es una lista
        print('La respuesta no contiene una lista de Partidos válida.');
      }
    } else {
      // Mostrar un mensaje de error si la solicitud falla
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load Partidos'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Partidos'),
      ),
      body: ListView.builder(
        itemCount: Partidos.length,
        itemBuilder: (context, index) {
          final Partido = Partidos[index];
          return ListTile(
            title: Text(
                'ID: ${Partido.id}, Nombre: ${Partido.nombre}, Fecha: ${Partido.fecha}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetallePartidoScreen(partido: Partido),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetallePartidoScreen extends StatelessWidget {
  final Partido partido;

  DetallePartidoScreen({required this.partido});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle del Partido'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Text(
            'ID del Partido: ${partido.id}',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // L�gica para participar en el partido
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AvisoConfirmPage()),
              );
            },
            child: Text('Participar'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Lógica para participar en el Partido
            },
            child: Text('Participar'),
          ),
        ],
      ),
    );
  }
}
