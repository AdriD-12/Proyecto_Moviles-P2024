import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyecto/shared_preferences.dart';

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
    String? token = await AuthService.getToken();
    if (token == null) {
      print('No se encontró ningún token guardado.');
      return;
    }

    final response = await http.get(
      Uri.parse('http://192.168.50.29:8080/api/event'),
      headers: {
        'Authorization':
            'Bearer Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJWaW9sZXQuRGFuaWVsMTdAeWFob28uY29tIiwiZmlyc3RfbmFtZSI6IlJpY2FyZG8iLCJsYXN0X25hbWUiOiJOYXZhcnJvIiwiYmlydGhkYXkiOiIyMDIyLTAzLTE1VDAwOjAwOjAwLjAwMFoiLCJ1c2VyX3R5cGUiOiJ1c2VyIiwidXBkYXRlZEF0IjoiMjAyNC0wNC0xOVQyMDo1NTo0OC43MzFaIiwiY3JlYXRlZEF0IjoiMjAyNC0wNC0xOVQyMDo1NTo0OC43MzFaIiwiaWF0IjoxNzEzNTYwMTQ4LCJleHAiOjE3MTM1NjE5NDh9.S_93rib7v1NmNpzuj_atrStmT1tagwP5zq4ESh7WUZo',
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
          Text(
            'Nombre del Partido: ${partido.nombre}',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          Text(
            'Fecha del Partido: ${partido.fecha}',
            style: TextStyle(fontSize: 20),
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
