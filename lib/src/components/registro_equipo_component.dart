import 'package:flutter/material.dart';
import 'package:proyecto/src/pages/qr_capture.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class RegisterTeamComponent extends StatefulWidget {
  @override
  _RegisterTeamComponentState createState() => _RegisterTeamComponentState();
}

class _RegisterTeamComponentState extends State<RegisterTeamComponent> {
  TextEditingController _codeController = TextEditingController();
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');

  QRViewController? _qrController;
  bool _isScanning = false;
  String _scannedCode = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 20),
        TextFormField(
          controller: _codeController,
          decoration: InputDecoration(
            labelText: 'Ingresar código',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Aquí puedes implementar la lógica para consultar la base de datos
            String code = _codeController.text;
            print('Consultar base de datos con el código: $code');
          },
          child: Text('Consultar'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _isScanning = true;
            });
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => QRCapture(),
              ),
            );
          },
          child: Text('Escanear código QR'),
        ),

        /*if (_scannedCode.isNotEmpty) // Mostrar mensaje de escaneo exitoso
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Escaneo exitoso: $_scannedCode',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),*/
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this._qrController = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        _scannedCode = scanData.code ?? 'Código no disponible';
      });
      // Detener la visualización de la cámara después de escanear un código
      controller.pauseCamera();

      // Mostrar SnackBar de escaneo exitoso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Escaneo exitoso: $_scannedCode'),
          backgroundColor: Colors.green,
        ),
      );
    });
  }

  @override
  void dispose() {
    _codeController.dispose();
    _qrController?.dispose();
    super.dispose();
  }
}



/*
class RegisterTeamComponent extends StatefulWidget {
  @override
  _RegisterTeamComponentState createState() => _RegisterTeamComponentState();
}

class _RegisterTeamComponentState extends State<RegisterTeamComponent> {
  TextEditingController _codeController = TextEditingController();
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');

  QRViewController? _qrController;
  bool _isScanning = false;
  String _scannedCode = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 20),
        TextFormField(
          controller: _codeController,
          decoration: InputDecoration(
            labelText: 'Ingresar código',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Aquí puedes implementar la lógica para consultar la base de datos
            String code = _codeController.text;
            print('Consultar base de datos con el código: $code');
          },
          child: Text('Consultar'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _isScanning = true;
            });
          },
          child: Text('Escanear código QR'),
        ),
        if (_isScanning)
          Expanded(
            child: QRView(
              key: _qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
        if (_scannedCode.isNotEmpty) // Mostrar mensaje de escaneo exitoso
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Escaneo exitoso: $_scannedCode',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this._qrController = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        _scannedCode = scanData.code ?? 'Código no disponible';
      });
      // Detener la visualización de la cámara después de escanear un código
      controller.pauseCamera();
    });
  }

  @override
  void dispose() {
    _codeController.dispose();
    _qrController?.dispose();
    super.dispose();
  }
}
*/