import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LandingController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final dataUser = {}.obs;

  @override
  void onInit() {
    getUserInformation();
    super.onInit();
  }

  getUserInformation() {
    if (auth.currentUser != null) {
      dataUser.value = {
        "name" :auth.currentUser!.displayName,
        "email" :auth.currentUser!.email,
        "photoUrl" :auth.currentUser!.photoURL,
        "emailVerified" :auth.currentUser!.emailVerified,
        "uid" :auth.currentUser!.uid,
      };
    } 
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore.collection("customer").doc(uid).snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamTransaction() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore.collection("transaction").doc(uid).snapshots();
  }
}