import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myott/Core/Utils/app_text_styles.dart';
import 'package:myott/services/MovieService.dart';
import 'package:myott/services/api_service.dart';
import 'package:myott/UI/Movie/Controller/Movie_controller.dart';
import 'package:myott/UI/Movie/movie_details_page.dart';
import '../Model/Moviesmodel.dart';

class MovieGrid extends StatelessWidget {
  final List<MoviesModel> movies;
  final String? title;

  const MovieGrid({Key? key, required this.movies, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          title ?? '',
          style: AppTextStyles.Headingb4,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.5,
          ),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];

            return GestureDetector(
              onTap: () {
                final movieId = movie.id;
                final slug=movie.slug;
                // Get.to(() => MovieDetailsPage(movieId: movieId,slug: slug,),
                //     binding: BindingsBuilder(() {
                //       Get.put(MovieController(MoviesService(ApiService())));
                //     }));
              },
              child: Column(
                children: [
                  Container(
                    height: 150.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.network(
                        movie.thumbnailImg,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/movies/SliderMovies/movie-1.png',
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Text(
                      movie.name,
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
      ),
    );
  }
}
