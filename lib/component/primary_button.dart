import 'package:flutter/material.dart';

import '../constant.dart';
import 'widget_model.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = kPrimaryColor,
    // this.padding = const EdgeInsets.all(kDefaultPadding * 0.89),
    this.padding = const EdgeInsets.all(kDefaultPadding * 0.69),
  }) : super(key: key);

  final String text;
  final VoidCallback press;
  final Color color;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(kRadiusS)),
        side: BorderSide.none
      ),
      padding: padding,
      color: Colors.lightBlue[600],
      minWidth: double.infinity,
      onPressed: press,
      elevation: 0,
      child: dText(text, color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      // child: dText(text, fontSize: 18, fontWeight: FontWeight.w600),
    );
  }
}