import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../component/logo.dart';
import '../../../component/widget_model.dart';
import '../../../constant.dart';

class Header extends StatelessWidget {
  Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const FaIcon(FontAwesomeIcons.wallet, color: Colors.orange, size: 70,),
          const SizedBox(height: kSpaceL),
          dText("Yuk ikutan, ada yang baru nih.", 
            fontWeight: FontWeight.bold, 
            fontSize: 34,
            color: Theme.of(Get.context!).bottomNavigationBarTheme.selectedItemColor!
          ),
          const SizedBox(height: kSpaceS),
          dText("Gunakan akunmu di sini untuk mulai aktifitasmu", fontSize: 16, textAlign: TextAlign.center, color: Theme.of(Get.context!).bottomNavigationBarTheme.selectedItemColor!),
        ],
      ),
    );
  }
}