import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:quantum_admin/component/widget_model.dart';
import 'package:quantum_admin/constant.dart';
import 'package:quantum_admin/controller/auth_controller.dart';
import 'package:quantum_admin/route/route_name.dart';

import '../../component/empty_data.dart';
import '../../controller/landing_controller.dart';
import 'confirmation.dart';

class Landing extends StatelessWidget {
  Landing({Key? key}) : super(key: key);
  final authC = Get.find<AuthController>();
  final landingC = Get.put<LandingController>(LandingController());

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
        title: Obx(() => 
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dText(landingC.dataUser['email'], fontSize: 18),
              // dText("uid : ${landingC.dataUser['uid']}", fontSize: 10)

            ],
          )
        ),
        actions: [
          IconButton(
            onPressed: () => authC.signOut(), 
            icon: const Icon(Icons.logout)
          )
        ],
      ),
      body: Obx(() => 
        landingC.dataUser['role'] == 'admin'
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AdminHeader(landingC: landingC),
              const Divider(thickness: 6),
              Padding(
                padding: const EdgeInsets.only(left: kSpaceM, top: kSpaceS, bottom: kSpaceS),
                child: dText("Riwayat semua transaksi", fontWeight: FontWeight.bold),
              ),
              AdminTransaction(landingC: landingC)
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomerHeader(landingC: landingC),
              const Divider(thickness: 6),
              Padding(
                padding: const EdgeInsets.only(left: kSpaceM, top: kSpaceS, bottom: kSpaceS),
                child: dText("Riwayat transaksimu", fontWeight: FontWeight.bold),
              ),
              CustomerTransaction(landingC: landingC)
            ],
          )
      )
    );
  }
}

class CustomerTransaction extends StatelessWidget {
  const CustomerTransaction({
    Key? key,
    required this.landingC,
  }) : super(key: key);

  final LandingController landingC;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: landingC.streamCustomerTransaction(),
        builder: (context, snapshot) {
          // log(snapshot.data!.docs.toString());
          if (snapshot.hasError) {
            return EmptyData(
              asset: Lottie.asset("assets/lotties/no-data-1.json", width: 170, height: 170),
              title: "Terjadi kesalahan pada sistem",
              subTitle: "Mohon maaf ada gangguan teknis, Tunggu bebrapa saat lagi atau langsung hubungi admin.",
            );
          }
    
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return EmptyData(
              asset: Lottie.asset("assets/lotties/no-data-1.json", width: 170, height: 170),
              title: "Belum ada data transaksi pembayaranmu",
              subTitle: "Jika kamu sudah pernah melakukan pembayaran, maka datanya akan tampil disini",
            );
          } else {
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                  return ListTile(
                    dense: true,
                    leading: FaIcon(data['tipe'] == 'pembayaran' ? FontAwesomeIcons.signOutAlt : FontAwesomeIcons.signInAlt, color: data['tipe'] == 'pembayaran' ? kErrorColor : Colors.green[600], size: 26,),
                    title: dText(data['email'], fontSize: 16),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        dText(DateFormat.yMEd().add_jm().format(DateTime.parse(data['tanggal_transaksi'])), fontSize: 12, fontWeight: FontWeight.w600),
                        dText("Transaction ID : ${document.id}", fontSize: 10, fontWeight: FontWeight.w500),
                      ]
                    ),
                    // subtitle: dText(DateFormat.yMEd().add_jm().format(DateTime.parse(data['tanggal_transaksi'])), fontSize: 12, fontWeight: FontWeight.w600),
                    trailing: dText("Rp ${NumberFormat('#,##0', 'id_ID').format(data['nominal'])}", fontSize: 14, fontWeight: FontWeight.bold, color: data['tipe'] == 'pembayaran' ? kErrorColor : Colors.green[600])
                  );
                }).toList(),
              );
          }
    
          // if (snapshot.connectionState == ConnectionState.waiting) { 
          //   return const Center(child: CircularProgressIndicator());
          // }
          // // if (snapshot.connectionState == ConnectionState.done) {
          //   if (snapshot.data!.exists) {
          //     return dText("ada datanya", fontSize: 36, fontWeight: FontWeight.bold);
    
          //   } else {
          //     return EmptyData(
          //       asset: Lottie.asset("assets/lotties/no-data-1.json", width: 170, height: 170),
          //       title: "Belum ada data transaksi pembayaranmu",
          //       subTitle: "Jika kamu sudah pernah melakukan pembayaran, maka datanya akan tampil disini",
          //     );
          //   }
          // // }
        }
      ),
    );
  }
}

class CustomerHeader extends StatelessWidget {
  const CustomerHeader({
    Key? key,
    required this.landingC,
  }) : super(key: key);

