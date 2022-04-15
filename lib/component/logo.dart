// import 'dart:math';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';

class Logo extends StatelessWidget{
  final Color color;
  final double size;

  const Logo({
    Key? key,
    required this.color,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final animation = listenable as Animation<double>;
    // return Transform.rotate(
    //   angle: -pi / 4,
    //   // angle: -pi / 90,
    //   // child: Icon(
    //   //   Icons.wb_incandescent_outlined,
    //   //   color: color,
    //   //   size: size,
    //   // ),
    //   child: Get.isDarkMode ? Image.asset('assets/images/logo-white.png', width: size) : Image.asset('assets/images/logo-color.png', width: size),
    // );
    return SizedBox(
      child: 
      // Get.isDarkMode 
        Image.asset('assets/images/new-logo-small.png', width: size,) 
        // Image.asset('assets/images/default_logo.png', width: size,) 
        // Image.asset('assets/images/logo-small.png', width: size,) 
        // ? Image.asset('assets/images/logo-small.png', width: size,) 
        // : SvgPicture.asset('assets/images/logo.svg', width: size, cacheColorFilter: true,)
        // ? Image.asset('assets/images/logo-white.png', width: size) 
        // : Image.asset('assets/images/logo-color.png', width: size)
      );
  }
}