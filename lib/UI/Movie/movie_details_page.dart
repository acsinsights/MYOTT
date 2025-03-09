import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myott/Core/Utils/app_text_styles.dart';
import 'package:myott/services/MovieService.dart';
import 'package:myott/services/api_service.dart';
import 'package:myott/UI/Movie/Component/MoviesActionButton.dart';
import 'package:myott/video_player/component/Video_palyer_widget.dart';

import '../Components/ShimmerLoader.dart';
import 'Controller/Movie_controller.dart';

class MovieDetailsPage extends StatefulWidget {
  final int movieId; // Pass Movie ID from the Home page

  MovieDetailsPage({required this.movieId});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {

  bool isWatchlisted=false;
  bool isLiked=false;

  @override
  Widget build(BuildContext context) {
    final MovieController controller =
        Get.put(MovieController(MoviesService(ApiService())));


    // Fetch details when this page loads
    controller.fetchMovieDetails(widget.movieId);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Obx(() {
            if (controller.isLoading.value) {
              return  Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerLoader(height: 200.h,),
                    SizedBox(height: 10,),
                    ShimmerLoader(height: 20.h,width: 50.h,),
                    SizedBox(height: 10,),
                    ShimmerLoader(height: 50.h,),
                    SizedBox(height: 10,),
                    ShimmerLoader(height: 100.h,),
                    SizedBox(height: 10,),
                    ShimmerLoader(height: 400.h,),
                  ],
                ),
              );
            }
            if (controller.movieDetails.value == null) {
              return  Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerLoader(height: 200.h,),
                    SizedBox(height: 10,),
                    ShimmerLoader(height: 20.h,width: 50.h,),
                    SizedBox(height: 10,),
                    ShimmerLoader(height: 50.h,),
                    SizedBox(height: 10,),
                    ShimmerLoader(height: 100.h,),
                    SizedBox(height: 10,),
                    ShimmerLoader(height: 400.h,),
                  ],
                ),
              );
            }
        
            final movie = controller.movieDetails.value!;
            return Column(
              children: [
                Stack(
                  children: [
                    VideoPlayerWidget(
                        videoUrl: movie.movie.movieUploadUrl,
                        thumbnailUrl: movie.movie.thumbnailImg),
                    Positioned(
                        top: 10,
                        left: 10,
                        child: IconButton(
                            icon: Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () => Get.back())),
                  ],
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(movie.movie.name,
                                    style: AppTextStyles.Headingb3),
                              ],
                            ),
                            Icon(Icons.download, size: 30, color: Colors.white),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MovieActionButtons(
                          isWatchlisted: isWatchlisted,
                          isLiked: isLiked,
                          toggleWatchlist: toggleWatchlist,
                          toggleLike: toggleLike),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Synopsis", style: AppTextStyles.SubHeadingb1),
                            SizedBox(height: 5),
                            Text(movie.movie.description, style: AppTextStyles.SubHeadingGrey2),
                          ],
                        ),
                      ),
        
                      // Add other UI elements here
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );

  }
  void toggleWatchlist() => setState(() => isWatchlisted = !isWatchlisted);
  void toggleLike() => setState(() => isLiked = !isLiked);

}
