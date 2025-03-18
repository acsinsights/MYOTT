import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chewie/chewie.dart';
import 'package:myott/UI/Movie/Model/movie_details_model.dart';
import 'package:video_player/video_player.dart';
import '../Controller/playerController.dart';

class SonyLIVStyleVideoPlayer extends StatelessWidget {
  final String videoUrl;
  final MovieDetailsModel movie;
  final VideoPlayerControllerXX controller = Get.put(VideoPlayerControllerXX());

  SonyLIVStyleVideoPlayer({super.key, required this.videoUrl,required this.movie});


  @override
  Widget build(BuildContext context) {
    controller.initializePlayer(videoUrl,movie);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() => controller.chewieController.value == null
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
            child: Container(
              child: SizedBox(
                  height: 200,
                      child:  Chewie(controller: controller.chewieController.value!),

                    ),
            ),
          )),
    );
  }

  void _showSubtitleOptions(BuildContext context) {
    Get.bottomSheet(
      Container(
        color: Colors.black,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...controller.subtitles.entries.map((entry) => ListTile(
              title: Text(entry.key, style: TextStyle(color: Colors.white)),
              onTap: () => controller.changeSubtitle(entry.value),
            )),
          ],
        ),
      ),
    );
  }

  void _showAudioOptions(BuildContext context) {
    Get.bottomSheet(
      Container(
        color: Colors.black,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...controller.dubbedAudio.entries.map((entry) => ListTile(
              title: Text(entry.key, style: TextStyle(color: Colors.white)),
              onTap: () => controller.changeAudio(entry.value),
            )),
          ],
        ),
      ),
    );
  }

  void _showSpeedOptions(BuildContext context) {
    Get.bottomSheet(
      Container(
        color: Colors.black,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(title: Text("0.5x", style: TextStyle(color: Colors.white)), onTap: () => controller.setSpeed(0.5)),
            ListTile(title: Text("1.0x", style: TextStyle(color: Colors.white)), onTap: () => controller.setSpeed(1.0)),
            ListTile(title: Text("1.5x", style: TextStyle(color: Colors.white)), onTap: () => controller.setSpeed(1.5)),
            ListTile(title: Text("2.0x", style: TextStyle(color: Colors.white)), onTap: () => controller.setSpeed(2.0)),
          ],
        ),
      ),
    );
  }
}