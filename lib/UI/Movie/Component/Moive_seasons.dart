import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Utils/app_colors.dart';
import 'episode_card.dart';

class MovieSeasons extends StatelessWidget {
  final dynamic movie;
  const MovieSeasons({required this.movie});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: movie.seasons.length,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            isScrollable: true,
            indicatorColor: AppColors.primary,
            labelColor: AppColors.primary,
            unselectedLabelColor: Colors.grey,
            labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            indicatorSize: TabBarIndicatorSize
                .label, // Wraps indicator tightly around text
            tabAlignment: TabAlignment
                .start, // Forces tabs to start from the left
            labelPadding: EdgeInsets.symmetric(
                horizontal: 10), // Adjust tab spacing
            tabs: movie.seasons.map<Widget>((season) => Tab(text: "Season ${season.seasonNumber}")).toList(),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 120,
            child: TabBarView(
              children: movie.seasons.map<Widget>((season) {  // Explicitly define <Widget>
                return ListView(
                  scrollDirection: Axis.horizontal,
                  children: season.episodes
                      .map<Widget>((episode) => EpisodeCard(episode.title, episode.imageUrl))
                      .toList(),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
