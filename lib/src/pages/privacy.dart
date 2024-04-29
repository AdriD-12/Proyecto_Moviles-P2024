import 'package:flutter/material.dart';
import 'package:proyecto/src/components/privacy_component.dart';

void main() {
  runApp(PrivacyPage());
}

class PrivacyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Privacy Policy'),
        ),
        body: PrivacyComponent(),
      ),
    );
  }
}
