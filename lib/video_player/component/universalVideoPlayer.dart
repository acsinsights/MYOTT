import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String videoUrl;
  const CustomVideoPlayer({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _CustomVideoPlayerState createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  YoutubePlayerController? _ytController;
  VideoPlayerController? _videoPlayerController;
  bool isYouTube = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  void _initializePlayer() {
    isYouTube = _isYouTubeUrl(widget.videoUrl);
    if (isYouTube) {
      _initializeYouTubePlayer();
    } else {
      _initializeVideoPlayer();
    }
  }

  bool _isYouTubeUrl(String url) {
    return url.contains("youtube.com") || url.contains("youtu.be");
  }

  void _initializeYouTubePlayer() {
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    _ytController = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: YoutubePlayerFlags(autoPlay: true, mute: false),
    );
  }

  void _initializeVideoPlayer() {
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {}); // Ensure widget updates after initialization
        _videoPlayerController?.play(); // Auto-play the video
      });
  }

  @override
  void didUpdateWidget(covariant CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl != widget.videoUrl) {
      _disposeControllers();
      _initializePlayer();
    }
  }

  void _disposeControllers() {
    _ytController?.dispose();
    _videoPlayerController?.dispose();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isYouTube
        ? YoutubePlayer(
      controller: _ytController!,
      showVideoProgressIndicator: true,
    )
        : _videoPlayerController != null && _videoPlayerController!.value.isInitialized
        ? AspectRatio(
      aspectRatio: _videoPlayerController!.value.aspectRatio,
      child: VideoPlayer(_videoPlayerController!),
    )
        : const Center(child: CircularProgressIndicator());
  }
}
