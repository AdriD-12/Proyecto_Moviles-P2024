import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyecto/src/abstract/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardComponent extends StatefulWidget {
  const DashboardComponent({Key? key}) : super(key: key);

  @override
  _DashboardComponentState createState() => _DashboardComponentState();
}

class _DashboardComponentState extends State<DashboardComponent> {
  int wins = 0, loses = 0, goals = 0;
  String court = '', StartTime = '';

  @override
  void initState() {
    super.initState();
    _getWinsAndLoses();
  }

  Future<void> _getWinsAndLoses() async {
    final sp = await SharedPreferences.getInstance();
    final userID = sp.getInt('id');
    try {
      String? token = await AuthService.getToken();
      String apiUrl = dotenv.env['BACKEND_ENDPOINT']!;
      final response = await http.get(
        Uri.parse('$apiUrl/user/$userID'),
        headers: {
          'Accept': '*/*',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          wins = data['won'];
          loses = data['lost'];
          court = data['court'];
          goals = data['goals'];
          String dateTimeString = data['StartTime'];

          // Parsear la cadena de fecha y hora en un objeto DateTime
          DateTime dateTime = DateTime.parse(dateTimeString);

          // Formatear el objeto DateTime para mostrar solo la hora
          String formattedTime = DateFormat.Hm().format(dateTime);
          StartTime = formattedTime;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildBackground(),
        _buildContent(context),
      ],
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('resources/fondo.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SafeArea(
      top: true,
      child: Align(
        alignment: AlignmentDirectional(0, 0),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFFAFE1C7),
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Text(
                      'Next Match: Quijotes',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 165,
                      decoration: BoxDecoration(
                        color: Color(0xFFAFE1C7),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Court',
                            style: const TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Text(
                                court,
                                style: const TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 165,
                      decoration: BoxDecoration(
                        color: Color(0xFFAFE1C7),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Approximate Time',
                            style: const TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Text(
                                StartTime,
                                style: const TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 56,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 200, // Ajusta esta altura según sea necesario
                decoration: BoxDecoration(
                  color: Color(0xFFAFE1C7),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                      child: Text(
                        'Win/Lose',
                        style: const TextStyle(
                          fontFamily: 'Readex Pro',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            PieChartWidget(
                                wins: wins,
                                loses:
                                    loses), // Aquí se añade el gráfico de pastel
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: wins.toString(),
                                      style: const TextStyle(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 25,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '- Wins',
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                                textScaler: TextScaler.linear(
                                    MediaQuery.of(context).textScaleFactor),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: loses.toString(),
                                      style: const TextStyle(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 25,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' - Losses',
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                                textScaler: TextScaler.linear(
                                    MediaQuery.of(context).textScaleFactor),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 165,
                      decoration: BoxDecoration(
                        color: Color(0xFFAFE1C7),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Total Goals',
                            style: const TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Text(
                                goals.toString(),
                                style: const TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 165,
                      decoration: BoxDecoration(
                        color: Color(0xFFAFE1C7),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Position',
                            style: const TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(0, 0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 10, 0, 0),
                              child: Text(
                                '5�',
                                style: const TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 58,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PieChartWidget extends StatelessWidget {
  final int wins;
  final int loses;

  const PieChartWidget({
    Key? key,
    required this.wins,
    required this.loses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (wins == 0 && loses == 0) {
      return SizedBox(
        width: 120,
        height: 120,
        child: PieChart(
          PieChartData(
            sections: [
              PieChartSectionData(
                color: Color.fromARGB(255, 73, 106, 127),
                value: 1,
                title: '',
                radius: 30,
              ),
            ],
            borderData: FlBorderData(show: false),
            sectionsSpace: 0,
            centerSpaceRadius: 0,
          ),
        ),
      );
    } else {
      return SizedBox(
        width: 120,
        height: 120,
        child: PieChart(
          PieChartData(
            sections: [
              PieChartSectionData(
                color: Colors.blue,
                value: wins.toDouble(),
                title: '',
                radius: 30,
              ),
              PieChartSectionData(
                color: Colors.red,
                value: loses.toDouble(),
                title: '',
                radius: 30,
              ),
            ],
            borderData: FlBorderData(show: false),
            sectionsSpace: 0,
            centerSpaceRadius: 0,
          ),
        ),
      );
    }
  }
}
