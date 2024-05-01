import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:proyecto/src/components/registro_equipo_component.dart'; // Importa registro_equipo_component.dart

class QRCaptureComponent extends StatefulWidget {
  @override
  _QRCaptureComponentState createState() => _QRCaptureComponentState();
}

class _QRCaptureComponentState extends State<QRCaptureComponent> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  String? _scannedCode;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Agrega SingleChildScrollView aquí
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height *
                0.8, // Ajusta la altura de la cámara según tus necesidades
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: _scannedCode != null
                ? Text('Scanned Code: $_scannedCode')
                : Text('Scan a QR code'),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        _scannedCode = scanData.code;
      });
      // Detener la visualización de la cámara después de escanear un código
      await controller.pauseCamera();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterTeamComponent(),
        ),
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
