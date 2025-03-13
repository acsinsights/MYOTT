import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Components/MovieListShrimerLoad.dart';
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
          return Container(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: ScreenUtil().screenWidth > 600 ? 4 : 3,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                  childAspectRatio: 2 / 3,

                ),
                itemCount: 20,
                itemBuilder: (context,index){
                  return ShimmerLoader(
                    height: 100,
                    width: 100,
                  );
                }),
          );
        }

        final movies = genreController.mAndtGenre.value!.movies;
        final tvseries = genreController.mAndtGenre.value!.tvSeries;

        // ✅ Combine Movies and TV Series into one list with type identifiers
        final List<Map<String, dynamic>> combinedList = [
          ...movies.map((m) => {'data': m, 'isMovie': true}),
          ...tvseries.map((t) => {'data': t, 'isMovie': false}),
        ];

        if (combinedList.isEmpty) {
          return Center(
            child: Text(
              "No content available in this genre",
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.all(8.0.w),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  ScreenUtil().screenWidth > 600 ? 4 : 3, // Tablet & Mobile
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 2 / 3,
            ),
            itemCount: combinedList.length,
            itemBuilder: (context, index) {
              final item = combinedList[index];
              final data = item['data'];
              final bool isMovie = item['isMovie'];

              return GestureDetector(
                onTap: () {
                  if (isMovie) {
                    Get.to(() => MovieDetailsPage(movieId: data.id),
                        binding: BindingsBuilder(() {
                      Get.put(MovieController(MoviesService(ApiService())));
                    }));
                  } else {
                    Get.to(() => TvSeriesDetailsPage(seriesId: data.id));
                  }
                },
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          image: DecorationImage(
                            image: NetworkImage(isMovie
                                ? data.posterImg
                                : data.thumbnailImg), // ✅ Correct image key
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Text(
                        data.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
