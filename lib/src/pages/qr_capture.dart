import 'package:flutter/material.dart';
import 'package:proyecto/src/components/qr_capture_component.dart';

void main() {
  runApp(QRCapture());
}

class QRCapture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('QR Capture'),
        ),
        body: QRCaptureComponent(
          onCodeScanned: (scannedCode) {
            // Aquí puedes manejar el código escaneado como desees
            print('Código escaneado: $scannedCode');
          },
        ),
      ),
    );
  }
}


/*import 'package:flutter/material.dart';
import 'package:proyecto/src/components/qr_capture_component.dart';

void main() {
  runApp(QRCapture());
}

class QRCapture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('QR Capture'),
        ),
        body: QRCaptureComponent(),
      ),
    );
  }
}
*/