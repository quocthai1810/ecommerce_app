import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
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

  final ImagePicker _picker = ImagePicker();
  var image = Rx<File?>(null);
  var fullName = ''.obs;
  var dateOfBirth = ''.obs;
  var phoneNumber = ''.obs;
  var gender = ''.obs;
  //chọn ngày sinh
  TextEditingController dateController = TextEditingController();

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

  String? genderValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select your gender'; // Thông báo lỗi nếu không chọn
    }
    return null; // Trả về null nếu giá trị hợp lệ
  }


  pickAndCropImage() async {

    await Permission.storage.request();
    // Chọn ảnh từ thư viện
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Cắt ảnh
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cắt ảnh',
            toolbarColor: primaryColor,
            toolbarWidgetColor: Colors.white,
            activeControlsWidgetColor: primaryColor,
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
            ],
          ),
          IOSUiSettings(
            title: 'Cắt ảnh',
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
            ],
          ),
        ],
      );

      if (croppedFile != null) {
        image.value = File(croppedFile.path);
      }
    }
    return null; // Nếu không có ảnh nào được chọn
  }

  void showImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: double.maxFinite,
            child: userInfo['avatarUrl'] == '' ?
            Image.asset('assets/images/user.jpg', fit: BoxFit.cover):
            Image.network(userInfo['avatarUrl'], fit: BoxFit.cover),
          ),
          actions: [
            TextButton(
              child: Text('Đóng'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> updateUserInfo() async {
    isLoading.value = true;
    try {
      await FirebaseFirestore.instance.collection('users').doc(currentUser?.uid).update({
        'fullName': fullName.value,
        'gender': gender.value,
        'dateOfBirth': dateController.text,
        'phoneNumber': phoneNumber.value,
      });
      fetchUserInfo();
      Get.snackbar('Thông báo', 'Cập nhập thành công');
    } catch (e) {
      Get.snackbar('Thông báo', 'Lỗi: $e');
    } finally {
      isLoading.value = false;
    }
  }

  var avatarUrl =''.obs;
  String avatarPath = '';

  Future<void> uploadImage(File? imageFile) async {
    User? user = FirebaseAuth.instance.currentUser;
    avatarPath = userInfo['avatarPath'];
    if(avatarPath.isNotEmpty) {


      // Đường dẫn của ảnh avatar cũ
      String? oldImagePath = 'users/${user?.uid}/images/$avatarPath';

      // Tham chiếu tới ảnh cũ
      final oldImageRef = FirebaseStorage.instance.ref().child(oldImagePath);

      try {
        // Xóa ảnh cũ nếu nó tồn tại
        await oldImageRef.delete();
        print('Old avatar deleted successfully.');
      } catch (e) {
        print('Error deleting old avatar: $e');
        // Nếu không có ảnh cũ, có thể tiếp tục
      }
    }

    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('users/${user?.uid}/images/${imageFile?.uri.pathSegments.last}');
      avatarPath = imageFile!.uri.pathSegments.last;
      // Tải lên hình ảnh
      try {
        await storageRef.putFile(imageFile);
        await FirebaseFirestore.instance.collection('users').doc(currentUser?.uid).update({
          'avatarPath': avatarPath,
        });
        avatarUrl.value = await storageRef.getDownloadURL();
        await FirebaseFirestore.instance.collection('users').doc(currentUser?.uid).update({
          'avatarUrl': avatarUrl.value,
        });
        fetchUserInfo();
      } catch (e){
        print(e);
      }
      print('Tải thành công');
    } catch (e) {
      print('Error uploading image: $e');
    }
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
