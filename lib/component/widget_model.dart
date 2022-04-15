// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../constant.dart';

dText(
  String? text,
  {
    // Color color = Colors.black87,
    Color? color,
    // Color color = Theme.of(Get.context!).textTheme.title.color,
    // Color color = Get.isDarkMode ? Colors.white : Colors.black87,
    double fontSize = 16,
    FontWeight? fontWeight,
    FontStyle fontStyle = FontStyle.normal,
    TextOverflow? overflow,
    TextAlign? textAlign,
    bool price = false,
    bool number = false,
    // String fontFamily = "OpenSans",
    int? maxLines,
    TextDecoration? textDecoration
  }) {
  
  return Text(
    text!,
    style: GoogleFonts.openSans(
      textStyle: TextStyle(
        // fontFamily: fontFamily,
        
        // color: Theme.of(Get.context!).textTheme.title!.color,
        // color: Theme.of(Get.context!).accentTextTheme.headline1!.color,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        decoration: textDecoration
      )
    ),
    overflow: overflow,
    textAlign: textAlign,
    maxLines: maxLines,
  );
}

String? parseDecimal(String? value) {
  if (value != "0") {
    value = value!.substring(0, value.length - 3);
    value = value.replaceAll(",", ".");
  }
  return value;
}

String? onlyNumber(String? value) {
  if (value != "0") {
    value = value!.substring(0, value.length - 3);
    value = value.replaceAll(",", "");
  }
  return value;
}

String? parseWaktu(String? value) {
  if (value != "0") {
    value = value!.substring(3);
    // value = value.replaceAll(",", ".");
  }
  return value;
}

String? secureText(String? value) {
  if (value != "") {
    var re = RegExp(r'\d(?!\d{0,4}$)'); // keep last n digits
    return (value!.replaceAll(re, '*')); // *******789
  }
  return value;
}

String? formatWaktu(String? value) {
  if (value != "0") {
    value = value!.substring(0, 5);
  }
  return value;
}

String? customFormatWaktu(String? value) {
  if (value != "") {
    value = value!.substring(11, 16);
  }
  return value;
}

int diffInMonth(DateTime dateTime) {
  var diffInDays = ((dateTime.difference(DateTime.now()).inDays.abs()) / 30).floor(); //diffe
  return diffInDays;
}

buttonLoading() {
  return MaterialButton(
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(kRadiusS))),
    padding: const EdgeInsets.symmetric(vertical: kDefaultPadding * 0.35),
    // color: kPrimaryColor.withOpacity(0.8),
    color: Colors.lightBlue[600],
    minWidth: double.infinity,
    onPressed: () {},
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      height: 36,
      width: 24,
      // child: CircularProgressIndicator(color: Colors.white, strokeWidth: 6, backgroundColor: Theme.of(Get.context!).bottomNavigationBarTheme.selectedItemColor!)),
      child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 6, backgroundColor: Colors.white30)),
  );
}

defaultCard(Widget content, Color? bgColor) {
  return Card(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(kRadiusS),
      side: BorderSide(
        width: 1.0, 
        // color: Get.isDarkMode ? Colors.white : Colors.black26
        color: Get.isDarkMode ? Colors.white : Theme.of(Get.context!).bottomNavigationBarTheme.unselectedItemColor!
        // color: Colors.black26
      ),
    ),
    color: bgColor,
    
    child: Container(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: content,
    ),

  );
}

customCard(Widget content) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Colors.black12,
        width: 1.0,
      ),
      gradient: const RadialGradient(
        // center: Alignment(-0.8, -0.6),
        center: Alignment(-1, 0.8),
        colors: [
          // Color.fromRGBO(3, 235, 255, 1),
          // Color.fromRGBO(152, 70, 242, 1),
          // Color.fromRGBO(255, 183, 183, 1),
          // Color.fromRGBO(163, 117, 255, 1),
          // // Colors.orange,
          // Color(0xFFE65100),
          // Color(0xFFDD2C00),
          // kSecondaryColor,
          kPrimaryColor,
          Colors.white
        ],
        radius: 1.0,
      ),
    ),
    padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
    child: content,
  

  );
}

customCardTips(String urlImage, String title, String desc) {
  return Container(
    width: 260,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Colors.black12,
        width: 1.0,
      ),
    ),
    // padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
    child: Column(
      children: [
        Expanded(
          flex: 4,
          child: Hero(
            tag: urlImage.toString(),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                image: DecorationImage(
                  image: NetworkImage(urlImage),    
                  fit: BoxFit.cover,
                ),
                
              ),
              width: double.infinity,
              // child: image,
              
            ),
          )
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: kPaddingM, horizontal: kSpaceM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dText(title, fontSize: 14, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                dText(desc, fontSize: 13, fontWeight: FontWeight.normal, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ),
      ],
    )
    
  );
}

dividerColor(Color color) {
  return Padding(
    padding: const EdgeInsets.only(top: kSpaceS),
    child: Container(
      height: 8,
      decoration: BoxDecoration(
        color: color,
        // borderRadius: BorderRadius.all(Radius.circular(40))
        // borderRadius: BorderRadius.only(
        //   topLeft: Radius.circular(40),
        //   topRight: Radius.circular(40)
        // )
      )
    ),
  );
}

bottomBarIcons({IconData? icon, String? title}) {
  return BottomNavigationBarItem(
    icon: Icon(
      icon,
      size: 24,
      // color: Colors.black45,
    ),
    activeIcon: Icon(
      icon,
      size: 24,
    ),
    label: title,
  );
}

