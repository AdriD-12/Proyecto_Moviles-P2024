import 'package:flutter/material.dart';
import 'package:proyecto/src/components/drawer_row.dart';
import 'package:proyecto/src/pages/courts_selection.dart';
import 'package:proyecto/src/pages/dashboard.dart';
import 'package:proyecto/src/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:proyecto/src/pages/match_player.dart';
import 'package:proyecto/src/pages/registro_equipo.dart';
import 'package:proyecto/src/pages/match_spectator.dart';

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({Key? key});

  Future<void> _logout(BuildContext context) async {
    // Elimina el token almacenado en las preferencias compartidas
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    // Navega a la pantalla de inicio de sesión (login)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

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
                  placeholder: "HOME",
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
                  placeholder: "Map",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CourtsSelectionPage(),
                      ),
                    );
                  },
                ),
                DrawerRow(
                  placeholder: "Events",
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
                  placeholder: "My Matches",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MatchPlayerPage(),
                      ),
                    );
                  },
                ),
                DrawerRow(
                  placeholder: "Team Registration",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterTeam(),
                      ),
                    );
                  },
                ),
                DrawerRow(
                  placeholder:
                      "Logout", // Texto para el botón de cierre de sesión
                  onTap: () =>
                      _logout(context), // Llama al método de cierre de sesión
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
