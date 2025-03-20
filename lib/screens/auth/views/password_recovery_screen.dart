import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart'; // Để điều hướng và hiển thị thông báo

class PasswordRecoveryScreen extends StatelessWidget {
  const PasswordRecoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller để quản lý email nhập vào
    final TextEditingController emailController = TextEditingController();

    // Hàm gửi email đặt lại mật khẩu
    Future<void> sendPasswordResetEmail(String email) async {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        Get.snackbar(
          'Success',
          'Password reset email sent! Check your inbox.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        switch (e.code) {
          case 'invalid-email':
            errorMessage = 'The email address is not valid.';
            break;
          case 'user-not-found':
            errorMessage = 'No user found with this email.';
            break;
          default:
            errorMessage = 'An error occurred. Please try again.';
        }
        Get.snackbar(
          'Error',
          errorMessage,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Quay lại màn hình trước đó
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tiêu đề
            const Text(
              'Password recovery',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Mô tả
            const Text(
              'Enter your E-mail address to recover your password',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            // Trường nhập email
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email_outlined),
                hintText: 'Email address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 32),
            // Nút "Next"
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final email = emailController.text.trim();
                  if (email.isEmpty) {
                    Get.snackbar(
                      'Error',
                      'Please enter your email address.',
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                    return;
                  }
                  await sendPasswordResetEmail(email);
                },

                child: const Text(
                  'Next',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}