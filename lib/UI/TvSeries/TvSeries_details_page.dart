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

class TvSeriesDetailsPage extends StatelessWidget {
  final String slug;

  const TvSeriesDetailsPage({Key? key, required this.slug}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TVSeriesController tvSeriesController = Get.find<TVSeriesController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      tvSeriesController.fetchTVSeriesDetails(slug);
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Obx(() {
          if (tvSeriesController.isDetailsLoading.value) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerLoader(height: 200.h),
                    SizedBox(height: 10),
                    ShimmerLoader(height: 20.h, width: 50.h),
                    SizedBox(height: 10),
                    ShimmerLoader(height: 50.h),
                    SizedBox(height: 10),
                    ShimmerLoader(height: 100.h),
                    SizedBox(height: 10),
                    ShimmerLoader(height: 400.h),
                  ],
                ),
              ),
            );
          }

          final tvdetails = tvSeriesController.tvSeriesDetails.value;
          if (tvdetails == null) {
            return Center(child: Text("TV Series details not available", style: AppTextStyles.SubHeading2));
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  width: double.infinity, // Ensures proper layout
                  child: Image.network(
                    tvdetails.series.thumbnail,
                    fit: BoxFit.cover, // Adjust as needed
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/CommingSoon/comming_movie.png', // Replace with your asset image path
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),


                 SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => TVseriesInfo(
                        movie: tvdetails,
                        isWatchlisted: tvSeriesController.isWatchlisted.value,
                        isLiked: tvSeriesController.isLiked.value,
                        toggleWatchlist: tvSeriesController.toggleWatchlist,
                        toggleLike: tvSeriesController.toggleLike,
                      )),
                      TvSeriesSeasons(tvSeries: tvdetails),
                      TVseriesAttributes(title: "Languages", items: tvdetails),
                      const SizedBox(height: 10),
                      TVseriesSynopsis(description: tvdetails.series.description),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }




}



