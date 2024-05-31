import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../providers/organization_provider.dart';

class OrgQRScanner extends StatefulWidget {
  const OrgQRScanner({super.key});

  @override
  State<OrgQRScanner> createState() => _OrgQRScannerState();
}

class _OrgQRScannerState extends State<OrgQRScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text('Barcode Type: ${result!.format}   Data: ${result!.code}')
                  : Text('Scan a code'),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      final donationid = scanData.code;
      print(donationid);
      if(donationid != null) {
        print(context.read<OrganizationProvider>().updateDonationStatusQR(donationid));
      }
      // Pause the camera after a successful scan
      controller.pauseCamera();
    }, onError: (error) {
      print('Error scanning QR code: $error');
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
