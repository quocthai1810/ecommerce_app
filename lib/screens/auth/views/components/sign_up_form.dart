import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../constants.dart';
import '../../controller/signup_controller.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final signUpController = Get.find<SignUpController>();

    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            onSaved: (email) {
              signUpController.email = email!;
            },
            validator: emaildValidator.call,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Email address (*)",
              prefixIcon: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                child: SvgPicture.asset(
                  "assets/icons/Message.svg",
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withOpacity(0.3),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          TextFormField(
            onChanged: (val)=>signUpController.password = val,
            onSaved: (password) {
              signUpController.password = password!;
              // Password
            },
            validator: passwordValidator.call,
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Password (*)",
              prefixIcon: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                child: SvgPicture.asset(
                  "assets/icons/Lock.svg",
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withOpacity(0.3),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          TextFormField(
            onSaved: (pass) {
              // Password
            },
            validator: (val)=> signUpController.confirmPasswordValidator(val),
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Confirm Password (*)",
              prefixIcon: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                child: SvgPicture.asset(
                  "assets/icons/Lock.svg",
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withOpacity(0.3),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          TextFormField(
            onSaved: (fullName) {
              signUpController.fullName = fullName!;
            },
            validator: nameValidator.call,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Full Name (*)",
              prefixIcon: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                child: SvgPicture.asset(
                  "assets/icons/Message.svg",
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withOpacity(0.3),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          Obx(
            () => TextFormField(
              readOnly: true,
              controller: signUpController.dateController,
              onSaved: (date) {
                signUpController.dateController.text = date!;
              },
              onTap: () => signUpController.selectDate(context),
              validator: (val) => signUpController.dateValidator(val),
              decoration: InputDecoration(
                hintText:signUpController.selectedDate.value!=DateTime.now()?'Date of birth (*)':null
        ,
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: defaultPadding * 0.75),
                  child: SvgPicture.asset(
                    "assets/icons/date-of-birth-icon.svg",
                    height: 24,
                    width: 24,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withOpacity(0.3),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          TextFormField(
            onSaved: (phoneNumber) {
              signUpController.phoneNumber = phoneNumber!;
            },
            validator: phoneValidator.call,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: "Phone Number (*)",
              prefixIcon: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                child: SvgPicture.asset(
                  "assets/icons/phone.svg",
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withOpacity(0.3),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          DropdownButtonFormField<String>(
            onSaved: (gender) {
              signUpController.selectedGender = gender;
            },
            validator: (val) => signUpController.genderValidator(val),
            decoration: InputDecoration(
              hintText: "Gender (*)",
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                child: SvgPicture.asset(
                  "assets/icons/gender.svg", // Thay đổi icon nếu cần
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.3),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              border: const OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            items: const [
              DropdownMenuItem(
                value: "Male",
                child: Opacity(opacity: 0.8,
                child: Text("Male")),
              ),
              DropdownMenuItem(
                value: "Female",
                child: Opacity(opacity: 0.8,
                child: Text("Female",)),
              ),
              DropdownMenuItem(
                value: "Other",
                child: Opacity(opacity: 0.8,
                child: Text("Other")),
              ),
            ],
            onChanged: (value) {
              // Xử lý khi người dùng chọn giới tính
            },
          ),
        ],
      ),
    );
  }
}
