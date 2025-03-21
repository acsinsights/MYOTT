import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TVseriesPoster extends StatelessWidget {
  final String videoUrl;
  final String thumbnailurl;
  TVseriesPoster({required this.videoUrl, required this.thumbnailurl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(height: 200,),
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
