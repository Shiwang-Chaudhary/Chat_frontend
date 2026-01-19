import 'dart:developer';
import 'package:chat_backend/app/routes/app_routes.dart';
import 'package:chat_backend/app/services/api_endpoints.dart';
import 'package:chat_backend/app/services/api_service.dart';
import 'package:chat_backend/app/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  var isPasswordVisible = false.obs;
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void login() async {
    log(
      "////////////////////////////////////LOGIN FUNCTION CALLED✅✅///////////////////////////////////////////",
    );
    final data = await ApiService.post({
      "email": emailController.text.trim(),
      "password": passController.text.trim(),
    }, ApiEndpoints.login);
    log("SignUp login: $data");
    final token = data["token"];
    final user = data["user"];
    final userName = user["name"];
    final userEmail = user["email"];
    final userId = user["id"];
    log("USER : $user");
    await StorageService.saveData(token, "token");
    await StorageService.saveData(userName, "name");
    await StorageService.saveData(userEmail, "email");
    await StorageService.saveData(userId, "id");
    Get.offAndToNamed(Routes.BOTTOM_NAV_BAR);
    // final receivedToken = await StorageService.getData("token");
    // log("SAVED TOKEN: $receivedToken");
  }
}
