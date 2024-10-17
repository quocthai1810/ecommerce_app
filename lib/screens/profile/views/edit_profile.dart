import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../constants.dart';
import '../controller/profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final editProfileController = Get.find<EditProfileController>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
            'Edit Profile',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Save changes here
                // editProfileController.saveProfile();
                Get.back();
              },
              child: const Text(
                'Save',
                style: TextStyle(color: primaryColor, fontSize: 16),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    // backgroundImage: editProfileController.avatarImage.value.isNotEmpty
                    //     ? FileImage(File(editProfileController.avatarImage.value))
                    //     : NetworkImage(editProfileController.userInfo['avatar']),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Thêm logic khi nhấn vào đây
                      print('Icon clicked!');
                    },
                    child: SvgPicture.asset(
                      'assets/images/uploadImage.svg',
                      width: 30,
                      height: 30,
                      colorFilter: ColorFilter.mode(
                          Get.theme.iconTheme.color!, BlendMode.srcIn),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              _buildTextField('Full Name'),
              const SizedBox(height: 16),
              _buildTextField('Date of Birth'),
              const SizedBox(height: 16),
              _buildTextField('Phone Number'),
              const SizedBox(height: 16),
              _buildGenderDropdown(editProfileController),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    // TextEditingController controller
  ) {
    return TextField(
      // controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildGenderDropdown(EditProfileController controller) {
    return DropdownButtonFormField<String>(
      value: 'Male',
      decoration: const InputDecoration(
        labelText: 'Gender',
        border: OutlineInputBorder(),
      ),
      items: ['Male', 'Female', 'Other']
          .map((gender) => DropdownMenuItem(
                value: gender,
                child: Text(gender),
              ))
          .toList(),
      onChanged: (value) {
        if (value != null) {
          // controller.gender.value = value;
        }
      },
    );
  }
}
