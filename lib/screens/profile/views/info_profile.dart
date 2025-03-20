import 'package:flutter/material.dart';
import 'package:shop/constants.dart';
import 'package:shop/screens/profile/views/components/profile_info.dart';
import 'package:get/get.dart';

import '../controller/profile_controller.dart';
import 'edit_profile.dart';

class InfoProfileScreen extends StatelessWidget {
  const InfoProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final editProfileController = Get.find<EditProfileController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.to(const EditProfileScreen(),
                  transition: Transition.rightToLeft,
                  duration: const Duration(milliseconds: 500));
            },
            child: const Text(
              'Edit',
              style: TextStyle(color: primaryColor, fontSize: 16),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                Obx(()=>
                    GestureDetector(
                      onTap:()=> editProfileController.showImage(context),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage:
                        editProfileController.userInfo['avatarUrl']==''
                            ? null
                            : NetworkImage(editProfileController.userInfo['avatarUrl']),
                        child: editProfileController.userInfo['avatarUrl']==''
                            ? Image.asset(
                          'assets/images/user.jpg',
                        )
                            : null,
                      ),
                    ),
                ),
                const SizedBox(width: 16),
                Obx( () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        editProfileController.userInfo['fullName'],
                        style: TextStyle(
                          color: Get.textTheme.bodyLarge!.color, fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        editProfileController.getUserEmail(),
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Obx(()=>ProfileInfoListTile.buildProfileInfoRow(
                'Name', editProfileController.userInfo['fullName'])),
            Obx(()=>ProfileInfoListTile.buildProfileInfoRow(
                'Date of Birth', editProfileController.userInfo['dateOfBirth'])),
            Obx(()=>ProfileInfoListTile.buildProfileInfoRow(
                'Phone Number', editProfileController.userInfo['phoneNumber'])),
            Obx(()=>ProfileInfoListTile.buildProfileInfoRow(
                'Gender', editProfileController.userInfo['gender'])),
            ProfileInfoListTile.buildProfileInfoRow(
                'Email', editProfileController.getUserEmail()),
            ProfileInfoListTile.buildProfileInfoRow(
              'Password',
              '',
              isPassword: true,
              passwordText: 'Change password',
              onPasswordTap: () {
                editProfileController.showChangePasswordDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
