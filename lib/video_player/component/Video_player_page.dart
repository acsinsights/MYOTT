import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:video_player/video_player.dart';

import '../Controller/CustomVideoController.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:video_player/video_player.dart';

import '../Controller/CustomVideoController.dart';
import 'SimpleVideoPlayerWidget.dart';

class VideoPlayerPage extends StatelessWidget {
  final String videoUrl;
  final Map<String, dynamic> subtitles;
  final Map<String, dynamic> dubbedLanguages;

  const VideoPlayerPage({
    Key? key,
    required this.videoUrl,
    required this.subtitles,
    required this.dubbedLanguages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomVideoPlayerController>(
      init: CustomVideoPlayerController(videoUrl, subtitles, dubbedLanguages),
      builder: (controller) {
        if (controller.isYouTube) {
          return YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: controller.youtubePlayerController!,
              showVideoProgressIndicator: true,
              onReady: () {
                print("YouTube Player is ready");
              },
            ),
            builder: (context, player) {
              return Scaffold(
                backgroundColor: Colors.black,
                body: SafeArea(
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: player, // Embed player here
                      ),
                      // You can show description, title, subtitle etc below if needed
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: _buildBetterPlayer(controller),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildBetterPlayer(CustomVideoPlayerController controller) {
    return BetterPlayer(controller: controller.betterPlayerController!);
  }
}


Widget _buildSimpleVideoPlayer(CustomVideoPlayerController controller) {
  if (!controller.isInitialized.value || controller.videoPlayerController == null) {
    return const Center(child: CircularProgressIndicator());
  }

  return SimpleVideoPlayerWidget(controller: controller.videoPlayerController!);
}
