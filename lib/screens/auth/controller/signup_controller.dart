import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shop/const_func.dart';
import 'package:shop/constants.dart';
import 'package:shop/route/route_constants.dart';

class SignUpController extends GetxController {
  var isTermsAccepted = false.obs; // Trạng thái checkbox

  void toggleTermsAccepted(bool value) {
    isTermsAccepted.value = value;
  }

  var selectedDate = DateTime.now().obs; //ngày sinh

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(1924),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
      dateController.text = '${picked.toLocal()}'.split(' ')[0];
    }
  }

  //chọn mật khẩu
  late String password;

  //Hàm xác nhận mật khẩu
  String? confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  //chọn ngày sinh
  TextEditingController dateController = TextEditingController();

  String? dateValidator(val) {
    if (val != null && val.isNotEmpty) {
      try {
        DateTime date = DateTime.parse(val);
        if (date.isAfter(DateTime.now())) {
          return 'Ngày sinh không thể là trong tương lai';
        }
      } catch (e) {
        return 'Ngày sinh không hợp lệ';
      }
    } else {
      return 'Hãy nhập ngày sinh của bạn';
    }
    return null;
  }

  //chọn giới tính
  String? selectedGender;

  String? genderValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select your gender'; // Thông báo lỗi nếu không chọn
    }
    return null; // Trả về null nếu giá trị hợp lệ
  }

  // chọn email
  late String email;

  // chọn sdt
  late String phoneNumber;

  //Đăng kí user lên Firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var isLoading = false.obs; // Biến để theo dõi trạng thái loading

  Future<void> signUp() async {

    isLoading.value = true;

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Gửi email xác thực
      await userCredential.user?.sendEmailVerification();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'gender': selectedGender,
        'dateOfBirth': dateController.text,
        'phoneNumber': phoneNumber
      });

      Get.toNamed(signUpVerificationScreenRoute);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.snackbar('Thông báo','Email này đã được sử dụng. Vui lòng chọn email khác.');
      }
    } catch (e) {
      Get.snackbar('Thông báo','Đăng kí không thành công !');
    } finally {
        isLoading.value = false; // Kết thúc loading
    }
  }
}