  final LandingController landingC;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kSpaceM),
      child: Column(
        children: [
          const FaIcon(FontAwesomeIcons.wallet, color: Colors.orange, size: 50,),
          const SizedBox(height: kSpaceM),
          dText("Sisa Saldomu", fontSize: 16),

          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: landingC.streamUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) return const CircularProgressIndicator();
              return dText("Rp ${NumberFormat('#,##0', 'id_ID').format(snapshot.data!.data()!['saldo_wallet'])}", fontSize: 36, fontWeight: FontWeight.bold);
            }
          ),
          
          const SizedBox(height: kSpaceM),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  MaterialButton(
                    onPressed: () => Get.toNamed(RouteName.qrCode),
                    color: Colors.lightBlue[600],
                    textColor: Colors.white,
                    child: const Icon(Icons.qr_code_2_outlined),
                    padding: const EdgeInsets.all(14),
                    shape: const CircleBorder(),
                  ),
                  const SizedBox(height: 4),
                  dText("QR Code", fontSize: 12)
                ],
              ),
              // Column(
              //   children: [
              //     MaterialButton(
              //       onPressed: () {},
              //       color: Colors.lightBlue[600],
              //       textColor: Colors.white,
              //       child: const Icon(Icons.bar_chart_outlined),
              //       padding: const EdgeInsets.all(14),
              //       shape: const CircleBorder(),
              //     ),
              //     const SizedBox(height: 4),
              //     dText("Laporan", fontSize: 12)
              //   ],
              // ),
            ],
          ),
        ]
      ),
    );
  }
}

class AdminHeader extends StatelessWidget {
  const AdminHeader({
    Key? key,
    required this.landingC,
  }) : super(key: key);

  final LandingController landingC;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kSpaceM),
      child: Column(
        children: [
          const FaIcon(FontAwesomeIcons.wallet, color: Colors.orange, size: 50,),
          const SizedBox(height: kSpaceM),
          dText("Total Saldo Customer", fontSize: 16),

          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: landingC.streamUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) return const CircularProgressIndicator();
              return dText("Rp ${NumberFormat('#,##0', 'id_ID').format(snapshot.data!.data()!['saldo_wallet'])}", fontSize: 36, fontWeight: FontWeight.bold);
            }
          ),
          
          const SizedBox(height: kSpaceM),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  MaterialButton(
                    onPressed: () => Get.toNamed(RouteName.scanQrCode),
                    color: Colors.lightBlue[600],
                    textColor: Colors.white,
                    // child: const FaIcon(FontAwesomeIcons.qrcode, size: 20,),
                    child: const Icon(Icons.qr_code_2_outlined),
                    padding: const EdgeInsets.all(14),
                    shape: const CircleBorder(),
                  ),
                  const SizedBox(height: 4),
                  dText("Scan Code", fontSize: 12)
                ],
              ),
              Column(
                children: [
                  MaterialButton(
                    onPressed: () => Get.toNamed(RouteName.customer),
                    color: Colors.lightBlue[600],
                    textColor: Colors.white,
                    child: const Icon(Icons.people_alt_outlined),
                    padding: const EdgeInsets.all(14),
                    shape: const CircleBorder(),
                  ),
                  const SizedBox(height: 4),
                  dText("Customer", fontSize: 12)
                ],
              ),
              Column(
                children: [
                  MaterialButton(
                    onPressed: () {},
                    color: Colors.lightBlue[600],
                    textColor: Colors.white,
                    child: const Icon(Icons.bar_chart_outlined),
                    padding: const EdgeInsets.all(14),
                    shape: const CircleBorder(),
                  ),
                  const SizedBox(height: 4),
                  dText("Laporan", fontSize: 12)
                ],
              ),
            ],
          ),
        ]
      ),
    );
  }
}

class AdminTransaction extends StatelessWidget {
  const AdminTransaction({
    Key? key,
    required this.landingC,
  }) : super(key: key);

