import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:quantum_admin/component/widget_model.dart';
import 'package:quantum_admin/constant.dart';
import 'package:quantum_admin/controller/laporan_controller.dart';


import '../../component/empty_data.dart';

class Laporan extends StatelessWidget {
  Laporan({Key? key}) : super(key: key);
  final laporanC = Get.put<LaporanController>(LaporanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: dText("Laporan Transaksi", fontSize: 18),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: kSpaceM, right: kSpaceM),
            decoration: BoxDecoration(
              // borderRadius: const BorderRadius.all(Radius.circular(kRadiusS)),
              color: kWarninngColor.withOpacity(0.2),
            ),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                dText("Periode"),
                Obx(() => TextButton(
                  onPressed: () => laporanC.pickDateRange(),
                  child: dText(
                    // "${laporanC.dateRange.start.day.toString()}/${laporanC.dateRange.start.month.toString()}/${laporanC.dateRange.start.year.toString()} - ${laporanC.dateRange.end.day.toString()}/${laporanC.dateRange.end.month.toString()}/${laporanC.dateRange.end.year.toString()}",
                    "${laporanC.strStartDate} - ${laporanC.strEndDate}",
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                  )
                ))
              ],
            ),
          ),
          Card(
            elevation: kSpaceS,
            child: Container(
              padding: const EdgeInsets.all(kSpaceM),
              width: Get.width,
              child: Column(
                children: [
                  dText("TOP UP", fontSize: 16),

                  // StreamBuilder<QuerySnapshot>(
                  //   stream: laporanC.streamTransaksiTopUp(),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.connectionState == ConnectionState.waiting) {
                  //       return const Center(child: SizedBox(width: 30, height: 30, child: CircularProgressIndicator()));
                  //     }

                  //     if (snapshot.hasError) {
                  //       return dText('Tidak dapat mendapatkan data');
                  //     }
                  //     if (snapshot.data!.docs.isEmpty) {
                  //       return dText("Rp 0", fontSize: 36, fontWeight: FontWeight.bold);
                  //     } else {
                  //       var total = 0;
                  //       // log(snapshot.data!.docs.toString());
                  //       snapshot.data!.docs.map((DocumentSnapshot document) {
                  //         Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                  //           total += data['nominal'] as int;
                  //           log(data['nominal'].toString());
                            
                  //         }).toList();
                  //       return dText("Rp ${NumberFormat('#,##0', 'id_ID').format(total)}", fontSize: 36, fontWeight: FontWeight.bold);
                          
                  //     }
                  //   }
                  // ),

                  Obx(() => dText("Rp ${NumberFormat('#,##0', 'id_ID').format(laporanC.totalTopUp.value)}", fontSize: 36, fontWeight: FontWeight.bold))
                ],
              ),
            ),
          ),
          Card(
            elevation: kSpaceS,
            child: Container(
              padding: const EdgeInsets.all(kSpaceM),
              width: Get.width,
              child: Column(
                children: [
                  dText("PEMBAYARAN", fontSize: 16),
                  Obx(() => dText("Rp ${NumberFormat('#,##0', 'id_ID').format(laporanC.totalPembayaran.value)}", fontSize: 36, fontWeight: FontWeight.bold))
                ],
              ),
            ),
          ),
          Card(
            elevation: kSpaceS,
            child: Container(
              padding: const EdgeInsets.all(kSpaceM),
              width: Get.width,
              child: Column(
                children: [
                  dText("TARIK SALDO", fontSize: 16),
                  Obx(() => dText("Rp ${NumberFormat('#,##0', 'id_ID').format(laporanC.totalTarikSaldo.value)}", fontSize: 36, fontWeight: FontWeight.bold))
                ],
              ),
            ),
          ),
        ],
      )
    );
  }

  
}