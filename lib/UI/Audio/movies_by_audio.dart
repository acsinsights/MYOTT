import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Audio/Model/MandTAudioModel.dart';
import 'package:myott/UI/Audio/controller/AudioController.dart';
import 'package:myott/UI/Components/ShimmerLoader.dart';
import 'package:myott/UI/Genre/Controller/genre_controller.dart';
import 'package:myott/UI/Movie/Controller/Movie_controller.dart';
import 'package:myott/UI/Movie/Movie_details_page.dart';
import 'package:myott/UI/TvSeries/TvSeries_details_page.dart';
import 'package:myott/UI/Video/video_Detials_page.dart';

import '../../services/MovieService.dart';
import '../../services/api_service.dart';

class MoviesByAudio extends StatelessWidget {
  final AudioController audioController = Get.put(AudioController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
          audioController.selectedAudio.value?.name ?? "Content",
          style: TextStyle(color: Colors.white),
        )),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      body: Obx(() {
        if (audioController.isLoading.value) {
          return Padding(
            padding: EdgeInsets.all(12.w),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: ScreenUtil().screenWidth > 600 ? 4 : 3,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                childAspectRatio: 2 / 3,
              ),
              itemCount: 20,
              itemBuilder: (context, index) => ShimmerLoader(height: 150.h, width: 100.w),
            ),
          );
        }

        final mandTAudioData = audioController.audioData.value; // Assuming this is the fetched data
        final movies = mandTAudioData?.movies ?? [];
        // final tvseries = mandTAudioData?. ?? [];
        final videos = mandTAudioData?.videos ?? [];
        final audio = mandTAudioData?.audio ?? [];

        // if (movies.isEmpty && tvseries.isEmpty && videos.isEmpty && audio.isEmpty) {
        //   return Center(
        //     child: Text(
        //       "No content available",
        //       style: TextStyle(color: Colors.white, fontSize: 16.sp),
        //     ),
        //   );
        // }

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (movies.isNotEmpty) ...[
                  Text("Movies", style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8.h),
                  _buildContentGrid(movies),
                  SizedBox(height: 16.h),
                ],
                // if (tvseries.isNotEmpty) ...[
                //   Text("TV Series", style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold)),
                //   SizedBox(height: 8.h),
                //   _buildContentGrid(tvseries),
                //   SizedBox(height: 16.h),
                // ],
                if (videos.isNotEmpty) ...[
                  Text("Videos", style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8.h),
                  _buildContentGrid(videos),
                  SizedBox(height: 16.h),
                ],
                if (audio.isNotEmpty) ...[
                  Text("Audio", style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8.h),
                  _buildContentGrid(audio),
                  SizedBox(height: 16.h),
                ],
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildContentGrid(List<dynamic> contentList) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: ScreenUtil().screenWidth > 600 ? 4 : 3,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 2 / 3,
      ),
      itemCount: contentList.length,
      itemBuilder: (context, index) {
        final content = contentList[index];
        return GestureDetector(
          onTap: () {
            // Handle the tap for each content (movie, series, etc.)
            if (content is Movie) {
              Get.to(() => MovieDetailsPage(),arguments: {
                "slug": content.slug
              });
            } else if (content is Audio) {
              // Handle audio
              // Get.to(() => AudioDetailsPage(audioId: content.id));
            } else if (content is Series) {
              Get.to(() => TvSeriesDetailsPage(slug: content.slug,));
            } else {
              Get.to(VideoDetialsPage());
            }
          },
          child: MovieOrTvItem(
            imageUrl: content.thumbnailImg,
            title: content.name,
          ),
        );
      },
    );
  }
}

class MovieOrTvItem extends StatelessWidget {
  final String imageUrl;
  final String title;

  const MovieOrTvItem({Key? key, required this.imageUrl, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(height: 6.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

