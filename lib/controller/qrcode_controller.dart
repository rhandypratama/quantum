import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../component/widget_model.dart';
import '../route/route_name.dart';

class QrCodeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final loading = false.obs;

  Future getUserInformation(String? uid) async {
    try {
      loading.value = true;
      if (uid != null) {
        await firestore
          .collection('customer')
          .doc(uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              Get.offAndToNamed(RouteName.transaction, parameters: {"uid" : uid});
            } else {
              showSnackbar('error', 'Terjadi Kesalahan', 'Tidak dapat menemukan data customer');
            }
          
          }).catchError((error) => showSnackbar('error', 'Terjadi Kesalahan', error.toString()));
      }
      // log(uid.toString());
      loading.value = false;
    } catch (e) {
      loading.value = false;
      showSnackbar('error', 'Terjadi kesalahan', e.toString());
    }
  }

}