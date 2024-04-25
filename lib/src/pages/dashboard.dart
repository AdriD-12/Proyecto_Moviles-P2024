import 'package:flutter/material.dart';
import 'package:proyecto/src/components/dashboard_component.dart';

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
      // Application name
      title: 'Flutter Hello World',
      // Application theme data, you can set the colors for the application as
      // you want
      theme: ThemeData(
          // useMaterial3: false,
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Color.fromARGB(142, 46, 141, 51)),
      // A widget which will be started on application startup
      home: DashboardComponent(title: 'Info Partidos'),
    );
  }
}
