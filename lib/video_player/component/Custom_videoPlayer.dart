import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class MoviePlayer extends StatefulWidget {
  final String videoUrl;

  const MoviePlayer({super.key, required this.videoUrl});

  @override
  State<MoviePlayer> createState() => _MoviePlayerState();
}

class _MoviePlayerState extends State<MoviePlayer> {
  late VideoPlayerController _videoController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(widget.videoUrl);

    _videoController.initialize().then((_) {
      _chewieController = ChewieController(
        videoPlayerController: _videoController,
        autoPlay: true,
        looping: true,

        optionsTranslation: OptionsTranslation(
          playbackSpeedButtonText: 'Playback Speed',
          subtitlesButtonText: 'Subtitles',
          cancelButtonText: 'Cancel',
        ),
        additionalOptions: (context) => [
          OptionItem(
            onTap: (ctx) => debugPrint('Custom option tapped!'),
            iconData: Icons.settings,
            title: 'Audio',
          ),
        ],
        subtitle: Subtitles([
          Subtitle(
            index: 0,
            start: Duration.zero,
            end: const Duration(seconds: 10),
            text: 'Hello from subtitles',
          ),
          Subtitle(
            index: 1,
            start: const Duration(seconds: 10),
            end: const Duration(seconds: 20),
            text: 'What’s up? :)',
          ),
        ]),
        showSubtitles: true,
        subtitleBuilder: (context, subtitle) => Container(
          padding: const EdgeInsets.all(5.0),
          color: Colors.black54,
          child: Text(
            subtitle,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      );
      setState(() {});
    });
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Movie Player")),
      body: SafeArea(
        child: Column(
          children: [
           AspectRatio(aspectRatio: 16/9,
           child:  _videoController.value.isInitialized
               ? Chewie(controller: _chewieController)
               : const CircularProgressIndicator()
             ,)

        ]
      ),
      )
    );
  }
}
