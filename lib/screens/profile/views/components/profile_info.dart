import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/const_func.dart';

import '../../../../constants.dart';
import '../../controller/profile_controller.dart';

class ProfileInfoListTile {
  static Widget buildProfileInfoRow(String label, String value,
      {bool isPassword = false,
      String passwordText = '',
      Function()? onPasswordTap}) {
    final editProfileController = Get.find<EditProfileController>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  color: Get.textTheme.bodyLarge!.color, fontSize: 14)),
          isPassword
              ? GestureDetector(
                  onTap: onPasswordTap,
                  child: Text(
                    passwordText,
                    style: const TextStyle(color: primaryColor, fontSize: 16),
                  ),
                )
              : Text(
                  value,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
        ],
      ),
    );
  }
}
