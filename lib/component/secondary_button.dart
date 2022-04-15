import 'package:flutter/material.dart';

import '../constant.dart';
import 'widget_model.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = Colors.white,
    // this.color = Theme.of(context).scaffoldBackgroundColor,
    // this.padding = const EdgeInsets.all(kDefaultPadding * 0.89),
    this.padding = const EdgeInsets.all(kDefaultPadding * 0.55),
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
        side: BorderSide(color: kErrorColor, width: 1.6)
      ),
      elevation: 0,
      padding: padding,
      // color: color,
      color: Theme.of(context).scaffoldBackgroundColor,
      minWidth: double.infinity,
      onPressed: press,
      child: dText(
        text, 
        // color: Colors.black87, 
        color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor!, 
        fontSize: 16, 
        fontWeight: FontWeight.bold
      ),
    );
  }
}