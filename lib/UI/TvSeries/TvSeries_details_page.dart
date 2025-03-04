import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myott/Core/Utils/app_text_styles.dart';
import 'package:myott/UI/Components/ShimmerLoader.dart';
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

  bool isWatchlisted = false;
  bool isLiked = false;



  @override
  Widget build(BuildContext context) {
    final TVSeriesController tvSeriesController = Get.find<TVSeriesController>();
    tvSeriesController.fetchTVSeriesDetails(widget.seriesId);



      return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Obx(() {
              if (tvSeriesController.isLoading.value) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerLoader(height: 200.h,),
                      SizedBox(height: 10,),
                      ShimmerLoader(height: 20.h,width: 50.h,),
                      SizedBox(height: 10,),
                      ShimmerLoader(height: 50.h,),
                      SizedBox(height: 10,),
                      ShimmerLoader(height: 100.h,),
                      SizedBox(height: 10,),
                      ShimmerLoader(height: 400.h,),
                    ],
                  ),
                );
              }
              if (tvSeriesController.tvSeriesDetails.value == null) {
                return Center(child: Text("Movie details not available",style: AppTextStyles.SubHeading2,));
              }
              final tvdetails=tvSeriesController.tvSeriesDetails.value!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TVseriesPoster(videoUrl: "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/720/Big_Buck_Bunny_720_10s_1MB.mp4", thumbnailurl: tvdetails.series.thumbnail,),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TVseriesInfo(
                          movie: tvdetails,
                          isWatchlisted: isWatchlisted,
                          isLiked: isLiked,
                          toggleWatchlist: _toggleWatchlist,
                          toggleLike: _toggleLike,
                        ),
                        TvSeriesSeasons(tvSeries: tvdetails),
                        TVseriesAttributes(title: "Languages", items: tvdetails),
                        const SizedBox(height: 10),
                        TVseriesSynopsis(description: tvdetails.series.description),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              );
            }

            )
          ),
        ),
      );
    }
  void _toggleWatchlist() => setState(() => isWatchlisted = !isWatchlisted);
  void _toggleLike() => setState(() => isLiked = !isLiked);
  }



