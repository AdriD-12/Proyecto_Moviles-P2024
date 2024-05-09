import 'dart:async';

import 'package:flutter/material.dart';
import 'package:proyecto/src/abstract/match_row.dart';

class MatchReferee extends StatefulWidget {
  final MatchRow partido;

  MatchReferee({required this.partido});

  @override
  _MatchRefereeState createState() => _MatchRefereeState();
}

class _MatchRefereeState extends State<MatchReferee> {
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
            Text(
              'Equipo 1',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              textAlign: TextAlign.center,
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
            Text(
              'Equipo 2',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              textAlign: TextAlign.center,
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
