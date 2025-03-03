import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/UI/TvSeries/Controller/tv_series_controller.dart';
import 'Component/TVSeries_poster.dart';
import 'Component/TVSeries_Info.dart';
import 'Component/TvSeries_Seasons.dart';
import 'Component/TVSeries_synopsis.dart';
import 'Component/TVSeries_attribute.dart';

class TvSeriesDetailsPage extends StatefulWidget {
  final int seriesId;

  const TvSeriesDetailsPage({Key? key, required this.seriesId}) : super(key: key);

  @override
  State<TvSeriesDetailsPage> createState() => _TvSeriesDetailsPageState();
}

class _TvSeriesDetailsPageState extends State<TvSeriesDetailsPage> {
  final TVSeriesController tvSeriesController = Get.find<TVSeriesController>();

  bool isWatchlisted = false;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    tvSeriesController.fetchTVSeriesDetails(widget.seriesId); // Fetch details
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (tvSeriesController.isLoading.value) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Center(child: CircularProgressIndicator()),
        );
      }

      final seriesDetails = tvSeriesController.tvSeriesDetails.value;
      if (seriesDetails == null) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Center(child: Text("No TV Series Details Available")),
        );
      }

      return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TVseriesPoster(videoUrl: "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/720/Big_Buck_Bunny_720_10s_1MB.mp4", thumbnailurl: seriesDetails.series.thumbnail,),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TVseriesInfo(
                        movie: seriesDetails,
                        isWatchlisted: isWatchlisted,
                        isLiked: isLiked,
                        toggleWatchlist: _toggleWatchlist,
                        toggleLike: _toggleLike,
                      ),
                      TvSeriesSeasons(tvSeries: seriesDetails),
                      TVseriesAttributes(title: "Languages", items: seriesDetails),
                      const SizedBox(height: 10),
                      TVseriesSynopsis(description: seriesDetails.series.description),
                      const SizedBox(height: 30),
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
