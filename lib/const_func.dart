import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shop/screens/auth/controller/signup_controller.dart';

import 'constants.dart';

class ConstFunc {
//Hàm hiện vòng loading
  static circularProgress(String? text) {
    return Stack(alignment: Alignment.center, children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          ),
          Text(text!)
        ],
      )
    ]);
  }

  static showLoading<T extends GetxController>(Widget widget, String? text, T controller) {
    controller = Get.find<T>();
    return Obx(
      () => AbsorbPointer(
        absorbing: (controller as dynamic).isLoading.value,
        child: Stack(alignment: Alignment.center, children: [
          Opacity(
              opacity: (controller as dynamic).isLoading.value ? 0.6 : 1,
              child: widget),
          if ((controller as dynamic).isLoading.value) ConstFunc.circularProgress(text)
        ]),
      ),
    );
  }
}
