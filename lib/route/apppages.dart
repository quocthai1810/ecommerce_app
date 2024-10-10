import 'package:get/get.dart';
import 'package:shop/screens/onbording/views/onbording_screnn.dart';
import '../screens/auth/controller/signup_binding.dart';
import '../screens/auth/views/login_screen.dart';
import '../screens/auth/views/signup_screen.dart';
import 'route_constants.dart';

class AppPages {
  static final List<GetPage> routes = [
    GetPage(
      name: onbordingScreenRoute,
      page: () => const OnBordingScreen(),
    ),
    GetPage(
      name: logInScreenRoute,
      page: () => const LoginScreen(),
    ),
    GetPage(
        name: signUpScreenRoute,
        page: () => const SignUpScreen(),
        binding: SignUpBinding()
        // Đăng ký binding ở đây
        ),
  ];
}
