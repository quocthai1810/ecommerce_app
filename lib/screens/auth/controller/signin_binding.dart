import 'package:get/get.dart';
import 'package:shop/screens/auth/controller/signin_controller.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {

    Get.put(SignInController());
  }
}
