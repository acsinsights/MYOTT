import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/services/api_service.dart';
import 'package:myott/UI/Model/Moviesmodel.dart';
import 'package:myott/UI/Movie/movie_details_page.dart';

import '../../Core/Utils/app_text_styles.dart';
import '../../services/MovieService.dart';
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
          return GestureDetector(
            onTap: () {
              final movieId = movies[index].id;
              Get.to(() => MovieDetailsPage(movieId: movieId),
                  binding: BindingsBuilder(() {
                    Get.put(MovieController(MoviesService(ApiService())));
                  }));
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
                          image: DecorationImage(
                            image: NetworkImage(movies[index].posterImg),
                            fit: BoxFit.cover,
                            onError: (exception, stackTrace) =>
                                ShimmerLoader(height: 180, width: 120),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      SizedBox(
                        width: 120,
                        child: Text(
                          movies[index].name,
                          style: AppTextStyles.SubHeading2,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),

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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
