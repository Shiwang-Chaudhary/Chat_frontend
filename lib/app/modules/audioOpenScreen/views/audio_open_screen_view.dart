import 'package:chat_backend/app/modules/audioOpenScreen/controllers/audio_open_screen_controller.dart';
import 'package:chat_backend/app/widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AudioOpenScreenView extends StatelessWidget {
  final String? audioUrl;
  final bool isMe;

  const AudioOpenScreenView({
    super.key,
    required this.audioUrl,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      AudioOpenScreenController(audioUrl!),
      tag: audioUrl,
    );

    return Container(
      padding: const EdgeInsets.all(10),
      width: 260,
      decoration: BoxDecoration(
        color: isMe
            ? const Color.fromRGBO(36, 36, 62, 1)
            : const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Obx(() {
        if (!controller.isInitialised.value) {
          return const SizedBox(
            height: 30,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.blue,
              ),
            ),
          );
        }

        final totalSeconds = controller.totalDuration.value.inSeconds
            .toDouble();

        final currentSeconds = controller.currentPosition.value.inSeconds
            .toDouble();

        final double safeMax = totalSeconds > 0 ? totalSeconds : 1;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: controller.togglePlayPause,
                  child: Icon(
                    controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 28,
                  ),
                ),

                const SizedBox(width: 8),
                Expanded(
                  child: Slider(
                    min: 0,
                    max: safeMax,
                    value: currentSeconds.clamp(0, safeMax),
                    onChanged: (value) {
                      controller.seekSliderPosition(value);
                    },
                    activeColor: Colors.blue,
                    inactiveColor: Colors.white,
                  ),
                ),

                const SizedBox(width: 6),
              ],
            ),
            CustomText(
              text:
                  "${controller.formatTime(controller.currentPosition.value)} / ${controller.formatTime(controller.totalDuration.value)}",
              size: 13,
              color: Colors.white70,
            ),
            // CustomText(
            //   text: controller.formatTime(controller.totalDuration.value),
            //   size: 14,
            // ),
          ],
        );
      }),
    );
  }
}
