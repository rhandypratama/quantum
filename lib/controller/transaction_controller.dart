import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum_admin/component/widget_model.dart';
import 'package:quantum_admin/route/route_name.dart';

class TransactionController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController nominalController = TextEditingController();

  final params = Get.parameters;

  final dataUser = {}.obs;
  final dataAdmin = {}.obs;
  final role = "".obs;
  final tipeTransaksi = "".obs;
  final loading = false.obs;

  @override
  void onInit() async {
    getUserInformation();
    super.onInit();
  }

  @override
  void onClose() async {
    nominalController.dispose();
    super.onClose();
  }

  Future getUserInformation() async {
    try {
      // params['uid'] = 'AT6KxRdumXPu29rl18RIBBCXFED2';
      // params['uid'] = '5Can1wBdR5gkA61wzCpzTDL3MVk2';
      loading.value = true;
      dataAdmin.value = {
        "uid" : "",
        "email" : "",
        "saldo_wallet" : 0,
        "pin" : "112233",
        "role" : "customer",
      };
      dataUser.value = {
        "uid" : "",
        "email" : "",
        "saldo_wallet" : 0,
        "pin" : "",
        "role" : "customer",
      };
      if (auth.currentUser != null && params['uid'] != null) {
        await firestore
          .collection('customer')
          .doc(params['uid'])
          .get()
          .then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              // log("Document data: ${documentSnapshot.get('role')}");
              // role.value = documentSnapshot.get('role');
              dataUser.value = {
                "uid" : documentSnapshot.get('uid'),
                "email" : documentSnapshot.get('email'),
                "saldo_wallet" : documentSnapshot.get('saldo_wallet'),
                "pin" : documentSnapshot.get('pin'),
                "role" : documentSnapshot.get('role'),
              };
            }
          
          }).catchError((error) => showSnackbar('error', 'Terjadi Kesalahan', error.toString()));
      }
      // log(dataUser.toString());
      loading.value = false;
    } catch (e) {
      loading.value = false;
      showSnackbar('error', 'Terjadi kesalahan', e.toString());
    }
  }

  Future getAdminInformation() async {
    try {
      String uid = auth.currentUser!.uid;
      // params['uid'] = 'R5XqLl86YbP74hGqsr0ynCxyAb12';
      loading.value = true;
      if (auth.currentUser != null && params['uid'] != null) {
        await firestore
          .collection('customer')
          .doc(uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              dataAdmin.value = {
                "uid" : documentSnapshot.get('uid'),
                "email" : documentSnapshot.get('email'),
                "saldo_wallet" : documentSnapshot.get('saldo_wallet'),
                "pin" : documentSnapshot.get('pin'),
                "role" : documentSnapshot.get('role'),
              };
            }
        });
      }
      // log(dataUser.toString());
      loading.value = false;
    } catch (e) {
      loading.value = false;
      showSnackbar('error', 'Terjadi kesalahan', e.toString());
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    // params['uid'] = 'AT6KxRdumXPu29rl18RIBBCXFED2';
    // params['uid'] = '5Can1wBdR5gkA61wzCpzTDL3MVk2';
    log('PARAM UID ===> ${params['uid']}');
    yield* firestore.collection("customer").doc(params['uid']).snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamTransaction() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore.collection("transaction").doc(uid).snapshots();
  }

  Future saveTransaction() async {
    try {
      loading.value = true;
      if (nominalController.text.trim().isNotEmpty) {
        CollectionReference trans = firestore.collection('transactions');
        CollectionReference customer = firestore.collection('customer');
        await trans
          .add({
            'user_id': dataUser['uid'].toString(),
            'email': dataUser['email'].toString(),
            'tipe': tipeTransaksi.toString(),
            'nominal': int.parse(nominalController.text.trim()),
            'tanggal_transaksi': DateTime.now().toIso8601String(),
          })
          .then((_) async {
            await getUserInformation(); // mencari saldo wallet customer terakhir
            await getAdminInformation(); // mencari saldo wallet admin terakhir
            var hasil = 0;
            var hasilAdmin = 0;
            if (tipeTransaksi.value == 'pembayaran' || tipeTransaksi.value == 'tarik saldo') {
              hasil = dataUser['saldo_wallet'] - int.parse(nominalController.text.trim());
              hasilAdmin = dataAdmin['saldo_wallet'] - int.parse(nominalController.text.trim());
            } else {
              hasil = dataUser['saldo_wallet'] + int.parse(nominalController.text.trim());
              hasilAdmin = dataAdmin['saldo_wallet'] + int.parse(nominalController.text.trim());
            }
            customer
              .doc(dataUser['uid'].toString())
              .update({'saldo_wallet': hasil.toInt()})
              .then((_) {

                // UPDATE SALDO ADMIN
                customer
                  .doc(auth.currentUser!.uid)
                  .update({'saldo_wallet': hasilAdmin.toInt()})
                  .then((_) {
                    Get.offAllNamed(RouteName.landing);
                  })
                  .catchError((error) => showSnackbar('error', 'Terjadi Kesalahan', error.toString()));
                
              })
              .catchError((error) => showSnackbar('error', 'Terjadi Kesalahan', error.toString()));

          })
          .catchError((error) {
            showSnackbar('error', 'Terjadi Kesalahan', error.toString());          
          });
        
        showSnackbar('success', 'Transaksi Berhasil', 'Selamat transaksimu berhasil, mohon cek ulang saldomu sekarang');
      } else {
        showSnackbar('error', 'Terjadi Kesalahan', 'Nominal wajib diisi');
      }
      loading.value = false;
    } catch (e) {
      loading.value = false;
      showSnackbar('error', 'Terjadi Kesalahan', e.toString());
    }
  }
  
}