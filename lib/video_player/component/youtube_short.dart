import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class YouTubeShortPlayer extends StatefulWidget {
  final String url;

  const YouTubeShortPlayer({super.key, required this.url});

  @override
  State<YouTubeShortPlayer> createState() => _YouTubeShortPlayerState();
}

class _YouTubeShortPlayerState extends State<YouTubeShortPlayer> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(_getPlayableUrl(widget.url)));
  }

  String _getPlayableUrl(String originalUrl) {
    final uri = Uri.parse(originalUrl);

    if (uri.host.contains("youtube.com") && uri.path.contains("/watch")) {
      final videoId = uri.queryParameters["v"];
      return "https://www.youtube.com/shorts/$videoId";
    }

    return originalUrl;
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}
