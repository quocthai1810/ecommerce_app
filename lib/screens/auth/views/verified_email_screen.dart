import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/route/route_constants.dart';
import 'package:shop/screens/auth/controller/signup_controller.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpController = Get.find<SignUpController>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.offAllNamed(logInScreenRoute),
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Xác Thực Email'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Mã xác thực đã gửi đến email của bạn.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                'Vui lòng xác thực để sử dụng các tính năng của app nhé!',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  signUpController.resendVerificationEmail();
                  // Xử lý nút "Gửi lại mã" hoặc chuyển hướng
                  // bạn có thể thêm logic gửi lại mã xác thực ở đây
                },
                child: const Text('Gửi lại mã xác thực'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
