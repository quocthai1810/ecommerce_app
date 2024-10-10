import 'package:get/get.dart';
import 'signup_controller.dart'; // Đường dẫn tới SignUpController

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    // Khởi tạo SignUpController khi điều hướng tới màn hình đăng ký
    Get.put(SignUpController());
  }
}
