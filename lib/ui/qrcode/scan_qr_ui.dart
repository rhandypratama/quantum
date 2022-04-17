import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:quantum_admin/route/route_name.dart';

class ScanQRCode extends StatefulWidget {
  ScanQRCode({ Key? key }) : super(key: key);

  @override
  State<ScanQRCode> createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((barcode) { 
      setState(() => this.barcode = barcode);
      if (this.barcode != null) {
        HapticFeedback.vibrate();
        Get.toNamed(RouteName.transaction, parameters: {"uid" : this.barcode!.code.toString()});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.green,
              borderRadius: 10,
              borderLength: 20,
              borderWidth: 10,
              cutOutSize: MediaQuery.of(context).size.width * 0.8
            ),
          ),

          Positioned(
            bottom: 10,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(8)
              ),
              child: Text(
                barcode != null ? "Result : ${barcode!.code}" : "Scanning ...",
                style: TextStyle(
                  color: Colors.white
                ),
              )
            )
          )
        ],
      ),
      
    );
  }
}

