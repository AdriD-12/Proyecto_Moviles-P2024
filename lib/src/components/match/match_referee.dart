import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:proyecto/src/abstract/match_row.dart';
import 'package:proyecto/src/abstract/match_team_info.dart';
import 'package:proyecto/src/abstract/shared_preferences.dart';

class MatchReferee extends StatefulWidget {
  final MatchRow partido;

  MatchReferee({required this.partido});

  @override
  _MatchRefereeState createState() => _MatchRefereeState();
}

class _MatchRefereeState extends State<MatchReferee> {
  List<MatchTeamInfo> teams = [];
  int equipo1Counter = 0;
  int equipo2Counter = 0;
  bool isTimerRunning = false;
  late Timer _timer;
  int _seconds = 0; // Cambiar a la cantidad de tiempo deseada en segundos
  int _minutes = 60;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _matchReference();
    _getNameVisitor();
    _getNameLocal();
  }

  Future<void> _matchReference() async {
    String? apiUrl = dotenv.env['BACKEND_ENDPOINT']!;
    String? token = await AuthService.getToken();
    if (token == null) {
      print('No se encontró ningún token guardado.');
      return;
    }
    int? iduser = await AuthService.getIdUser();

    final response = await http.get(
      Uri.parse('$apiUrl/event/${widget.partido.idTable}/matches'),
      headers: {
        'Accept': '*/*',
        'authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print('si autoriza');
      final dynamic jsonData = jsonDecode(response.body);
      if (jsonData.containsKey('matches') && jsonData['matches'] is List) {
        setState(() {
          teams = (jsonData['matches'] as List)
              .map((x) => MatchTeamInfo(
                    id: x['id'].toString(),
                    score_local: x['score_local'].toString(),
                    score_visitor: x['score_visitor'].toString(),
                    goals_local: x['goals_local'].toString(),
                    goals_visitor: x['goals_visitor'].toString(),
                    end_date: x['end_date'].toString(),
                    fk_local: x['fk_local'].toString(),
                    fk_visitor: x['fk_visitor'].toString(),
                  ))
              .toList();
        });
      }
      /* final responseData = json.decode(response.body);


      int idPartie = responseData['matches']['fk_event'];
      if (idPartie.toString() == test) {
        print("si es igual");
      }*/
    }
    _FinishedGame();
  }

  Future<void> _FinishedGame() async {
    int id = int.parse(widget.partido.id);
    int index = teams.indexWhere((team) => team.id == id.toString());
    String tiempo = teams[index].end_date;
    int golVisitante = int.parse(teams[index].goals_visitor);
    int golLocal = int.parse(teams[index].goals_local);
    ;
    // Obtener la fecha y hora actual
    DateTime now = DateTime.now();

    // Convertir la fecha del partido a un objeto DateTime
    DateTime endTime = DateTime.parse(tiempo);

    // Verificar si el partido ya ha finalizado
    if (endTime.isBefore(now)) {
      isTimerRunning = true;
      equipo1Counter = golVisitante;
      equipo2Counter = golLocal;
    }
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (_seconds == 0) {
          if (_minutes == 0) {
            timer.cancel();
          } else {
            _minutes--;
            _seconds = 59;
          }
        } else {
          _seconds--;
        }
      });
    });
  }

  void pauseTimer() {
    _timer.cancel();
  }

  void finishGame() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("¿Quieres terminar el partido?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: Text("No"),
            ),
            TextButton(
              onPressed: () {
                pauseTimer(); // Detener el temporizador
                setState(() {
                  isTimerRunning = true;
                });
                _timer.cancel();
                Navigator.of(context).pop(); // Cerrar el diálogo
                // Mover el SnackBar al árbol de widgets del Scaffold
              },
              child: Text("Sí"),
            ),
          ],
        );
      },
    );
  }

  Future<String> _getNameVisitor() async {
    String? apiUrl = dotenv.env['BACKEND_ENDPOINT']!;
    String? token = await AuthService.getToken();

    int id = int.parse(widget.partido.id);
    int index = teams.indexWhere((team) => team.id == id.toString());

    if (index != -1) {
      print('$apiUrl/team/${teams[index].id}');

      final response = await http.get(
        Uri.parse('$apiUrl/team/${teams[index].fk_visitor}'),
        headers: {
          'Accept': '*/*',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        String name = responseData['team']['name'];
        return name;
      }
    }
    return 'Null';
  }

  Future<String> _getNameLocal() async {
    String? apiUrl = dotenv.env['BACKEND_ENDPOINT']!;
    String? token = await AuthService.getToken();

    int id = int.parse(widget.partido.id);
    int index = teams.indexWhere((team) => team.id == id.toString());

    if (index != -1) {
      print('$apiUrl/team/${teams[index].id}');

      final response = await http.get(
        Uri.parse('$apiUrl/team/${teams[index].fk_local}'),
        headers: {
          'Accept': '*/*',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        String name = responseData['team']['name'];
        return name;
      }
    }
    return 'Null';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle del Partido ${widget.partido.id}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FutureBuilder<String>(
              future: _getNameLocal(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Puedes mostrar un indicador de carga mientras se obtiene el nombre
                } else if (snapshot.hasError) {
                  return Text(
                      'Error al obtener el nombre del visitante'); // Maneja el error si ocurre
                } else {
                  return Text(
                    snapshot.data ??
                        'Nombre no encontrado', // Muestra el nombre o un mensaje predeterminado si no se encuentra
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    textAlign: TextAlign.center,
                  );
                }
              },
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    isTimerRunning
                        ? null
                        : isTimerRunning
                            ? null
                            : setState(() {
                                if (equipo1Counter > 0) {
                                  equipo1Counter--;
                                }
                              });
                  },
                ),
                Text(
                  equipo1Counter.toString(),
                  style: TextStyle(fontSize: 24),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    isTimerRunning
                        ? null
                        : isTimerRunning
                            ? null
                            : setState(() {
                                equipo1Counter++;
                              });
                  },
                ),
              ],
            ),
            SizedBox(height: 24),
            FutureBuilder<String>(
              future: _getNameVisitor(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Puedes mostrar un indicador de carga mientras se obtiene el nombre
                } else if (snapshot.hasError) {
                  return Text(
                      'Error al obtener el nombre del visitante'); // Maneja el error si ocurre
                } else {
                  return Text(
                    snapshot.data ??
                        'Nombre no encontrado', // Muestra el nombre o un mensaje predeterminado si no se encuentra
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    textAlign: TextAlign.center,
                  );
                }
              },
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    isTimerRunning
                        ? null
                        : setState(() {
                            if (equipo2Counter > 0) {
                              equipo2Counter--;
                            }
                          });
                  },
                ),
                Text(
                  equipo2Counter.toString(),
                  style: TextStyle(fontSize: 24),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    isTimerRunning
                        ? null
                        : setState(() {
                            equipo2Counter++;
                          });
                  },
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(
              'Tiempo restante:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${_minutes.toString().padLeft(2, '0')} : ${_seconds.toString().padLeft(2, '0')}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ],
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: isTimerRunning
                  ? null
                  : () {
                      startTimer();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('¡El partido ha sido iniciado!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 161, 247, 164),
              ),
              child: Text('Iniciar'),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: isTimerRunning
                  ? null
                  : () {
                      pauseTimer();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('¡El partido ha sido pausado!'),
                          backgroundColor: Color.fromARGB(255, 255, 180, 59),
                        ),
                      );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 255, 180, 59),
              ),
              child: Text('Pausar'),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                isTimerRunning ? null : finishGame();
                // Mostrar el SnackBar
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text(
                'Finalizar',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
