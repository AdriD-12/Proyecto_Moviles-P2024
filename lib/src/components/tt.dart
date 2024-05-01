import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class RegisterTeamComponent extends StatefulWidget {
  @override
  _RegisterTeamComponentState createState() => _RegisterTeamComponentState();
}

class _RegisterTeamComponentState extends State<RegisterTeamComponent> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  String? _scannedCode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: _scannedCode != null
                ? Text('Código escaneado: $_scannedCode')
                : Text('Escanea un código QR'),
          ),
        ),
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        _scannedCode = scanData.code;
      });
      // Detener la visualización de la cámara después de escanear un código
      controller.pauseCamera();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
