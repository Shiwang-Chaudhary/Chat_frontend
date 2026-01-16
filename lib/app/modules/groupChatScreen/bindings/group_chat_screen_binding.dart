import 'package:get/get.dart';

import '../controllers/group_chat_screen_controller.dart';

class GroupChatScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroupChatScreenController>(
      () => GroupChatScreenController(),
    );
  }
}
