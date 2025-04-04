import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myott/UI/TvSeries/Model/TVSeriesDetailsModel.dart';
import 'package:myott/UI/TvSeries/Model/TvSeriesModel.dart';

import '../../../video_player/component/Video_player_page.dart';
import 'episode_card.dart';



class TvSeriesEpisode extends StatelessWidget {
  final SeriesDetailResponse tvSeries;
  const TvSeriesEpisode({required this.tvSeries});

  @override
  Widget build(BuildContext context) {
    print("Episodes: ${tvSeries.episodes}"); // ✅ Debugging

    if (tvSeries.episodes.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("No episodes available", style: GoogleFonts.poppins(color: Colors.white)),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text("Episodes", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 10),
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tvSeries.episodes.length,
            itemBuilder: (context, index) {
              final episode = tvSeries.episodes[index];
              print("Episode $index: ${episode.title}, ${episode.poster}"); // ✅ Debugging
              return GestureDetector(
                  onTap: (){
                    Get.to(VideoPlayerPage(videoUrl: episode.uploadUrl, subtitles: {}, dubbedLanguages: {},));
                  },
                  child: EpisodeCard(episode.title, episode.poster.toString()));
            },
          ),
        ),
      ],
    );
  }

}


