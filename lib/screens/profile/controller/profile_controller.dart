import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop/constants.dart';

import '../../../route/route_constants.dart';

class EditProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? currentUser;
  var userInfo = <String, dynamic>{}.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    currentUser = _auth.currentUser;
    if (currentUser != null) {
      fetchUserInfo();
    }
  }

  String getUserEmail() {
    return currentUser?.email ?? 'Chưa có email';
  }

  // Phương thức để lấy thông tin người dùng từ Firestore
  Future<void> fetchUserInfo() async {
    isLoading.value = true;
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(currentUser!.uid).get();
      if (snapshot.exists) {
        userInfo.value = snapshot.data() as Map<String, dynamic>;
      } else {
        Get.snackbar("Thông báo", "User không có trên Firestore.");
      }
    } catch (e) {
      Get.snackbar("Thông báo", "Lỗi: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thay đổi mật khẩu'),
          content: const ChangePasswordForm(),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Đóng hộp thoại
              },
              child: const Text('Hủy'),
            ),
          ],
        );
      },
    );
  }

  void logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.snackbar('Thông báo','Đăng xuất thành công');
    } catch (e) {
      Get.snackbar('Thông báo','Đã xảy ra lỗi: $e');
    }
    Get.offAllNamed(logInScreenRoute);
  }

}

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({super.key});

  @override
  ChangePasswordFormState createState() => ChangePasswordFormState();
}

class ChangePasswordFormState extends State<ChangePasswordForm> {
  final _formKey = GlobalKey<FormState>();
  String? _newPassword;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Mật khẩu mới',errorMaxLines: 2),
            obscureText: true,
            validator: passwordValidator.call,
            onSaved: (value) {
              _newPassword = value;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // Gọi hàm để cập nhật mật khẩu
                _updatePassword(_newPassword);
                Get.back(); // Đóng hộp thoại
              }
            },
            child: const Text('Thay đổi'),
          ),
        ],
      ),
    );
  }

  void _updatePassword(String? newPassword) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await user?.updatePassword(newPassword!);
      Get.snackbar('Thông báo','Thay đổi mật khẩu thành công !');
    } catch (e) {
      Get.snackbar('Thông báo','Đã xảy ra lỗi: $e');
    }
  }

}
