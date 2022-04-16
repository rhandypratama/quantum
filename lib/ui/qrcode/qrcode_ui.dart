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
      // backgroundColor: Colors.black,
      body: Center(
        child: Container(
          // color: Colors.black,
          child: QrImage(
            data: landingC.dataUser['uid'].toString(),
            // version: QrVersions.auto,
            size: Get.width * 0.54,
            // gapless: false,
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