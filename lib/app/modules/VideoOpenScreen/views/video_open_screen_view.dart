import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/video_open_screen_controller.dart';

class VideoOpenScreenView extends GetView<VideoOpenScreenController> {
  const VideoOpenScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VideoOpenScreenView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'VideoOpenScreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
