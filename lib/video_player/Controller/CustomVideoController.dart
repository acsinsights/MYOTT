import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CustomVideoPlayerController extends GetxController {
  final String videoUrl;
  final Map<String, dynamic> subtitles;
  final Map<String, dynamic> dubbedLanguages;

  VideoPlayerController? videoPlayerController;
  YoutubePlayerController? youtubePlayerController;

  bool isYouTube = false;
  RxBool isInitialized = false.obs;

  CustomVideoPlayerController(this.videoUrl, this.subtitles, this.dubbedLanguages);

  @override
  void onInit() {
    super.onInit();
    isYouTube = videoUrl.contains("youtube.com") || videoUrl.contains("youtu.be");

    if (isYouTube) {
      _initYouTubePlayer();
    } else {
      _initSimplePlayer();
    }
  }

  void _initYouTubePlayer() {
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);
    if (videoId != null) {
      youtubePlayerController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(autoPlay: true),
      );
    }
  }

  void _initSimplePlayer() {
    videoPlayerController = VideoPlayerController.network(videoUrl)
      ..initialize().then((_) {
        videoPlayerController?.play();
        isInitialized.value = true;
        update();
      });
  }

  @override
  void onClose() {
    youtubePlayerController?.dispose();
    videoPlayerController?.dispose();
    super.onClose();
  }
}
