import 'package:flutter/material.dart';
import 'package:proyecto/src/components/drawer_component.dart';
import 'package:proyecto/src/components/registro_equipo_component.dart';

void main() {
  runApp(RegisterTeam());
}

class RegisterTeam extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Register Team'),
        ),
        body: RegisterTeamComponent(),
        drawer: DrawerComponent(),
      ),
    );
  }
}
