import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:personel_v1/controller/landing_controller.dart';
import '../component/widget_model.dart';
// import '../helper/api_helper.dart';
import '../route/route_name.dart';

import '../constant.dart';
import 'auth_state.dart';

// final landingC = Get.find<LandingController>();

class AuthController extends GetxController {
  GetStorage box = GetStorage();
  
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;


  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailResetController = TextEditingController();
  
  final loading = false.obs;

  @override
  void onInit() {
    // auth
    //   .authStateChanges()
    //   .listen((User? user) {
    //     if (user == null) {
    //       Get.offAllNamed(RouteName.signin);
    //       log('sudah logout / belum login');
    //     } else {
    //       Get.offAllNamed(RouteName.landing);
    //       log('sudah login');
    //     }
    // });
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    emailResetController.dispose();
    super.onClose();
  }

  Future<void> signOut() async {
    try {
      auth.signOut();
    } catch (e) {
      showSnackbar('error', 'Terjadi kesalahan', e.toString());
    } finally {
      Get.offAllNamed(RouteName.signin);
    }
  }

  Future<void> register() async {
    try {
      loading.value = true;
      if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
        // REGISTER
        UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(), 
          password: passwordController.text.trim()
        );

        if (userCredential.user != null) {
          String uid = userCredential.user!.uid;
          String role = "customer";
          if (emailController.text.trim() == "gusnemat@gmail.com") {
            role = "admin";
          }
          firestore.collection("customer").doc(uid).set({
            "uid" : uid,
            "email" : emailController.text.trim(),
            "role" : role,
            "saldo_wallet" : 0,
            "created_at" : DateTime.now().toIso8601String(),
          });
          await userCredential.user!.sendEmailVerification();

          // OTOMATIS SIGN IN
          // var result = await auth.signInWithEmailAndPassword(
          //   email: emailController.text.trim(),
          //   password: passwordController.text.trim()
          // );
          // log(result.toString());
          // Get.offAllNamed(RouteName.landing);
          showSnackbar('success', 'Selamat Bergabung', 'Akunmu berhasil terdaftar, silahkan cek inbox emailmu untuk proses verifikasi selanjutnya');
        }
      } else {
        showSnackbar('error', 'Terjadi kesalahan', 'Email harus valid dan Password wajib diisi');
      }
      loading.value = false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackbar('error', 'Password', 'Password minimal harus 6 karakter');
      } else if (e.code == 'email-already-in-use') {
        try {
          // SIGN IN
          UserCredential userSignIn = await auth.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim()
          );
          log(userSignIn.toString());
          if (userSignIn.user != null) {
            if (userSignIn.user!.emailVerified == true) {
              Get.offAllNamed(RouteName.landing);
            } else {
              showSnackbar(
                'success', 
                'Verifikasi user', 
                'Proses verifikasi user diperlukan. Silahkan cek emailmu dan ikuti langkah selanjutnya.',
                action: true,
                actionText: 'Kirim ulang email verifikasi',
                onTap: () async { 
                  await userSignIn.user!.sendEmailVerification().then((_) {
                    if (Get.isSnackbarOpen) Get.back();
                    showSnackbar('success', 'Berhasil kirim ulang email verifikasi', 'Email verifikasimu berhasil terkirim. Mohon periksa emailmu dan ikuti langkah selanjutnya');
                  });
                }
              );
              auth.signOut();
            }
          }
        } on FirebaseAuthException catch(e) {
          if (e.code == 'user-not-found') {
            showSnackbar('error', 'Terjadi kesalahan', 'User tidak dapat ditemukan');
          } else if (e.code == 'wrong-password') {
            showSnackbar('error', 'Terjadi kesalahan', 'Password tidak valid');
          }
        } catch (e) {
          showSnackbar('error', 'Terjadi kesalahan Sign In', e.toString());
        }
        
      }
      loading.value = false;
    } catch (e) {
      loading.value = false;
      showSnackbar('error', 'Terjadi kesalahan', e.toString());
      log(e.toString());
    }
  }

  Future<void> sendResetPassword() async {
    try {
      loading.value = true;
      if (emailResetController.text.isNotEmpty) {
        await auth.sendPasswordResetEmail(email: emailResetController.text.trim());
        showSnackbar('success', 'Selamat', 'Kami sudah mengirimkan email verifikasi reset password ke emailmu, mohon cek di inbox dan ikuti proses selanjutnya.');
      } else {
        showSnackbar('error', 'Terjadi kesalahan', 'Email tidak boleh kosong');
      }
      loading.value = false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        showSnackbar('error', 'Terjadi kesalahan', 'Email tidak valid');
      }
      loading.value = false;
    } catch (e) {
      loading.value = false;
      showSnackbar('error', 'Terjadi kesalahan', e.toString());
      log("CATCH ERROR SEND RESET PASSWORD : ${e.toString()}");
    }
    
  }
}