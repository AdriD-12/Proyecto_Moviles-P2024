import 'package:flutter/material.dart';
import 'package:proyecto/src/pages/registro_equipo.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCaptureComponent extends StatefulWidget {
  final void Function(String) onCodeScanned;

  const QRCaptureComponent({Key? key, required this.onCodeScanned})
      : super(key: key);

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
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: _scannedCode != null
                ? Text('Código escaneado: $_scannedCode')
                : Text('Escanea un código QR'),
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
      controller.stopCamera();
      widget.onCodeScanned(_scannedCode!);

      //Navigator.pop(context);
      print(widget.onCodeScanned);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterTeam(scannedCode: _scannedCode!),
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
