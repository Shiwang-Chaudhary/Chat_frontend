import 'package:chat_backend/app/routes/app_routes.dart';
import 'package:chat_backend/app/services/api_endpoints.dart';
import 'package:chat_backend/app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void signUp() async {
    print(
        "////////////////////////////////////LOGN FUNCTION CALLED✅✅///////////////////////////////////////////");
    final data = await ApiService.post({
      "name": nameController.text.trim(),
      "email": emailController.text.trim(),
      "password": passwordController.text.trim()
    }, ApiEndpoints.signUp);
    print("SignUp data:$data");
    Get.offAndToNamed(Routes.LOGIN);
  }
}
