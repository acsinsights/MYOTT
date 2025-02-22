import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MoviePoster extends StatelessWidget {
  final dynamic movie;
  const MoviePoster({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(movie.bannerUrl, width: double.infinity, height: MediaQuery.of(context).size.width * (9 / 16), fit: BoxFit.cover),
        Positioned(top: 10, left: 10, child: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Get.back())),
        Positioned(
          top: MediaQuery.of(context).size.width * (9 / 16) / 2 - 30,
          left: MediaQuery.of(context).size.width / 2 - 30,
          child: IconButton(icon: Icon(Icons.play_circle_fill, color: Colors.white, size: 60), onPressed: () {}),
        ),
      ],
    );
  }
}
