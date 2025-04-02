import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Components/network_image_widget.dart';
import 'package:myott/UI/Home/Model/videoModel.dart';
import 'package:myott/UI/Video/video_Detials_page.dart';
import 'package:myott/services/api_service.dart';

import '../../Core/Utils/app_text_styles.dart';
import 'ShimmerLoader.dart';

class VideoList extends StatelessWidget {
  final List<Video> videos;
  final bool isTop10;

  VideoList({Key? key, required this.videos, this.isTop10 = false}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    if (videos.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "No video available",
            style: AppTextStyles.SubHeading2.copyWith(color: Colors.white),
          ),
        ),
      );
    }

    return SizedBox(
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: videos.length,
        padding: const EdgeInsets.only(left: 16),
        itemBuilder: (context, index) {
          final video = videos[index];

          return GestureDetector(
            onTap: () {
              final videoId = video.id;
              final slug = video.slug;
              Get.to(VideoDetialsPage(),arguments: {
                "videoId":videoId,
                "slug":slug
              });

            },
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: NetworkImageWidget(imageUrl: video.image,
                        errorAsset: "assets/images/movies/SliderMovies/movie-1.png",
                        ),
                      ),
                      const SizedBox(height: 6),
                      SizedBox(
                        width: 120,
                        child: Text(
                          video.name,
                          style: AppTextStyles.SubHeading2,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),


                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
