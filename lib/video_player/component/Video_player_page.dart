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
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: controller.isYouTube
                      ? _buildYouTubePlayer(controller)
                      : _buildSimpleVideoPlayer(controller),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget _buildSimpleVideoPlayer(CustomVideoPlayerController controller) {
    if (!controller.isInitialized.value || controller.videoPlayerController == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return SimpleVideoPlayerWidget(controller: controller.videoPlayerController!);
  }


  Widget _buildYouTubePlayer(CustomVideoPlayerController controller) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(controller: controller.youtubePlayerController!),
      builder: (context, player) => player,
    );
  }
}

