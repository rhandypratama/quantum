// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum_admin/route/route_name.dart';

import '../../component/form_input_field_with_icon.dart';
import '../../component/form_vertical_spacing.dart';
import '../../component/primary_button.dart';
import '../../component/widget_model.dart';
import '../../constant.dart';
import '../../controller/auth_controller.dart';
import '../../helper/validator.dart';
import 'component/header.dart';

class SignInUI extends StatelessWidget {
  SignInUI({ Key? key }) : super(key: key);
  final c = Get.put<AuthController>(AuthController(), permanent: true);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    // c.statusApi.value = true;
    return Scaffold(
        body: Form(
          key: _formKey,
          child: Stack(
            children: [
              Container(
                // color: Get.isDarkMode ? kContentColorLightTheme :  Colors.white,
                // color: Colors.white,
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        // LogoGraphicHeader(),
                        Header(),
                        const SizedBox(height: kSpaceL),
                        FormInputFieldWithIcon(
                          controller: c.emailController,
                          iconPrefix: Icons.mail,
                          labelText: 'Email',
                          validator: Validator().email,
                          keyboardType: TextInputType.emailAddress,
                          // onChanged: (value) => null,
                          onChanged: (_) {},
                          onSaved: (value) => c.emailController.text = value!,
                        ),
                        const FormVerticalSpace(),
                        FormInputFieldWithIcon(
                          controller: c.passwordController,
                          iconPrefix: Icons.lock,
                          labelText: 'Password',
                          validator: Validator().password,
                          obscureText: true,
                          // onChanged: (value) => null,
                          onChanged: (_) {},
                          onSaved: (value) => c.passwordController.text = value!,
                          maxLines: 1,
                        ),
                        const FormVerticalSpace(),
                        Obx(() {
                          if (c.loading.value) {
                            return buttonLoading();
                          } else {
                            return PrimaryButton(
                              text: 'Daftar Sekarang', 
                              press: () {
                                FocusScope.of(context).unfocus();
                                c.register();
                              }
                            );
                          }
                          
                        }),
                        const FormVerticalSpace(),
                        TextButton(
                          onPressed: () => Get.toNamed(RouteName.forgotPassword), 
                          child: dText("Sudah punya akun tapi lupa password?", color: Colors.blue[700], fontSize: 14)
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
