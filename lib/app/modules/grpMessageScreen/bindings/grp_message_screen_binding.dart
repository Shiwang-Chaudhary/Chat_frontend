import 'package:get/get.dart';

import '../controllers/grp_message_screen_controller.dart';

class GrpMessageScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GrpMessageScreenController>(
      () => GrpMessageScreenController(),
    );
  }
}
