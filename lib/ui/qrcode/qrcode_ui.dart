import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:quantum_admin/constant.dart';
import 'package:quantum_admin/controller/landing_controller.dart';

import '../../component/widget_model.dart';

class QrCode extends StatelessWidget {
  QrCode({ Key? key }) : super(key: key);
  final landingC = Get.find<LandingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kWarninngColor.withOpacity(0.2),
      body: ListView(
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.all(kSpaceM),
            child: Container(
              padding: const EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(kRadiusS)),
                color: kWarninngColor.withOpacity(0.2),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lightbulb_outline_rounded),
                  const SizedBox(width: kSpaceS),
                  Column(
                    children: [
                      SizedBox(
                        width: Get.width * 0.74,
                        child: dText("JANGAN PERNAH MENUNJUKKAN / SHARE QR CODE INI KEPADA SIAPAPUN (KECUALI PADA SAAT AKAN MELAKUKAN TRASAKSI). SEGALA BENTUK KECURANGAN / KERUGIAN YANG DI AKIBATKAN KELALAIAN PRIBADI AKAN MENJADI TANGGUNG JAWAB PRIBADI MASING - MASING.", fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: kSpaceL),
          Center(
            child: Card(
              elevation: kSpaceS,
              // color: Colors.black,
              child: Container(
                padding: const EdgeInsets.all(kSpaceM),
                child: QrImage(
                  data: landingC.dataUser['uid'].toString(),
                  // version: QrVersions.auto,
                  size: Get.width * 0.5,
                  // gapless: false,
                  errorStateBuilder: (cxt, err) {
                    return Container(
                      child: dText("Terjadi kesalahan pada saat generate QR Code. Mohon coba beberapa saat lagi.",
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              )
            ),
          ),
        ],
      ),
    );
  }
}