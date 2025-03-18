import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '../../UI/Movie/Model/movie_details_model.dart';
import '../../UI/Setting/Setting_Controller.dart';

class VideoPlayerControllerXX extends GetxController {
  late VideoPlayerController videoController;
  Rx<ChewieController?> chewieController = Rx<ChewieController?>(null);

  final SettingController settingController = Get.find<SettingController>();

  // Player settings variables
  RxBool isAutoPlay = false.obs;
  RxBool showLogo = false.obs;
  RxDouble playbackSpeed = 1.0.obs;
  RxString logoUrl = "".obs;

  // Subtitle & Dubbed Audio
  RxMap<String, String> subtitles = <String, String>{}.obs;
  RxMap<String, String> dubbedAudio = <String, String>{}.obs;
  RxString selectedSubtitle = "".obs;
  RxString selectedDubbedAudio = "".obs;

  @override
  void onInit() {
    super.onInit();
  }

  void initializePlayer(String videoUrl, MovieDetailsModel movieDetails) async {
    if (settingController.playerSetting.isNotEmpty) {
      isAutoPlay.value = settingController.playerSetting.first.videoAutoPlay == "1";
      showLogo.value = settingController.playerSetting.first.playerLogo == "1";
      playbackSpeed.value = settingController.playerSetting.first.speedControl == "1" ? 1.5 : 1.0;
      logoUrl.value = settingController.playerSetting.first.playerLogoImage;
    }

    // ✅ Assign subtitles & audio tracks safely
    subtitles.assignAll(movieDetails.movie.subtitles);
    dubbedAudio.assignAll(movieDetails.movie.dubbedLanguages);

    selectedSubtitle.value = subtitles.keys.isNotEmpty ? subtitles.keys.first : "";
    selectedDubbedAudio.value = dubbedAudio.keys.isNotEmpty ? dubbedAudio.keys.first : "";

    // ✅ Initialize video player
    videoController = VideoPlayerController.network(videoUrl);
    await videoController.initialize();

    // ✅ Correctly configure ChewieController
    chewieController.value = ChewieController(
      videoPlayerController: videoController,
      autoPlay: isAutoPlay.value,
      looping: false,
      allowFullScreen: true,
      showControls: false, // Custom Controls
    );

    update();
  }

  // ✅ Play/Pause Toggle
  void togglePlayPause() {
    if (videoController.value.isPlaying) {
      videoController.pause();
    } else {
      videoController.play();
    }
    update();
  }

  // ✅ Subtitle Change
  void changeSubtitle(String language) {
    selectedSubtitle.value = language;
    update();
  }

  // ✅ Dubbed Audio Change
  void changeAudio(String language) {
    selectedDubbedAudio.value = language;
    update();
  }

  // ✅ Fullscreen Toggle with Navigation Handling
  void toggleFullscreen() {
    if (chewieController.value != null) {
      chewieController.value!.enterFullScreen();
    }
  }

  // ✅ Playback Speed Control (Sync with UI)
  void setSpeed(double speed) {
    playbackSpeed.value = speed;
    videoController.setPlaybackSpeed(speed);
    update();
  }

  @override
  void onClose() {
    chewieController.value?.dispose();
    videoController.dispose();
    super.onClose();
  }
}
