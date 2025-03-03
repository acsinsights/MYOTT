import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerControllerX extends GetxController {
  late VideoPlayerController videoController;
  ChewieController? chewieController;

  var isVideoInitialized = false.obs;
  var isPlaying = false.obs;
  var isFullScreen = false.obs;

  void initializeVideo(String videoUrl) {
    if (isVideoInitialized.value) return; // Prevent re-initialization

    videoController = VideoPlayerController.network(videoUrl)
      ..initialize().then((_) {
        isVideoInitialized.value = true;
        _setupChewieController();
        update();
      })
      ..addListener(() {
        isPlaying.value = videoController.value.isPlaying;
      });
  }

  void _setupChewieController() {
    chewieController = ChewieController(
      videoPlayerController: videoController,
      autoPlay: false, // Ensure autoPlay is disabled
      looping: false,
      showControlsOnInitialize: false,
      allowedScreenSleep: false,
      allowFullScreen: true,
      allowPlaybackSpeedChanging: true,
      allowMuting: true,
      fullScreenByDefault: false,
      aspectRatio: videoController.value.aspectRatio,
    );
    update();
  }

  void playVideo() {
    if (!isVideoInitialized.value) return;
    videoController.play();
  }

  void togglePlayPause() {
    if (videoController.value.isPlaying) {
      videoController.pause();
    } else {
      videoController.play();
    }
    update();
  }

  void toggleFullScreen() {
    if (chewieController != null) {
      chewieController!.enterFullScreen();
    }
  }

  void setPlaybackSpeed(double speed) {
    videoController.setPlaybackSpeed(speed);
  }

  @override
  void onClose() {
    videoController.dispose();
    chewieController?.dispose();
    super.onClose();
  }
}
