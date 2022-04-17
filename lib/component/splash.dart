import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import '../constant.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: FaIcon(FontAwesomeIcons.wallet, color: Colors.orange, size: 100),
        ),
      ),
    );
  }
}