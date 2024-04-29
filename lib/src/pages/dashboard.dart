import 'package:flutter/material.dart';
import 'package:proyecto/src/components/dashboard_component.dart';
import 'package:proyecto/src/components/drawer_component.dart';

void main() {
  print("Open Dashboard");
  runApp(DashboardPage());
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Color.fromARGB(142, 46, 141, 51)),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Registro'),
          ),
          body: DashboardComponent(),
          drawer: DrawerComponent(),
        ));
  }
}
