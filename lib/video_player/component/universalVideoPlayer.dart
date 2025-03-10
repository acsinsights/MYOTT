import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart';

class UniversalVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const UniversalVideoPlayer({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _UniversalVideoPlayerState createState() => _UniversalVideoPlayerState();
}

class _UniversalVideoPlayerState extends State<UniversalVideoPlayer> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  YoutubePlayerController? _youtubeController;
  bool isYouTube = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
    _setLandscapeMode();
  }

  void _initializePlayer() {
    if (_isYouTubeUrl(widget.videoUrl)) {
      isYouTube = true;
      String? videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);

      if (videoId != null) {
        _youtubeController = YoutubePlayerController(
          initialVideoId: videoId,
          flags: YoutubePlayerFlags(
            autoPlay: true, // AutoPlay enabled
            mute: false,
          ),
        );

        setState(() {}); // Ensure UI updates
      } else {
        print("⚠️ Invalid YouTube URL");
      }
    } else {
      _videoController = VideoPlayerController.network(widget.videoUrl)
        ..initialize().then((_) {
          setState(() {}); // Ensure UI updates after initialization
          _videoController!.play(); // Start playing automatically
        }).catchError((error) {
          print("⚠️ Video initialization error: $error");
        });

      _chewieController = ChewieController(
        videoPlayerController: _videoController!,
        autoPlay: true,  // Ensure AutoPlay
        looping: false,
      );

      setState(() {}); // Ensure UI updates
    }
  }

  void _setLandscapeMode() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
// Reset orientation when leaving
    _videoController?.dispose();
    _chewieController?.dispose();
    _youtubeController?.dispose();
    super.dispose();
  }

  bool _isYouTubeUrl(String url) {
    return url.contains("youtube.com") || url.contains("youtu.be");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isYouTube
            ? _youtubeController != null
            ? YoutubePlayer(controller: _youtubeController!)
            : Center(child: Text("Invalid YouTube URL"))
            : _videoController != null && _videoController!.value.isInitialized
            ? Chewie(controller: _chewieController!)
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
