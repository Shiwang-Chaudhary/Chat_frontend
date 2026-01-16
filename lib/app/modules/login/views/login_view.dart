import 'package:chat_backend/app/routes/app_routes.dart';
import 'package:chat_backend/app/widgets/bgContainer.dart';
import 'package:chat_backend/app/widgets/customLargeButton.dart';
import 'package:chat_backend/app/widgets/customText.dart';
import 'package:chat_backend/app/widgets/emailTextfield.dart';
import 'package:chat_backend/app/widgets/passTextfield.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BgContainer(
            body: Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 200,
            ),
            const CustomText(
              text: "Welcome back!",
              size: 34,
              color: Colors.white,
              weight: FontWeight.w400,
            ),
            const SizedBox(
              height: 10,
            ),
            const CustomText(
              text: "Enter details to login ",
              size: 20,
              color: Colors.white,
              weight: FontWeight.w300,
            ),
            const SizedBox(
              height: 20,
            ),
            EmailTextField(
              controller: controller.emailController,
            ),
            const SizedBox(
              height: 15,
            ),
            Obx(
              () => PassTextfield(
                controller: controller.passController,
                obscureText: !controller.isPasswordVisible.value,
                togglePasswordVisibility: controller.togglePasswordVisibility,
                suffixIcon: controller.isPasswordVisible.value
                    ? Icons.visibility_off
                    : Icons.visibility,
              ),
            ),
            const SizedBox(
              height: 23,
            ),
            Center(
                child: SizedBox(
                    width: 140,
                    height: 60,
                    child: CustomLargeButton(onTap: () {}, text: "LOGIN"))),
            const SizedBox(
              height: 23,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: "Don't have any account?",
                  color: Colors.white,
                  size: 16,
                  weight: FontWeight.w400,
                ),
                TextButton(
                  onPressed: () {
                    Get.offAndToNamed(Routes.SIGN_UP);
                  },
                  child: CustomText(
                    text: "SIGN UP",
                    color: Colors.blue,
                    size: 16,
                    weight: FontWeight.w500,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    )));
  }
}
