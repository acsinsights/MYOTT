import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:myott/UI/Components/app_title.dart';
import 'package:myott/UI/Components/section_title.dart';
import 'package:myott/UI/TvSeries/tv_series_controller.dart';
import '../../Utils/app_text_styles.dart';
import 'Component/TVSeries_synopsis.dart';
import 'Component/TvSeries_Seasons.dart';
import 'Component/TVSeries_Action.dart';
import 'Component/TvSeries_attribute.dart';
import 'Component/episode_card.dart';
import 'Component/TVSeries_Info.dart';
import 'Component/TVSeries_poster.dart';
import '../Movie/Controller/Movie_controller.dart';

class TvSeriesPage extends StatefulWidget {
  @override
  State<TvSeriesPage> createState() => _TvSeriesPageState();
}

class _TvSeriesPageState extends State<TvSeriesPage> {
  final MovieController movieController = Get.find<MovieController>();
  final TVSeriesController tvSeriesController = Get.find<TVSeriesController>();
  bool isWatchlisted = false;
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final movie = tvSeriesController.selectedTvSeries.value;
      if (movie == null) {
        return Scaffold(
          appBar: AppBar(title: Text("TvSeries Details")),
          body: Center(child: Text("No TvSeries selected")),
        );
      }

      return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TVseriesPoster(movie: movie),
                SizedBox(height: 10,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TVseriesInfo(movie: movie, isWatchlisted: isWatchlisted, isLiked: isLiked, toggleWatchlist: _toggleWatchlist, toggleLike: _toggleLike),
                      TvSeriesSeasons(tvSeries: movie),
                      TVseriesAttributes(title: "Languages", items: movie),
                      SizedBox(height: 10,),

                      TVseriesSynopsis(description: movie.description),
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








