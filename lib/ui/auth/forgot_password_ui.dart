// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../component/form_input_field_with_icon.dart';
import '../../component/form_vertical_spacing.dart';
import '../../component/primary_button.dart';
import '../../component/widget_model.dart';
import '../../constant.dart';
import '../../controller/auth_controller.dart';
import '../../helper/validator.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({ Key? key }) : super(key: key);
  final authC = Get.find<AuthController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
          key: _formKey,
          child: Stack(
            children: [
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: SingleChildScrollView(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const FaIcon(FontAwesomeIcons.wallet, color: Colors.orange, size: 70,),
                              const SizedBox(height: kSpaceL),
                              dText("Lupa passwordmu?", 
                                fontWeight: FontWeight.bold, 
                                fontSize: 30,
                                color: Theme.of(Get.context!).bottomNavigationBarTheme.selectedItemColor!
                              ),
                              const SizedBox(height: kSpaceS),
                              dText("Jangan cemas, kami akan kirim verifikasi reset password ke emailmu.", fontSize: 16, color: Theme.of(Get.context!).bottomNavigationBarTheme.selectedItemColor!),
                            ],
                          ),
                        ),
                        const SizedBox(height: kSpaceL),
                        FormInputFieldWithIcon(
                          controller: authC.emailResetController,
                          iconPrefix: Icons.mail,
                          labelText: 'Email',
                          validator: Validator().email,
                          keyboardType: TextInputType.emailAddress,
                          // onChanged: (value) => null,
                          onChanged: (_) {},
                          onSaved: (value) => authC.emailResetController.text = value!,
                        ),
                        const FormVerticalSpace(),
                        Obx(() {
                          if (authC.loading.value) {
                            return buttonLoading();
                          } else {
                            return PrimaryButton(
                              text: 'Reset Password', 
                              press: () {
                                FocusScope.of(context).unfocus();
                                authC.sendResetPassword();
                              }
                            );
                          }
                          
                        }),
                        const FormVerticalSpace(),
                        TextButton(
                          onPressed: () => Get.back(), 
                          child: dText("Kembali ke halaman awal", color: Colors.blue[700], fontSize: 14)
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        
      
    );
  }
}
