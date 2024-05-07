import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:proyecto/src/components/drawer_row.dart';
import 'package:proyecto/src/pages/courts_selection.dart';
import 'package:proyecto/src/pages/dashboard.dart';
import 'package:proyecto/src/pages/login.dart';
import 'package:proyecto/src/pages/referee_page.dart';
import 'package:proyecto/src/pages/register_team.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:proyecto/src/pages/match_player.dart';
import 'package:proyecto/src/pages/match_spectator.dart';

class DrawerComponent extends StatefulWidget {
  const DrawerComponent({Key? key});

  @override
  _DrawerComponentState createState() => _DrawerComponentState();
}

class _DrawerComponentState extends State<DrawerComponent> {
  String type_User = '';

  @override
  void initState() {
    super.initState();
    _getUserType().then((value) {
      setState(() {
        type_User = value ?? '';
      });
    });
  }

  get scannedCode => '';

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

  Future<String?> _getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      final parts = token.split('.');
      if (parts.length != 3) {
        throw FormatException('Invalid token');
      }

      final payload = json
          .decode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));

      return payload['user_type'].toString(); // Convertir el id a String
    }

    return null;
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
                  placeholder: "Tournaments",
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
                        builder: (context) =>
                            RegisterTeam(scannedCode: scannedCode),
                      ),
                    );
                  },
                ),
                if (type_User ==
                    'organizer') // Mostrar solo si el usuario es "referee"
                  DrawerRow(
                    placeholder: "Tournaments Management",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RefereePage(),
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
