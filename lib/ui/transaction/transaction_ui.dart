import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:quantum_admin/component/primary_button.dart';
import 'package:quantum_admin/component/widget_model.dart';
import 'package:quantum_admin/constant.dart';
import 'package:quantum_admin/controller/transaction_controller.dart';
import 'package:quantum_admin/route/route_name.dart';

import '../../component/form_input_field_with_icon.dart';
import '../../helper/validator.dart';
import 'confirmation.dart';

class Transaction extends StatelessWidget {
  Transaction({Key? key}) : super(key: key);
  final transC = Get.put<TransactionController>(TransactionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dText("Transaksi Customer", fontSize: 18),
          ],
        )
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(transC: transC),
          ],
        ),
      )
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.transC,
  }) : super(key: key);

  final TransactionController transC;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      padding: const EdgeInsets.all(kSpaceM),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: kSpaceM),
          const FaIcon(FontAwesomeIcons.child, color: Colors.orange, size: 70,),
          const SizedBox(height: kSpaceM),
          transC.dataUser['email'] == ""
          ? dText("User tidak ditemukan", fontSize: 16, fontWeight: FontWeight.bold)
          : dText("${transC.dataUser['email']}", fontSize: 16, fontWeight: FontWeight.bold),
          const SizedBox(height: kSpaceL),
          dText("Sisa Saldo", fontSize: 16),
          // dText("Rp ${NumberFormat('#,##0', 'id_ID').format(transC.dataUser['saldo_wallet'])}", fontSize: 36, fontWeight: FontWeight.bold),
    
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: transC.streamUser(),
            builder: (context, snapshot) {
              // log(snapshot.data.toString());
              if (snapshot.connectionState == ConnectionState.waiting) return const CircularProgressIndicator();
              if (snapshot.hasError) {
                return dText("-", fontSize: 36, fontWeight: FontWeight.bold);
              } else {
                if (snapshot.data!.exists) {
                  return dText("Rp ${NumberFormat('#,##0', 'id_ID').format(snapshot.data!.data()!['saldo_wallet'])}", fontSize: 36, fontWeight: FontWeight.bold);
                } else {
                  return dText("-", fontSize: 36, fontWeight: FontWeight.bold);
                }
              }
              
            }
          ),
          const SizedBox(height: kSpaceL),
          FormInputFieldWithIcon(
            controller: transC.nominalController,
            iconPrefix: Icons.paid,
            labelText: 'Nominal',
            validator: Validator().email,
            keyboardType: TextInputType.number,
            onChanged: (_) {},
            onSaved: (value) => transC.nominalController.text = value!,
          ),
          const SizedBox(height: kSpaceL),
          Obx(() =>
            transC.loading.value
            ? buttonLoading()
            : 
            PrimaryButton(
              text: "Top Up", 
              press: () {
                transC.tipeTransaksi.value = 'top up';
                Get.bottomSheet(
                  Confirmation(),
                  enterBottomSheetDuration: const Duration(milliseconds: 300),
                  barrierColor: Colors.black38,
                  isDismissible: true,
                  enableDrag: true,
                  isScrollControlled: true,
                );
              }
            )),
          //   MaterialButton(
          //       shape: const RoundedRectangleBorder(
          //         borderRadius: BorderRadius.all(Radius.circular(kRadiusS)),
          //         side: BorderSide.none
          //       ),
          //       padding: const EdgeInsets.all(kSpaceM),
          //       color: Colors.green,
          //       minWidth: double.infinity,
          //       elevation: 0,
          //       child: dText("Top Up", color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          //       onPressed: () {
          //         transC.tipeTransaksi.value = 'top up';
          //         Get.bottomSheet(
          //           Confirmation(),
          //           enterBottomSheetDuration: const Duration(milliseconds: 300),
          //           barrierColor: Colors.black38,
          //           isDismissible: true,
          //           enableDrag: true,
          //           isScrollControlled: true,
          //         );
          //       },
          //       // child: dText(text, fontSize: 18, fontWeight: FontWeight.w600),
          //     ),
          // ),
          const SizedBox(height: kSpaceS),
          Obx(() =>
            transC.loading.value
            ? buttonLoading()
            : 
            PrimaryButton(
              text: "Pembayaran", 
              press: () {
                transC.tipeTransaksi.value = 'pembayaran';
                Get.bottomSheet(
                  Confirmation(),
                  enterBottomSheetDuration: const Duration(milliseconds: 300),
                  barrierColor: Colors.black38,
                  isDismissible: true,
                  enableDrag: true,
                  isScrollControlled: true,
                );
              }
            )
            // MaterialButton(
            //     shape: const RoundedRectangleBorder(
            //       borderRadius: BorderRadius.all(Radius.circular(kRadiusS)),
            //       side: BorderSide.none
            //     ),
            //     padding: const EdgeInsets.all(kSpaceM),
            //     color: Colors.red,
            //     minWidth: double.infinity,
            //     elevation: 0,
            //     child: dText("Pembayaran", color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            //     onPressed: () {
            //       transC.tipeTransaksi.value = 'pembayaran';
            //       Get.bottomSheet(
            //         Confirmation(),
            //         enterBottomSheetDuration: const Duration(milliseconds: 300),
            //         barrierColor: Colors.black38,
            //         isDismissible: true,
            //         enableDrag: true,
            //         isScrollControlled: true,
            //       );
            //     }
            //     // child: dText(text, fontSize: 18, fontWeight: FontWeight.w600),
            //   ),
          ),
          const SizedBox(height: kSpaceS),
          Obx(() =>
            transC.loading.value
            ? buttonLoading()
            : 
            PrimaryButton(
              text: "Tarik Saldo", 
              press: () {
                transC.tipeTransaksi.value = 'tarik saldo';
                Get.bottomSheet(
                  Confirmation(),
                  enterBottomSheetDuration: const Duration(milliseconds: 300),
                  barrierColor: Colors.black38,
                  isDismissible: true,
                  enableDrag: true,
                  isScrollControlled: true,
                );
              }
            )
          )
        ]
      ),
    ));
  }
}