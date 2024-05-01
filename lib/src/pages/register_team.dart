import 'package:flutter/material.dart';
import 'package:proyecto/src/components/registro_equipo_component.dart';

void main() {
  String? scannedCode = "asdasd";
  runApp(RegisterTeam(scannedCode: scannedCode));
}

class RegisterTeam extends StatelessWidget {
  final String scannedCode;

  RegisterTeam({required this.scannedCode});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Register Team'),
        ),
        body: RegisterTeamComponent(scannedCode: scannedCode),
      ),
    );
  }
}
