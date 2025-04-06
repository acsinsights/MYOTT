import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Components/network_image_widget.dart';
import 'package:myott/services/api_service.dart';
import 'package:myott/UI/Model/Moviesmodel.dart';
import 'package:myott/UI/Movie/movie_details_page.dart';

import '../../Core/Utils/app_text_styles.dart';
import '../../services/MovieService.dart';
import '../../video_player/component/Video_player_page.dart';
import '../Movie/Controller/Movie_controller.dart';
import 'ShimmerLoader.dart';

class MovieList extends StatelessWidget {
  final List<MoviesModel> movies;
  final bool isTop10;

  MovieList({Key? key, required this.movies, this.isTop10 = false}) : super(key: key);

  final List<String> topRankImages = [
    'assets/Icons/top_10_icon/ic_one.png',
    'assets/Icons/top_10_icon/ic_two.png',
    'assets/Icons/top_10_icon/ic_three.png',
    'assets/Icons/top_10_icon/ic_four.png',
    'assets/Icons/top_10_icon/ic_five.png',
    'assets/Icons/top_10_icon/ic_six.png',
    'assets/Icons/top_10_icon/ic_seven.png',
    'assets/Icons/top_10_icon/ic_eight.png',
    'assets/Icons/top_10_icon/ic_nine.png',
    'assets/Icons/top_10_icon/ic_ten.png',
  ];

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "No movies available",
            style: AppTextStyles.SubHeading2.copyWith(color: Colors.white),
          ),
        ),
      );
    }

    return SizedBox(
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        padding: const EdgeInsets.only(left: 16),
        itemBuilder: (context, index) {
          final movie = movies[index];
          final bool isFree = movie.package?.free ?? false; // Check if the movie is free

          return GestureDetector(
            onTap: () {
              final slug = movie.slug;
              debugPrint(slug);
      
              Get.to(() => MovieDetailsPage(),arguments: {
                'slug': slug,
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
                        child: NetworkImageWidget(imageUrl: movie.thumbnailImg,
                        errorAsset: "assets/images/movies/SliderMovies/movie-1.png",
                        ),
                      ),
                      const SizedBox(height: 6),
                      SizedBox(
                        width: 120,
                        child: Text(
                          movie.name,
                          style: AppTextStyles.SubHeading2,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),

                  // ✅ **TOP 10 BADGE** (if applicable)
                  if (isTop10 && index < topRankImages.length)
                    Positioned(
                      bottom: 60,
                      right: 8,
                      child: Image.asset(
                        topRankImages[index],
                        width: 30,
                        height: 60,
                      ),
                    ),

                  // ✅ **FREE/PAID BADGE** (always show)
                  // Positioned(
                  //   top: 8,
                  //   right: 8,
                  //   child: Container(
                  //     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  //     decoration: BoxDecoration(
                  //       color: isFree ? Colors.green : Colors.red, // Green for free, Red for paid
                  //       borderRadius: BorderRadius.circular(6),
                  //     ),
                  //     child: Text(
                  //       isFree ? "FREE" : "PAID",
                  //       style: AppTextStyles.SubHeading2.copyWith(
                  //         color: Colors.white,
                  //         fontSize: 12,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
