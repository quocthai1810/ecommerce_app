import 'package:get/get.dart';
import 'package:flutter/material.dart';

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
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
    }
  }


}
