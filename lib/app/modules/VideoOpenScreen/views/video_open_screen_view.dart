import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/video_open_screen_controller.dart';

class VideoOpenScreenView extends GetView<VideoOpenScreenController> {
  const VideoOpenScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Video Player"), centerTitle: true),
      body: Center(
        child: Obx(() {
          // ✅ Show loader until controller is ready
          if (!controller.isInitialized.value) {
            return const CircularProgressIndicator();
          }
          return Chewie(controller: controller.chewieController);
        }),
      ),
    );
  }
}
