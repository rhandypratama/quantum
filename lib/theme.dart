import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constant.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: Colors.white,
    // appBarTheme: appBarTheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      // textTheme: TextTheme(
      //   title: TextStyle(color: Colors.black),
      // ),
      // color: Colors.black26,
      // brightness: Brightness.light,
      // foregroundColor: Colors.black,
      elevation: 0
    ),
    iconTheme: const IconThemeData(color: kContentColorLightTheme),
    
    // textTheme: GoogleFonts.openSans(textStyle: TextStyle(
    //     color: Get.isDarkMode ? Colors.white : Colors.black87,
    //     fontSize: fontSize,
    //     fontWeight: fontWeight,
    //     fontStyle: fontStyle,
    //     decoration: textDecoration
    //   )),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme).apply(
      fontFamily: 'Open Sans',
      // decoration: TextDecoration.lineThrough,
      // fontFamily: 'montserrat',
      bodyColor: kContentColorLightTheme,
      // bodyColor: Colors.black
    ),
    accentTextTheme: const TextTheme(
      headline1: TextStyle(color: kContentColorLightTheme),
      headline2: TextStyle(color: Colors.black),
    ),
    colorScheme: const ColorScheme.light(
      primary: kPrimaryColor,
      secondary: kSecondaryColor,
      error: kErrorColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: kContentColorLightTheme.withOpacity(0.8),
      unselectedItemColor: kContentColorLightTheme.withOpacity(0.22),
      selectedIconTheme: const IconThemeData(color: kPrimaryColor),
      showUnselectedLabels: true,
    ),
  );
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: kContentColorLightTheme,
    // appBarTheme: appBarTheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      // color: Colors.white24,
      // foregroundColor: Colors.white,
      // color: Colors.black,
      // brightness: Brightness.light,
      elevation: 0
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme).apply(
      fontFamily: 'Open Sans',
      bodyColor: kContentColorDarkTheme),
    accentTextTheme: const TextTheme(
      headline1: TextStyle(color: kContentColorDarkTheme),
      headline2: TextStyle(color: Colors.white),
    ),
    colorScheme: const ColorScheme.dark().copyWith(
      primary: kPrimaryColor,
      secondary: kSecondaryColor,
      error: kErrorColor,
    ),
    
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      // backgroundColor: kContentColorLightTheme,
      backgroundColor: Colors.white10,
      selectedItemColor: kContentColorDarkTheme.withOpacity(0.72),
      unselectedItemColor: kContentColorDarkTheme.withOpacity(0.22),
      selectedIconTheme: const IconThemeData(color: kPrimaryColor),
      showUnselectedLabels: true,
    ),
    
  );
}

// ThemeData lightThemeData(BuildContext context) {
//   return ThemeData(
//     scaffoldBackgroundColor: Colors.white,
//     appBarTheme: AppBarTheme(
//       color: Colors.teal,
//       iconTheme: IconThemeData(
//         color: Colors.white,
//       ),
//     ),
//     colorScheme: ColorScheme.light(
//       primary: Colors.white,
//       onPrimary: Colors.white,
//       primaryVariant: Colors.white38,
//       secondary: Colors.red,
//     ),
//     cardTheme: CardTheme(
//       color: Colors.teal,
//     ),
//     iconTheme: IconThemeData(
//       color: Colors.white54,
//     ),
//     textTheme: TextTheme(
//       title: TextStyle(
//         color: Colors.black87,
//       ),
//       subtitle: TextStyle(
//         color: Colors.black87,
//       ),
//       button: TextStyle(
//         color: Colors.white,
//       ),
//     ),
//   );
// }

// ThemeData darkThemeData(BuildContext context) {
//   return ThemeData(
//     scaffoldBackgroundColor: kContentColorLightTheme,
//     appBarTheme: AppBarTheme(
//       color: Colors.black,
//       iconTheme: IconThemeData(
//         color: Colors.white,
//       ),
//     ),
//     colorScheme: ColorScheme.light(
//       primary: Colors.black,
//       onPrimary: Colors.black,
//       primaryVariant: Colors.black,
//       secondary: Colors.red,
//     ),
//     cardTheme: CardTheme(
//       color: Colors.black,
//     ),
//     iconTheme: IconThemeData(
//       color: Colors.white54,
//     ),
//     textTheme: TextTheme(
//       title: TextStyle(
//         color: Colors.white,
//       ),
//       subtitle: TextStyle(
//         color: Colors.white70,
//       ),
//       button: TextStyle(
//         color: Colors.white,
//       ),
//     ),
//   );
// }
// final appBarTheme = AppBarTheme(centerTitle: false, elevation: 0);