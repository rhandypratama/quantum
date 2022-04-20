import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CustomerController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final dataUser = {}.obs;
  final role = "".obs;

  @override
  void onInit() async {
    // await getUserInformation();
    // getDetailUser();
    super.onInit();
  }

  getUserInformation() async {
    if (auth.currentUser != null) {
      dataUser.value = {
        "name" : auth.currentUser!.displayName,
        "email" : auth.currentUser!.email,
        "photoUrl" : auth.currentUser!.photoURL,
        "emailVerified" : auth.currentUser!.emailVerified,
        "uid" : auth.currentUser!.uid,
        // "role" : documentSnapshot.get('role'),
      };

      String uid = auth.currentUser!.uid;
      await firestore
        .collection('customer')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            // log("Document data: ${documentSnapshot.get('role')}");
            // role.value = documentSnapshot.get('role');
            dataUser.value = {
              "name" : auth.currentUser!.displayName,
              "email" : auth.currentUser!.email,
              "photoUrl" : auth.currentUser!.photoURL,
              "emailVerified" : auth.currentUser!.emailVerified,
              "uid" : auth.currentUser!.uid,
              "role" : documentSnapshot.get('role'),
            };
          }
        });
    } 
  }

  // getDetailUser() async {
  //   String uid = auth.currentUser!.uid;
  //   await firestore
  //     .collection('customer')
  //     .doc(uid)
  //     .get()
  //     .then((DocumentSnapshot documentSnapshot) {
  //       if (documentSnapshot.exists) {
  //         log("Document data: ${documentSnapshot.get('role')}");
  //       }
  //     });
  //   // log("DETAIL USER ===> ${result.toString()}");
  // }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamAllCustomer() async* {
    yield* firestore.collection("customer").snapshots();
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
      // .get();
  }
}