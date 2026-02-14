import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bottom_nav_bar_controller.dart';

class BottomNavBarView extends GetView<BottomNavBarController> {
  const BottomNavBarView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.pages[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          selectedItemColor: Colors.blue,

          backgroundColor: const Color(0xFF24243E),
          unselectedItemColor: Colors.white,
          currentIndex: controller.selectedIndex.value,
          onTap: (index) {
            controller.changeIndex(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: controller.selectedIndex.value == 0
                  ? Bounce(child: Icon(Icons.chat))
                  : Icon(Icons.chat_outlined),
              label: 'Chats',
            ),
            BottomNavigationBarItem(
              icon: controller.selectedIndex.value == 1
                  ? Bounce(child: Icon(Icons.group))
                  : Icon(Icons.group_outlined),
              label: 'Groups',
            ),
            BottomNavigationBarItem(
              icon: controller.selectedIndex.value == 2
                  ? Bounce(child: Icon(Icons.person))
                  : Icon(Icons.person_outlined),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: controller.selectedIndex.value == 3
                  ? Bounce(child: Icon(Icons.location_on))
                  : Icon(Icons.location_on_outlined),
              label: 'Location',
            ),
          ],
        ),
      ),
    );
  }
}
