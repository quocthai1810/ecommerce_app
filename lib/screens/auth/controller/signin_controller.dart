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

  var isLoading = false.obs;

  Future<void> signIn() async {

    isLoading.value = true;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user!.emailVerified) {
        Get.offAllNamed(entryPointScreenRoute);
      } else {
        await userCredential.user?.sendEmailVerification();
        Get.offAllNamed(signUpVerificationScreenRoute);
      }
    } catch (e) {
      Get.snackbar('Thông báo','Email hoặc Password không chính xác');
    } finally {
      isLoading.value = false; // Kết thúc loading
    }
  }


}