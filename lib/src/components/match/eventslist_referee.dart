import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyecto/src/abstract/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:proyecto/src/abstract/match_row.dart';
import 'package:proyecto/src/components/match/match_referee.dart';

class EventsListRefereeComponent extends StatefulWidget {
  @override
  _EventsListRefereeComponentState createState() =>
      _EventsListRefereeComponentState();
}

class _EventsListRefereeComponentState
    extends State<EventsListRefereeComponent> {
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
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 2,
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: ListTile(
              title: Center(
                child: Text(
                  'TORNEO ${Partido.id}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              subtitle: Text(
                'Nombre: ${Partido.nombre}\nFecha: ${(Partido.fecha).toString().substring(0, 10)}\nHora: ${(Partido.fecha).toString().substring(11, 16)}',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ExpandedList(partido: Partido),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class ExpandedList extends StatelessWidget {
  final MatchRow partido;

  ExpandedList({required this.partido});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TORNEO ${partido.id}'),
      ),
      body: ListView.builder(
        itemCount: 3, // Número de componentes más pequeños que deseas mostrar
        itemBuilder: (context, index) {
          // Aquí construyes tus componentes más pequeños
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 2,
              child: ListTile(
                title: Text(
                    'Partido $index'), // Texto de ejemplo, puedes personalizarlo
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MatchReferee(partido: partido),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
