import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum_admin/component/widget_model.dart';

class LandingController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController pinController = TextEditingController();

  final dataUser = {}.obs;
  final dataAdmin = {}.obs;
  final dataCustomer = {}.obs;
  final role = "".obs;

  final loading = false.obs;
  final loadingDelete = false.obs;
  final dataTrans = {}.obs;

  @override
  void onInit() async {
    dataAdmin.value = {
      "uid" : "",
      "email" : "",
      "saldo_wallet" : 0,
      "pin" : "112233",
      "role" : "admin",
    };
    dataCustomer.value = {
      "uid" : "",
      "email" : "",
      "saldo_wallet" : 0,
      "pin" : "",
      "role" : "customer",
    };

    getUserInformation();
    // getDetailUser();
    super.onInit();
  }

  @override
  void onClose() async {
    pinController.dispose();
    super.onClose();
  }

  getUserInformation() async {
    if (auth.currentUser != null) {
      dataUser.value = {
        "name" : auth.currentUser!.displayName,
        "email" : auth.currentUser!.email,
        "photoUrl" : auth.currentUser!.photoURL,
        "emailVerified" : auth.currentUser!.emailVerified,
        "uid" : auth.currentUser!.uid,
        "pin" : "",
        // "role" : documentSnapshot.get('role'),
      };
      String uid = auth.currentUser!.uid;
      await firestore
        .collection('customer')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            dataUser.value = {
              "name" : auth.currentUser!.displayName,
              "email" : auth.currentUser!.email,
              "photoUrl" : auth.currentUser!.photoURL,
              "emailVerified" : auth.currentUser!.emailVerified,
              "uid" : auth.currentUser!.uid,
              "pin" : documentSnapshot.get('pin'),
              "role" : documentSnapshot.get('role'),
            };
          }
        });
    } 
  }

  Future getAdminInformation() async {
    try {
      String uid = auth.currentUser!.uid;
      loading.value = true;
      if (auth.currentUser != null) {
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

  Future getCustomerInformation() async {
    try {
      String uid = dataTrans['uid'].toString();
      loading.value = true;
      await firestore
        .collection('customer')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            dataCustomer.value = {
              "uid" : documentSnapshot.get('uid'),
              "email" : documentSnapshot.get('email'),
              "saldo_wallet" : documentSnapshot.get('saldo_wallet'),
              "pin" : documentSnapshot.get('pin'),
              "role" : documentSnapshot.get('role'),
            };
          }
      });
      // log(dataUser.toString());
      loading.value = false;
    } catch (e) {
      loading.value = false;
      showSnackbar('error', 'Terjadi kesalahan', e.toString());
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String uid = auth.currentUser!.uid;
    // log('UID ==> $uid');
    yield* firestore.collection("customer").doc(uid).snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamTransaction() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore.collection("transactions").doc(uid).snapshots();
  }

  Stream<QuerySnapshot> streamCustomerTransaction() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore
      .collection("transactions")
      .where('user_id', isEqualTo: uid)
      .orderBy('tanggal_transaksi', descending: true)
      .limitToLast(30)
      .snapshots();
  }

  Stream<QuerySnapshot> streamAdminTransaction() async* {
    yield* firestore
      .collection("transactions")
      .orderBy('tanggal_transaksi', descending: true)
      .limitToLast(30)
      .snapshots();
  }

  Future deleteTransaction() async {
    try {
      loadingDelete.value = true;
      
      await getCustomerInformation(); // mencari saldo wallet customer terakhir
      await getAdminInformation(); // mencari saldo wallet admin terakhir
      // log(dataCustomer.toString());
      log(dataAdmin.toString());
      // log(dataTrans.toString());

      if (pinController.text.trim().isEmpty) {
        loadingDelete.value = false;
        showSnackbar('error', 'PIN Transaksi', 'Untuk menghapus transaksi ini dibutuhkan PIN Transaksimu');
      } else if (pinController.text.trim() != dataAdmin['pin']) {
        loadingDelete.value = false;
        showSnackbar('error', 'PIN Transaksi', 'PIN Transaksimu tidak valid');
        pinController.text = "";
      } else if (pinController.text.trim() == dataAdmin['pin']) {
          
        CollectionReference trans = firestore.collection('transactions');
        CollectionReference customer = firestore.collection('customer');

        var hasilCustomer = 0;
        var hasilAdmin = 0;
        if (dataTrans['tipe'] == 'pembayaran') {
          hasilCustomer = dataCustomer['saldo_wallet'] + dataTrans['nominal'];
          hasilAdmin = dataAdmin['saldo_wallet'] + dataTrans['nominal'];
        } else {
          hasilCustomer = dataCustomer['saldo_wallet'] - dataTrans['nominal'];
          hasilAdmin = dataAdmin['saldo_wallet'] - dataTrans['nominal'];
        }

        // UPDATE SALDO WALLET CUSTOMER
        await customer
          .doc(dataTrans['uid'].toString())
          .update({'saldo_wallet': hasilCustomer.toInt()})
          .then((_) {})
          .catchError((error) => showSnackbar('error', 'Terjadi kesalahan pada saat update saldo wallet customer', error.toString()));

        // UPDATE SALDO WALLET ADMIN
        await customer
          .doc(auth.currentUser!.uid)
          .update({'saldo_wallet': hasilAdmin.toInt()})
          .then((_) {})
          .catchError((error) => showSnackbar('error', 'Terjadi kesalahan pada saat update saldo wallet admin', error.toString()));

        // DELETE TRANSAKSI
        await trans
          .doc(dataTrans['transId'].toString())
          .delete()
          .then((value) {})
          .catchError((error) => showSnackbar('error', 'Terjadi kesalahan pada saat hapus transaksi', error.toString()));

        loadingDelete.value = false;
        pinController.text = "";
        if (Get.isSnackbarOpen) Get.back();
        showSnackbar('success', 'Berhasil', 'Transaksi berhasil dihapus');
      }
      
    } catch (e) {
      loadingDelete.value = false;
      showSnackbar('error', 'Terjadi kesalahan saat hapus transaksi', e.toString());
    }

  }
}