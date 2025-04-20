import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myott/Core/Utils/app_text_styles.dart';
import 'package:myott/UI/Components/Comment_section.dart';
import 'package:myott/UI/Components/network_image_widget.dart';
import 'package:myott/UI/Movie/Component/ExpandableDescription.dart';
import 'package:myott/UI/Profile/Controller/ProfileController.dart';
import 'package:myott/UI/TvSeries/Controller/tv_series_controller.dart';
import 'package:myott/video_player/component/verticalPlayerPage.dart';
import '../../Core/Utils/app_common.dart';
import '../../video_player/component/Video_player_page.dart';
import '../Components/buildAccessButton.dart';
import '../Components/custom_button.dart';
import '../Setting/Setting_Controller.dart';
import 'Component/SeriesActionButton.dart';
import 'Component/TvSeries_Seasons.dart';
import 'Model/TVSeriesDetailsModel.dart';

class TvSeriesDetailsPage extends StatefulWidget {
  @override
  State<TvSeriesDetailsPage> createState() => _TvSeriesDetailsPageState();
}

class _TvSeriesDetailsPageState extends State<TvSeriesDetailsPage> {
  final TVSeriesController tvSeriesController = Get.put(TVSeriesController());
  final ProfileController profileController=Get.put(ProfileController());
  final SettingController settiingController=Get.put(SettingController());


  @override
  void initState() {
    profileController.fetchProfileData();
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
          if (tvSeriesController.isLoading.value || profileController.isLoading.value || settiingController.isLoading.value) {
            return Center(child: CircularProgressIndicator(color: Colors.white,)); // Replace with Shimmer if needed
          }

            if (tvSeriesController.tvSeriesDetails.value == null) {
              return Center(child: Text("TV Series details not available", style: AppTextStyles.SubHeading2));
            }
           final verticalPlayer = settiingController.settingData.value?.generalSettings!.view ;

          final tvdetails = tvSeriesController.tvSeriesDetails.value;
            final userId=profileController.user.value!.id;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SeriesBanner(series: tvdetails!,verticalPlayer: verticalPlayer),

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
                      verticalPlayer==0
                      ?
                      TvSeriesEpisode(tvSeries: tvdetails,order: tvdetails.series.seriesorder,):
                          SizedBox.shrink(),
                      SizedBox(height: 5.h,),
                      // ActorListWidget(actors: tvdetails.series.actors, label: "Artist"),
                      SizedBox(height: 5.h,),
                      // ActorListWidget(actors: tvdetails.series.directors, label: "Directors"),
                      SeriesGenreList(tvdetails: tvdetails),
                      // SizedBox(height: 30.h,),



                    ],
                  ),
                ),
                CommentSection(comments: tvdetails.comments,
                    controller: tvSeriesController.commentController,
                    onSend: (){
                      tvSeriesController.addCommentForSeries(tvdetails.series.id, tvdetails.series.slug);
                    },
                  onDelete: (comments){
                    tvSeriesController.deleteCommentForSeries(comments.id, tvdetails.series.slug);

                  },
                  currentUserId:userId,

                    )
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
   SeriesBanner({
    super.key,
    required this.series,
    required this.verticalPlayer,
  });

  final SeriesDetailResponse? series;
  final int? verticalPlayer;

  List<Episode> episodes = [
    Episode(
      id: 1,
      episodeNumber: 1,
      title: "Midnight Serenity",
      description: "A calming escape into the heart of the night — feel the tranquility of moonlit silence.",
      poster: "poster",
      isFree: true,
      uploadUrl: "https://videos.pexels.com/video-files/5896379/5896379-uhd_1440_2560_24fps.mp4",
    ),
    Episode(
      id: 2,
      episodeNumber: 2,
      title: "Golden Hour Dreams",
      description: "The perfect blend of soft light and warm skies — a visual symphony of sunset.",
      poster: "poster",
      isFree: true,
      uploadUrl: "https://videos.pexels.com/video-files/4812203/4812203-hd_1080_1920_30fps.mp4",
    ),
    Episode(
      id: 3,
      episodeNumber: 3,
      title: "Urban Rhythm",
      description: "Experience the soul of the city through lights, movement, and a touch of chaos.",
      poster: "poster",
      isFree: true,
      uploadUrl: "https://videos.pexels.com/video-files/8859849/8859849-sd_360_640_25fps.mp4",
    ),
    Episode(
      id: 4,
      episodeNumber: 4,
      title: "Nature’s Echo",
      description: "Dive into the wild — leaves rustle, water flows, and peace reigns.",
      poster: "poster",
      isFree: true,
      uploadUrl: "https://videos.pexels.com/video-files/4448895/4448895-sd_360_640_30fps.mp4",
    ),
    Episode(
      id: 5,
      episodeNumber: 5,
      title: "The Quiet Adventure",
      description: "A poetic journey through isolated paths, where every sound tells a story.",
      poster: "poster",
      isFree: false,
      uploadUrl: "https://videos.pexels.com/video-files/6010489/6010489-sd_360_640_25fps.mp4",
    ),
    Episode(
      id: 6,
      episodeNumber: 6,
      title: "Nature’s Echo",
      description: "Dive into the wild — leaves rustle, water flows, and peace reigns.",
      poster: "poster",
      isFree: false,
      uploadUrl: "https://videos.pexels.com/video-files/4448895/4448895-sd_360_640_30fps.mp4",
    ),
  ];

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
    final package = series!.series.seriesPackage;

    print("🔥 DEBUG VALUES 🔥");
    print("🎬 isFree: ${package.isFree}");
    print("📦 selection: ${package.selection}");
    print("🔐 hasAccess: ${_checkHasAccess(order,package.selection)}");

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
                    errorAsset: "assets/images/movies/SliderMovies/movie-1.png",
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
                        errorAsset: "assets/images/movies/SliderMovies/movie-1.png",

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
                            !package.isFree
                                ? Icon(
                              Icons.workspace_premium, // Premium icon
                              color: Colors.amber,
                              size: 25.w,
                            )
                                : SizedBox.shrink() // Hide if it's free


                          ],
                        ),
                        SizedBox(height: 10.h),

                        verticalPlayer == 1
                            ? CustomButton(
                          width: 180.w,
                          text: "Play Now",
                          onPressed: () {
                            if (verticalPlayer == 0) {
                              Get.to(VideoPlayerPage(
                                videoUrl: series!.series.trailerUrl,
                                subtitles: {},
                                dubbedLanguages: {},
                              ));
                            } else {
                              Get.to(VerticalPlayerPage(
                                episodes: series!.episodes,
                                seriesPackage: series!.series.seriesPackage,
                                order: series!.series.seriesorder,
                                slug: series!.series.slug,
                                contentId: series!.series.id,
                                title: series!.series.name,
                              ));
                            }
                          },
                          backgroundColor: Colors.black,
                          borderColor: Colors.white,
                        )
                            : ContentAccessButton(
                          coinPrice: package.coinCost,
                          isFree: package.isFree,
                          selection: package.selection,
                          hasAccess: _checkHasAccess(order, package.selection),
                          videoUrl: series!.series.trailerUrl,
                          subtitles: {},
                          // dubbedLanguages: {},
                          contentId: series!.series.id,
                          contentCost: package.coinCost,
                          contentType: MediaType.series.name,
                          planPrice: package.planPrice,
                          offerPrice: package.offerPrice,
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
