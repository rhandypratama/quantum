import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant.dart';
import 'widget_model.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({ Key? key, required this.title }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return 
    // MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   home: 
      Scaffold(
        body: Center(
          child: Container(
            width: Get.width,
            // color: Colors.white,
            color: Theme.of(Get.context!).scaffoldBackgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(width: Get.width * 0.3, child: Image.asset("assets/images/new-logo-loading.gif")),
                CircularProgressIndicator(strokeWidth: 6, backgroundColor: Theme.of(Get.context!).bottomNavigationBarTheme.unselectedItemColor!, color: kPrimaryColor),
                const SizedBox(height: kDefaultPadding),
                dText(title, color: Theme.of(Get.context!).bottomNavigationBarTheme.selectedItemColor!),
              ],
            )
          ),
        ),
        
      // ),
    );
  }
}