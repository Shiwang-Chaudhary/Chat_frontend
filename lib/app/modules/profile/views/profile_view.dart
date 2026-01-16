import 'package:chat_backend/app/widgets/customText.dart';
import 'package:chat_backend/app/widgets/customTile.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF24243E),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar(
                  backgroundColor: const Color(0xFF24243E),
                  title: const CustomText(
                    text: "Profile",
                    size: 27,
                    color: Colors.white,
                    weight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 70,
                        child: Icon(
                          Icons.person_2,
                          color: Colors.white,
                          size: 80,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => CustomText(
                          text: controller.name.value.isEmpty ? "NAME" : controller.name.value ,
                          size: 26,
                          color: Colors.white,
                          weight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Obx(
                        () => CustomText(
                          text: controller.email.value.isEmpty ? "emaiL@gmail.com" : controller.email.value,
                          size: 19,
                          color: Colors.white,
                          weight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                const CustomText(
                  text: "💼 Profile Summary",
                  size: 26,
                  color: Colors.white,
                  weight: FontWeight.w500,
                ),
                const SizedBox(
                  height: 20,
                ),
                const CustomText(
                  maxLines: 4,
                  text:
                      "Developer skilled in Flutter, Dart, C, Python, Node.js, and MongoDB, with experience in building cross-platform apps and backend solutions.",
                  size: 19,
                  color: Colors.white,
                  weight: FontWeight.w500,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTile(
                    icon: Icons.person, text: "Complete Profile", ontap: () {}),
                CustomTile(
                  icon: Icons.logout,
                  text: "Logout",
                  ontap: () {},
                  iconColor: Colors.red,
                ),
              ],
            ),
          ),
        ));
  }
}
