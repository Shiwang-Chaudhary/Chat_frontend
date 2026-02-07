import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/audio_open_screen_controller.dart';

class AudioOpenScreenView extends GetView<AudioOpenScreenController> {
  const AudioOpenScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AudioOpenScreenView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ✅ Static Play Button
            IconButton(
              iconSize: 70,
              icon: const Icon(Icons.play_circle),
              onPressed: () {
                print("Play button tapped (UI test)");
              },
            ),

            const SizedBox(height: 10),

            // ✅ Static Status Text
            const Text("Paused", style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
