import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myott/UI/Video/Controller/VideoDetailsController.dart';
import 'package:myott/UI/Video/Model/VideoDetailsModel.dart';

import '../../Core/Utils/app_text_styles.dart';
import '../../video_player/component/InlineVideoPlayer.dart';
import '../../video_player/component/Video_player_page.dart';
import '../Components/custom_button.dart';
import '../Components/network_image_widget.dart';
import '../Movie/Component/RatingBottomSheet.dart';

class VideoDetialsPage extends StatelessWidget {
  VideoDetailsController videoDetailsController =
      Get.put(VideoDetailsController());

  @override
  Widget build(BuildContext context) {
    var slug = Get.arguments["slug"];
    videoDetailsController.fetchVideoDetails(slug);
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
                  child: Text("TV Series details not available",
                      style: AppTextStyles.SubHeading2));
            }
            final videoDetails = videoDetailsController.videoDetails.value;
            return SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Stack(
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity, // Ensures proper layout
                        child: NetworkImageWidget(
                            imageUrl: videoDetails!.thumbnailImg),
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
                        Text(
                          videoDetails.name,
                          style: AppTextStyles.SubHeadingb,
                        ),
                        Divider(
                          color: Colors.white,
                        ),
                        SizedBox(height: 5.h,),
                        CustomButton(
                          width: double.infinity,
                          text: "Play Now",
                          onPressed: () {
                            Get.to(VideoPlayerPage(videoUrl: videoDetails.trailerUrl,dubbedLanguages: {},
                              subtitles: {},
                            ));
                          },
                          backgroundColor: Color(0xff290b0b),
                          borderColor: Colors.white,
                        ),
                        SizedBox(height: 5.h,),

                        // videoActionButtons(
                        //     videodetailsController: videoDetailsController,
                        //     videos: videoDetails),
                        // Divider(
                        //   color: Colors.white,
                        // ),
                        VideoDescription(videoDetails: videoDetails),
                        SizedBox(height: 5.h,),
                        VideoActorListWidget(actors: videoDetails.cast.actors, label: "Actors"),
                        SizedBox(height: 10.h,),
                        VideoActorListWidget(actors: videoDetails.cast.directors, label: "Directors"),
                        VideosGenreList(videodetails: videoDetails),
                        SizedBox(height: 30.h,)

                        
                        

                      ],
                    ),
                  )
                ]));
          }),
        ));
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
        Text("Description",
            style: AppTextStyles.SubHeadingb1),
        
        SizedBox(height: 5),
        Row(
          children: [
            Text("Rating: ${videoDetails!.maturity.toString()}",style: AppTextStyles.SubHeadingGrey2,)
          ],
        ),
        SizedBox(height: 5),

        Text(videoDetails!.description,
            style: AppTextStyles.SubHeadingGrey2),
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
          Text("Genre",
            style: AppTextStyles.SubHeadingb1,
          ),
          SizedBox(height: 10.h,),
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
            // videodetailsController.toggleWishlist(series!.series.id, "M");
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
        GestureDetector(
          onTap: () {
            videodetailsController.toggleDownload();
          },
          child: Column(
            children: [
              Obx(() {
                return Icon(
                  videodetailsController.isDownloaded.value
                      ? Icons.download_done
                      : Icons.download,
                  color: Colors.white,
                );
              }),
              SizedBox(
                height: 10.h,
              ),
              Obx(() {
                return Text(
                  videodetailsController.isDownloaded.value
                      ? "Downloaded"
                      : "Download",
                  style: AppTextStyles.SubHeadingb3,
                );
              })
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

  const VideoActorListWidget({super.key, required this.actors,required this.label});

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
