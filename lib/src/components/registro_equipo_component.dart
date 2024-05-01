import 'package:flutter/material.dart';
import 'package:proyecto/src/pages/qr_capture.dart';

class RegisterTeamComponent extends StatefulWidget {
  final String scannedCode;

  RegisterTeamComponent({required this.scannedCode});

  @override
  _RegisterTeamComponentState createState() => _RegisterTeamComponentState();
}

class _RegisterTeamComponentState extends State<RegisterTeamComponent> {
  TextEditingController _codeController = TextEditingController();
  // ignore: unused_field
  bool _isScanning = false;
  @override
  void initState() {
    super.initState();
    // Aquí puedes usar widget.scannedCode para acceder al valor del código escaneado
    _codeController.text = widget.scannedCode;
  }

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
            String code = _codeController.text;
            if (code == "RAS134SAS") {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Registro exitoso'),
                  backgroundColor: Colors.green,
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Registro no realizado o código erróneo'),
                  backgroundColor: Colors.red,
                ),
              );
            }
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
      ],
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }
}


/*

import 'package:flutter/material.dart';
import 'package:proyecto/src/pages/qr_capture.dart';

class RegisterTeamComponent extends StatefulWidget {
  final String scannedCode;

  RegisterTeamComponent({required this.scannedCode});

  @override
  _RegisterTeamComponentState createState() => _RegisterTeamComponentState();
}

class _RegisterTeamComponentState extends State<RegisterTeamComponent> {
  TextEditingController _codeController = TextEditingController();
  // ignore: unused_field
  bool _isScanning = false;
  @override
  void initState() {
    super.initState();
    // Aquí puedes usar widget.scannedCode para acceder al valor del código escaneado
    _codeController.text = widget.scannedCode;
  }

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
      ],
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }
}



*/ 
/*import 'package:flutter/material.dart';
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

  void setScannedCode(String scannedCode) {
    setState(() {
      _codeController.text = scannedCode;
    });
  }

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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QRCapture(),
              ),
            );
          },
          child: Text('Escanear código QR'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    _qrController?.dispose();
    super.dispose();
  }
}

*/



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