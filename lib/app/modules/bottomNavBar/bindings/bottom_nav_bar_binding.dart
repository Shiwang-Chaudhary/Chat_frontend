import 'package:chat_backend/app/modules/Home/controller/home_controller.dart';
import 'package:chat_backend/app/modules/chatScreen/controllers/chat_screen_controller.dart';
import 'package:chat_backend/app/modules/groupChatScreen/controllers/group_chat_screen_controller.dart';
import 'package:chat_backend/app/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';

import '../controllers/bottom_nav_bar_controller.dart';

class BottomNavBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavBarController>(
      () => BottomNavBarController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<GroupChatScreenController>(
      () => GroupChatScreenController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}
