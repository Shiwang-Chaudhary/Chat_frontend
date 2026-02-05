import 'package:get/get.dart';

import '../controllers/image_open_screen_controller.dart';

class ImageOpenScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImageOpenScreenController>(
      () => ImageOpenScreenController(),
    );
  }
}
