import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:video_player/video_player.dart';

class VideoOpenScreenController extends GetxController {
  late VideoPlayerController videoController;
  late ChewieController chewieController;
  late String videoUrl;
  RxBool isInitialized = false.obs;
  final logger = Logger();
  @override
  void onInit() {
    videoUrl = Get.arguments["videoUrl"];
    logger.i("VideoUrl: $videoUrl");
    initVideoPlayer();
    super.onInit();
  }

  void initVideoPlayer() async {
    logger.i("InitVideoPlayer function called");
    videoController = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    await videoController.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoController,
      autoPlay: true,
      looping: false,
      showControls: true,
      allowFullScreen: true,
    );
    isInitialized.value = true;
  }

  @override
  void onClose() {
    // TODO: implement onClose
    videoController.dispose();
    chewieController.dispose();
    logger.e("Video Player closed");
    super.onClose();
  }
}
