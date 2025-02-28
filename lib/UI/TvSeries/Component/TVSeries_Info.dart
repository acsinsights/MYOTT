import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myott/UI/TvSeries/Model/TvSeriesModel.dart';
import 'package:myott/Utils/app_text_styles.dart';

import '../TvSeries_details_page.dart';
import 'TVSeries_Action.dart';
import 'TvSeries_metadata.dart';
class TVseriesInfo extends StatelessWidget {
  final TvSeriesModel movie;
  final bool isWatchlisted;
  final bool isLiked;
  final VoidCallback toggleWatchlist;
  final VoidCallback toggleLike;

  const TVseriesInfo({required this.movie, required this.isWatchlisted, required this.isLiked, required this.toggleWatchlist, required this.toggleLike});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.name, style: AppTextStyles.Headingb3),
                MovieMeta(movie: movie),
              ],
            ),
            Icon(Icons.download, size: 30, color: Colors.white),
          ],
        ),
        SizedBox(height: 10),
        MovieActions(isWatchlisted: isWatchlisted, isLiked: isLiked, toggleWatchlist: toggleWatchlist, toggleLike: toggleLike),
        Divider(color: Colors.grey),
      ],
    );
  }
}
