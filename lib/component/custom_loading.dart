import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant.dart';
import 'widget_model.dart';

class MyLoading{

  MyLoading({this.title});
  final String? title;

  void loading() {
    showDialog(
      barrierDismissible: false,
      barrierColor: Colors.black26,
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: SizedBox(width: 40, height: 40, child: CircularProgressIndicator(strokeWidth: 6, backgroundColor: Colors.black12))),
          content: dText(title!, textAlign: TextAlign.center),
          contentPadding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(kRadiusS))),
        );
      },
    );
  }
}
