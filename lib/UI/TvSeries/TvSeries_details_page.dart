import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myott/Core/Utils/app_text_styles.dart';
import 'package:myott/UI/Components/Comment_section.dart';
import 'package:myott/UI/Components/ShimmerLoader.dart';
import 'package:myott/UI/Components/network_image_widget.dart';
import 'package:myott/UI/Movie/Component/ExpandableDescription.dart';
import 'package:myott/UI/TvSeries/Controller/tv_series_controller.dart';
import '../../Core/Utils/app_common.dart';
import '../../video_player/component/Video_player_page.dart';
import '../Components/buildAccessButton.dart';
import '../Components/custom_button.dart';
import 'Component/SeriesActionButton.dart';
import 'Component/TvSeries_Seasons.dart';
import 'Component/TVSeries_synopsis.dart';
import 'Model/TVSeriesDetailsModel.dart';

class TvSeriesDetailsPage extends StatefulWidget {
  @override
  State<TvSeriesDetailsPage> createState() => _TvSeriesDetailsPageState();
}

class _TvSeriesDetailsPageState extends State<TvSeriesDetailsPage> {
  final TVSeriesController tvSeriesController = Get.put(TVSeriesController());

  @override
  void initState() {
    final slug = Get.arguments['slug'];
    tvSeriesController.fetchTVSeriesDetails(slug);
    tvSeriesController.checkWishlistStatus(slug);
  }

  @override
  Widget build(BuildContext context) {
   
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
                SeriesBanner(series: tvdetails!),

                 SizedBox(height: 10),
                ExpandableDescription(description: tvdetails.series.description),
                SizedBox(
                  height: 10.h,
                ),
                seriessActionButtons(tvseriesController: tvSeriesController, series: tvdetails),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TvSeriesEpisode(tvSeries: tvdetails),
                      SizedBox(height: 5.h,),
                      ActorListWidget(actors: tvdetails.series.actors, label: "Artist"),
                      SizedBox(height: 5.h,),
                      ActorListWidget(actors: tvdetails.series.directors, label: "Directors"),
                      SeriesGenreList(tvdetails: tvdetails),
                      SizedBox(height: 30.h,),



                    ],
                  ),
                ),
                CommentSection(comments: tvdetails.comments,
                    controller: tvSeriesController.commentController,
                    onSend: (){
                      tvSeriesController.addCommentForSeries(tvdetails.series.id, tvdetails.series.slug);
                    })
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

class SeriesBanner extends StatelessWidget {
  const SeriesBanner({
    super.key,
    required this.series,
  });

  final SeriesDetailResponse? series;


  bool _checkHasAccess(SOrder? order, String contentType) {
    contentType = contentType.trim();

    if (contentType == "subsriptionSystem" || contentType == "pricingSection") {
      return order != null && order.endDate != null && order.endDate!.isAfter(DateTime.now());
    }

    if (contentType == "coinCostSection") {
      return order != null; // Only return true if order is created
    }

    return false;
  }



  @override
  Widget build(BuildContext context) {
    final SOrder? order = series!.series.seriesorder; // or movie!.movie.order if renamed

    print("🔥 DEBUG VALUES 🔥");
    print("🎬 isFree: ${series!.packages.first.isFree}");
    print("📦 selection: ${series!.packages.first.selection}");
    print("🔐 hasAccess: ${_checkHasAccess(order,series!.packages.first.selection)}");

    if (order != null) {
      print("📦 Orders Count: 1");
      print("📄 Order ID: ${order.orderId}");
      print("🗓️ Start: ${order.startDate} - End: ${order.endDate}");
      print("✅ Is Active: ${order.endDate.isAfter(DateTime.now())}");
    } else {
      print("❌ No Order Found");
    }

    return Container(
        height: 400.h,
        child: Stack(
          children: [
            Positioned.fill(
              child: Stack(
                children: [
                  NetworkImageWidget(
                    imageUrl: series!.series.thumbnailImg,
                    width: double.infinity,
                    height: 400.h,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: double.infinity,
                    height: 400.h,
                    color: Colors.black.withOpacity(
                        0.7), // Black overlay with 50% opacity
                  ),
                ],
              ),
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
            Positioned(
              bottom: 20,
              left: 10,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 200.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: NetworkImageWidget(
                        imageUrl: series!.series.thumbnailImg,
                        fit: BoxFit.cover,
                        width: 140.w,
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Container(
                    width: 200.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        Text(
                          series!.series.name,
                          style: AppTextStyles.Headingb4,
                          maxLines: 2,
                        ),
                        Row(
                          children: [
                            Text(
                              series!.series.releaseYear, // Release Year
                              style: AppTextStyles.SubHeadingb3,
                            ),
                            SizedBox(width: 10.w), // Space between year and maturity
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                series!.series.maturity, // Maturity Rating
                                style: AppTextStyles.SubHeadingb3.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w,),
                            series!.packages.isNotEmpty && !series!.packages.first.isFree
                                ? Icon(
                              Icons.workspace_premium, // Premium icon
                              color: Colors.amber,
                              size: 25.w,
                            )
                                : SizedBox.shrink() // Hide if it's free


                          ],
                        ),
                        SizedBox(height: 10.h),
                        ContentAccessButton(
                          coinPrice: series!.packages.isNotEmpty ? series!.packages.first.coinCost : 0,
                          isFree: series!.packages.isNotEmpty ? series!.packages.first.isFree : false,
                          selection: series!.packages.isNotEmpty? series!.packages.first.selection :"" ,
                          hasAccess: _checkHasAccess(order, series!.packages.first.selection),
                          videoUrl: series!.series.trailerUrl,
                          subtitles: {},
                          // dubbedLanguages: {},
                          contentId: series!.series.id,
                          contentCost: series!.packages.isNotEmpty ? series!.packages.first.coinCost : 0,
                          contentType: MediaType.series.toString(),
                          planPrice: series!.packages.isNotEmpty ? series!.packages.first.planPrice : 0,
                          offerPrice: series!.packages.isNotEmpty ? series!.packages.first.offerPrice : 0,
                          slug: series!.series.slug,
                        ),
                        SizedBox(height: 10.h),
                        CustomButton(
                          width: 180.w,
                          text: "Trailer",
                          onPressed: () {
                            Get.to(VideoPlayerPage(
                              videoUrl: series!.series.trailerUrl,
                              subtitles: {},
                              dubbedLanguages: {},
                            ));
                          },
                          backgroundColor: Colors.black,
                          borderColor: Colors.white,
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ));
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
