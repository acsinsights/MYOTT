import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import '../../UI/Movie/Model/movie_details_model.dart';
import '../Controller/playerController.dart';

class VideoPlayerScreen extends StatelessWidget {
  final String videoUrl;
  final MovieDetailsModel movieDetails;
  final VideoPlayerControllerXX controller = Get.put(VideoPlayerControllerXX());

  VideoPlayerScreen({super.key, required this.videoUrl, required this.movieDetails});

  @override
  Widget build(BuildContext context) {
    controller.initializePlayer(videoUrl, movieDetails);
    return Scaffold(
      body: Obx(() => SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 200.h,
                  child: controller.chewieController.value != null
                      ? Chewie(controller: controller.chewieController.value!)
                      : const Center(child: CircularProgressIndicator()),
                ),

                // App Logo
                if (controller.showLogo.value && controller.logoUrl.value.isNotEmpty)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Image.network(
                      controller.logoUrl.value,
                      height: 40,
                      width: 40,
                      fit: BoxFit.contain,
                    ),
                  ),

                // Subtitle Button
                Positioned(
                  right: 60,
                  bottom: 30,
                  child: IconButton(
                    onPressed: () => _showSubtitleDialog(context),
                    icon: const Icon(Icons.subtitles, color: Colors.white),
                  ),
                ),

                // Audio Button
                Positioned(
                  right: 10,
                  bottom: 30,
                  child: IconButton(
                    onPressed: () => _showAudioDialog(context),
                    icon: const Icon(Icons.audiotrack, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }

  // Subtitle Selection Dialog
  void _showSubtitleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Select Subtitle"),
          content: Obx(() => Column(
            mainAxisSize: MainAxisSize.min,
            children: controller.subtitles.keys.map((language) {
              return ListTile(
                title: Text(language),
                onTap: () {
                  controller.changeSubtitle(language);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          )),
        );
      },
    );
  }

  // Dubbed Audio Selection Dialog
  void _showAudioDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Select Audio"),
          content: Obx(() => Column(
            mainAxisSize: MainAxisSize.min,
            children: controller.dubbedAudio.keys.map((language) {
              return ListTile(
                title: Text(language),
                onTap: () {
                  controller.changeAudio(language);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          )),
        );
      },
    );
  }
}
