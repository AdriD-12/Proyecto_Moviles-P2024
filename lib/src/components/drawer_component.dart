import 'package:flutter/material.dart';
import 'package:proyecto/src/components/drawer_row.dart';
import 'package:proyecto/src/pages/dashboard.dart';
import 'package:proyecto/src/pages/login.dart';
import 'package:proyecto/src/pages/match_player.dart';
import 'package:proyecto/src/pages/match_spectator.dart';

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xffbccfbc),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: Icon(
              Icons.sports,
              color: Colors.red,
              size: 30.0,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                DrawerRow(
                  placeholder: "Home",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DashboardPage()), // Redirige a la página Partidos.dart
                    );
                  },
                ),
                DrawerRow(
                  placeholder: "Ver Torneo",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MatchSpectatorPage()), // Redirige a la página Partidos.dart
                    );
                  },
                ),
                DrawerRow(
                  placeholder: "Mis Partidos",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MatchPlayerPage()), // Redirige a la página Partidos.dart
                    );
                  },
                ),
                DrawerRow(
                  placeholder: "LogOut",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              LoginPage()), // Redirige a la página Login.dart
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
