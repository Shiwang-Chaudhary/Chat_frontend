import 'package:get/get.dart';

import '../controllers/create_group_screen_controller.dart';

class CreateGroupScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateGroupScreenController>(
      () => CreateGroupScreenController(),
    );
  }
}
