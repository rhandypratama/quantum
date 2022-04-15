import 'package:get/get.dart';
import '../ui/qrcode/qrcode_ui.dart';
import '../ui/auth/forgot_password_ui.dart';
import '../ui/landing/landing_ui.dart';
import '../ui/auth/sign_in.dart';
import 'route_name.dart';

class AppPages {
  static final pages = [
    GetPage(name: RouteName.signin, page: () => SignInUI()),
    GetPage(name: RouteName.landing , page: () => Landing()),
    GetPage(name: RouteName.forgotPassword , page: () => ForgotPassword()),
    GetPage(name: RouteName.qrCode , page: () => QrCode()),
  ];
}