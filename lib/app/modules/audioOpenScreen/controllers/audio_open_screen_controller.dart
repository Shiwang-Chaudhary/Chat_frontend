// import 'package:get/get.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:logger/web.dart';

// class AudioOpenScreenController extends GetxController {
//   late AudioPlayer audioPlayer;
//   late String audioUrl;
//   RxBool isInitialised = false.obs;
//   RxBool isPlaying = false.obs;
//   Rx<Duration> totalDuration = Duration.zero.obs;
//   Rx<Duration> currentPosition = Duration.zero.obs;
//   final logger = Logger();
//   @override
//   void onInit() {
//     audioUrl = Get.arguments["audioUrl"];
//     logger.i("AudioUrl:$audioUrl");
//     initializedAudioPlayer();
//     super.onInit();
//   }

//   void initializedAudioPlayer() async {
//     try {
//       logger.i("InitializedAudioPlayer called");
//       audioPlayer = AudioPlayer();
//       final Duration? duration = await audioPlayer.setUrl(audioUrl);
//       if (duration != null) {
//         totalDuration.value = duration;
//       }
//       //play/pause state
//       audioPlayer.playerStateStream.listen((state) {
//         isPlaying.value = state.playing;
//       });

//       //for knowing current position of the audio
//       audioPlayer.positionStream.listen((position) {
//         currentPosition.value = position;
//       });
//       isInitialised.value = true;
//     } catch (e) {
//       logger.e("Audio Init Error: $e");
//     }
//   }

//   void seekSliderPosition(double seconds) {
//     audioPlayer.seek(Duration(seconds: seconds.toInt()));
//   }

//   void togglePlayPause() {
//     if (audioPlayer.playing) {
//       audioPlayer.pause();
//     } else {
//       audioPlayer.play();
//     }
//   }

//   String formatTime(Duration d) {
//     //Lets say d value is 75 seconds, means 1 minute 15 seconds then d.inminutes = 1 min
//     //similary, d.inseconds give total duration in seconds if it were 1min 15 sec then
//     // it will return that time in total seconds: 75 seconds
//     // we did %60 so that 75%60 = 15 (remainder is 15) can be convert to:
//     // 1:15 secons format
//     final minutes = d.inMinutes;
//     final seconds = d.inSeconds % 60;
//     final String minuteString = minutes.toString().padLeft(2, "0");
//     final String secondString = seconds.toString().padLeft(2, "0");
//     return "$minuteString:$secondString";
//   }

//   @override
//   void onClose() {
//     audioPlayer.dispose();
//     super.onClose();
//   }
// }
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:just_audio/just_audio.dart';

class AudioOpenScreenController extends GetxController {
  late AudioPlayer audioPlayer;

  final String audioUrl;

  AudioOpenScreenController(this.audioUrl);

  RxBool isInitialised = false.obs;
  RxBool isPlaying = false.obs;

  Rx<Duration> totalDuration = Duration.zero.obs;
  Rx<Duration> currentPosition = Duration.zero.obs;

  @override
  void onInit() {
    super.onInit();
    initializedAudioPlayer();
  }

  void initializedAudioPlayer() async {
    try {
      audioPlayer = AudioPlayer();

      final Duration? duration = await audioPlayer.setUrl(audioUrl);

      if (duration != null) {
        totalDuration.value = duration;
      }

      audioPlayer.playerStateStream.listen((state) {
        isPlaying.value = state.playing;

        if (state.processingState == ProcessingState.completed) {
          isPlaying.value = false;
          currentPosition.value = Duration.zero;
        }
      });

      audioPlayer.positionStream.listen((position) {
        currentPosition.value = position;
      });

      isInitialised.value = true;
    } catch (e) {
      print("Audio Init Error: $e");
    }
  }

  void togglePlayPause() async {
    if (audioPlayer.processingState == ProcessingState.completed) {
      await audioPlayer.seek(Duration.zero);
      await audioPlayer.play();
      return;
    }
    if (audioPlayer.playing) {
      audioPlayer.pause();
    } else {
      audioPlayer.play();
    }
  }

  void seekSliderPosition(double seconds) {
    audioPlayer.seek(Duration(seconds: seconds.toInt()));
  }

  String formatTime(Duration d) {
    final minutes = d.inMinutes;
    final seconds = d.inSeconds % 60;
    return "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }
}
