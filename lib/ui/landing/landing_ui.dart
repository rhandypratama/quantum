import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:quantum_admin/component/widget_model.dart';
import 'package:quantum_admin/constant.dart';
import 'package:quantum_admin/controller/auth_controller.dart';
import 'package:quantum_admin/route/route_name.dart';

import '../../component/empty_data.dart';
import '../../controller/landing_controller.dart';

class Landing extends StatelessWidget {
  Landing({Key? key}) : super(key: key);
  final authC = Get.find<AuthController>();
  final landingC = Get.put<LandingController>(LandingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[800],
        // leading: SizedBox(
        //   height: 5,
        //   width: 5,
        //   child: CircleAvatar(
        //     child: dText("M"),
        //   ),
        // ),
        title: Obx(() => 
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dText(landingC.dataUser['email'], fontSize: 18),
              dText("uid : ${landingC.dataUser['uid']}", fontSize: 10)

            ],
          )
        ),
        actions: [
          IconButton(
            onPressed: () => authC.signOut(), 
            icon: const Icon(Icons.logout)
          )
        ],
      ),
      body: Column(
        children: [
          // Container(
          //   height: 100,
          //   width: double.infinity,
          //   // color: kWarninngColor,
          //   child: dText("Promo"),
          // ),
          const SizedBox(height: kSpaceM),
          Container(
            padding: const EdgeInsets.all(kSpaceM),
            child: Column(
              children: [
                const FaIcon(FontAwesomeIcons.wallet, color: Colors.orange, size: 50,),
                const SizedBox(height: kSpaceM),
                dText("Sisa Saldomu", fontSize: 16),

                StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: landingC.streamUser(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) return const CircularProgressIndicator();
                    return dText("Rp ${NumberFormat('#,##0', 'id_ID').format(snapshot.data!.data()!['saldo_wallet'])}", fontSize: 36, fontWeight: FontWeight.bold);
                  }
                ),
                
                const SizedBox(height: kSpaceM),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        MaterialButton(
                          onPressed: () => Get.toNamed(RouteName.qrCode),
                          color: Colors.lightBlue[600],
                          textColor: Colors.lightBlue[100],
                          child: const FaIcon(FontAwesomeIcons.qrcode, size: 20,),
                          padding: const EdgeInsets.all(14),
                          shape: const CircleBorder(),
                        ),
                        const SizedBox(height: 4),
                        dText("QR Code", fontSize: 12)
                      ],
                    ),
                    Column(
                      children: [
                        MaterialButton(
                          onPressed: () {},
                          color: Colors.lightBlue[600],
                          textColor: Colors.lightBlue[100],
                          child: const FaIcon(FontAwesomeIcons.chartBar, size: 20,),
                          padding: const EdgeInsets.all(14),
                          shape: const CircleBorder(),
                        ),
                        const SizedBox(height: 4),
                        dText("Laporan", fontSize: 12)
                      ],
                    ),
                  ],
                ),
              ]
            ),
          ),
          const SizedBox(height: kSpaceM),
          const Divider(thickness: 8),
          Expanded(
            child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: landingC.streamTransaction(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) { 
                  return const Center(child: CircularProgressIndicator());
                }
                // if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data!.exists) {
                    return dText("ada datanya", fontSize: 36, fontWeight: FontWeight.bold);

                  } else {
                    return EmptyData(
                      asset: Lottie.asset("assets/lotties/no-data-1.json", width: 170, height: 170),
                      title: "Belum ada data transaksi pembayaranmu",
                      subTitle: "Jika kamu sudah pernah melakukan pembayaran, maka datanya akan tampil disini",
                    );
                  }
                // }
              }
            ),
          )
        ],
      )
      
    );
  }
}