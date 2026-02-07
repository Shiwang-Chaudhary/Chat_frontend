import 'package:get/get.dart';

import '../controllers/audio_bubble_controller.dart';

class AudioBubbleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AudioBubbleController>(
      () => AudioBubbleController(),
    );
  }
}
