import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyecto/src/abstract/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:proyecto/src/abstract/match_row.dart';
import 'package:proyecto/src/pages/match_spectator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MatchListComponent extends StatefulWidget {
  @override
  _MatchListComponentState createState() => _MatchListComponentState();
}

class _MatchListComponentState extends State<MatchListComponent> {
  List<MatchRow> Torneos = [];

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    String apiUrl = dotenv.env['BACKEND_ENDPOINT']!;
    String? token = await AuthService.getToken();
    if (token == null) {
      print('No se encontró ningún token guardado.');
      return;
    }
    int? iduser = await AuthService.getIdUser();

    print('$apiUrl/user/${iduser}/event');
    final response = await http.get(
      Uri.parse('$apiUrl/user/${iduser}/event'),
      headers: {
        'Accept': '*/*',
        'authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final dynamic jsonData = jsonDecode(response.body);
      print('si esta habil el token');
      if (jsonData.containsKey('events') && jsonData['events'] is List) {
        setState(() {
          Torneos = (jsonData['events'] as List)
              .map((x) => MatchRow(
                    id: x['id'].toString(),
                    nombre: x['name'],
                    fecha: x['createdAt'],
                    idTable: "",
                  ))
              .toList();
        });
      } else {
        // Manejar el caso donde 'events' no está presente o no es una lista
        print('La respuesta no contiene una lista de Torneos válida.');
      }
    } else if (response.statusCode == 401) {
      print('volver a iniciar sesion automaticamente');
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      String? email = await AuthService.getEmail();
      String? password = await AuthService.getPassword();
      final String apiUrl = dotenv.env['BACKEND_ENDPOINT']!;
      final url = Uri.parse('$apiUrl/auth');

      try {
        final response = await http.post(
          url,
          body: json.encode({
            'email': email,
            'password': password,
          }),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          String token = responseData['token'];

          // Guardar el token en SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('token', token);
          print('Token: $token');
          // Redirigir a la página Torneos.dart
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MatchSpectatorPage(),
            ),
          );
        }
      } catch (e) {
        print('Error: $e');
      }
    } else {
      // Mostrar un mensaje de error si la solicitud falla
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Theres no  Torneos'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Torneos.length,
      itemBuilder: (context, index) {
        final Partido = Torneos[index];
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

class ExpandedList extends StatefulWidget {
  final MatchRow partido;

  ExpandedList({required this.partido});

  @override
  _ExpandedListState createState() => _ExpandedListState();
}

class _ExpandedListState extends State<ExpandedList> {
  List<MatchRow> partidos = [];

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
      Uri.parse('$apiUrl/match/'),
      headers: {
        'Accept': '*/*',
        'authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final dynamic jsonData = jsonDecode(response.body);
      print('si esta habil el token');
      if (jsonData.containsKey('match') && jsonData['match'] is List) {
        setState(() {
          partidos = (jsonData['match'] as List)
              .map((x) => MatchRow(
                    id: x['id'].toString(),
                    nombre: "",
                    fecha: x['start_date'],
                    idTable: x['fk_event'].toString(),
                  ))
              .toList();
        });
        print(partidos[0].fecha);
      } else {
        // Manejar el caso donde 'match' no está presente o no es una lista
        print('La respuesta no contiene una lista de partidos válida.');
      }
    } else if (response.statusCode == 401) {
      // Lógica para manejar error de autenticación
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
        title: Text('TORNEO ${widget.partido.id}'),
      ),
      body: ListView.builder(
          itemCount: partidos.length,
          itemBuilder: (context, index) {
            final partido = partidos[index];
            if (widget.partido.id == partido.idTable) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 2,
                  child: ListTile(
                    title: Text(
                      'Partido ${partido.id}',
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MatchDetail(partido: partido),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
          }),
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
        title: Text('Detalles del Partido'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Text(
              'Nombre del Partido: ${partido.id}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Fecha: ${(partido.fecha).toString().substring(0, 10)}',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Hora: ${(partido.fecha).toString().substring(11, 16)}',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lógica para participar en el partido
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchSpectatorPage()),
                );
              },
              child: Text(
                'Cerrar',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
