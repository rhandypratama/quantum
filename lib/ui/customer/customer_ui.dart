import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:quantum_admin/component/widget_model.dart';
// import 'package:quantum_admin/constant.dart';
import 'package:quantum_admin/controller/customer_controller.dart';
// import 'package:quantum_admin/route/route_name.dart';

import '../../component/empty_data.dart';

class Customer extends StatelessWidget {
  Customer({Key? key}) : super(key: key);
  final customerC = Get.put<CustomerController>(CustomerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.lightBlue[800],
        backgroundColor: Colors.green,
        // leading: SizedBox(
        //   height: 5,
        //   width: 5,
        //   child: CircleAvatar(
        //     child: dText("M"),
        //   ),
        // ),
        title: StreamBuilder<QuerySnapshot>(
          stream: customerC.streamAllCustomer(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) return dText("List Semua Customer (0)", fontSize: 18);
            if (snapshot.data!.docs.isEmpty) {
              return dText("List Semua Customer (0)", fontSize: 18);
            } else {
              return dText("List Semua Customer (${snapshot.data!.docs.length})", fontSize: 18);
            }
          }
        ),
        
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: customerC.streamAllCustomer(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: SizedBox(width: 50, height: 50, child: CircularProgressIndicator()));
                }
                if (snapshot.data!.docs.isEmpty) {
                  return EmptyData(
                    asset: Lottie.asset("assets/lotties/no-data-1.json", width: 170, height: 170),
                    title: "Belum ada data customer",
                    subTitle: "Yuk bisa yuk, daftarkan temanmu disini agar bisa bertransaksi denganmu",
                  );
                } else {
                  return ListView(
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                        return ListTile(
                          dense: true,
                          leading: CircleAvatar(child: dText(data['email'].toString().substring(0, 1).toUpperCase(), color: Colors.black, fontSize: 18), backgroundColor: Colors.orange,),
                          title: dText(data['email'], fontSize: 16),
                          subtitle: dText("${data['role']} - ${data['uid']}", fontSize: 10, fontWeight: FontWeight.w600),
                          trailing: dText("Rp ${NumberFormat('#,##0', 'id_ID').format(data['saldo_wallet'])}", fontSize: 14, fontWeight: FontWeight.bold)
                        );
                      }).toList(),
                    );
                }
              }
            ),
          )
        ],
      )
    );
  }
}