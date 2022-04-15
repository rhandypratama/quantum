import 'package:flutter/material.dart';
import '../constant.dart';

import 'widget_model.dart';

class EmptyData extends StatelessWidget {
  const EmptyData({Key? key, required this.asset, required this.title, required this.subTitle}) : super(key: key);
  final Widget asset;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            asset,
            title == "" ? const SizedBox.shrink() : const SizedBox(height: kDefaultPadding),
            dText(title, fontSize: 20.0, fontWeight: FontWeight.bold, textAlign: TextAlign.center),
            title == "" ? const SizedBox.shrink() : const SizedBox(height: kSpaceS),
            dText(subTitle, fontSize: 16.0, textAlign: TextAlign.center),
          ]),
      ),
    );

    // return Stack(
    //   children: [
    //     Container(color: kPrimaryColor.withOpacity(0.4), width: double.infinity, height: double.infinity,),
    //     Positioned(
    //       right: 0,
    //       left: 0,
    //       bottom: 0,
    //       child: Container(
    //         height: 200,
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.only(
    //             topLeft: Radius.circular(200),
    //             topRight: Radius.circular(200)
    //           ),
    //           color: Colors.white
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}