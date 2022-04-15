import 'package:flutter/material.dart';

import '../../../component/widget_model.dart';
import '../../../constant.dart';

class HeaderRegister extends StatelessWidget {
  const HeaderRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Image.asset('assets/images/img1.png', width: 200),
          // SizedBox(height: kSpaceL),
          // Logo(
          //   color: kPrimaryColor,
          //   size: 50.0,
          // ),
          const SizedBox(height: kSpaceM),
          dText('Get registered', fontWeight: FontWeight.bold, fontSize: 34),
          const SizedBox(height: kSpaceS),
          dText("For those of you who don't have an account, you can create one here", fontSize: 16),
        ],
      ),
    );
  }
}