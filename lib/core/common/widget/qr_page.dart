import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerPage extends StatefulWidget {
  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  bool isScanned = false; // Flag to check if QR has already been scanned

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR Code'),
      ),
      body: MobileScanner(
        onDetect: (barcode) {
          if (!isScanned && barcode.barcodes.isNotEmpty) {
            setState(() {
              isScanned = true; // Set flag to true when QR is scanned
            });

            final scannedValue = barcode.barcodes.first.displayValue;
            if (scannedValue != null) {
              Navigator.of(context)
                  .pop(scannedValue); // Return the scanned value
            }
          }
        },
      ),
    );
  }
}
