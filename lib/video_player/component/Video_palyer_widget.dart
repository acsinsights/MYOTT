import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/video_controller.dart';

class VideoPlayerWidget extends StatelessWidget {
  final String videoUrl;
  final String thumbnailUrl;

  VideoPlayerWidget({required this.videoUrl, required this.thumbnailUrl});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoPlayerControllerX>(
      init: VideoPlayerControllerX(),
      builder: (videoController) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // Show Thumbnail if Video is Not Initialized
            if (!videoController.isVideoInitialized.value)
              GestureDetector(
                onTap: () {
                  videoController.initializeVideo(videoUrl);
                  videoController.playVideo();
                },
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width * (9 / 16),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(thumbnailUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Icon(Icons.play_circle_fill, color: Colors.white, size: 60),
                  ),
                ),
              )
            else
              AspectRatio(
                aspectRatio: videoController.videoController.value.aspectRatio,
                child: Chewie(controller: videoController.chewieController!),
              ),
          ],
        );
      },
    );
  }
}
