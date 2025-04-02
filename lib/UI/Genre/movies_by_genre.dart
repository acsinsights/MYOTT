import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Components/ShimmerLoader.dart';
import 'package:myott/UI/Genre/Controller/genre_controller.dart';
import 'package:myott/UI/Movie/Controller/Movie_controller.dart';
import 'package:myott/UI/Movie/Movie_details_page.dart';
import 'package:myott/UI/TvSeries/TvSeries_details_page.dart';
import 'package:myott/UI/Video/video_Detials_page.dart';

class MoviesByGenre extends StatelessWidget {
  final GenreController genreController = Get.find<GenreController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
          genreController.selectedGenre.value?.name ?? "Movies",
          style: TextStyle(color: Colors.white),
        )),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      body: Obx(() {
        if (genreController.isLoading.value) {
          return ContentShimmer();
        }

        final movies = genreController.movies ?? [];
        final tvseries = genreController.tvSeries ?? [];
        final videos = genreController.videos ?? [];
        final audios = genreController.audios ?? [];

        if (movies.isEmpty && tvseries.isEmpty && videos.isEmpty && audios.isEmpty) {
          return Center(
            child: Text(
              "No content available in this genre",
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
            ),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (movies.isNotEmpty)
                ContentSection(title: "Movies", items: movies, onTap: (movie) {
                  Get.to(() => MovieDetailsPage(), binding: BindingsBuilder(() {
                    Get.put(MovieController());
                  }));
                }),

              if (tvseries.isNotEmpty)
                ContentSection(title: "TV Series", items: tvseries, onTap: (series) {
                  Get.to(() => TvSeriesDetailsPage(slug: series.slug));
                }),

              if (videos.isNotEmpty)
                ContentSection(title: "Videos", items: videos, onTap: (video) {
                  Get.to(() => VideoDetialsPage());
                }),

              if (audios.isNotEmpty)
                ContentSection(title: "Audios", items: audios, onTap: (audio) {
                  // Future implementation for audio playback
                }),
            ],
          ),
        );
      }),
    );
  }
}

/// Reusable Widget for Movie, TV, Video, and Audio sections
class ContentSection extends StatelessWidget {
  final String title;
  final List<dynamic> items;
  final Function(dynamic) onTap;

  const ContentSection({
    Key? key,
    required this.title,
    required this.items,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.h),
        ContentGrid(items: items, onTap: onTap),
        SizedBox(height: 16.h),
      ],
    );
  }
}

/// Reusable GridView for displaying items
class ContentGrid extends StatelessWidget {
  final List<dynamic> items;
  final Function(dynamic) onTap;

  const ContentGrid({Key? key, required this.items, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: ScreenUtil().screenWidth > 600 ? 4 : 3,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 2 / 3,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return GestureDetector(
          onTap: () => onTap(item),
          child: MovieOrTvItem(
            imageUrl: item.thumbnailImg ?? "",
            title: item.name ?? "Unknown",
          ),
        );
      },
    );
  }
}

/// Reusable Movie or TV Series Grid Item
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

/// Placeholder for Shimmer Loader (Skeleton UI)
class ContentShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
}
