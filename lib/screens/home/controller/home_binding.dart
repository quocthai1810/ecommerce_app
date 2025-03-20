import 'package:get/get.dart';
import 'home_controller.dart'; // Đường dẫn tới SignUpController

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Khởi tạo SignUpController khi điều hướng tới màn hình đăng ký
    Get.put(HomeController());
  }
}
