import 'package:get/get.dart';

import '../controllers/audio_open_screen_controller.dart';

class AudioOpenScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AudioOpenScreenController>(
      () => AudioOpenScreenController(),
    );
  }
}
