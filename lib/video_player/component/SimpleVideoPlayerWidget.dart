import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class SimpleVideoPlayerWidget extends StatefulWidget {
  final VideoPlayerController controller;

  const SimpleVideoPlayerWidget({super.key, required this.controller});

  @override
  State<SimpleVideoPlayerWidget> createState() => _SimpleVideoPlayerWidgetState();
}

class _SimpleVideoPlayerWidgetState extends State<SimpleVideoPlayerWidget> {
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    _chewieController = ChewieController(

      draggableProgressBar: true,
      videoPlayerController: widget.controller,
      autoPlay: true,
      looping: false,
      showControls: true,
      allowFullScreen: true,
      allowMuting: true,
      allowPlaybackSpeedChanging: true,
      materialProgressColors: ChewieProgressColors(

        playedColor: Colors.red,
        handleColor: Colors.white,
        backgroundColor: Colors.grey.shade700,
        bufferedColor: Colors.lightGreen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widget.controller.value.aspectRatio,
      child: Chewie(controller: _chewieController),
    );
  }

  @override
  void dispose() {
    _chewieController.dispose();
    super.dispose();
  }

}
