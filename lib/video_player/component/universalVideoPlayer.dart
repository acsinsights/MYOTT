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

  /// Check if the URL is a YouTube link
  bool _isYouTubeUrl(String url) {
    return url.contains("youtube.com") || url.contains("youtu.be");
  }

  void _initializePlayer() {
    if (_isYouTubeUrl(widget.videoUrl)) {
      isYouTube = true;
      String? videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);

      if (videoId != null) {
        _youtubeController = YoutubePlayerController(
          initialVideoId: videoId,
          flags: YoutubePlayerFlags(
            autoPlay: true,
            mute: false, // Allows user to control volume
          ),
        );
      } else {
        print("⚠️ Invalid YouTube URL");
      }
    } else {
      _videoController = VideoPlayerController.network(widget.videoUrl)
        ..initialize().then((_) {
          setState(() {}); // Update UI after initialization
          _videoController!.play();
        }).catchError((error) {
          print("⚠️ Video initialization error: $error");
        });

      _chewieController = ChewieController(
        videoPlayerController: _videoController!,
        autoPlay: true,
        looping: false,
        allowMuting: true,

      );
    }
  }

  /// Force the app into landscape mode
  void _setLandscapeMode() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  /// Reset orientation back to portrait when leaving
  void _resetPortraitMode() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    _resetPortraitMode(); // Ensure portrait mode is restored

    _videoController?.dispose();
    _chewieController?.dispose();
    _youtubeController?.dispose();

    super.dispose();
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