  final LandingController landingC;

  

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: landingC.streamAdminTransaction(),
        builder: (context, snapshot) {
          
          if (snapshot.hasError) {
            return EmptyData(
              asset: Lottie.asset("assets/lotties/no-data-1.json", width: 170, height: 170),
              title: "Terjadi kesalahan pada sistem",
              subTitle: "Mohon maaf ada gangguan teknis, Tunggu bebrapa saat lagi atau langsung hubungi admin.",
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data!.docs.isNotEmpty) {
              return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                  return ListTile(
                    // dense: true,
                    leading: FaIcon(data['tipe'] == 'pembayaran' ? FontAwesomeIcons.signOutAlt : FontAwesomeIcons.signInAlt, color: data['tipe'] == 'pembayaran' ? kErrorColor : Colors.green[600], size: 26,),
                    title: dText(data['email'], fontSize: 16),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        dText(DateFormat.yMEd().add_jm().format(DateTime.parse(data['tanggal_transaksi'])), fontSize: 12, fontWeight: FontWeight.w600),
                        dText("Transaction ID : ${document.id}", fontSize: 10, fontWeight: FontWeight.w500),
                      ]
                    ), 
                    trailing: dText("Rp ${NumberFormat('#,##0', 'id_ID').format(data['nominal'])}", fontSize: 14, fontWeight: FontWeight.bold, color: data['tipe'] == 'pembayaran' ? kErrorColor : Colors.green[600]),
                    onLongPress: () {
                      landingC.dataTrans.value = {
                        'transId': document.id,
                        'uid': data['user_id'],
                        'email': data['email'],
                        'tipe': data['tipe'],
                        'nominal': data['nominal'],
                      };
                      Get.bottomSheet(
                        Confirmation(),
                        enterBottomSheetDuration: const Duration(milliseconds: 300),
                        barrierColor: Colors.black38,
                        isDismissible: true,
                        enableDrag: true,
                        isScrollControlled: true,
                      );
                    },
                  );
                }).toList(),
              );
              
            } else {
              return EmptyData(
                asset: Lottie.asset("assets/lotties/no-data-1.json", width: 170, height: 170),
                title: "Belum ada data transaksi pembayaranmu",
                subTitle: "Jika kamu sudah pernah melakukan pembayaran, maka datanya akan tampil disini",
              );
            }
          // }
          // return SizedBox.shrink();
        }
          
          
          
          // if (snapshot.data!.docs.isEmpty) {
          //   return EmptyData(
          //     asset: Lottie.asset("assets/lotties/no-data-1.json", width: 170, height: 170),
          //     title: "Belum ada data transaksi pembayaranmu",
          //     subTitle: "Jika kamu sudah pernah melakukan pembayaran, maka datanya akan tampil disini",
          //   );
          // } else {
          //   return ListView(
          //     children: snapshot.data!.docs.map((DocumentSnapshot document) {
          //       Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          //         // log(document.id);
          //         // log(data.toString());
          //         return Slidable(
          //           key: const ValueKey(0),
          //           endActionPane: ActionPane(
          //             motion: StretchMotion(),
          //             children: [
          //               // SlidableAction(
          //               //   // flex: 2,
          //               //   onPressed: (context) {},
          //               //   backgroundColor: Color(0xFF7BC043),
          //               //   foregroundColor: Colors.white,
          //               //   icon: Icons.archive,
          //               //   label: 'Archive',
          //               // ),
          //               SlidableAction(
          //                 onPressed: (context) {
          //                   landingC.dataTrans.value = {
          //                     'transId': document.id,
          //                     'uid': data['user_id'],
          //                     'email': data['email'],
          //                     'tipe': data['tipe'],
          //                     'nominal': data['nominal'],
          //                   };
          //                   Get.bottomSheet(
          //                     Confirmation(),
          //                     enterBottomSheetDuration: const Duration(milliseconds: 300),
          //                     barrierColor: Colors.black38,
          //                     isDismissible: true,
          //                     enableDrag: true,
          //                     isScrollControlled: true,
          //                   );
          //                 },
          //                 backgroundColor: const Color(0xFFFE4A49),
          //                 foregroundColor: Colors.white,
          //                 icon: Icons.delete,
          //                 label: 'Hapus',
          //               ),
          //             ],
          //           ),

          //           child: ListTile(
          //             // dense: true,
          //             leading: FaIcon(data['tipe'] == 'pembayaran' ? FontAwesomeIcons.signOutAlt : FontAwesomeIcons.signInAlt, color: data['tipe'] == 'pembayaran' ? kErrorColor : Colors.green[600], size: 26,),
          //             title: dText(data['email'], fontSize: 16),
          //             subtitle: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 dText(DateFormat.yMEd().add_jm().format(DateTime.parse(data['tanggal_transaksi'])), fontSize: 12, fontWeight: FontWeight.w600),
          //                 dText("Transaction ID : ${document.id}", fontSize: 10, fontWeight: FontWeight.w500),
          //               ]
          //             ), 
          //             trailing: dText("Rp ${NumberFormat('#,##0', 'id_ID').format(data['nominal'])}", fontSize: 14, fontWeight: FontWeight.bold, color: data['tipe'] == 'pembayaran' ? kErrorColor : Colors.green[600])
          //           )
          //         );
          //       }).toList(),
          //     );

          // }

          // if (snapshot.connectionState == ConnectionState.waiting) { 
          //   return const Center(child: CircularProgressIndicator());
          // }
          // // if (snapshot.connectionState == ConnectionState.done) {
          //   if (snapshot.data.) {
          //     return dText("ada datanya", fontSize: 36, fontWeight: FontWeight.bold);

          //   } else {
          //     return EmptyData(
          //       asset: Lottie.asset("assets/lotties/no-data-1.json", width: 170, height: 170),
          //       title: "Belum ada data transaksi pembayaranmu",
          //       subTitle: "Jika kamu sudah pernah melakukan pembayaran, maka datanya akan tampil disini",
          //     );
          //   }
          // }
        // }
      ),
    );
  }
}