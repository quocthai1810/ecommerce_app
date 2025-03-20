import 'package:get/get.dart';
import 'package:shop/screens/auth/controller/signin_controller.dart';
import 'package:shop/screens/profile/controller/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {

    Get.put(EditProfileController());
  }

}
