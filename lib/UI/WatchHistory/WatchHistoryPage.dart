import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:myott/UI/Components/network_image_widget.dart';
import 'package:myott/UI/Movie/Movie_details_page.dart';
import 'package:myott/UI/TvSeries/TvSeries_details_page.dart';
import 'package:myott/UI/Video/video_Detials_page.dart';
import 'Controller/watchHistoryController.dart';

class WatchHistoryPage extends StatelessWidget {
  const WatchHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WatchHistoryController());

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Watch History",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.deepPurple),
          );
        }

        if (controller.watchHistoryList.isEmpty) {
          return Center(
            child: Text(
              "No watch history found.",
              style: TextStyle(color: Colors.white70, fontSize: 16.sp),
            ),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          itemCount: controller.watchHistoryList.length,
          separatorBuilder: (_, __) => SizedBox(height: 16.h),
          itemBuilder: (context, index) {
            final item = controller.watchHistoryList[index];

            String type = '';
            String title = '';
            String image = '';
            int id = item.id;
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

            return GestureDetector(
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
              child:Container(
                margin: EdgeInsets.symmetric(vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1C1E),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                        bottomLeft: Radius.circular(12.r),
                      ),
                      child: NetworkImageWidget(imageUrl: image,height: 90.h,width: 100.w,errorAsset: "assets/images/movies/SliderMovies/movie-1.png",)
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                                  decoration: BoxDecoration(
                                    color: Colors.deepPurple,
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  child: Text(
                                    type,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    String shortType = type[0].toUpperCase();
                                    print(shortType);
                                    print(id);
                                    controller.deleteHistory(shortType, id);
                                  },
                                  child: CircleAvatar(
                                    radius: 12.r,
                                    backgroundColor: Colors.redAccent,
                                    child: Icon(Icons.delete, size: 14.sp, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            );
          },
        );
      }),
    );
  }
}
