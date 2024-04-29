import 'package:flutter/material.dart';
import 'package:proyecto/src/components/declaration_component.dart';

void main() {
  print("Open Declaration");
  runApp(DeclarationPage());
}

class DeclarationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: DeclarationComponent(),
      ),
    );
  }
}
