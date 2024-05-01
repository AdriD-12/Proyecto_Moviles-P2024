import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyecto/src/abstract/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:proyecto/src/abstract/match_row.dart';
import 'package:proyecto/src/pages/privacy.dart';

class MatchListComponent extends StatefulWidget {
  @override
  _MatchListComponentState createState() => _MatchListComponentState();
}

class _MatchListComponentState extends State<MatchListComponent> {
  List<MatchRow> Partidos = [];

  @override
  void initState() {
    super.initState();
    _fetchMatches();
  }

  Future<void> _fetchMatches() async {
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
        'authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final dynamic jsonData = jsonDecode(response.body);
      if (jsonData.containsKey('events') && jsonData['events'] is List) {
        setState(() {
          Partidos = (jsonData['events'] as List)
              .map((x) => MatchRow(
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
    return ListView.builder(
      itemCount: Partidos.length,
      itemBuilder: (context, index) {
        final Partido = Partidos[index];
        return ListTile(
          title: Text(
              'ID: ${Partido.id}, Nombre: ${Partido.nombre}, Fecha: ${Partido.fecha}'),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MatchDetail(partido: Partido),
              ),
            );
          },
        );
      },
    );
  }
}

class MatchDetail extends StatelessWidget {
  final MatchRow partido;

  MatchDetail({required this.partido});

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
                MaterialPageRoute(builder: (context) => PrivacyPage()),
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
