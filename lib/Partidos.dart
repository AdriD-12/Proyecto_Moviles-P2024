import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:proyecto/constants.dart';

void main() {
  runApp(MyApp());
}

// Clase para representar un partido
class Partido {
  final String id;
  final String time;
  final int idGroup1;
  final int idGroup2;
  final String idPlace;

  Partido({
    required this.id,
    required this.time,
    required this.idGroup1,
    required this.idGroup2,
    required this.idPlace,
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

class PartidosScreen extends StatelessWidget {
  final List<Partido> partidos = _parsePartidos();

  static List<Partido> _parsePartidos() {
    final jsonData = jsonDecode(CATALOGO_PARTIDOS);
    return List<Partido>.from(jsonData.map((x) => Partido(
          id: x['id'],
          time: x['time'],
          idGroup1: x['id_group1'],
          idGroup2: x['id_group2'],
          idPlace: x['id_place'],
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 
          Text('Partidos',
          //textAlign: Center(),
            style: TextStyle(color: 
                      Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 25)
          ),
        backgroundColor: Colors.green[700],
      ),
      body: ListView.builder(
        itemCount: partidos.length,
        itemBuilder: (context, index) {
          final partido = partidos[index];
          return ListTile(
            title: Text('ID: ${partido.id}, Hora: ${partido.time}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetallePartidoScreen(partido: partido),
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
              // Lógica para participar en el partido
            },
            child: Text('Participar'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Lógica para ver el partido
            },
            child: Text('Ver'),
          ),
        ],
      ),
    );
  }
}