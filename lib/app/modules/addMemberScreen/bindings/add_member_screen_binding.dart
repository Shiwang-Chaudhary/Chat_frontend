import 'package:get/get.dart';

import '../controllers/add_member_screen_controller.dart';

class AddMemberScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddMemberScreenController>(
      () => AddMemberScreenController(),
    );
  }
}
