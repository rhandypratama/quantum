import 'package:flutter/material.dart';
import '../constant.dart';
import 'widget_model.dart';

class CustomButton extends StatelessWidget {
  final Color bgColor;
  final Color textColor;
  final String text;
  final Widget image;
  final VoidCallback onPressed;
  
  const CustomButton({
    Key? key,
    required this.bgColor,
    required this.textColor,
    required this.text,
    required this.onPressed,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: double.infinity,
      ),
      child: image != null
          ? 
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: bgColor,
                primary: textColor,
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: 2),
                // side: BorderSide(color: borderColor, width: 1),
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(kRadiusS))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: kPaddingM, top: kPaddingS, bottom: kPaddingS),
                    child: image,
                  ),
                  dText(text, fontSize: 16, color: textColor, fontWeight: FontWeight.bold)
                ],
              ),
              onPressed: onPressed, 
            )
          
          // OutlineButton(
          //     color: color,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: <Widget>[
          //         Padding(
          //           padding: const EdgeInsets.only(right: kPaddingM, top: kPaddingS, bottom: kPaddingS),
          //           child: image,
          //         ),
          //         dText(text, fontSize: 14, color: textColor, fontWeight: FontWeight.bold)
          //       ],
          //     ),
          //     onPressed: onPressed,
          //   )
          : FlatButton(
              color: bgColor,
              padding: const EdgeInsets.all(kPaddingM),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: dText(text, fontSize: 14, color: textColor, fontWeight: FontWeight.bold),
              onPressed: onPressed,
            ),
    );
  }
}
