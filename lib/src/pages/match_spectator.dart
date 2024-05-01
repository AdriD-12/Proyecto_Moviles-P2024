import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:proyecto/src/components/drawer_component.dart';
import 'package:proyecto/src/components/match/eventsList.dart';

void main() async {
  print("Open Match to Attend");
  await dotenv.load(fileName: ".env");
  runApp(MatchSpectatorPage());
}

class MatchSpectatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tournaments',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tournaments'),
        ),
        body: EventsListComponent(),
        drawer: DrawerComponent(),
      ),
    );
  }
}
