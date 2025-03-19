import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Components/network_image_widget.dart';

class MoviePoster extends StatelessWidget {
  final String videoUrl;
  final String thumbnailurl;
  MoviePoster({required this.videoUrl, required this.thumbnailurl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: 10,
            left: 10,
            child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Get.back())),
      ],
    );
  }
}