defaultChip(String label, Color bgColor) {
  return Container(
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(kSpaceL),
    ),
    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
    child: dText(
      label, 
      fontSize: 10, 
      // color: Colors.black, 
      color: Theme.of(Get.context!).bottomNavigationBarTheme.selectedItemColor!, 
      fontWeight: FontWeight.bold
    ),
  );
}

defaultRaisedButton(String label, Function onPres) {
  return RaisedButton(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6.0),
    ),
    color: Colors.blueAccent,
    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
    onPressed: () => onPres, 
    child: dText(label, fontWeight: FontWeight.w600, fontSize: 13),
  );
}

defaultFlatButton(String label, Function onPres) {
 return FlatButton(
    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
    onPressed: () => onPres, 
    child: dText(label, fontWeight: FontWeight.w600, fontSize: 13),
  );
}

defaultImageThumb(String url) {
  return Container(
    height: 100,
    width: 100,
    decoration: BoxDecoration(
      color: Colors.blue[50],
      borderRadius: BorderRadius.circular(6),
      image: DecorationImage(
        image: NetworkImage(url)
      //   image: CachedNetworkImage(
      //     placeholder: (context, url) => CircularProgressIndicator(),
      //     imageUrl: 'https://picsum.photos/250?image=9',
      //   )
      )
    ),
    margin: const EdgeInsets.only(right: 6),
  );
}

Widget fadeInImage(String? assetImg, {String imgPlaceholder = "assets/images/img_placeholder.png", double? width, double? height}) {
  return FadeInImage.assetNetwork(
    placeholder: imgPlaceholder,
    image: assetImg ?? "https://i.stack.imgur.com/y9DpT.jpg",
    width: width,
    height: height,
    fit: BoxFit.cover,
  );
}

Widget getFontAwesome(String source) {
  switch (source) {
    case "whatsapp":
      return FaIcon(FontAwesomeIcons.whatsapp, size: 14, color: Theme.of(Get.context!).bottomNavigationBarTheme.selectedItemColor!);
    case "telegram":
      return FaIcon(FontAwesomeIcons.telegram, size: 14, color: Theme.of(Get.context!).bottomNavigationBarTheme.selectedItemColor!);
    case "line":
      return FaIcon(FontAwesomeIcons.line, size: 14, color: Theme.of(Get.context!).bottomNavigationBarTheme.selectedItemColor!);
    case "facebook":
      return FaIcon(FontAwesomeIcons.facebook, size: 18, color: Theme.of(Get.context!).bottomNavigationBarTheme.selectedItemColor!);
    case "instagram":
      return FaIcon(FontAwesomeIcons.instagram, size: 14, color: Theme.of(Get.context!).bottomNavigationBarTheme.selectedItemColor!);
    case "twitter":
      return FaIcon(FontAwesomeIcons.twitter, size: 14, color: Theme.of(Get.context!).bottomNavigationBarTheme.selectedItemColor!);
    case "email":
      return FaIcon(FontAwesomeIcons.solidEnvelope, size: 14, color: Theme.of(Get.context!).bottomNavigationBarTheme.selectedItemColor!);
    case "sms":
      return FaIcon(FontAwesomeIcons.sms, size: 14, color: Theme.of(Get.context!).bottomNavigationBarTheme.selectedItemColor!);
    case "chat":
      return FaIcon(FontAwesomeIcons.facebookMessenger, size: 14, color: Theme.of(Get.context!).bottomNavigationBarTheme.selectedItemColor!);
    case "google_play":
      return FaIcon(FontAwesomeIcons.googlePlay, size: 14, color: Theme.of(Get.context!).bottomNavigationBarTheme.selectedItemColor!);
    default:
      return const SizedBox.shrink();
  }
}

String greeting() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Good Morning';
  } else if (hour < 17) {
    return 'Good Afternoon';
  } else {
    return 'Good Evening';
  }
}

Widget spaceWidthS() {
  return const SizedBox(width: 4);
}

Widget spaceHeightS() {
  return const SizedBox(height: kSpaceS);
}

String? formatCurrency(String val) {
  final currencyFormatter = NumberFormat('#,##0', 'ID');
  // final currencyFormatter = NumberFormat('#,##0.00', 'ID');
  return currencyFormatter.format(val); // 100.286.020.524,17
  
}

showSnackbar(String? type, String? title, String? message, {bool? action = false, String? actionText,Function()? onTap}) {
  return Get.snackbar(
    '','',
    titleText: Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpaceM, vertical: 0),
      child: dText(title, fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
    ), 
    messageText: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kSpaceM, vertical: 0),
          child: dText(message, fontSize: 14, color: Colors.white),
        ),
        action == true
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: kSpaceM, vertical: 6),
            child: OutlinedButton(
              child: dText(actionText, fontSize: 14, color: Colors.white),
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                // primary: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: kSpaceM, vertical: 0),
                // side: BorderSide(color: borderColor, width: 1),
                shape: const StadiumBorder(),
              ),
            ),
          )
        : const SizedBox.shrink()
      ],
    ),
    backgroundColor: type == 'error' ? kErrorColor : Colors.green,
    // borderRadius: kRadiusS,
    borderRadius: 0,
    snackPosition: SnackPosition.BOTTOM,
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    duration: action == false ? const Duration(seconds: 5) : const Duration(seconds: 15),
    animationDuration: const Duration(milliseconds: 200),
    margin: const EdgeInsets.all(0), 
  );
}