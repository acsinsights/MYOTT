import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myott/UI/TvSeries/Model/TVSeriesDetailsModel.dart';
import 'package:myott/UI/TvSeries/Model/TvSeriesModel.dart';

class TVseriesPoster extends StatelessWidget {
  final TvSeriesDetailsModel movie;
  const TVseriesPoster({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(movie.series.thumbnail, width: double.infinity, height: MediaQuery.of(context).size.width * (9 / 16), fit: BoxFit.fitWidth),
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
