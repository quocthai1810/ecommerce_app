import 'package:get/get.dart';
import 'package:shop/entry_point.dart';
import 'package:shop/screens/auth/controller/signin_binding.dart';
import 'package:shop/screens/auth/views/verified_email_screen.dart';
import 'package:shop/screens/home/views/home_screen.dart';
import 'package:shop/screens/onbording/views/onbording_screnn.dart';
import 'package:shop/screens/profile/controller/profile_binding.dart';
import 'package:shop/screens/profile/controller/profile_controller.dart';
import '../screens/auth/controller/signup_binding.dart';
import '../screens/auth/views/login_screen.dart';
import '../screens/auth/views/signup_screen.dart';
import '../screens/profile/views/info_profile.dart';
import '../screens/profile/views/profile_screen.dart';
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
      binding: SignInBinding()
    ),
    GetPage(
        name: signUpScreenRoute,
        page: () => const SignUpScreen(),
        binding: SignUpBinding()

        ),
    GetPage(
        name: entryPointScreenRoute,
        page: () => const EntryPoint(),
      bindings: [ProfileBinding()]
    ),
    GetPage(
      name: signUpVerificationScreenRoute,
      page: () => const VerificationScreen(),
      binding: SignUpBinding()

    ),
    GetPage(
      name: infoProfileScreenRoute,
      page: () => const InfoProfileScreen(),
    ),
    // GetPage(
    //   name: editProfileScreenRoute,
    //   page: () => const EditProfileScreen(),
    // ),
  ];
}
