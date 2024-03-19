import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
              image: DecorationImage(
                //image: NetworkImage('https://st3.depositphotos.com/1008939/17741/i/450/depositphotos_177413090-stock-photo-two-football-players-hugging-friendly.jpg'),
                image: AssetImage("resources/fondo.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: 
            Column(
              children: [
                Text('data')
              ],
            ),
            ),
          ],
        ),
      ),
      );
  }
}