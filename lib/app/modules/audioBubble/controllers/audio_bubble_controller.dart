import 'package:get/get.dart';

class AudioBubbleController extends GetxController {
  var isPlaying = false.obs;

  // Static test data
  var isMe = true.obs;
  var durationText = "0:00 / 1:24".obs;

  void togglePlayPause() {
    isPlaying.value = !isPlaying.value;
  }
}
