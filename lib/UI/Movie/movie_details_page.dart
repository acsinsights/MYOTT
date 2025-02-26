import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:myott/UI/Components/app_title.dart';
import 'package:myott/UI/Components/section_title.dart';
import '../../Utils/app_text_styles.dart';
import 'Component/Moive_seasons.dart';
import 'Component/Movie_Action.dart';
import 'Component/Movie_attribute.dart';
import 'Component/episode_card.dart';
import 'Component/movie_info.dart';
import 'Component/movie_poster.dart';
import 'Component/movie_synopsis.dart';
import 'Controller/Movie_controller.dart';

class MovieDetailScreen extends StatefulWidget {
  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final MovieController movieController = Get.find<MovieController>();
  bool isWatchlisted = false;
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final movie = movieController.selectedMovie.value;
      if (movie == null) {
        return Scaffold(
          appBar: AppBar(title: Text("Movie Details")),
          body: Center(child: Text("No movie selected")),
        );
      }

      return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MoviePoster(movie: movie),
                SizedBox(height: 10,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MovieInfo(movie: movie, isWatchlisted: isWatchlisted, isLiked: isLiked, toggleWatchlist: _toggleWatchlist, toggleLike: _toggleLike),
                      MovieSeasons(movie: movie),
                      MovieAttributes(title: "Movie Name", items: movie),
                      SizedBox(height: 10,),
                      MovieAttributes(title: "Languages", items: movie),
                      SizedBox(height: 10,),

                      MovieSynopsis(description: movie.description),
                      SizedBox(height: 30,)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  void _toggleWatchlist() => setState(() => isWatchlisted = !isWatchlisted);
  void _toggleLike() => setState(() => isLiked = !isLiked);
}








