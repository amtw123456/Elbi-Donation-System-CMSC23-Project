import 'dart:io';

import 'package:elbi_donation_app/providers/donor_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../models/donation_model.dart';
import '../../providers/organization_provider.dart';
import 'org_donation_details_page.dart';

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
    controller.scannedDataStream.listen((scanData) async {
      final donationid = scanData.code;
      print(donationid);
      if(donationid != null) {
        Map<String, dynamic> success = await context.read<OrganizationProvider>().updateDonationStatusQR(donationid);
        print(success);
        controller.pauseCamera();
        // success snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Successfully updated donation status. Thank you!"))
        );

        final donationInformation = await context.read<DonorProvider>().getDonationModel(donationid);
        // show donation page
         Navigator.push(
          context,
          MaterialPageRoute( builder: (context) =>
            OrgDonationDetails(
              donationDetails: DonationModel.fromJson(donationInformation),
            ))); 
      }
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
