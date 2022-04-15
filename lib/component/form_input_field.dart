import 'package:flutter/material.dart';

import '../constant.dart';

class FormInputField extends StatelessWidget {
  const FormInputField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.minLines = 1,
    required this.onChanged,
    this.align,
    required this.onSaved}) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final int minLines;
  final void Function(String) onChanged;
  final void Function(String?)? onSaved;
  final TextAlign? align;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: align ?? TextAlign.left,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(bottom: 14.5, left: kSpaceS, right: kSpaceS),
        border: const UnderlineInputBorder(
            borderSide: BorderSide(
              // color: Colors.black,
              color: kPrimaryColor,
              width: 1,

            
            ),
            
          ),
        hintText: labelText,
        hintStyle: const TextStyle(fontSize: 16),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelStyle: const TextStyle(
          fontSize: 16
        ),
        
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.all(Radius.circular(kRadiusS)),
        //   borderSide: BorderSide(color: Colors.black12.withOpacity(0.01))
        // ),
        // enabledBorder: OutlineInputBorder(
        //   borderSide: BorderSide(
        //     color: Get.isDarkMode ? Colors.white : Colors.black.withOpacity(0.22),
        //     width: 1
        //   ),
        //   borderRadius: BorderRadius.all(Radius.circular(kRadiusS)),
        // ),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: kPrimaryColor,
              width: 1
            
            ),
          // borderRadius: BorderRadius.all(Radius.circular(kRadiusS)),
        ),
        // filled: true,
        // fillColor: Colors.black45, //Palette.inputFillColor,
        labelText: labelText,
      ),
      controller: controller,
      onSaved: onSaved,
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: null,
      minLines: minLines,
      validator: validator,
    );
  }
}
