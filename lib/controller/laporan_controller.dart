import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quantum_admin/constant.dart';

DateTimeRange dateRange = DateTimeRange(start: DateTime.now(), end: DateTime.now().add(const Duration(days: 1)));

class LaporanController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // DateTimeRange dateRange = DateTimeRange(start: DateTime(2022, 4, 19), end: DateTime(2022, 4, 20));
  
  final strStartDate = DateFormat('dd/MM/yyyy').format(dateRange.start).toString().obs;
  final strEndDate = DateFormat('dd/MM/yyyy').format(dateRange.end).toString().obs;
  // final strStartDate1 = DateFormat('yyyy-MM-dd').format(dateRange.start).toString().obs;
  // final strEndDate1 = DateFormat('yyyy-MM-dd').format(dateRange.end).toString().obs;
  final strStartDate1 = dateRange.start.toIso8601String().obs;
  final strEndDate1 = dateRange.end.toIso8601String().obs;
  final totalTopUp = 0.obs;
  final totalPembayaran = 0.obs;
  final totalTarikSaldo = 0.obs;

  final dataUser = {}.obs;

  @override
  void onInit() async {
    // log(dateRange.start.toString());
    // log(strStartDate1.value.toString());
    // log(strEndDate1.value.toString());
    // getTransaksiTopUp();
    super.onInit();
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: Get.context!,
      // saveText: "Simpan",
      initialDateRange: dateRange, 
      firstDate: DateTime(2022), 
      lastDate: DateTime(DateTime.now().year.toInt() + 1),
      builder: (context, child) {
        final themeData = Theme.of(context);
        return Theme(
          data: themeData.copyWith(appBarTheme: themeData.appBarTheme.copyWith(backgroundColor: kGreenColor)),
          child: child!,
        );
      }
    );
    if (newDateRange == null) return;
    strStartDate.value = DateFormat('dd/MM/yyyy').format(newDateRange.start).toString();
    strEndDate.value = DateFormat('dd/MM/yyyy').format(newDateRange.end).toString();
    // strStartDate1.value = DateFormat('yyyy-MM-dd').format(newDateRange.start).toString();
    // strEndDate1.value = DateFormat('yyyy-MM-dd').format(newDateRange.end).toString();
    strStartDate1.value = newDateRange.start.toIso8601String();
    strEndDate1.value = newDateRange.end.toIso8601String();

    // log(strStartDate1.value.toString());
    // log(strEndDate1.value.toString());
    // getTransaksiTopUp();
    getTotalTransaksi();
  }

  Stream<QuerySnapshot> streamTransaksiTopUp() async* {
    yield* firestore
      .collection("transactions")
      .where('tipe', isEqualTo: 'top up')
      // .where('tanggal_transaksi', isGreaterThanOrEqualTo: "2022-04-18T23:17:14.676850")
      // .where('tanggal_transaksi', isLessThanOrEqualTo: "2022-04-20T19:54:07.913852")
      .where('tanggal_transaksi', isGreaterThanOrEqualTo: "2022-04-01T00:00:00.000")
      .where('tanggal_transaksi', isLessThanOrEqualTo: "2022-04-30T00:00:00.000")
      // .where('tanggal_transaksi', isGreaterThanOrEqualTo: dateRange.start)
      // .where('tanggal_transaksi', isLessThanOrEqualTo: dateRange.end)
      // .where('tanggal_transaksi', isGreaterThanOrEqualTo: DateTime.parse(strStartDate1.value))
      // .where('tanggal_transaksi', isGreaterThanOrEqualTo: DateTime.parse(strEndDate1.value))
      // .where('tanggal_transaksi', isGreaterThanOrEqualTo: s)
      // .where('tanggal_transaksi', isLessThanOrEqualTo: e)
      // .where('tanggal_transaksi', isGreaterThanOrEqualTo: "'"+strStartDate1.value.toString()+"'")
      // .where('tanggal_transaksi', isGreaterThanOrEqualTo: '"${strStartDate1}"')
      // .where('tanggal_transaksi', isLessThanOrEqualTo: "'${strEndDate1}'")
      .snapshots();
  }

  Future getTransaksiTopUp() async {
    await firestore
      .collection('transactions')
      .where('tipe', isEqualTo: 'top up')
      .where('tanggal_transaksi', isGreaterThanOrEqualTo: strStartDate1.value.toString())
      .where('tanggal_transaksi', isLessThanOrEqualTo: strEndDate1.value.toString())
      .get()
      .then((QuerySnapshot<Map<String, dynamic>> documentSnapshot) {
        var total = 0;
        if (documentSnapshot.docs.isNotEmpty) {
          documentSnapshot.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            total += data['nominal'] as int;
            // log(data['nominal'].toString());
          }).toList();
        }
        totalTopUp.value = total;
      });
  }

  Future getTotalTransaksi() async {
    await firestore
      .collection('transactions')
      .where('tanggal_transaksi', isGreaterThanOrEqualTo: strStartDate1.value.toString())
      .where('tanggal_transaksi', isLessThanOrEqualTo: strEndDate1.value.toString())
      .get()
      .then((QuerySnapshot<Map<String, dynamic>> documentSnapshot) {
        if (documentSnapshot.docs.isNotEmpty) {
          documentSnapshot.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            if (data['tipe'] == 'top up') {
              totalTopUp.value += data['nominal'] as int;
            } else if (data['tipe'] == 'pembayaran') {
              totalPembayaran.value += data['nominal'] as int;
            } else if (data['tipe'] == 'tarik saldo') {
              totalTarikSaldo.value += data['nominal'] as int;
            }
            // log(data['nominal'].toString());
          }).toList();
        }
      });
  }
  
}