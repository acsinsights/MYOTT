import 'package:better_player_plus/better_player_plus.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CustomVideoPlayerController extends GetxController {
  final String videoUrl;
  final Map<String, dynamic> subtitles;
  final Map<String, dynamic> dubbedLanguages;

  VideoPlayerController? videoPlayerController;
  YoutubePlayerController? youtubePlayerController;
  BetterPlayerController? betterPlayerController;

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
      _initBetterPlayer();
    }
  }

  void _initYouTubePlayer() {
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);
    if (videoId != null) {
      youtubePlayerController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          enableCaption: true,
          controlsVisibleAtStart: true,
          forceHD: true,
          isLive: false,
          hideControls: false,
        ),
      );

      // Jump to fullscreen by default after slight delay
      Future.delayed(Duration(milliseconds: 500), () {
        youtubePlayerController!.toggleFullScreenMode();
      });
    }
  }

  void _initBetterPlayer() {
    final dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      videoUrl,
      subtitles: _getSubtitleSources(),
    );

    betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(
        autoPlay: true,
        aspectRatio: 16 / 9,
        fullScreenByDefault: true, // 👉 makes fullscreen by default
        autoDetectFullscreenDeviceOrientation: true,
        autoDetectFullscreenAspectRatio: true,
        handleLifecycle: true,
        allowedScreenSleep: false,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          enableFullscreen: true,
          enablePlayPause: true,
          enableAudioTracks: true, // 👉 this enables audio language change button
        ),
      ),
      betterPlayerDataSource: dataSource,
    );

    betterPlayerController!.addEventsListener((event) {
      if (event.betterPlayerEventType == BetterPlayerEventType.hideFullscreen) {
        Future.delayed(Duration(milliseconds: 300), () {
          update();
        });
      }
    });
  }

  List<BetterPlayerSubtitlesSource> _getSubtitleSources() {
    return subtitles.entries
        .map((entry) => BetterPlayerSubtitlesSource(
      type: BetterPlayerSubtitlesSourceType.network,
      urls: [entry.value],
      name: entry.key,
    ))
        .toList();
  }

  @override
  void onClose() {
    youtubePlayerController?.dispose();
    videoPlayerController?.dispose();
    betterPlayerController?.dispose();
    super.onClose();
  }
}
