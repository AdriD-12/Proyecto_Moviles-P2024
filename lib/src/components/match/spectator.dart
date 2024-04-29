import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:proyecto/src/abstract/constants.dart';
import 'package:proyecto/src/abstract/match_info.dart';
import 'package:proyecto/src/pages/privacy.dart';

class MatchListComponent extends StatelessWidget {
  final List<MatchInfo> partidos = _parseMatch();

  static List<MatchInfo> _parseMatch() {
    final jsonData = jsonDecode(CATALOGO_PARTIDOS_ASISTIR);
    return List<MatchInfo>.from(jsonData.map((x) => MatchInfo(
          id: x['id'],
          time: x['time'],
          idGroup1: x['id_group1'],
          idGroup2: x['id_group2'],
          idPlace: x['id_place'],
        )));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: partidos.length,
      itemBuilder: (context, index) {
        final partido = partidos[index];
        return ListTile(
          title: Text('ID: ${partido.id}, Hora: ${partido.time}'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MatchDetail(partido: partido),
              ),
            );
          },
        );
      },
    );
  }
}

class MatchDetail extends StatelessWidget {
  final MatchInfo partido;

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
              // L�gica para ver el partido
            },
            child: Text('Ver'),
          ),
        ],
      ),
    );
  }
}
