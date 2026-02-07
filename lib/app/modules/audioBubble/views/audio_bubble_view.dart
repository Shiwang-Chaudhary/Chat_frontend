import 'package:chat_backend/app/modules/audioBubble/controllers/audio_bubble_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AudioBubble extends StatelessWidget {
  AudioBubble({super.key});

  final AudioBubbleController controller = Get.put(AudioBubbleController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 4),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: controller.isMe.value
              ? Colors.blueAccent
              : Colors.grey.shade700,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // ▶️ Play/Pause Button
            GestureDetector(
              onTap: controller.togglePlayPause,
              child: Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.25),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),

            const SizedBox(width: 10),

            // Waveform + Duration
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Fake waveform bar
                  Container(
                    height: 4,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  const SizedBox(height: 6),

                  // Duration text
                  Text(
                    controller.durationText.value,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // 🎤 Mic Icon
            const Icon(Icons.mic, color: Colors.white70, size: 20),
          ],
        ),
      );
    });
  }
}
