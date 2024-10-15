import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shop/const_func.dart';
import 'package:shop/route/route_constants.dart';

class SignInController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String email;
  late String password;

  Future<void> signIn() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user!.emailVerified) {
        Get.offAllNamed(entryPointScreenRoute);
      } else {
        Get.snackbar('Thông báo','Vui lòng xác thực email của bạn trước khi đăng nhập.');
      }
    } catch (e) {
      Get.snackbar('Thông báo','Email hoặc Password không chính xác');
    }
  }


}