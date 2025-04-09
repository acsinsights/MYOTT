import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myott/UI/Movie/Component/ExpandableDescription.dart';
import 'package:myott/UI/Video/Controller/VideoDetailsController.dart';
import 'package:myott/UI/Video/Model/VideoDetailsModel.dart';

import '../../Core/Utils/app_common.dart';
import '../../Core/Utils/app_text_styles.dart';
import '../../video_player/component/InlineVideoPlayer.dart';
import '../../video_player/component/Video_player_page.dart';
import '../Components/buildAccessButton.dart';
import '../Components/custom_button.dart';
import '../Components/network_image_widget.dart';
import '../Movie/Component/RatingBottomSheet.dart';

class VideoDetialsPage extends StatefulWidget {
  @override
  State<VideoDetialsPage> createState() => _VideoDetialsPageState();
}

class _VideoDetialsPageState extends State<VideoDetialsPage> {
  VideoDetailsController videoDetailsController =
      Get.put(VideoDetailsController());

  @override
  void initState() {
    var slug = Get.arguments["slug"];
    videoDetailsController.fetchVideoDetails(slug);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Obx(() {
            if (videoDetailsController.videoDetails.value == null) {
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              ));
            }
            if (videoDetailsController.videoDetails.value == null) {
              return Center(
                  child: Text("TV video details not available",
                      style: AppTextStyles.SubHeading2));
            }
            final videoDetails = videoDetailsController.videoDetails.value;
            return SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  VideoBanner(
                    video: videoDetails!,
                  ),
                  SizedBox(height: 10),
                  ExpandableDescription(description: videoDetails.description),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        videoActionButtons(
                            videodetailsController: videoDetailsController,
                            videos: videoDetails),
                        SizedBox(
                          height: 5.h,
                        ),
                        VideoActorListWidget(
                            actors: videoDetails.cast.actors, label: "Actors"),
                        SizedBox(
                          height: 10.h,
                        ),
                        VideoActorListWidget(
                            actors: videoDetails.cast.directors,
                            label: "Directors"),
                        VideosGenreList(videodetails: videoDetails),
                        SizedBox(
                          height: 30.h,
                        )
                      ],
                    ),
                  )
                ]));
          }),
        ));
  }

  @override
  void dispose() {
    Get.delete<VideoDetailsController>();

  }
}

class VideoDescription extends StatelessWidget {
  const VideoDescription({
    super.key,
    required this.videoDetails,
  });

  final VideoDetailsModel? videoDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Description", style: AppTextStyles.SubHeadingb1),
        SizedBox(height: 5),
        Row(
          children: [
            Text(
              "Rating: ${videoDetails!.maturity.toString()}",
              style: AppTextStyles.SubHeadingGrey2,
            )
          ],
        ),
        SizedBox(height: 5),
        Text(videoDetails!.description, style: AppTextStyles.SubHeadingGrey2),
      ],
    );
  }
}

class VideosGenreList extends StatelessWidget {
  const VideosGenreList({
    super.key,
    required this.videodetails,
  });

  final VideoDetailsModel? videodetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Genre",
            style: AppTextStyles.SubHeadingb1,
          ),
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            height: 35,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: videodetails?.cast.genres.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                VideoActor genre = videodetails!.cast.genres[index];

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
                        child:
                            Text(genre.name, style: AppTextStyles.SubHeadingb2),
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

class VideoBanner extends StatelessWidget {
  const VideoBanner({
    super.key,
    required this.video,
  });

  final VideoDetailsModel? video;
  bool _checkHasAccess(VOrder? order, String contentType) {
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
    final VOrder? order = video!.vOrder; // or movie!.movie.order if renamed

    print("🔥 DEBUG VALUES 🔥");
    print("🎬 isFree: ${video!.videoPackage.free}");
    print("📦 selection: ${video!.videoPackage.selection}");
    print("🔐 hasAccess: ${_checkHasAccess(order,video!.videoPackage.selection)}");
    print("Video Url: ${video!.trailerUrl}");


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
                    imageUrl: video!.thumbnailImg,
                    width: double.infinity,
                    height: 400.h,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: double.infinity,
                    height: 400.h,
                    color: Colors.black
                        .withOpacity(0.7), // Black overlay with 50% opacity
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
                        imageUrl: video!.thumbnailImg,
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
                          video!.name,
                          style: AppTextStyles.Headingb4,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                        Row(
                          children: [
                            Text(
                              video!.releaseYear, // Release Year
                              style: AppTextStyles.SubHeadingb3,
                            ),
                            SizedBox(
                                width: 10.w), // Space between year and maturity
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 2.h),
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                video!.maturity, // Maturity Rating
                                style: AppTextStyles.SubHeadingb3.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        ContentAccessButton(
                          coinPrice: video!.videoPackage.coinCost,
                          slug: video!.slug,
                          isFree:video!.videoPackage.free,
                          selection: video!.videoPackage.selection.toString(),
                          hasAccess: _checkHasAccess(video!.vOrder, video!.videoPackage.selection.toString()),
                          videoUrl: video!.trailerUrl,
                          subtitles: {},
                          // dubbedLanguages: movie!.movie.dubbedLanguages,
                          contentId: video!.id,
                          contentCost: video!.videoPackage.coinCost,
                          contentType: MediaType.video.name,
                          planPrice: video!.videoPackage.planPrice,
                          offerPrice: video!.videoPackage.offerPrice,
                        ),
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

class videoActionButtons extends StatelessWidget {
  const videoActionButtons(
      {super.key, required this.videodetailsController, required this.videos});

  final VideoDetailsController videodetailsController;
  final VideoDetailsModel videos;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () {
            videodetailsController.toggleWishlist(videos!.id, "V");
          },
          child: Column(
            children: [
              Obx(() => Icon(
                    videodetailsController.isWishList.value
                        ? CupertinoIcons.heart_fill
                        : CupertinoIcons.add,
                    color: videodetailsController.isWishList.value
                        ? Colors.red
                        : Colors.white,
                  )),
              SizedBox(height: 10),
              Obx(() => Text(
                    videodetailsController.isWishList.value
                        ? "Wishlisted"
                        : "WishList",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            videodetailsController.shareContent(
                videos.name, "video", videos.trailerUrl);
          },
          child: Column(
            children: [
              Icon(
                Icons.share,
                color: Colors.white,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Share",
                style: AppTextStyles.SubHeadingb3,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class VideoActorListWidget extends StatelessWidget {
  final List<VideoActor> actors;
  final String label;

  const VideoActorListWidget(
      {super.key, required this.actors, required this.label});

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
                  onTap: () {},
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
                        )),
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
