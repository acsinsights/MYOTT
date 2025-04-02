import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../video_player/component/InlineVideoPlayer.dart';

class VideoDetialsPage extends StatelessWidget {
  const VideoDetialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var slug =Get.arguments;
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Inlinevideoplayer(videoUrl: 'https://www.youtube.com/embed/Ts-7jQ_5EgM?si=aWcLyIowndKEchiH', subtitles: {}, dubbedLanguages: {},)
              ]
          )
        ),
      )
    );
  }
}
