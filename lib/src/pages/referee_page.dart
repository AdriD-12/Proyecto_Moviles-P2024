import 'package:flutter/material.dart';
import 'package:proyecto/src/components/drawer_component.dart';
import '../components/match/eventslist_referee.dart';

class RefereePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Referee Management',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Referee Management'),
          ),
          body: EventsListRefereeComponent(),
          drawer: DrawerComponent(),
        ));
  }
}
