import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:quantum_admin/controller/qrcode_controller.dart';
import 'package:quantum_admin/route/route_name.dart';

import '../../component/widget_model.dart';

class ScanQRCode extends StatefulWidget {
  ScanQRCode({ Key? key }) : super(key: key);

  @override
  State<ScanQRCode> createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  final qrC = Get.put<QrCodeController>(QrCodeController());
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
      // if (this.barcode != null) {
      //   // HapticFeedback.vibrate();
      //   var users = FirebaseFirestore.instance.collection('customer').doc(this.barcode!.code.toString()).get();
      //   log(users.toString());
        // Get.toNamed(RouteName.transaction, parameters: {"uid" : this.barcode!.code.toString()});
      // }
    });
  }

  // void getUser() {
  //   if (barcode != null) {
  //     var users = FirebaseFirestore.instance.collection('customer').doc(barcode!.code.toString()).get();
  //     log(users.toString());
  //   }
  // }

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
              cutOutSize: MediaQuery.of(context).size.width * 0.6
            ),
          ),

          Positioned(
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.16,
              width: MediaQuery.of(context).size.width,
              // padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
                // borderRadius: BorderRadius.circular(8)
              ),
              child: Center(
                child: TextButton.icon(
                  onPressed: () {
                    if (barcode != null) {
                      // Get.offAndToNamed(RouteName.transaction, parameters: {"uid" : barcode!.code.toString()});
                      qrC.getUserInformation(barcode!.code.toString());
                      setState(() {this.barcode = null;});
                    } else {
                      showSnackbar('error', 'QR Code diperlukan', 'Scan QR Code yang ada di smartphone customermu');
                    }
                  }, 
                  icon: const Icon(Icons.document_scanner), 
                  label: dText(barcode != null ? "${barcode!.code}" : "Scanning ...", color: Colors.black),
                )
                
                
              )
              
            )
          )
        ],
      ),
      
    );
  }
}

