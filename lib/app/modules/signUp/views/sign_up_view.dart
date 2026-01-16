import 'package:chat_backend/app/routes/app_routes.dart';
import 'package:chat_backend/app/widgets/bgContainer.dart';
import 'package:chat_backend/app/widgets/customLargeButton.dart';
import 'package:chat_backend/app/widgets/customText.dart';
import 'package:chat_backend/app/widgets/customTextfield.dart';
import 'package:chat_backend/app/widgets/emailTextfield.dart';
import 'package:chat_backend/app/widgets/passTextfield.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: BgContainer(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
              ),
              CustomText(
                text: "Create Account!",
                color: Colors.white,
                size: 40,
                weight: FontWeight.w500,
              ),
              SizedBox(
                height: 10,
              ),
              CustomText(
                text: "Sign up to get started",
                color: Colors.white,
                size: 20,
                weight: FontWeight.w300,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextfield(
                  controller: controller.nameController,
                  prefixIcon: Icons.person,
                  showSuffixIcon: false,
                  hintText: "Enter your name"),
              SizedBox(
                height: 15,
              ),
              EmailTextField(controller: controller.emailController),
              SizedBox(
                height: 15,
              ),
              Obx(
                () => PassTextfield(
                  controller: controller.passwordController,
                  obscureText: !controller.isPasswordVisible.value,
                  togglePasswordVisibility: controller.togglePasswordVisibility,
                  suffixIcon: controller.isPasswordVisible.value
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
              ),
              SizedBox(height: 25),
              Center(
                child: SizedBox(
                  height: 60,
                  width: 140,
                  child: CustomLargeButton(
                    size: 20,
                    onTap: () {
                      Get.offAndToNamed(Routes.BOTTOM_NAV_BAR);
                    },
                    text: "Submit",
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Already have an account?",
                    color: Colors.white,
                    size: 16,
                    weight: FontWeight.w400,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.offAndToNamed(Routes.LOGIN);
                    },
                    child: CustomText(
                      text: "LOGIN",
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
      ),
    );
  }
}
