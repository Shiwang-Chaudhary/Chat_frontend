import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/image_open_screen_controller.dart';

class ImageOpenScreenView extends GetView<ImageOpenScreenController> {
  const ImageOpenScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('You'), centerTitle: false),
      body: ClipRRect(
        child: Image.network(
          controller.fileUrl,
          fit: BoxFit.contain,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
