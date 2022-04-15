import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quantum_admin/firebase_options.dart';
import 'package:quantum_admin/route/route_name.dart';
import 'package:quantum_admin/ui/landing/landing_ui.dart';

// import 'component/loading_page.dart';
import 'component/splash.dart';
import 'controller/auth_controller.dart';
// import 'controller/auth_state.dart';
import 'route/app_pages.dart';
import 'theme.dart';
// import 'ui/auth/sign_in.dart';
// import 'ui/landing/landing_ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends GetWidget<AuthController> {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent)
    );

    return StreamBuilder<User?>(
      // future: Future.delayed(const Duration(seconds: 1)),
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        } else {
          log('USER YANG LOGIN ===> ${snapshot.data.toString()}');
          return GetMaterialApp(
            title: 'Quantum Admin',
            debugShowCheckedModeBanner: false,
            theme: lightThemeData(context),
            darkTheme: darkThemeData(context),
            getPages: AppPages.pages,
            initialRoute: snapshot.data == null ? RouteName.signin : RouteName.landing,
            // home: Obx(() {
            //   if (controller.state is AuthenticationLoading) {}
            //   if (controller.state is UnAuthenticated) return SignInUI();
            //   if (controller.state is Authenticated) {
            //     // if (controller.statusMe.isFalse) {
            //       return Landing();
            //     // }
            //   }
            //   return const LoadingPage(title: "Checking requirement ...");
            //   // return const SizedBox.shrink();
            // }),
          );
        }
      }
    );
  }
}