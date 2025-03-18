import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;


class VideoPlayerScreenSub extends StatefulWidget {
  final String videoUrl;
  final String subtitleUrl;

  const VideoPlayerScreenSub({required this.videoUrl, required this.subtitleUrl});

  @override
  _VideoPlayerScreenSubState createState() => _VideoPlayerScreenSubState();
}

class _VideoPlayerScreenSubState extends State<VideoPlayerScreenSub> {
  late VideoPlayerController _videoController;
  late ChewieController _chewieController;
  List<Subtitle> _subtitles = [];

  @override
  void initState() {
    super.initState();
    _loadSubtitles();
    _initializePlayer();
  }

  /// ✅ Load and parse subtitles from URL or local file
  Future<void> _loadSubtitles() async {
    try {
      String srtContent;
      if (widget.subtitleUrl.startsWith("http")) {
        final response = await http.get(Uri.parse(widget.subtitleUrl));
        if (response.statusCode == 200) {
          srtContent = response.body;
        } else {
          throw Exception("Failed to load subtitles");
        }
      } else {
        srtContent = await rootBundle.loadString(widget.subtitleUrl);
      }

      _subtitles = _parseSrt(srtContent);
      _initializePlayer();
    } catch (e) {
      debugPrint("Error loading subtitles: $e");
    }
  }

  /// ✅ Parse SRT file into a usable format
  List<Subtitle> _parseSrt(String srtContent) {
    final subtitleList = <Subtitle>[];
    final lines = srtContent.split("\n\n");

    for (var line in lines) {
      final parts = line.split("\n");
      if (parts.length >= 3) {
        final timecodes = parts[1].split(" --> ");
        final start = _parseDuration(timecodes[0]);
        final end = _parseDuration(timecodes[1]);
        final text = parts.sublist(2).join("\n");

        subtitleList.add(Subtitle(
          index: subtitleList.length,
          start: start,
          end: end,
          text: text,
        ));
      }
    }
    return subtitleList;
  }

  /// ✅ Convert SRT timestamps to Duration
  Duration _parseDuration(String time) {
    final parts = time.split(":");
    final secondsParts = parts[2].split(",");

    return Duration(
      hours: int.parse(parts[0]),
      minutes: int.parse(parts[1]),
      seconds: int.parse(secondsParts[0]),
      milliseconds: int.parse(secondsParts[1]),
    );
  }

  /// ✅ Initialize Video Player with subtitles
  void _initializePlayer() {
    _videoController = VideoPlayerController.network(widget.videoUrl);
    _videoController.initialize().then((_) {
      _chewieController = ChewieController(
        videoPlayerController: _videoController,
        autoPlay: true,
        looping: false,
        showControls: true,
        showSubtitles: true,
        subtitle: Subtitles(_subtitles),
        subtitleBuilder: (context, subtitle) => Container(
          color: Colors.black54,
          padding: const EdgeInsets.all(8.0),
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

  /// ✅ UI for Video Player
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Movie Player")),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            child: _videoController.value.isInitialized
                ? Chewie(controller: _chewieController)
                : Center(child: const CircularProgressIndicator()),
          ),
          const SizedBox(height: 10),

        ],
      ),
    );
  }
}