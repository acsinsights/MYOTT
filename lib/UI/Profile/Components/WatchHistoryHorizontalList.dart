import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myott/UI/Components/network_image_widget.dart';
import 'package:myott/UI/Movie/Movie_details_page.dart';
import 'package:myott/UI/TvSeries/TvSeries_details_page.dart';
import 'package:myott/UI/Video/video_Detials_page.dart';
import 'package:myott/UI/WatchHistory/Controller/watchHistoryController.dart';

class WatchHistoryHorizontalList extends StatelessWidget {
  final controller = Get.put(WatchHistoryController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.watchHistoryList.isEmpty) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Text("No watch history", style: TextStyle(color: Colors.white70)),
        );
      }

      return SizedBox(
        height: 190.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: controller.watchHistoryList.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final item = controller.watchHistoryList[index];

            String image = '';
            String title = '';
            String type = '';
            int id = 0;
            String slug = '';

            if (item.movie.name.isNotEmpty) {
              type = "Movie";
              title = item.movie.name;
              image = item.movie.thumbnailImg;
              id = item.movie.id;
              slug = item.movie.slug;
            } else if (item.series.name.isNotEmpty) {
              type = "Series";
              title = item.series.name;
              image = item.series.thumbnailImg;
              id = item.series.id;
              slug = item.series.slug;
            } else if (item.audio.name.isNotEmpty) {
              type = "Audio";
              title = item.audio.name;
              image = item.audio.thumbnailImg;
              id = item.audio.id;
              slug = item.audio.slug;
            } else if (item.video.name.isNotEmpty) {
              type = "Video";
              title = item.video.name;
              image = item.video.thumbnailImg;
              id = item.video.id;
              slug = item.video.slug;
            }

            return Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    if (type == "Movie") {
                      Get.to(MovieDetailsPage(), arguments: {"slug": slug});
                    } else if (type == "Series") {
                      Get.to(TvSeriesDetailsPage(), arguments: {"slug": slug});
                    } else if (type == "Audio") {
                      Get.toNamed('/audio-details', arguments: {'id': id});
                    } else if (type == "Video") {
                      Get.to(VideoDetialsPage(), arguments: {"slug": slug});
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: NetworkImageWidget(
                          imageUrl: image,
                          width: 100.w,
                          height: 140.h,
                          errorAsset: "assets/images/movies/SliderMovies/movie-1.png",
                        ),
                      ),
                      SizedBox(height: 6.h),
                      SizedBox(
                        width: 100.w,
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 12.sp),
                        ),
                      ),
                    ],
                  ),
                ),

                // ❌ Delete Button on top-right of thumbnail
                Positioned(
                  right: 0,
                  top: 0,
                  child: GestureDetector(
                    onTap: () {
                      String shortType = type[0].toUpperCase(); // M / S / A / V
                      controller.deleteHistory(shortType, id);
                    },
                    child: CircleAvatar(
                      radius: 12.r,
                      backgroundColor: Colors.redAccent,
                      child: Icon(Icons.close, size: 14.sp, color: Colors.white),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      );
    });
  }
}
