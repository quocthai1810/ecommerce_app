import 'package:get/get.dart';
import 'package:shop/entry_point.dart';
import 'package:shop/screens/auth/controller/signin_binding.dart';
import 'package:shop/screens/auth/views/password_recovery_screen.dart';
import 'package:shop/screens/auth/views/verified_email_screen.dart';
import 'package:shop/screens/home/controller/home_binding.dart';
import 'package:shop/screens/home/views/fragment/list_categories.dart';
import 'package:shop/screens/home/views/home_screen.dart';
import 'package:shop/screens/onbording/views/onbording_screnn.dart';
import 'package:shop/screens/product/views/product_details_screen.dart';
import 'package:shop/screens/profile/controller/profile_binding.dart';
import 'package:shop/screens/profile/controller/profile_controller.dart';
import '../models/product_model.dart';
import '../screens/auth/controller/signup_binding.dart';
import '../screens/auth/views/login_screen.dart';
import '../screens/auth/views/signup_screen.dart';
import '../screens/profile/views/edit_profile.dart';
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
      bindings: [ProfileBinding(),HomeBinding()]
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
    GetPage(
      name: editProfileScreenRoute,
      page: () => const EditProfileScreen(),
    ),
    GetPage(
      name: productDetailsScreenRoute,
      page: () => const ProductDetailsScreen(),
    ),
    GetPage(
      name: listCategoriesScreenRoute,
      page: () {
        // Lấy danh sách sản phẩm từ Get.arguments
        final Map<String, dynamic> args = Get.arguments;
        final List<ProductModel> products = args['products'];
        final String nameCategories = args['categoryName'];
        return ListCategories(products: products, nameCategories: nameCategories);
      },
    ),
    GetPage(
        name: passwordRecoveryScreenRoute,
        page: () => const PasswordRecoveryScreen(),
        // binding: SignInBinding()
    ),
  ];
}
