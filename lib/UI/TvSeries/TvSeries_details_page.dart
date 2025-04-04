import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myott/Core/Utils/app_text_styles.dart';
import 'package:myott/UI/Components/ShimmerLoader.dart';
import 'package:myott/UI/Components/network_image_widget.dart';
import 'package:myott/UI/TvSeries/Controller/tv_series_controller.dart';
import '../../video_player/component/Video_player_page.dart';
import '../Components/custom_button.dart';
import 'Component/SeriesActionButton.dart';
import 'Component/TvSeries_Seasons.dart';
import 'Component/TVSeries_synopsis.dart';
import 'Model/TVSeriesDetailsModel.dart';

class TvSeriesDetailsPage extends StatelessWidget {
  final TVSeriesController tvSeriesController = Get.put(TVSeriesController());

  @override
  Widget build(BuildContext context) {
    final slug = Get.arguments['slug'];
    tvSeriesController.fetchTVSeriesDetails(slug);
    tvSeriesController.checkWishlistStatus(slug);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child:Obx(() {
          if (tvSeriesController.isLoading.value) {
            return Center(child: CircularProgressIndicator(color: Colors.white,)); // Replace with Shimmer if needed
          }

            if (tvSeriesController.tvSeriesDetails.value == null) {
              return Center(child: Text("TV Series details not available", style: AppTextStyles.SubHeading2));
            }
            final tvdetails = tvSeriesController.tvSeriesDetails.value;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Stack(
                 children: [
                   Container(
                     height: 200,
                     width: double.infinity,
                     child: NetworkImageWidget(imageUrl: tvdetails!.series.thumbnailImg),
                   ),
                   Positioned(
                       top: 10,
                       left: 10,
                       child: IconButton(
                           onPressed: () {
                             Get.back();
                           },
                           icon: Icon(
                             Icons.arrow_back,
                             color: Colors.white,
                           ))),

                 ],
               ),

                 SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            tvdetails.series.name,
                            style: AppTextStyles.Headingb4,
                          ),
                          tvdetails.packages.isNotEmpty && !tvdetails.packages.first.isFree
                              ? Icon(
                            Icons.workspace_premium, // Premium icon
                            color: Colors.amber, // Gold/Yellow color for premium
                            size: 20.w, // Adjust size as needed
                          )
                              : SizedBox.shrink(), // Show nothing if free

                        ],
                      ),
                      Divider(color: Colors.white,),
                      seriessActionButtons(tvseriesController: tvSeriesController, series: tvdetails),
                      Divider(color: Colors.white,),
                      SizedBox(height: 5.h,),
                      CustomButton(
                        width: double.infinity,
                        text: "Play Now",
                        onPressed: () {
                          Get.to(VideoPlayerPage(videoUrl: tvdetails.series.trailerUrl,dubbedLanguages: {},
                          subtitles: {},
                          ));
                        },
                        backgroundColor: Color(0xff290b0b),
                        borderColor: Colors.white,
                      ),
                      TvSeriesEpisode(tvSeries: tvdetails),
                      TVseriesSynopsis(description: tvdetails.series.description),
                      SizedBox(height: 5.h,),
                      ActorListWidget(actors: tvdetails.series.actors, label: "Artist"),
                      SizedBox(height: 5.h,),
                      ActorListWidget(actors: tvdetails.series.directors, label: "Directors"),
                      SeriesGenreList(tvdetails: tvdetails),
                      SizedBox(height: 30.h,)
                      

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

class SeriesGenreList extends StatelessWidget {
  const SeriesGenreList({
    super.key,
    required this.tvdetails,
  });

  final SeriesDetailResponse? tvdetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Genre",
            style: AppTextStyles.SubHeadingb1,
          ),
          SizedBox(height: 10.h,),
          SizedBox(
            height: 35,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tvdetails?.series.genres.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                TvSeriesActor genre = tvdetails!.series.genres[index];

                return GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Container(
                      width: 100,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child:Text(
                            genre.name,
                            style: AppTextStyles.SubHeadingb2
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}



class ActorListWidget extends StatelessWidget {
  final List<TvSeriesActor> actors;
  final String label;

  const ActorListWidget({super.key, required this.actors,required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.SubHeadingb1,
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 120.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: actors.length,
            padding: const EdgeInsets.only(left: 16),
            itemBuilder: (context, index) {
              var actor = actors[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: GestureDetector(
                  onTap: () {
                  },
                  child: Container(
                    width: 70.w,
                    height: 70.h,
                    child: Column(
                      children: [
                        ClipOval(
                            child: NetworkImageWidget(
                              height: 65.h,
                              width: 65.w,
                              imageUrl: actor.image,
                              errorAsset: "assets/Avtars/person2.png",
                            )
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          actor.name,
                          style: AppTextStyles.SubHeading2,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
