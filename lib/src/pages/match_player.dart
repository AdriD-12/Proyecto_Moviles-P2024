import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:proyecto/src/components/drawer_component.dart';
import 'package:proyecto/src/components/match/player.dart';

void main() async {
  print("Open Player Matches");
  await dotenv.load(fileName: ".env");
  runApp(MatchPlayerPage());
}

class MatchPlayerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'My Matches',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('My Matches'),
          ),
          body: MatchListComponent(),
          drawer: DrawerComponent(),
        ));
  }
}
