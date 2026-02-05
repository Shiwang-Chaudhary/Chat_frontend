import 'package:get/get.dart';

import '../controllers/video_open_screen_controller.dart';

class VideoOpenScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoOpenScreenController>(() => VideoOpenScreenController());
  }
}
