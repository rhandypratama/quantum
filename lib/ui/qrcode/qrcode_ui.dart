import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:quantum_admin/controller/landing_controller.dart';

import '../../component/widget_model.dart';

class QrCode extends StatelessWidget {
  QrCode({ Key? key }) : super(key: key);
  final landingC = Get.find<LandingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: QrImage(
            data: landingC.dataUser['email'].toString(),
            version: QrVersions.auto,
            size: Get.width * 0.6,
            gapless: false,
            errorStateBuilder: (cxt, err) {
              return Container(
                child: dText("Terjadi kesalahan pada saat generate QR Code. Mohon coba beberapa saat lagi.",
                  textAlign: TextAlign.center,
                ),
              );
            },
          )
        ),
      ),
    );
  }
}