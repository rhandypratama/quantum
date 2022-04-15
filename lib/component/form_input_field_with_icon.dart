import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant.dart';

class FormInputFieldWithIcon extends StatelessWidget {
  const FormInputFieldWithIcon({
    Key? key,
    required this.controller,
    required this.iconPrefix,
    required this.labelText,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.minLines = 1,
    this.maxLines,
    required this.onChanged,
    required this.onSaved}) : super(key: key);

  final TextEditingController controller;
  final IconData iconPrefix;
  final String labelText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final int minLines;
  final int? maxLines;
  final void Function(String) onChanged;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: Theme.of(Get.context!).bottomNavigationBarTheme.selectedItemColor!
      ),
      decoration: InputDecoration(
        labelStyle: TextStyle(
          color: Theme.of(Get.context!).bottomNavigationBarTheme.selectedItemColor!
          // color: Get.isDarkMode ? Colors.white : Colors.black
        ),
        contentPadding: const EdgeInsets.all(kPaddingM),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(kRadiusS)),
          borderSide: BorderSide(
            // color: Theme.of(context).indicatorColor,
            // color: Get.isDarkMode ? Colors.white : Colors.black.withOpacity(0.22),
            color: Theme.of(Get.context!).bottomNavigationBarTheme.unselectedItemColor!,
            width: 1
          ),
        ),
        // enabledBorder: Theme.of(context).inputDecorationTheme.border.borderSide.color,
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(kRadiusS)),
          borderSide: BorderSide(
            // color: Get.isDarkMode ? Colors.white : Colors.black.withOpacity(0.22),
            color: Theme.of(Get.context!).bottomNavigationBarTheme.unselectedItemColor!,
            width: 1
          ),
        ),
        hintText: labelText,
        hintStyle: GoogleFonts.openSans(
          textStyle: TextStyle(
            // color: AppThemes.kBlack.withOpacity(0.5),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Theme.of(Get.context!).bottomNavigationBarTheme.unselectedItemColor!
          )
        ),
        prefixIcon: Icon(
          iconPrefix,
          // color: Colors.black.withOpacity(0.8),
          // color: Theme.of(context).iconTheme.color
          color: Theme.of(Get.context!).bottomNavigationBarTheme.selectedItemColor!
        ),
      ),
      // decoration: InputDecoration(
      //   filled: true,
      //   prefixIcon: Icon(iconPrefix),
      //   labelText: labelText,
      // ),
      controller: controller,
      onSaved: onSaved,
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      minLines: minLines,
      validator: validator,
    );
  }
}
