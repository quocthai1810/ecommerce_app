import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shop/const_func.dart';
import '../../../constants.dart';
import '../controller/profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final editProfileController = Get.find<EditProfileController>();
    editProfileController.dateController.text = editProfileController.userInfo['dateOfBirth'];
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
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Save changes here
              // editProfileController.saveProfile();
              // Get.back();
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                editProfileController.updateUserInfo();
                if (editProfileController.image.value != null) {
                  editProfileController
                      .uploadImage(editProfileController.image.value);
                }
                Get.back();
              }
            },
            child: const Text(
              'Save',
              style: TextStyle(color: primaryColor, fontSize: 16),
            ),
          )
        ],
      ),
      body: AbsorbPointer(
          absorbing: editProfileController.isLoading.value,
          child: ConstFunc.showLoading(
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Obx(
                          () => GestureDetector(
                            onTap: () =>
                                editProfileController.showImage(context),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: editProfileController.image.value != null
                                  ? FileImage(editProfileController.image.value!)
                                  : (editProfileController.userInfo['avatarUrl'] != ''
                                  ? NetworkImage(editProfileController.userInfo['avatarUrl']) as ImageProvider
                                  : const AssetImage('assets/images/user.jpg')),
                              child: editProfileController.userInfo['avatarUrl'] == '' && editProfileController.image.value == null
                                  ? Image.asset(
                                'assets/images/user.jpg',
                                fit: BoxFit.cover,
                              )
                                  : null,
                            ),

                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              // Thêm logic khi nhấn vào đây
                              print('Icon clicked!');
                              editProfileController.pickAndCropImage();
                            },
                            child: SvgPicture.asset(
                              'assets/images/uploadImage.svg',
                              width: 30,
                              height: 30,
                              colorFilter: const ColorFilter.mode(
                                  primaryColor, BlendMode.srcIn),
                            ))
                      ],
                    ),
                    const SizedBox(height: 20),
                    Form(
                        key: formKey,
                        child: Column(
                          children: [
                            _buildTextField('Full Name'),
                            const SizedBox(height: 16),
                            TextFormField(
                              readOnly: true,
                              controller: editProfileController.dateController,
                              onSaved: (date) {
                                editProfileController.dateOfBirth.value = date!;
                              },
                              onTap: () =>
                                  editProfileController.selectDate(context),
                              validator: (val) =>
                                  editProfileController.dateValidator(val),
                              decoration: const InputDecoration(
                                labelText: 'Date of Birth',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildTextField('Phone Number'),
                            const SizedBox(height: 16),
                            _buildGenderDropdown(editProfileController),
                          ],
                        )),
                  ],
                ),
              ),
              'Đang cập nhập',
              editProfileController)),
    );
  }

  Widget _buildTextField(
    String label,
    // TextEditingController controller
  ) {
    final editProfileController = Get.find<EditProfileController>();
    return TextFormField(
      initialValue: label == 'Full Name' ?
      editProfileController.userInfo['fullName'] : editProfileController.userInfo['phoneNumber'],
      textInputAction: TextInputAction.next,
      validator:
          label == 'Full Name' ? nameValidator.call : phoneValidator.call,
      onSaved: (value) {
        switch (label) {
          case 'Full Name':
            editProfileController.fullName.value = value!;
            break;
          case 'Date of Birth':
            editProfileController.dateOfBirth.value = value!;
            break;
          default:
            editProfileController.phoneNumber.value = value!;
        }
      },
      // controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildGenderDropdown(EditProfileController controller) {
    final editProfileController = Get.find<EditProfileController>();
    return DropdownButtonFormField<String>(
      validator: (val) => editProfileController.genderValidator(val),
      value: editProfileController.userInfo['gender'],
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
          editProfileController.gender.value = value;
        }
      },
      onSaved: (value){
        if (value != null) {
          editProfileController.gender.value = value;
        }
      },
    );
  }
}
