import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myott/UI/TvSeries/Model/TvSeriesModel.dart';

import 'episode_card.dart';



class TvSeriesSeasons extends StatelessWidget {
  final TvSeriesModel tvSeries;
  const TvSeriesSeasons({required this.tvSeries});

  @override
  Widget build(BuildContext context) {
    // bool hasSeasons = tvSeries.seasons.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // if (hasSeasons) ...[
        //   DefaultTabController(
        //     length: tvSeries.seasons.length,
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         TabBar(
        //           isScrollable: true,
        //           indicatorColor: AppColors.primary,
        //           labelColor: AppColors.primary,
        //           unselectedLabelColor: Colors.grey,
        //           labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        //           indicatorSize: TabBarIndicatorSize.label,
        //           tabAlignment: TabAlignment.start,
        //           labelPadding: EdgeInsets.symmetric(horizontal: 10),
        //           tabs: tvSeries.seasons
        //               .map((season) => Tab(text: "Season ${season.seasonNumber}"))
        //               .toList(),
        //         ),
        //         SizedBox(height: 10),
        //         SizedBox(
        //           height: 120,
        //           child: TabBarView(
        //             children: tvSeries.seasons.map((season) {
        //               return ListView(
        //                 scrollDirection: Axis.horizontal,
        //                 children: season.episodes
        //                     .map((episode) => EpisodeCard(episode.title, episode.imageUrl))
        //                     .toList(),
        //               );
        //             }).toList(),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ] else ...
        //
        // [
          SizedBox(height: 10),
          Text("Episodes", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 10),
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: tvSeries.episodes
                  .map((episode) => EpisodeCard(episode.title, episode.posterImage))
                  .toList(),
            ),
          ),
        ],
      // ],
    );
  }
}


