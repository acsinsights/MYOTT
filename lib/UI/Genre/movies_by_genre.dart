import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Components/ShimmerLoader.dart';
import 'package:myott/UI/Genre/Controller/genre_controller.dart';
import 'package:myott/UI/Movie/Controller/Movie_controller.dart';
import 'package:myott/UI/Movie/Movie_details_page.dart';
import 'package:myott/UI/TvSeries/TvSeries_details_page.dart';

import '../../services/MovieService.dart';
import '../../services/api_service.dart';

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

        final movies = genreController.mAndtGenre.value?.movies ?? [];
        final tvseries = genreController.mAndtGenre.value?.tvSeries ?? [];

        if (movies.isEmpty && tvseries.isEmpty) {
          return Center(
            child: Text(
              "No content available in this genre",
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
            ),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (movies.isNotEmpty) ...[
                  Text(
                    "Movies",
                    style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.h),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: ScreenUtil().screenWidth > 600 ? 4 : 3,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h,
                      childAspectRatio: 2 / 3,
                    ),
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => MovieDetailsPage(movieId: movie.id), binding: BindingsBuilder(() {
                            Get.put(MovieController(MoviesService(ApiService())));
                          }));
                        },
                        child: MovieOrTvItem(imageUrl: movie.posterImg, title: movie.name),
                      );
                    },
                  ),
                  SizedBox(height: 16.h),
                ],

                // TV Series Section
                if (tvseries.isNotEmpty) ...[
                  Text(
                    "TV Series",
                    style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.h),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: ScreenUtil().screenWidth > 600 ? 4 : 3,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h,
                      childAspectRatio: 2 / 3,
                    ),
                    itemCount: tvseries.length,
                    itemBuilder: (context, index) {
                      final series = tvseries[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => TvSeriesDetailsPage(seriesId: series.id));
                        },
                        child: MovieOrTvItem(imageUrl: series.thumbnailImg, title: series.name),
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
        );
      }),
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
