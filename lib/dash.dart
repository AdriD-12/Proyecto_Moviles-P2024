import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() => runApp(MyApp());

class PieChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              color: Colors.blue,
              value: 5,
              title: '',
              radius: 30,
            ),
            PieChartSectionData(
              color: Colors.red,
              value: 2,
              title: '',
              radius: 30,
            ),
          ],
          borderData: FlBorderData(show: false),
          sectionsSpace: 0,
          centerSpaceRadius: 0,
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
      home: MyHomePage(title: 'Info Partidos'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // The title text which will be shown on the action bar
        title: Text(title),
      ),
      drawer: Drawer(
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
                  const ListDrawer(data1: "Cancha 1", data2: "otro"),
                  const ListDrawer(data1: "Cancha 2", data2: "otro"),
                  const ListDrawer(data1: "Cancha 3", data2: "otro"),
                  const ListDrawer(data1: "Dato 1", data2: "otro"),
                  const ListDrawer(data1: "Dato 2", data2: "otro"),
                ],
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        top: true,
        child: Align(
          alignment: AlignmentDirectional(0, 0),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFFAFE1C7),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Text(
                        'Siguiente Partido: Quijotes',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Readex Pro',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: 165,
                        decoration: BoxDecoration(
                          color: Color(0xFFAFE1C7),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Cancha',
                              style: const TextStyle(
                                fontFamily: 'Readex Pro',
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Text(
                                  '7',
                                  style: const TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 60,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: 165,
                        decoration: BoxDecoration(
                          color: Color(0xFFAFE1C7),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Hora Aprox',
                              style: const TextStyle(
                                fontFamily: 'Readex Pro',
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Text(
                                  '9:11',
                                  style: const TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 56,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 200, // Ajusta esta altura según sea necesario
                  decoration: BoxDecoration(
                    color: Color(0xFFAFE1C7),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                        child: Text(
                          'Win/Lose',
                          style: const TextStyle(
                            fontFamily: 'Readex Pro',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              PieChartWidget(), // Aquí se añade el gráfico de pastel
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RichText(
                                  textScaleFactor:
                                      MediaQuery.of(context).textScaleFactor,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '5 ',
                                        style: const TextStyle(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 25,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '- Ganados',
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RichText(
                                  textScaleFactor:
                                      MediaQuery.of(context).textScaleFactor,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '2',
                                        style: const TextStyle(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 25,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' - Perdidos',
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: 165,
                        decoration: BoxDecoration(
                          color: Color(0xFFAFE1C7),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Goles totales',
                              style: const TextStyle(
                                fontFamily: 'Readex Pro',
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Text(
                                  '12',
                                  style: const TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 60,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: 165,
                        decoration: BoxDecoration(
                          color: Color(0xFFAFE1C7),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Posición',
                              style: const TextStyle(
                                fontFamily: 'Readex Pro',
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 10, 0, 0),
                                child: Text(
                                  '5°',
                                  style: const TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 58,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListDrawer extends StatelessWidget {
  final String data1;
  final String data2;
  const ListDrawer({Key? key, required this.data1, required this.data2})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          print("hola");
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.grey[200],
          ),
          margin: const EdgeInsets.only(bottom: 5, left: 3.0, right: 3.0),
          child: ListTile(
            title: Text(data1),
            leading: Icon(Icons.sports_soccer),
          ),
        ));
  }
}
