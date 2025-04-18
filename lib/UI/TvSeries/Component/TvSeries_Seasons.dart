import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../video_player/component/Video_player_page.dart';
import '../Model/TVSeriesDetailsModel.dart';
import 'episode_card.dart';



class TvSeriesEpisode extends StatelessWidget {
  final SeriesDetailResponse tvSeries;
  final SOrder? order;

  const TvSeriesEpisode({
    required this.tvSeries,
    required this.order,
  });
  bool _checkHasAccess(SOrder? order, String contentType) {
    contentType = contentType.trim();

    if (contentType == "subsriptionSystem" || contentType == "pricingSection") {
      return order != null &&
          order.endDate != null &&
          order.endDate!.isAfter(DateTime.now());
    }

    if (contentType == "coinCostSection") {
      return order != null;
    }

    return false;
  }

  bool _checkEpisodeAccess(Episode episode, SOrder? order, String contentType) {
    if (episode.isFree) return true;
    return _checkHasAccess(order, contentType);
  }

  @override
  Widget build(BuildContext context) {

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

              return GestureDetector(
                onTap: () {
                  if (_checkEpisodeAccess(episode,tvSeries.series.seriesorder,tvSeries.series.seriesPackage.selection)) {
                    Get.to(() => VideoPlayerPage(
                      videoUrl: episode.uploadUrl,
                      subtitles: {},
                      dubbedLanguages: {},
                    ));
                  } else {
                    // ❌ Access denied — show snackbar
                    Get.snackbar(
                      "Access Denied",
                      "You don't have access to this episode.",
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
                child: EpisodeCard(
                  episode.title,
                  episode.poster.toString(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}


