// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/landing_controller.dart';

import '../../../component/line_modal.dart';
import '../../../component/widget_model.dart';
import '../../../constant.dart';

class Confirmation extends StatelessWidget {
  Confirmation({Key? key}) : super(key: key);
  
  final landingC = Get.find<LandingController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(Get.context!).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(kRadiusS),
            topRight: Radius.circular(kRadiusS)
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: kDefaultPadding, top: 8),
              alignment: const Alignment(0.0, 0),
              child: const LineModal()
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: dText('Kamu akan menghapus transaksi ini', fontSize: 20, fontWeight:FontWeight.bold)
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(kDefaultPadding, 0, kDefaultPadding, kSpaceS),
              child: dText("Apakah yakin mau melanjutkan?", fontWeight:FontWeight.normal, fontSize: 16)
            ),
            const SizedBox(height: kSpaceS),
            Container(
              width: Get.width,
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kSpaceS),
              child: Obx(() =>
                landingC.loadingDelete.value
                ? buttonLoading()
                : ElevatedButton(
                    onPressed: () async {
                      if (Get.isBottomSheetOpen!) Get.back();
                      await landingC.deleteTransaction();
                    },
                    child: dText("OK, SETUJU", fontSize: 16, fontWeight:FontWeight.bold),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: 14),
                      elevation: 0,
                      // primary: kErrorColor,
                    ),
                  )
              ),
            ),
            Container(
              width: Get.width,
              padding: const EdgeInsets.only(left: kDefaultPadding, right: kDefaultPadding, bottom: kSpaceM),
              child: ElevatedButton(
                onPressed: () {
                  if (Get.isBottomSheetOpen!) Get.back();
                },
                child: dText("BATAL", fontSize: 16, fontWeight:FontWeight.bold, color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(width: 1, color: kGrayColor)
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: 14),
                  elevation: 0,
                  primary: kBackgroundCardLight,
                ),
              ),
            ),
            
          ],
        )
      ),
    );
  }
}