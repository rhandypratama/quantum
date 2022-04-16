import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodeController extends GetxController {
  QRViewController? controller;
  final result = ''.obs;
  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      // result.value = scanData;
      
    });
  }

}