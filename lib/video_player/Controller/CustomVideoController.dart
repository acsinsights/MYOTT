import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CustomVideoPlayerController extends GetxController {
  final String videoUrl;
  final Map<String, dynamic> subtitles;
  final Map<String, dynamic> dubbedLanguages;
  BetterPlayerController? betterPlayerController;
  YoutubePlayerController? youtubePlayerController;
  bool isYouTube = false;

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
    String? videoId = YoutubePlayer.convertUrlToId(videoUrl);
    if (videoId != null) {
      youtubePlayerController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          enableCaption: true,
        ),
      );
    }
  }

  void _initBetterPlayer() {
    betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(
        autoPlay: true,
        aspectRatio: 16 / 9,
        fullScreenAspectRatio: 16 / 9,
        handleLifecycle: true,
        allowedScreenSleep: false,
        autoDetectFullscreenAspectRatio: true,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          enableFullscreen: true,
          enablePlayPause: true,
        ),
      ),
      betterPlayerDataSource: BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        videoUrl,
        subtitles: _getSubtitleSources(), // Subtitles added here
      ),
    );

    // Handle fullscreen exit properly
    betterPlayerController!.addEventsListener((event) {
      if (event.betterPlayerEventType == BetterPlayerEventType.hideFullscreen) {
        Future.delayed(Duration(milliseconds: 300), () {
          update(); // Updates UI after exiting fullscreen
        });
      }
    });
  }



  // Fetch subtitle sources
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
    youtubePlayerController?.pause();
    youtubePlayerController?.dispose();
    betterPlayerController?.dispose();
    super.onClose();
  }
}
